package com.villagevista.villagevista.Model.Dao.postgresJDBCImpl;

import com.villagevista.villagevista.Model.Dao.AlloggioDAO;
import com.villagevista.villagevista.Model.Mo.Alloggio;
import com.villagevista.villagevista.Model.Mo.Prenotazione;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AlloggioDAOPostgresJDBCImpl implements AlloggioDAO {
    Connection conn;

    public AlloggioDAOPostgresJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Alloggio create(
            Long num_alloggio,
            String tipo,
            String capienza,
            String occupato,
            Date data_inizio,
            Date data_fine,
            Long prezzonotte)
    {
        PreparedStatement ps;
        Alloggio alloggio = new Alloggio();

        alloggio.setNum_alloggio(num_alloggio);
        alloggio.setTipo(tipo);
        alloggio.setCapienza(capienza);
        alloggio.setOccupato(occupato);
        alloggio.setData_inizio(data_inizio);
        alloggio.setData_fine(data_fine);
        alloggio.setPrezzonotte(prezzonotte);

        try {
            String sql
                    = " INSERT INTO ALLOGGIO "
                    + " (num_alloggio,"
                    + " tipo,"
                    + " capienza,"
                    + " occupato,"
                    + " data_inizio,"
                    + " data_fine,"
                    + " prezzonotte,"
                    + " ) "
                    + " VALUES (?,?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, alloggio.getNum_alloggio());
            ps.setString(i++, alloggio.getTipo());
            ps.setString(i++, alloggio.getCapienza());
            ps.setString(i++, alloggio.getOccupato());
            ps.setDate(i++, alloggio.getData_inizio());
            ps.setDate(i++, alloggio.getData_fine());

            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                alloggio.setNum_alloggio(generatedKeys.getLong(1));
            } else {
                throw new SQLException("Creazione alloggio fallita, nessun numero assegnato.");
            }
            generatedKeys.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return alloggio;
    }
    public void update(Alloggio alloggio) {
        PreparedStatement ps;

        try {
            String sql
                    = " UPDATE ALLOGGIO "
                    + " SET TIPO = ?, "
                    + " CAPIENZA = ?, "
                    + " PREZZONOTTE = ? "
                    + " WHERE NUM_ALLOGGIO = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, alloggio.getTipo());
            ps.setString(i++, alloggio.getCapienza());
            ps.setLong(i++, alloggio.getPrezzonotte());
            ps.setLong(i++, alloggio.getNum_alloggio());

            int rowsUpdated = ps.executeUpdate(); // Controllore delle righe modificate con successo

            if (rowsUpdated == 0) {
                throw new SQLException("Modifica dell'alloggio fallita, nessuna riga aggiornata con successo");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Alloggio alloggio) {
        throw new UnsupportedOperationException("Not supported"); //Impossibile eliminare un alloggio
    }

    @Override
    public void booked (Alloggio alloggio){

        PreparedStatement ps;

        try{
            String sql
                    = " UPDATE ALLOGGIO "
                    + " SET OCCUPATO = 'SI' "
                    + " WHERE "
                    + " NUM_ALLOGGIO = ?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1,alloggio.getNum_alloggio());
            ps.executeUpdate();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }

    }
    @Override
    public void free(Alloggio alloggio){

        PreparedStatement ps;

        try{
            String sql
                    = " UPDATE ALLOGGIO "
                    + " SET OCCUPATO = 'NO' "
                    + " WHERE "
                    + " NUM_ALLOGGIO = ?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1,alloggio.getNum_alloggio());
            ps.executeUpdate();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }

    }
    @Override
    public void bookedDate(Long num_alloggio, Date data_inizio, Date data_fine) {
        PreparedStatement ps;

        try {
            String sql =
                    "UPDATE ALLOGGIO " +
                            "SET occupato = 'SI' " +
                            "WHERE Num_alloggio = ? " +
                            "AND data_inizio <= ? AND data_fine >= ?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, num_alloggio);
            ps.setDate(2, new java.sql.Date(data_fine.getTime()));
            ps.setDate(3, new java.sql.Date(data_inizio.getTime()));


            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public List<Alloggio> findAll(){
        ArrayList <Alloggio> alloggi = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT * "
                    + " FROM ALLOGGIO ";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Alloggio alloggio = read(resultSet);
                alloggi.add(alloggio);
                System.out.println("prenotazione trovata: " + alloggio.getNum_alloggio());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return alloggi;
    }
    @Override
    public List<Alloggio> findDisponibili(String tipo, String capienza, Date data_inizio, Date data_fine) {
        List<Alloggio> alloggi = new ArrayList<>();
        PreparedStatement ps;

        try {
            String sql = "SELECT * FROM ALLOGGIO " +
                    "WHERE tipo = ? " +
                    "AND capienza = ? " +
                    "AND occupato = 'NO' " +
                    "AND (data_inizio IS NULL OR data_inizio > ?) " +
                    "AND (data_fine IS NULL OR data_fine < ?)";

            ps = conn.prepareStatement(sql);
            ps.setString(1, tipo);
            ps.setString(2, capienza);
            ps.setDate(3, new java.sql.Date(data_inizio.getTime()));
            ps.setDate(4, new java.sql.Date(data_fine.getTime()));

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                Alloggio alloggio = read(resultSet);
                alloggi.add(alloggio);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return alloggi;
    }
    @Override
    public List<Alloggio> findDisponibilita(String tipo, String capienza, Date data_inizio, Date data_fine) {
        List<Alloggio> alloggiDisponibili = new ArrayList<>();
        PreparedStatement ps;

        System.out.println( capienza + tipo + data_inizio + data_fine);
        try {
            String sql = "SELECT * FROM ALLOGGIO " +
                    "WHERE NUM_ALLOGGIO NOT IN (" +
                    "    SELECT NUM_ALLOGGIO " +
                    "    FROM prenotazione " +
                    "    WHERE " +
                    "       ( (data_checkin BETWEEN ? AND ?) " +
                    "        OR " +
                    "        (data_checkout BETWEEN ? AND ?) " +
                    "        OR " +
                    "        (data_checkin <= ? AND data_checkout >= ?) ) " +
                    "    AND stato <> 'Cancellata' " +
                    ") " +
                    "AND tipo = ? " +
                    "AND capienza = ? " +
                    "AND occupato = 'NO'";

            ps = conn.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(data_inizio.getTime()));
            ps.setDate(2, new java.sql.Date(data_fine.getTime()));
            ps.setDate(3, new java.sql.Date(data_inizio.getTime()));
            ps.setDate(4, new java.sql.Date(data_fine.getTime()));
            ps.setDate(5, new java.sql.Date(data_inizio.getTime()));
            ps.setDate(6, new java.sql.Date(data_fine.getTime()));
            ps.setString(7, tipo);
            ps.setString(8, capienza);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                Alloggio alloggio = read(resultSet);
                alloggiDisponibili.add(alloggio);
            }
            System.out.println("Parametri di ricerca: tipo=" + tipo + ", capienza=" + capienza + ", data_checkin=" + data_inizio + ", data_checkout=" + data_fine);
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return alloggiDisponibili;
    }
    @Override
    public Alloggio findByNum_alloggio (Long num_alloggio){

        PreparedStatement ps;
        Alloggio alloggio = null;

        try{

            String sql
                    = " SELECT *"
                    + " FROM ALLOGGIO "
                    + " WHERE "
                    + " num_alloggio = ?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, num_alloggio);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()){
                alloggio = read(resultSet);
            }
            resultSet.close();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return alloggio;
    }

    @Override
    public Alloggio findByCapienza (String capienza){
        PreparedStatement ps;
        Alloggio alloggio = null;

        try{

            String sql
                    = " SELECT *"
                    + " FROM ALLOGGIO "
                    + " WHERE "
                    + " capienza = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, capienza);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()){
                alloggio = read(resultSet);
            }
            resultSet.close();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return alloggio;
    }

    Alloggio read (ResultSet rs) {
        Alloggio alloggio = new Alloggio();
        try {
            alloggio.setNum_alloggio(rs.getLong("NUM_ALLOGGIO"));
        } catch (SQLException sqle) {
        }
        try {
            alloggio.setTipo(rs.getString("TIPO"));
        } catch (SQLException sqle) {
        }
        try {
            alloggio.setCapienza(rs.getString("CAPIENZA"));
        } catch (SQLException sqle) {
        }
        try {
            alloggio.setData_inizio(rs.getDate("DATA_INIZIO"));
        } catch (SQLException sqle) {
        }
        try {alloggio.setData_fine(rs.getDate("DATA_FINE"));
        } catch (SQLException sqle){
        }
        try {
            alloggio.setOccupato(rs.getString("OCCUPATO"));
        } catch (SQLException sqle){
        }
        try{ alloggio.setPrezzonotte(rs.getLong("PREZZONOTTE"));
        } catch (SQLException sqle){
        }
        return alloggio;
    }
}



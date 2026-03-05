package com.villagevista.villagevista.Model.Dao.mySQLJDBCImpl;

import com.villagevista.villagevista.Model.Mo.Cliente;
import com.villagevista.villagevista.Model.Mo.Dipendente;
import com.villagevista.villagevista.Model.Dao.Turno_lavoroDAO;
import com.villagevista.villagevista.Model.Mo.Prenotazione;
import com.villagevista.villagevista.Model.Mo.Turno_lavoro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Turno_lavoroDAOMySQLJDBCImpl implements Turno_lavoroDAO{

Connection conn;

public Turno_lavoroDAOMySQLJDBCImpl(Connection conn){this.conn = conn;}

    @Override
    public Turno_lavoro create(
            Long id_dip_turno,
            String ora_inizio,
            String ora_fine,
            String cognome_turno,
            Date data_turno,
            Dipendente dipendente) {

        PreparedStatement ps;
        Turno_lavoro turno_lavoro = new Turno_lavoro();

        turno_lavoro.setId_dip_turno(id_dip_turno);
        turno_lavoro.setOra_inizio(ora_inizio);
        turno_lavoro.setOra_fine(ora_fine);
        turno_lavoro.setCognome_turno(cognome_turno);
        turno_lavoro.setData_turno(data_turno);
        turno_lavoro.setDipendente(dipendente);

        try{
            String sql
                    = " INSERT INTO TURNO_LAVORO "
                    + " ( ID_DIP_TURNO, "
                    + " ORA_INIZIO, "
                    + " ORA_FINE, "
                    + " COGNOME_TURNO, "
                    + " DATA_TURNO )"
                    + " VALUES (?,?,?,?,?)";

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            int i = 1;
            ps.setLong(i++, turno_lavoro.getId_dip_turno());
            ps.setString(i++, turno_lavoro.getOra_inizio());
            ps.setString(i++, turno_lavoro.getOra_fine());
            ps.setString(i++, turno_lavoro.getCognome_turno());
            ps.setDate(i++, turno_lavoro.getData_turno());

            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                turno_lavoro.setTurno_id(generatedKeys.getLong(1));
            } else {
                throw new SQLException("Creazine turno di lavoro fallita, nessun ID assegnato.");
            }
            generatedKeys.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return turno_lavoro;

    }

    @Override
    public void update (Turno_lavoro turno_lavoro){
    PreparedStatement ps;

    try{
        String sql
                = " UPDATE TURNO_LAVORO "
                + " SET ID_DIP_TURNO = ?, "
                + " ORA_INIZIO = ?, "
                + " ORA_FINE = ?, "
                + " DATA_TURNO = ?, "
                + " COGNOME_TURNO = ? "
                + " WHERE TURNO_ID = ? ";

        ps = conn.prepareStatement(sql);
        int i = 1;
        ps.setLong(i++, turno_lavoro.getId_dip_turno());
        ps.setString(i++, turno_lavoro.getOra_inizio());
        ps.setString(i++, turno_lavoro.getOra_fine());
        ps.setDate(i++, turno_lavoro.getData_turno());
        ps.setString(i++, turno_lavoro.getCognome_turno());
        ps.setLong(i++, turno_lavoro.getTurno_id());

        int rowsUpdated = ps.executeUpdate(); //Controllore delle righe modificate con successo

        if (rowsUpdated == 0) {
            throw new SQLException("Modifica del turno di lavoro fallita, nessuna riga aggiunta con successo");
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    }
    public void delete(Long turno_id) {
        PreparedStatement ps = null;
        try {
            String sql = "DELETE FROM TURNO_LAVORO WHERE turno_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setLong(1, turno_id);

            int rowsDeleted = ps.executeUpdate(); // Controllo delle righe rimosse
            if (rowsDeleted == 0) {
                throw new SQLException("Eliminazione del cliente fallita, nessuna riga rimossa con successo");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    @Override
    public Turno_lavoro findByCognome_turno(String cognome_turno){

        PreparedStatement ps;
        Turno_lavoro turno_lavoro= null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM TURNO_LAVORO "
                    + " WHERE "
                    + "   COGNOME_TURNO = ? ";


            ps = conn.prepareStatement(sql);
            ps.setString(1, cognome_turno);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
               turno_lavoro = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return turno_lavoro;

    }

    @Override
    public List<Turno_lavoro> findByIdDipTurno(Long id_dip_turno){


        ArrayList<Turno_lavoro> turni_lavoro = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT *"
                    + " FROM TURNO_LAVORO "
                    + " WHERE id_dip_turno = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, id_dip_turno);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Turno_lavoro turno_lavoro = read(resultSet);
                turni_lavoro.add(turno_lavoro);
                System.out.println("turno trovato: " + turno_lavoro.getTurno_id());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return turni_lavoro;
    }
    @Override
    public Turno_lavoro findByData_turno(Date data_turno){

        PreparedStatement ps;
        Turno_lavoro turno_lavoro= null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM TURNO_LAVORO "
                    + " WHERE "
                    + "   DATA_TURNO = ? ";


            ps = conn.prepareStatement(sql);
            ps.setDate(1,  data_turno);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                turno_lavoro = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return turno_lavoro;
     }

    @Override
    public List<Turno_lavoro> findAllTurni(String cognome_turno){


        ArrayList<Turno_lavoro> turni_lavoro = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT *"
                    + " FROM TURNO_LAVORO "
                    + " WHERE cognome_turno = ? ";

            ps = conn.prepareStatement(sql);
            ps.setString(1, cognome_turno);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Turno_lavoro turno_lavoro = read(resultSet);
                turni_lavoro.add(turno_lavoro);
                System.out.println("turno trovato: " + turno_lavoro.getTurno_id());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return turni_lavoro;
    }
    @Override
    public List<Turno_lavoro> findAll(){


        ArrayList <Turno_lavoro> turni_lavoro = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT *"
                    + " FROM TURNO_LAVORO ";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Turno_lavoro turno_lavoro = read(resultSet);
                turni_lavoro.add(turno_lavoro);
                System.out.println("prenotazione trovata: " + turno_lavoro.getTurno_id());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return turni_lavoro;
    }
    @Override
    public Turno_lavoro findByTurnoId(Long turno_id) {

        PreparedStatement ps;
        Turno_lavoro turno_lavoro = null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM TURNO_LAVORO "
                    + " WHERE "
                    + "   turno_id = ? ";


            ps = conn.prepareStatement(sql);
            ps.setLong(1, turno_id);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                turno_lavoro = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return turno_lavoro;

    }



    Turno_lavoro read (ResultSet rs){

     Turno_lavoro turno_lavoro = new Turno_lavoro();

     Dipendente dipendente = new Dipendente();
     turno_lavoro.setDipendente(dipendente);

    try {
        turno_lavoro.setTurno_id(rs.getLong("TURNO_ID"));
    } catch (SQLException sqle){
    }
    try{
        turno_lavoro.setId_dip_turno(rs.getLong("ID_DIP_TURNO"));
    } catch (SQLException sqle){
    }
    try {
        turno_lavoro.setOra_inizio(rs.getString("ORA_INIZIO"));
    } catch (SQLException sqle){
    }
    try {
        turno_lavoro.setOra_fine(rs.getString("ORA_FINE"));
    } catch (SQLException sqle){
    }
      try {
          turno_lavoro.setData_turno(rs.getDate("DATA_TURNO"));
      } catch (SQLException sqle){
      }
      try {
          turno_lavoro.setCognome_turno(rs.getString("COGNOME_TURNO"));
      } catch(SQLException sqle){

      }
      return turno_lavoro;
    }


}

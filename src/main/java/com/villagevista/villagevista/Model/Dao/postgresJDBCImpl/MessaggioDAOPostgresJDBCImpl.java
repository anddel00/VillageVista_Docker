package com.villagevista.villagevista.Model.Dao.postgresJDBCImpl;

import com.villagevista.villagevista.Model.Dao.MessaggioDAO;
import com.villagevista.villagevista.Model.Mo.Cliente;
import com.villagevista.villagevista.Model.Mo.Messaggio;
import com.villagevista.villagevista.Model.Mo.Prenotazione;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessaggioDAOPostgresJDBCImpl implements MessaggioDAO {

    Connection conn;

    public MessaggioDAOPostgresJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Messaggio create(
            Long id_messaggio_cliente,
            Long id_messaggio,
            String testo,
            String letto
    ) {

        PreparedStatement ps;
        ResultSet generatedKeys;

        Messaggio messaggio = new Messaggio();

        messaggio.setId_messaggio_cliente(id_messaggio_cliente);
        messaggio.setId_messaggio(id_messaggio);
        messaggio.setTesto(testo);
        messaggio.setLetto(letto);

        try {
            String sql
                    = " INSERT INTO MESSAGGIO "
                    + " (id_messaggio_cliente,"
                    + " testo,"
                    + " letto,"
                    + " ) "
                    + " VALUES (?,?,?,)";

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            int i = 1;
            ps.setLong(i++, messaggio.getId_messaggio_cliente());
            ps.setString(i++, messaggio.getTesto());
            ps.setString(i++, messaggio.getletto());

            ps.executeUpdate();

            generatedKeys = ps.getGeneratedKeys();

            if (generatedKeys.next()) {
                messaggio.setId_messaggio(generatedKeys.getLong(1));
            } else {
                throw new SQLException("Creazione prenotazione fallita, nessun ID assegnato.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return messaggio;
    }


    public void delete(Long id_messaggio) {
        PreparedStatement ps = null;
        try {
            String sql = "DELETE FROM MESSAGGIO WHERE ID_MESSAGGIO = ?";
            ps = conn.prepareStatement(sql);
            ps.setLong(1, id_messaggio);

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

    Messaggio read (ResultSet rs){
        Messaggio messaggio = new Messaggio();

        try {
            messaggio.setId_messaggio_cliente(rs.getLong("ID_MESSAGGIO_CLIENTE"));
        }catch(SQLException sqle){
        }
        try {
            messaggio.setId_messaggio(rs.getLong("ID_MESSAGGIO"));
        }catch (SQLException sqle){
        }
        try {
            messaggio.setTesto(rs.getString("TESTO"));
        }catch (SQLException sqle){
        }
        try {
            messaggio.setLetto(rs.getString("LETTO"));
        } catch (SQLException sqle){
        }

        return messaggio;
    }
}


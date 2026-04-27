package com.villagevista.villagevista.Model.Dao.postgresJDBCImpl;

import com.villagevista.villagevista.Model.Dao.PrenotazioneDAO;
import com.villagevista.villagevista.Model.Mo.Cliente;
import com.villagevista.villagevista.Model.Mo.Prenotazione;
import com.villagevista.villagevista.Model.Mo.Turno_lavoro;

import java.sql.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


public class PrenotazioneDAOPostgresJDBCImpl implements PrenotazioneDAO {
    Connection conn;

    public PrenotazioneDAOPostgresJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Prenotazione create(
            Date data_checkin,
            Date data_checkout,
            Long num_alloggio,
            Long id_cliente,
            Long persone,
            String alloggio,       // Spostato in ordine corretto
            String cognome_p,      // Spostato in ordine corretto
            Long totale,
            String pagato,
            String stato
    ) {

        PreparedStatement ps;
        ResultSet generatedKeys;

        Prenotazione prenotazione = new Prenotazione();
        prenotazione.setData_checkin(data_checkin);
        prenotazione.setData_checkout(data_checkout);
        prenotazione.setNum_alloggio(num_alloggio);
        prenotazione.setId_cliente(id_cliente);
        prenotazione.setPersone(persone);
        prenotazione.setAlloggio(alloggio);       // Impostato in ordine corretto
        prenotazione.setCognomeP(cognome_p);      // Impostato in ordine corretto
        prenotazione.setTotale(totale);
        prenotazione.setPagato(pagato);
        prenotazione.setStato(stato);

        try {
            String sql
                        = "INSERT INTO prenotazione "
                    + " (data_checkin, "
                    + " data_checkout, "
                    + " num_alloggio, "
                    + " id_cliente, "
                    + " persone, "
                    + " alloggio, "
                    + " cognome_p, "
                    + " totale, "
                    + " pagato, "
                    + " stato "
                    + " ) "
                    + " VALUES (?,?,?,?,?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            int i = 1;
            ps.setDate(i++, prenotazione.getDataCheckin());
            ps.setDate(i++, prenotazione.getDataCheckout());
            ps.setLong(i++, prenotazione.getNum_alloggio());
            ps.setLong(i++, prenotazione.getId_cliente());
            ps.setLong(i++, prenotazione.getPersone());
            ps.setString(i++, prenotazione.getAlloggio());
            ps.setString(i++, prenotazione.getCognomeP());
            ps.setLong(i++, prenotazione.getTotale());
            ps.setString(i++, prenotazione.getPagato());
            ps.setString(i++, prenotazione.getStato());

            ps.executeUpdate();

            generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                prenotazione.setNum_prenotazione(generatedKeys.getLong(1));
            } else {
                throw new SQLException("Creazione prenotazione fallita, nessun ID assegnato.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return prenotazione;
    }

    @Override
    public void update(Prenotazione prenotazione) {
        PreparedStatement ps;

        try {
            String sql
                    = " UPDATE prenotazione "
                    + " SET data_checkin = ?, "
                    + " data_checkout = ?, "
                    + " cognome_p = ? "
                    + " WHERE num_prenotazione = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setDate(i++, prenotazione.getDataCheckin());
            ps.setDate(i++, prenotazione.getDataCheckout());
            ps.setString(i++, prenotazione.getCognomeP());
            ps.setLong(i++, prenotazione.getNumPrenotazione());

            int rowsUpdated = ps.executeUpdate(); //Controllore delle righe modificate con successo
            if (rowsUpdated == 0) {
                throw new SQLException("Modifica della prenotazione fallita, nessuna riga modificata con successo");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override public void delete(Long num_prenotazione){

        PreparedStatement ps;
        try{

            String sql =
                         " UPDATE prenotazione " +
                         " SET stato = 'Cancellata' " +
                         " WHERE Num_Prenotazione = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, num_prenotazione);

            int rowsDeleted = ps.executeUpdate(); //Controllore delle righe rimosse
            if(rowsDeleted == 0){
                throw new SQLException("nessuna riga rimossa con successo");
            }
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        }
    @Override public void confirm(Long num_prenotazione){

        PreparedStatement ps;
        try{

            String sql =
                    " UPDATE prenotazione " +
                            " SET pagato = 'già pagato' " +
                            " WHERE Num_Prenotazione = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, num_prenotazione);

            int rowsDeleted = ps.executeUpdate(); //Controllore delle righe rimosse
            if(rowsDeleted == 0){
                throw new SQLException("nessuna riga rimossa con successo");
            }
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

        @Override
    public Prenotazione findByNum_prenotazione (Long num_prenotazione){

        PreparedStatement ps;
        Prenotazione prenotazione = null;

        try{
            String sql
                    = " SELECT *"
                    + " FROM prenotazione "
                    + " WHERE num_prenotazione = ?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, num_prenotazione);

            ResultSet resultSet = ps.executeQuery();

            if(resultSet.next()){
                prenotazione = read(resultSet);
        }
            resultSet.close();
            ps.close();
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return prenotazione;
    }
     @Override
     public List <Prenotazione> findByCognome_cliente (String cognome_p){
        ArrayList<Prenotazione> prenotazioni = new ArrayList<>();
         PreparedStatement ps;


         try{
             String sql
                     = " SELECT *"
                     + " FROM prenotazione "
                     + " WHERE cognome_p = ?"
                     + " AND stato <> 'Cancellata' ";

             ps = conn.prepareStatement(sql);
             ps.setString(1, cognome_p);
             ResultSet resultSet = ps.executeQuery();

             while(resultSet.next()){
                 Prenotazione prenotazione = read(resultSet);
                 prenotazioni.add(prenotazione);
             }

             resultSet.close();
             ps.close();

         } catch (SQLException e){
             e.printStackTrace();
             throw new RuntimeException(e);
         }
         return prenotazioni;
     }
    @Override
    public List <Prenotazione> findByClienteId(Long id_cliente){
        ArrayList<Prenotazione> prenotazioniCliente = new ArrayList<>();
        PreparedStatement ps;


        try{
            String sql
                    = " SELECT *"
                    + " FROM prenotazione "
                    + " WHERE id_cliente = ?"
                    + " AND stato <> 'Cancellata' ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, id_cliente);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Prenotazione prenotazione = read(resultSet);
                prenotazioniCliente.add(prenotazione);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return prenotazioniCliente;
    }
    @Override
    public List <Prenotazione> findCancellateCliente(String cognome_p){

        ArrayList<Prenotazione> cancprenotazioni = new ArrayList<>();
        PreparedStatement ps;


        try{
            String sql
                    = " SELECT *"
                    + " FROM prenotazione "
                    + " WHERE cognome_p = ?"
                    + " AND stato = 'Cancellata'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, cognome_p);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Prenotazione prenotazione = read(resultSet);
                cancprenotazioni.add(prenotazione);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return cancprenotazioni;
    }
    @Override
    public List <Prenotazione> findCancellate(){

        ArrayList<Prenotazione> deletedprenotazioni = new ArrayList<>();
        PreparedStatement ps;


        try{
            String sql
                    = " SELECT *"
                    + " FROM prenotazione "
                    + " WHERE stato = 'Cancellata' ";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Prenotazione prenotazione = read(resultSet);
                deletedprenotazioni.add(prenotazione);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return deletedprenotazioni;
    }
    @Override
    public List<Prenotazione> findAll(){
        ArrayList <Prenotazione> prenotazioni = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT *"
                    + " FROM prenotazione ";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Prenotazione prenotazione = read(resultSet);
                prenotazioni.add(prenotazione);
                System.out.println("prenotazione trovata: " + prenotazione.getNumPrenotazione());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return prenotazioni;
    }

    @Override
    public List<Prenotazione> findAllWithCliente() {
        ArrayList<Prenotazione> prenotazioni = new ArrayList<>();
        PreparedStatement ps;

        try {
            String sql = "SELECT p.*, c.nome_cliente, c.cognome_cliente, c.email, c.telefono " +
                         "FROM prenotazione p " +
                         "JOIN cliente c ON p.id_cliente = c.num_p " +
                         "WHERE p.stato <> 'Cancellata' " +
                         "ORDER BY p.data_checkin ASC";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()) {
                Prenotazione prenotazione = read(resultSet);
                
                // Popoliamo i dati del cliente estrapolati dalla JOIN
                Cliente cliente = new Cliente();
                cliente.setNome_cliente(resultSet.getString("nome_cliente"));
                cliente.setCognome_cliente(resultSet.getString("cognome_cliente"));
                cliente.setEmail(resultSet.getString("email"));
                cliente.setTelefono(resultSet.getString("telefono"));
                prenotazione.setCliente(cliente);
                
                prenotazioni.add(prenotazione);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return prenotazioni;
    }
    @Override
    public List<Prenotazione> findByMese(int mese) {
        ArrayList<Prenotazione> prenotazioni = new ArrayList<>();
        PreparedStatement ps;

        try {
            // Costruiamo la query in base al mese specificato usando data_checkin
            String sql = "SELECT * FROM prenotazione " +
                    "WHERE EXTRACT(MONTH FROM data_checkin) = ?" +
                    " AND stato <> 'Cancellata'";

            System.out.println("Chiamato findByMese con mese = " + mese);

            ps = conn.prepareStatement(sql);
            ps.setInt(1, mese);
            ResultSet resultSet = ps.executeQuery();



            while (resultSet.next()) {
                Prenotazione prenotazione = read(resultSet);
                prenotazioni.add(prenotazione);
                System.out.println("Prenotazione trovata: " + prenotazione.getNumPrenotazione());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return prenotazioni;
    }

        public int countByCliente(Long id_cliente){
            int count = 0;
            String query = "SELECT COUNT(*) FROM prenotazione " +
                    " WHERE id_cliente = ? " +
                    " AND stato <> 'Cancellata' ";

            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setLong(1, id_cliente);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
            return count;
        }

    @Override public void deleteforever(Long num_prenotazione){

        PreparedStatement ps;
        try{

            String sql =
                             " DELETE FROM prenotazione " +
                             " WHERE num_prenotazione = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, num_prenotazione);

            int rowsDeleted = ps.executeUpdate(); //Controllore delle righe rimosse
            if(rowsDeleted == 0){
                throw new SQLException("nessuna riga rimossa con successo");
            }
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

    Prenotazione read(ResultSet rs) {
        Prenotazione prenotazione = new Prenotazione();
        Cliente cliente = new Cliente(); // Assicurati di avere un costruttore senza argomenti per Cliente

        try {
            prenotazione.setNum_prenotazione(rs.getLong("num_prenotazione"));
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        try {
            prenotazione.setData_checkin(rs.getDate("data_checkin"));
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        try {
            prenotazione.setData_checkout(rs.getDate("data_checkout"));
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        try{
            prenotazione.setNum_alloggio(rs.getLong("num_alloggio"));
        } catch (SQLException sqle){
            sqle.printStackTrace();
        }
        try{
            prenotazione.setId_cliente(rs.getLong("id_cliente"));
        } catch (SQLException sqle){
            sqle.printStackTrace();
        }
        try {
            prenotazione.setCognomeP(rs.getString("cognome_p"));
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        try {
            prenotazione.setPersone(rs.getLong("persone"));
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        try {
            prenotazione.setAlloggio(rs.getString("alloggio"));
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        try{
            prenotazione.setTotale(rs.getLong("totale"));
        } catch (SQLException sqle){
            sqle.printStackTrace();
        }
        try{
            prenotazione.setPagato(rs.getString("pagato"));
        } catch (SQLException sqle){
            sqle.printStackTrace();
        }
        try{
            prenotazione.setStato(rs.getString("stato"));
        } catch (SQLException sqle){
            sqle.printStackTrace();
        }
        return prenotazione;
    }


}

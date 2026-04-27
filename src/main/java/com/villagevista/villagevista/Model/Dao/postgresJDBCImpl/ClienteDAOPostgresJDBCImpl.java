package com.villagevista.villagevista.Model.Dao.postgresJDBCImpl;

import com.villagevista.villagevista.Model.Dao.ClienteDAO;
import com.villagevista.villagevista.Model.Mo.Admin;
import com.villagevista.villagevista.Model.Mo.Cliente;
import com.villagevista.villagevista.Model.Mo.Prenotazione;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAOPostgresJDBCImpl implements ClienteDAO {
    Connection conn;

    public ClienteDAOPostgresJDBCImpl(Connection conn) {this.conn = conn;}

    @Override
    public Cliente create(
            String nome_cliente,
            String cognome_cliente ,
            String telefono,
            String email,
            String user_cliente,
            String pass_cliente
            ){

        PreparedStatement ps;
        ResultSet generatedKeys;

        Cliente cliente = new Cliente();


       cliente.setNome_cliente(nome_cliente);
       cliente.setCognome_cliente(cognome_cliente);
       cliente.setTelefono(telefono);
       cliente.setEmail(email);
       cliente.setUser_cliente(user_cliente);
       cliente.setPass_cliente(pass_cliente);


       try {

           String sql
                   = " INSERT INTO CLIENTE "
                   + " ( "
                   + " nome_cliente, "
                   + " cognome_cliente, "
                   + " telefono, "
                   + " email, "
                   + " user_cliente, "
                   + " pass_cliente "
                   + " ) "
                   + " VALUES (?,?,?,?,?,?)";

           ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
           int i = 1;

           ps.setString(i++, cliente.getNome_cliente());
           ps.setString(i++, cliente.getCognome_cliente());
           ps.setString(i++, cliente.getTelefono());
           ps.setString(i++, cliente.getEmail());
           ps.setString(i++, cliente.getUser_cliente());
           ps.setString(i++, cliente.getPass_cliente());

           ps.executeUpdate();

           generatedKeys = ps.getGeneratedKeys();
           if (generatedKeys.next()) {
               cliente.setNum_p(generatedKeys.getLong(1));
           } else {
               throw new SQLException("Creazione prenotazione fallita, nessun ID assegnato.");
           }
       } catch (SQLException e) {
           throw new RuntimeException(e);
       }
        return cliente;
    }


    @Override
    public void update(Cliente cliente) {
        PreparedStatement ps;

        try{
            String sql
                    = " UPDATE CLIENTE "
                    + " SET "
                    + " nome_cliente = ?, "
                    + " cognome_cliente = ?, "
                    + " telefono = ?, "
                    + " email = ?, "
                    + " user_cliente = ?, "
                    + " pass_cliente = ? "
                    + " WHERE "
                    + " num_p = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, cliente.getNome_cliente());
            ps.setString(i++, cliente.getCognome_cliente());
            ps.setString(i++, cliente.getEmail());
            ps.setString(i++, cliente.getTelefono());
            ps.setString(i++, cliente.getUser_cliente());
            ps.setString(i++, cliente.getPass_cliente());
            ps.setLong(i++, cliente.getNum_p());

            int rowsUpdated = ps.executeUpdate(); //Controllore delle righe modificate con successo

            if (rowsUpdated == 0) {
                throw new SQLException("Modifica dell'admin fallita, nessuna riga aggiunta con successo");
            }

        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }


    public void delete(Long num_p) {
        PreparedStatement ps = null;
        try {
            String sql = "DELETE FROM CLIENTE WHERE num_p = ?";
            ps = conn.prepareStatement(sql);
            ps.setLong(1, num_p);

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
    public Cliente findByUser_cliente(String user_cliente){
        PreparedStatement ps;
        Cliente cliente = null;
        try{
            String sql
                    =" SELECT * "
                    +" FROM CLIENTE "
                    +" WHERE "
                    +" USER_CLIENTE = ?";

            ps= conn.prepareStatement(sql);
            ps.setString(1, user_cliente);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()){
                cliente = read(resultSet);
            }
            resultSet.close();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return cliente;
    }

     @Override
    public Cliente findByCognome_cliente(String cognome_cliente){
        PreparedStatement ps;
        Cliente cliente = null;

        try{
            String sql
                    = " SELECT *"
                    +" FROM CLIENTE "
                    + " WHERE "
                    + " cognome_cliente = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1,cognome_cliente);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()){
                cliente = read(resultSet);
            }
            resultSet.close();
            ps.close();
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return cliente;
     }
    @Override
    public Cliente findByNum_P(Long num_p){
        PreparedStatement ps;
        Cliente cliente = null;

        try{
            String sql
                    = " SELECT *"
                    +" FROM CLIENTE "
                    + " WHERE "
                    + " num_p = ?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1,num_p);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()){
                cliente = read(resultSet);
            }
            resultSet.close();
            ps.close();
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return cliente;
    }
    @Override
    public List<Cliente> findAllClienti(){


        ArrayList<Cliente> clienti = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT * "
                    + " FROM CLIENTE ";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Cliente cliente = read(resultSet);
                clienti.add(cliente);
                System.out.println("cliente trovato: " + cliente.getNum_p());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return clienti;
    }

    @Override
    public Cliente findLoggedCliente() {
        return null;
    }

    Cliente read (ResultSet rs){
        Cliente cliente = new Cliente();
        Prenotazione prenotazione = new Prenotazione();
        cliente.setPrenotazione(prenotazione);

        try {
            cliente.setNome_cliente(rs.getString("NOME_CLIENTE"));
        }catch(SQLException sqle){
        }
        try {
            cliente.setCognome_cliente(rs.getString("COGNOME_CLIENTE"));
        }catch (SQLException sqle){
        }
        try {
            cliente.setNum_p(rs.getLong("NUM_P"));
        }catch (SQLException sqle){
        }
        try {
            cliente.setTelefono(rs.getString("TELEFONO"));
        } catch (SQLException sqle){
        }
        try {
            cliente.setEmail(rs.getString("EMAIL"));
        }catch (SQLException sqle){
        }
        try{
            cliente.setUser_cliente(rs.getString("USER_CLIENTE"));
        } catch (SQLException sqle){
        }
        try{
            cliente.setPass_cliente(rs.getString("PASS_CLIENTE"));
        } catch (SQLException sqle){
        }

        return cliente;
    }


}


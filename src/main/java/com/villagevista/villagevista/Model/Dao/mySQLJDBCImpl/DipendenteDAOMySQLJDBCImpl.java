package com.villagevista.villagevista.Model.Dao.mySQLJDBCImpl;

import com.villagevista.villagevista.Model.Dao.DipendenteDAO;
import com.villagevista.villagevista.Model.Mo.Admin;
import com.villagevista.villagevista.Model.Mo.Cliente;
import com.villagevista.villagevista.Model.Mo.Dipendente;
import com.villagevista.villagevista.Model.Mo.Turno_lavoro;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DipendenteDAOMySQLJDBCImpl implements DipendenteDAO {
    Connection conn;

    public DipendenteDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Dipendente create(
            String cf_dip,
            String nome_dip,
            String cognome_dip,
            String user_dip,
            String pass_dip,
            Date data_n,
            Float salario
    ) {

        PreparedStatement ps;
        Dipendente dipendente = new Dipendente();

        dipendente.setCf_dip(cf_dip);
        dipendente.setNome_dip(nome_dip);
        dipendente.setCognome_dip(cognome_dip);
        dipendente.setUser_dip(user_dip);
        dipendente.setPass_dip(pass_dip);
        dipendente.setData_n(data_n);
        dipendente.setSalario(salario);

        try {
            String sql
                    = " INSERT INTO DIPENDENTE "
                    + "( cf_dip,"
                    + " nome_dip,"
                    + " cognome_dip,"
                    + " user_dip, "
                    + " pass_dip, "
                    + " data_n,"
                    + " salario "
                    + " ) "
                    + " VALUES (?,?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            int i = 1;
            ps.setString(i++, dipendente.getCf_dip());
            ps.setString(i++, dipendente.getNome_dip());
            ps.setString(i++, dipendente.getCognome_dip());
            ps.setString(i++, dipendente.getUser_dip());
            ps.setString(i++, dipendente.getPass_dip());
            ps.setDate(i++, dipendente.getData_n());
            ps.setFloat(i++, dipendente.getSalario());

            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                dipendente.setDipId(generatedKeys.getLong(1));
            } else {
                throw new SQLException("Creazione dipendente fallita, nessun ID assegnato.");
            }
            generatedKeys.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return dipendente;
    }

    @Override
    public void update(Dipendente dipendente) {
        PreparedStatement ps;

        try {
            String sql
                    = " UPDATE DIPENDENTE "
                    + " SET cf_dip = ?, "
                    + " nome_dip = ?, "
                    + " cognome_dip = ?, "
                    + " user_dip = ?, "
                    + " pass_dip = ?, "
                    + " data_n = ?, "
                    + " salario = ?"
                    + " WHERE dipId = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, dipendente.getCf_dip());
            ps.setString(i++, dipendente.getNome_dip());
            ps.setString(i++, dipendente.getCognome_dip());
            ps.setString(i++, dipendente.getUser_dip());
            ps.setString(i++, dipendente.getPass_dip());
            ps.setDate(i++, dipendente.getData_n());
            ps.setFloat(i++, dipendente.getSalario());
            ps.setLong(i++, dipendente.getDipId());

            int rowsUpdated = ps.executeUpdate(); //Controllore delle righe modificate con successo

            if (rowsUpdated == 0) {
                throw new SQLException("Modifica del dipendente fallita, nessuna riga aggiunta con successo");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void delete(Long dipId){

        PreparedStatement ps;
        try{

            String sql
                    = "DELETE FROM DIPENDENTE WHERE DipId = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1,dipId);

            int rowsDeleted = ps.executeUpdate(); //Controllore delle righe rimosse
            if(rowsDeleted == 0){
                throw new SQLException("Eliminazione del dipendente fallita, nessuna riga rimossa con successo");
            }

        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }
    @Override
    public Dipendente findByDipId(Long dipId) {

        PreparedStatement ps;
        Dipendente dipendente = null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM DIPENDENTE "
                    + " WHERE "
                    + "   dipId = ? ";


            ps = conn.prepareStatement(sql);
            ps.setLong(1, dipId);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                dipendente = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return dipendente;

    }
    @Override
    public Dipendente findLoggedDipendente(){throw new UnsupportedOperationException("not supported");}

    @Override
    public Dipendente findByCf_dip(String Cf_dip){throw new UnsupportedOperationException("not supported");}

    @Override
    public Dipendente findByUser_dip(String user_dip){
        PreparedStatement ps;
        Dipendente dipendente = null;
        try{
            String sql
                    =" SELECT * "
                    +" FROM DIPENDENTE "
                    +" WHERE "
                    +" USER_DIP = ?";

            ps= conn.prepareStatement(sql);
            ps.setString(1, user_dip);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()){
                dipendente = read(resultSet);
            }
            resultSet.close();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return dipendente;
    }

    @Override
    public List<Dipendente> findAllDipendenti(){


        ArrayList<Dipendente> dipendenti = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT *"
                    + " FROM DIPENDENTE ";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Dipendente dipendente = read(resultSet);
                dipendenti.add(dipendente);
                System.out.println("cliente trovato: " + dipendente.getDipId());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return dipendenti;
    }


    Dipendente read (ResultSet rs){
        Dipendente dipendente = new Dipendente();

        try {
            dipendente.setDipId(rs.getLong("DipId"));
        }catch (SQLException sqle){
        }
        try {
            dipendente.setNome_dip(rs.getString("NOME_DIP"));
        }catch(SQLException sqle){
        }
        try {
            dipendente.setCognome_dip(rs.getString("COGNOME_DIP"));
        }catch (SQLException sqle){
        }
        try{
            dipendente.setUser_dip(rs.getString("USER_DIP"));
        } catch (SQLException sqle){

        }
        try {
            dipendente.setPass_dip(rs.getString("PASS_DIP"));
        } catch (SQLException sqle){

        }
        try {
            dipendente.setSalario(rs.getFloat("SALARIO"));
        } catch (SQLException sqle){

        }
        try {
            dipendente.setCf_dip(rs.getString("CF_DIP"));
        }catch (SQLException sqle){
        }
        try {
            dipendente.setData_n(rs.getDate("DATA_N"));
        } catch (SQLException sqle){
        }
        return dipendente;
        }

    }





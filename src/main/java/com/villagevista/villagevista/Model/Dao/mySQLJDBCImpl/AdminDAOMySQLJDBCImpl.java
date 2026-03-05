package com.villagevista.villagevista.Model.Dao.mySQLJDBCImpl;

import com.villagevista.villagevista.Model.Dao.AdminDAO;
import com.villagevista.villagevista.Model.Mo.Admin;
import com.villagevista.villagevista.Model.Mo.Dipendente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAOMySQLJDBCImpl implements AdminDAO {
    private final String COUNTER_ID="adminId";
    Connection conn;

    public AdminDAOMySQLJDBCImpl(Connection conn) { this.conn=conn; }

    @Override
    public Admin create(
            Long adminId,
            String username,
            String password,
            String nome,
            String cognome,
            String cf_admin) {

        PreparedStatement ps = null;
        Admin admin = new Admin();

        admin.setAdminId(adminId);
        admin.setUsername(username);
        admin.setPassword(password);
        admin.setNome(nome);
        admin.setCognome(cognome);
        admin.setCf_admin(cf_admin);

        try {
            String sql
                    = "INSERT INTO ADMIN "
                    + "(ADMIN_ID, username, password, nome, cognome, cf_admin) "
                    + "VALUES (?,?,?,?,?,?)";

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            int i = 1;
            ps.setLong(i++, admin.getAdminId());
            ps.setString(i++, admin.getUsername());
            ps.setString(i++, admin.getPassword());
            ps.setString(i++, admin.getNome());
            ps.setString(i++, admin.getCognome());
            ps.setString(i++, admin.getCf_admin());

            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                admin.setAdminId(generatedKeys.getLong(1));
            } else {
                throw new SQLException("Creazione admin fallita, nessun ID assegnato.");
            }
            generatedKeys.close();

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
        return admin;
    }
    @Override
    public void update(Admin admin) {
        PreparedStatement ps;

        try{
            String sql
                    = " UPDATE ADMIN "
                    + " SET "
                    + " nome = ?, "
                    + " cognome = ?, "
                    + " cf_admin = ?, "
                    + " WHERE "
                    + " adminid = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, admin.getNome());
            ps.setString(i++, admin.getCognome());
            ps.setString(i++, admin.getCf_admin());
            ps.setLong(i++, admin.getAdminId());

            int rowsUpdated = ps.executeUpdate(); //Controllore delle righe modificate con successo

            if (rowsUpdated == 0) {
                throw new SQLException("Modifica dell'admin fallita, nessuna riga aggiunta con successo");
            }

        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }


    @Override
    public void delete(Admin admin) {throw new UnsupportedOperationException("Not supported");}

    @Override
    public Admin findLoggedAdmin() {return null;}

    @Override
    public Admin findByAdminId(Long adminId){
        PreparedStatement ps;
        Admin admin = null;
        try{
            String sql
                    =" SELECT * "
                    +" FROM ADMIN"
                    +" WHERE "
                    +" userId = ?";

            ps=conn.prepareStatement(sql);
            ps.setLong(1, adminId);

            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()){
                admin = read(resultSet);
            }
            resultSet.close();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return admin;
    }
    @Override
    public Admin findByUsername(String username){
        PreparedStatement ps;
        Admin admin = null;
        try{
            String sql
                    =" SELECT * "
                    +" FROM ADMIN "
                    +" WHERE "
                    +" username = ?";

            ps= conn.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()){
                admin = read(resultSet);
            }
            resultSet.close();
            ps.close();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return admin;
    }
    @Override
    public Admin validate(String username, String password) {
        PreparedStatement ps;
        Admin admin = null;
        try {
            String sql = "SELECT * FROM ADMIN WHERE USERNAME = ? AND PASSWORD = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()) {
                admin = read(resultSet);
            }
            resultSet.close();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return admin;
    }

    @Override
    public List<Admin> findAllAdmins(){

        ArrayList<Admin> admins = new ArrayList<>();
        PreparedStatement ps;

        try{
            String sql
                    = " SELECT *"
                    + " FROM ADMIN ";

            ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while(resultSet.next()){
                Admin admin = read(resultSet);
                admins.add(admin);
                System.out.println("admin trovato: " + admin.getAdminId());
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return admins;
    }


    Admin read(ResultSet rs) {

        Admin admin = new Admin();
        try {
            admin.setAdminId(rs.getLong("ADMIN_ID"));
        } catch (SQLException sqle) {
        }
        try {
            admin.setUsername(rs.getString("USERNAME"));
        } catch (SQLException sqle){
        }
        try {
            admin.setPassword(rs.getString("PASSWORD"));
        } catch (SQLException sqle){
        }

        try {
            admin.setNome(rs.getString("NOME"));
        } catch (SQLException sqle) {
        }
        try {
            admin.setCognome(rs.getString("COGNOME"));
        } catch (SQLException sqle) {
        }
            try {
                admin.setCf_admin(rs.getString("CF_ADMIN"));
            } catch (SQLException sqle) {
            }
        return admin;
    }
}
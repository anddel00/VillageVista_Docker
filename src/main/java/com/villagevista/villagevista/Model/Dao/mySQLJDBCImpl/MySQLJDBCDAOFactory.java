package com.villagevista.villagevista.Model.Dao.mySQLJDBCImpl;

import com.villagevista.villagevista.Model.Dao.*;
import com.villagevista.villagevista.Model.Dao.*;
import com.villagevista.villagevista.Model.Dao.*;
import com.villagevista.villagevista.services.config.Configuration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Map;

public class MySQLJDBCDAOFactory extends DAOFactory {
    private Map factoryParameters;
    private Connection connection;

    public MySQLJDBCDAOFactory(Map factoryParameters){this.factoryParameters=factoryParameters;}
    @Override
    public void beginTransaction() {

        try {
            Class.forName(Configuration.DATABASE_DRIVER);
            this.connection = DriverManager.getConnection(Configuration.DATABASE_URL);
            this.connection.setAutoCommit(false);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    @Override
    public void commitTransaction() {
        try {
            this.connection.commit();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void rollbackTransaction() {

        try {
            this.connection.rollback();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    @Override
    public void closeTransaction() {
        try {
            this.connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public AdminDAO getAdminDAO(){return new AdminDAOMySQLJDBCImpl(connection);}
    @Override
    public DipendenteDAO getDipendenteDAO(){return new DipendenteDAOMySQLJDBCImpl(connection);}

    @Override
    public ClienteDAO getClienteDAO(){return new ClienteDAOMySQLJDBCImpl(connection);}

    @Override
    public AlloggioDAO getAlloggioDAO (){return new AlloggioDAOMySQLJDBCImpl(connection);}
    @Override
    public PrenotazioneDAO getPrenotazioneDAO(){return new PrenotazioneDAOMySQLJDBCImpl(connection);}

    @Override
    public Turno_lavoroDAO getTurno_lavoroDAO(){return new Turno_lavoroDAOMySQLJDBCImpl(connection);}
    @Override
    public MessaggioDAO getMessaggioDAO(){return new MessaggioDAOMySQLJDBCImpl(connection);}

}

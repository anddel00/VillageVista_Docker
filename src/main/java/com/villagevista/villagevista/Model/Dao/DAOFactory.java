package com.villagevista.villagevista.Model.Dao;

import com.villagevista.villagevista.Model.Dao.CookieImpl.CookieDAOFactory;
import com.villagevista.villagevista.Model.Dao.postgresJDBCImpl.PostgresJDBCDAOFactory;

import java.util.Map;

public abstract class DAOFactory {

    // List of DAO types supported by the factory
    public static final String POSTGRESJDBCIMPL = "PostgresJDBCImpl";
    public static final String COOKIEIMPL= "com/villagevista/villagevista/Model";

    public abstract void beginTransaction();
    public abstract void commitTransaction();
    public abstract void rollbackTransaction();
    public abstract void closeTransaction();

    public abstract AdminDAO getAdminDAO();
    public abstract AlloggioDAO getAlloggioDAO();
    public abstract ClienteDAO getClienteDAO();
    public abstract DipendenteDAO getDipendenteDAO();
    public abstract PrenotazioneDAO getPrenotazioneDAO();
    public abstract Turno_lavoroDAO getTurno_lavoroDAO();
    public abstract MessaggioDAO getMessaggioDAO();

    public static DAOFactory getDAOFactory(String whichFactory,Map factoryParameters) {

        if (whichFactory.equals(POSTGRESJDBCIMPL)) {
            return new PostgresJDBCDAOFactory(factoryParameters);
        } else if (whichFactory.equals(COOKIEIMPL)) {
            return new CookieDAOFactory(factoryParameters);
        } else {
            return null;
        }
    }
}


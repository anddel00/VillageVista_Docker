package com.villagevista.villagevista.services.config;

import java.util.Calendar;
import java.util.logging.Level;

import com.villagevista.villagevista.Model.Dao.DAOFactory;

public class Configuration {
    /* Database Configruation */
    // L'Agente punta ora alla nuova famiglia di DAO per Postgres
    public static final String DAO_IMPL = DAOFactory.POSTGRESJDBCIMPL;

    // Aggiornato al driver PostgreSQL
    public static final String DATABASE_DRIVER = "org.postgresql.Driver";
    public static final String SERVER_TIMEZONE = Calendar.getInstance().getTimeZone().getID();

    // Nuova stringa di connessione JDBC per l'istanza PostgreSQL su Aiven
    public static final String DATABASE_URL = "jdbc:postgresql://pg-villagevista-andreadelfatto-a5e9.i.aivencloud.com:21300/defaultdb?user=avnadmin&password=AVNS_apPNXaLImyhVFY0bLcU&sslmode=require";

    /* Session Configuration */
    public static final String COOKIE_IMPL = DAOFactory.COOKIEIMPL;

    /* Logger Configuration */
    public static final String GLOBAL_LOGGER_NAME = "VillageVista";
    public static final String GLOBAL_LOGGER_FILE = "villagevista_log.%g.%u.txt";
    public static final Level GLOBAL_LOGGER_LEVEL = Level.ALL;
}
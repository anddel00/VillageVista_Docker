package com.villagevista.villagevista.services.config;

import java.util.Calendar;
import java.util.logging.Level;

import com.villagevista.villagevista.Model.Dao.DAOFactory;

public class Configuration {
    /* Database Configruation */
    public static final String DAO_IMPL= DAOFactory.MYSQLJDBCIMPL;
    public static final String DATABASE_DRIVER="com.mysql.cj.jdbc.Driver";
    public static final String SERVER_TIMEZONE= Calendar.getInstance().getTimeZone().getID();

    public static final String DATABASE_URL="jdbc:mysql://villagevista-andreadelfatto-a5e9.f.aivencloud.com:21300/villaggio?user=avnadmin&password=AVNS_cBodN9VpSMTr_p4_VCO&sslMode=REQUIRED&serverTimezone=" + SERVER_TIMEZONE;
    /* Session Configuration */
    public static final String COOKIE_IMPL=DAOFactory.COOKIEIMPL;

    /* Logger Configuration */
    public static final String GLOBAL_LOGGER_NAME="VillageVista";
    public static final String GLOBAL_LOGGER_FILE="villagevista_log.%g.%u.txt";
    public static final Level GLOBAL_LOGGER_LEVEL=Level.ALL;

}



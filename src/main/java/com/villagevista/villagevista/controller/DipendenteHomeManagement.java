package com.villagevista.villagevista.controller;

import com.villagevista.villagevista.Model.Dao.DAOFactory;
import com.villagevista.villagevista.Model.Dao.DipendenteDAO;
import com.villagevista.villagevista.Model.Dao.PrenotazioneDAO;
import com.villagevista.villagevista.Model.Dao.Turno_lavoroDAO;
import com.villagevista.villagevista.Model.Mo.Admin;
import com.villagevista.villagevista.Model.Mo.Dipendente;
import com.villagevista.villagevista.Model.Mo.Turno_lavoro;
import com.villagevista.villagevista.services.config.Configuration;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.villagevista.villagevista.services.logservice.LogService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import static com.villagevista.villagevista.Model.Dao.DAOFactory.POSTGRESJDBCIMPL;

public class DipendenteHomeManagement {
    private DipendenteHomeManagement() {
    }

    public static void goToDipendentePersonale(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory sessionDAOFactory = null;
        DAOFactory daoFactory = null;
        Dipendente loggedDipendente = null;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            DipendenteDAO sessionDipendenteDAO = sessionDAOFactory.getDipendenteDAO();
            loggedDipendente = sessionDipendenteDAO.findLoggedDipendente();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction();

            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            if (turno_lavoroDAO == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            // Recupera il dipendente usando il metodo findByUser_dip
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            Dipendente dipendente = dipendenteDAO.findByUser_dip(loggedDipendente.getUser_dip());
            if (dipendente == null) {
                throw new RuntimeException("Dipendente non trovato");
            }

            // Passa il dipendente alla vista
            request.setAttribute("dipendente", dipendente);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAllTurni(loggedDipendente.getCognome_dip());
            System.out.println("numero di turni trovati:" + turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            request.setAttribute("viewUrl", "dipendentePersonale/dipendentePersonale");

            daoFactory.commitTransaction();

        } catch (Exception e) {
            e.printStackTrace();
            if (daoFactory != null) {
                try {
                    daoFactory.rollbackTransaction(); // Rollback della transazione in caso di errore
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException(e);
        } finally {
            if (daoFactory != null) {
                try {
                    daoFactory.closeTransaction(); // Chiude la transazione
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }



    public static void view(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory sessionDAOFactory = null;
        DAOFactory daoFactory = null;
        Dipendente loggedDipendente = null;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            DipendenteDAO sessionDipendenteDAO = sessionDAOFactory.getDipendenteDAO();
            loggedDipendente = sessionDipendenteDAO.findLoggedDipendente();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction();

            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            if (turno_lavoroDAO == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            // Recupera il dipendente usando il metodo findByUser_dip
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            Dipendente dipendente = dipendenteDAO.findByUser_dip(loggedDipendente.getUser_dip());
            if (dipendente == null) {
                throw new RuntimeException("Dipendente non trovato");
            }

            // Passa il dipendente alla vista
            request.setAttribute("dipendente", dipendente);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAllTurni(loggedDipendente.getCognome_dip());
            System.out.println("numero di turni trovati:" + turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            request.setAttribute("viewUrl", "dipendenteHome/dipendenteHome");

            daoFactory.commitTransaction();

        } catch (Exception e) {
            e.printStackTrace();
            if (daoFactory != null) {
                try {
                    daoFactory.rollbackTransaction(); // Rollback della transazione in caso di errore
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException(e);
        } finally {
            if (daoFactory != null) {
                try {
                    daoFactory.closeTransaction(); // Chiude la transazione
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}


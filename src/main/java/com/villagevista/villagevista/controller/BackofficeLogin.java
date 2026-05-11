package com.villagevista.villagevista.controller;

import com.villagevista.villagevista.Model.Dao.*;
import com.villagevista.villagevista.Model.Mo.*;
import com.villagevista.villagevista.services.logservice.LogService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.villagevista.villagevista.services.config.Configuration;



import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BackofficeLogin {

    private BackofficeLogin() {
    }

    public static void view(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("viewUrl", "backofficeLogin.jsp");
    }

    public static void processLoginAdmin(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory = null;
        DAOFactory daoFactory = null;
        Admin loggedAdmin = null;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            AdminDAO sessionAdminDAO = sessionDAOFactory.getAdminDAO();
            loggedAdmin = sessionAdminDAO.findLoggedAdmin();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Admin admin = adminDAO.findByUsername(username);


            if (admin == null || !admin.getPassword().equals(password)) {
                sessionAdminDAO.delete(null);
                applicationMessage = "Username e password errati!";
            } else {
                loggedAdmin = sessionAdminDAO.create(admin.getAdminId(), null, null, admin.getNome(), null, admin.getCognome());
                request.getSession().setAttribute("nome", admin.getNome());
                request.getSession().setAttribute("cognome", admin.getCognome());
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            if (loggedAdmin != null) {

                PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
                ClienteDAO clienteDAO = daoFactory.getClienteDAO();
                Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
                AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
                DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

                if (prenotazioneDAO == null) {
                    throw new RuntimeException("PrenotazioneDAO is null");
                }
                if (clienteDAO == null) {
                    throw new RuntimeException("PrenotazioneDAO is null");
                }


                List <Cliente> clienti = clienteDAO.findAllClienti();
                System.out.println("Numero di clienti trovati: " + clienti.size());
                request.setAttribute("clienti",clienti);

                request.setAttribute("viewUrl", "adminHome/adminHome");

                List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
                request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

                request.setAttribute("viewUrl", "adminHome/adminHome");

                List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
                request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

                List<Prenotazione> prenotazioniDicembre = prenotazioneDAO.findByMese(12); // Utilizza il metodo corretto per il DAO
                request.setAttribute("prenotazioniDicembre", prenotazioniDicembre);

                request.setAttribute("viewUrl", "adminHome/adminHome");

                List<Prenotazione> deletedprenotazioni = prenotazioneDAO.findCancellate();
                request.setAttribute("deletedprenotazioni", deletedprenotazioni);

                request.setAttribute("viewUrl", "adminHome/adminHome");


                List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
                System.out.println("numero di turni trovati: " + turni_lavoro.size());
                request.setAttribute("turni_lavoro", turni_lavoro);

                List <Alloggio> alloggi = alloggioDAO.findAll();
                request.setAttribute("alloggi",alloggi);

                List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
                System.out.println("turni di lavoro trovati: "+ dipendenti.size());
                request.setAttribute("dipendenti", dipendenti);

                request.setAttribute("viewUrl", "adminHome/adminHome");


                List<Prenotazione> prenotazioniComplete = prenotazioneDAO.findAllWithCliente();
                request.setAttribute("prenotazioniComplete", prenotazioniComplete);
                
                request.setAttribute("viewUrl", "adminHome/adminHome");
            } else {
                request.setAttribute("applicationMessage", applicationMessage);
                request.setAttribute("viewUrl", "backofficeLogin/backofficeLogin");

            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "controller error", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "rollback error", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "transaction close error", t);
            }
        }
    }

    public static void processLoginDipendente(HttpServletRequest request, HttpServletResponse response) {

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

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            Dipendente dipendente = dipendenteDAO.findByUser_dip(username);


            if (dipendente == null || !dipendente.getPass_dip().equals(password)) {
                sessionDipendenteDAO.delete(null);
                applicationMessage = "Username e password errati!";
            } else {
                loggedDipendente = sessionDipendenteDAO.create(
                        dipendente.getCf_dip(),
                        dipendente.getNome_dip(),
                        dipendente.getCognome_dip(),
                        dipendente.getUser_dip(),
                        dipendente.getPass_dip(),
                        dipendente.getData_n(),
                        dipendente.getSalario()
                );                request.getSession().setAttribute("username",dipendente.getUser_dip());
                request.getSession().setAttribute("nome", dipendente.getNome_dip());
                request.getSession().setAttribute("cognome", dipendente.getCognome_dip());
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            if (loggedDipendente != null) {

                Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();

                List <Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAllTurni(loggedDipendente.getCognome_dip());
                        request.setAttribute("turni_lavoro",turni_lavoro);

                        request.setAttribute("viewUrl","dipendenteHome/dipendenteHome");

            } else {
                request.setAttribute("applicationMessage", applicationMessage);
                request.setAttribute("viewUrl", "backofficeLogin/backofficeLogin");

            }


        } catch (Exception e) {
            logger.log(Level.SEVERE, "controller error", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "rollback error", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "transaction close error", t);
            }
        }
    }
}


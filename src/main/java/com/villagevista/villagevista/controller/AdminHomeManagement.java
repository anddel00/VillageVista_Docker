package com.villagevista.villagevista.controller;

import com.villagevista.villagevista.Model.Dao.*;
import com.villagevista.villagevista.Model.Mo.*;
import com.villagevista.villagevista.services.config.Configuration;
import com.villagevista.villagevista.services.logservice.LogService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.villagevista.villagevista.Model.Dao.DAOFactory.POSTGRESJDBCIMPL;

public class AdminHomeManagement {
    private AdminHomeManagement() {}

    public static void view(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }
            // Esempio per luglio
            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7);
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

// Esempio per agosto
            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8);
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            List<Prenotazione> prenotazioniDicembre = prenotazioneDAO.findByMese(12);
            request.setAttribute("prenotazioniDicembre", prenotazioniDicembre);

            List<Prenotazione> deletedprenotazioni = prenotazioneDAO.findCancellate();
            request.setAttribute("deletedprenotazioni", deletedprenotazioni);

            List<Prenotazione> prenotazioniComplete = prenotazioneDAO.findAllWithCliente();
            request.setAttribute("prenotazioniComplete", prenotazioniComplete);

            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            if (turnoLavoroDAO == null) {
                throw new RuntimeException("Turno_lavoroDAO is null");
            }
            List<Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            List<Cliente> clienti = clienteDAO.findAllClienti();
            request.setAttribute("clienti",clienti);

            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);


            request.setAttribute("viewUrl", "adminHome/adminHome");

            daoFactory.commitTransaction(); // Commit della transazione

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
    public static void goToInsert(HttpServletRequest request, HttpServletResponse response) {
        // Reindirizza alla pagina per inserire la prenotazione
        request.setAttribute("viewUrl", "addPrenotazione/addPrenotazione");
    }
    public static void goToInsertOspite(HttpServletRequest request, HttpServletResponse response) {
        // Reindirizza alla pagina per inserire il cliente
        request.setAttribute("viewUrl", "addCliente/addCliente");
    }

    public static void goToInsertTurno(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        request.setAttribute("viewUrl","addTurno/addTurno");
    }

    public static void goToDeleteOspite(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        request.setAttribute("viewUrl","deleteOspite/deleteOspite");
    }
    public static void goToModOspite(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        request.setAttribute("viewUrl","modOspite/modOspite");
    }
    public static void goToModPrenotazione(HttpServletRequest request, HttpServletResponse response){
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            Long NumPrenotazione = Long.parseLong(request.getParameter("num_prenotazione"));
            // Recupera il dipendente dal database usando l'ID
            Prenotazione prenotazione = prenotazioneDAO.findByNum_prenotazione(NumPrenotazione);

            // Imposta il dipendente come attributo nella richiesta
            request.setAttribute("prenotazione", prenotazione);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl","modPrenotazione/modPrenotazione");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }

    }

    public static void goToModTurno(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            Long IdTurno = Long.parseLong(request.getParameter("turno_id"));
            // Recupera il dipendente dal database usando l'ID
             Turno_lavoro turno_lavoro = turnoLavoroDAO.findByTurnoId(IdTurno);

            // Imposta il dipendente come attributo nella richiesta
            request.setAttribute("turno_lavoro", turno_lavoro);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl","modTurno/modTurno");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void goToModAlloggio(HttpServletRequest request, HttpServletResponse response){
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            Long NumAlloggio = Long.parseLong(request.getParameter("num_alloggio"));
            // Recupera il dipendente dal database usando l'ID
            Alloggio alloggio = alloggioDAO.findByNum_alloggio(NumAlloggio);

            // Imposta il dipendente come attributo nella richiesta
            request.setAttribute("alloggio", alloggio);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl","modAlloggio/modAlloggio");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void goToInsertDipendente(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        request.setAttribute("viewUrl","addDipendente/addDipendente");
    }
    public static void goToInsertAdmin(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        request.setAttribute("viewUrl","addAdmin/addAdmin");
    }

    public static void goToModDipendente(HttpServletRequest request, HttpServletResponse response){
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            Long dipId = Long.parseLong(request.getParameter("id"));
            // Recupera il dipendente dal database usando l'ID
            Dipendente dipendente = dipendenteDAO.findByDipId(dipId);

            // Imposta il dipendente come attributo nella richiesta
            request.setAttribute("dipendente", dipendente);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "modDipendente/modDipendente");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }

        request.setAttribute("viewUrl","modDipendente/modDipendente");
    }
    public static void goToAlloggiManagement(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }
            // Esempio per luglio
            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

// Esempio per agosto
            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);


            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            request.setAttribute("viewUrl", "alloggiManagement/alloggiManagement");

            daoFactory.commitTransaction(); // Commit della transazione

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
    public static void goToClientiManagement(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }
            // Esempio per luglio
            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

// Esempio per agosto
            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            List<Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            request.setAttribute("dipendenti",dipendenti);

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            List <Cliente> clienti = clienteDAO.findAllClienti();

            Map<Long, Integer> clientePrenotazioniMap = new HashMap<>();
            for (Cliente cliente : clienti) {
                int numeroPrenotazioni = prenotazioneDAO.countByCliente(cliente.getNum_p());
                clientePrenotazioniMap.put(cliente.getNum_p(), numeroPrenotazioni);
            }
            request.setAttribute("clienti", clienti);
            request.setAttribute("clientePrenotazioniMap", clientePrenotazioniMap);



            request.setAttribute("viewUrl", "clientiManagement/clientiManagement");

            daoFactory.commitTransaction(); // Commit della transazione

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

    public static void viewCliente(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();

            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }

            // Recupera l'ID del cliente dalla richiesta
            Long clienteId = Long.parseLong(request.getParameter("clienteId"));

            // Recupera il cliente specifico usando l'ID
            Cliente cliente = clienteDAO.findByNum_P(clienteId);

            // Recupera le prenotazioni del cliente usando l'ID
            List<Prenotazione> prenotazioniCliente = prenotazioneDAO.findByClienteId(clienteId);

            // Imposta gli attributi nella richiesta per essere utilizzati nella JSP
            request.setAttribute("cliente", cliente);
            request.setAttribute("prenotazioniCliente", prenotazioniCliente);

            // Altri dati da caricare, ad esempio:
            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7);
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8);
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            List<Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            request.setAttribute("dipendenti",dipendenti);

            List<Cliente> clienti = clienteDAO.findAllClienti();

            Map<Long, Integer> clientePrenotazioniMap = new HashMap<>();
            for (Cliente c : clienti) {
                int numeroPrenotazioni = prenotazioneDAO.countByCliente(c.getNum_p());
                clientePrenotazioniMap.put(c.getNum_p(), numeroPrenotazioni);
            }
            request.setAttribute("clienti", clienti);
            request.setAttribute("clientePrenotazioniMap", clientePrenotazioniMap);

            request.setAttribute("viewUrl", "viewCliente/viewCliente");

            daoFactory.commitTransaction(); // Commit della transazione

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
    public static void disponibilita(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            // Recupera gli alloggi disponibili dal database
            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();


            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();

            String tipo = request.getParameter("alloggio");
            String capienza = request.getParameter("persone");
            Date data_checkin = Date.valueOf(request.getParameter("data_checkin"));
            Date data_checkout = Date.valueOf(request.getParameter("data_checkout"));

            List<Alloggio> alloggiDisponibili = alloggioDAO.findDisponibilita(tipo, capienza, data_checkin, data_checkout);

            // Imposta gli attributi della richiesta per la JSP
            request.setAttribute("alloggiDisponibili", alloggiDisponibili);
            request.setAttribute("data_checkin", data_checkin);
            request.setAttribute("data_checkout", data_checkout);
            request.setAttribute("alloggio", tipo);

            request.setAttribute("idCliente", Long.parseLong(request.getParameter("idCliente")));

            request.setAttribute("viewUrl", "disponibiliAdmin/disponibiliAdmin");

            daoFactory.commitTransaction(); // Commit della transazione



        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Si è verificato un errore durante la ricerca della disponibilità.");
            throw new RuntimeException("Si è verificato un errore durante la ricerca della disponibilità.", e);
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
    public static void goToAddPrenotazioneAdmin(HttpServletRequest request, HttpServletResponse response) {

        //pagina per inserire la prenotazione
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();



            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }

            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();


            Long idCliente = Long.parseLong(request.getParameter("idCliente"));
            Cliente cliente = clienteDAO.findByNum_P(idCliente);

            // Verifica se il cliente è stato trovato
            if (cliente == null) {
                throw new RuntimeException("Cliente non trovato con ID: " + idCliente);
            }
            request.setAttribute("cliente", cliente);
            request.setAttribute("clienteId",idCliente);

            request.setAttribute("viewUrl","addPrenotazioneAdmin/addPrenotazioneAdmin");

            daoFactory.commitTransaction(); // Commit della transazione


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

    public static void confPrenotazione(HttpServletRequest request, HttpServletResponse response) {

        //pagina per confermare la prenotazione
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();

            // Recupera i parametri inviati dalla JSP precedente
            Date dataCheckin = Date.valueOf(request.getParameter("data_checkin"));
            Date dataCheckout = Date.valueOf(request.getParameter("data_checkout"));
            Long num_alloggio = Long.parseLong(request.getParameter("num_alloggio"));
            Long persone = Long.parseLong(request.getParameter("persone"));
            String alloggio = request.getParameter("tipoCamera");
            Long totale = Long.parseLong(request.getParameter("totale"));
            String pagato = request.getParameter("pagato");
            String stato = request.getParameter("stato");

            Long idCliente = Long.parseLong(request.getParameter("idCliente")); // Recupera l'ID del cliente

            // Recupera il cliente tramite l'ID
            Cliente cliente = clienteDAO.findByNum_P(idCliente);

            if (cliente != null) {
                // Crea la prenotazione utilizzando il PrenotazioneDAO
                Prenotazione prenotazione = prenotazioneDAO.create(dataCheckin, dataCheckout, num_alloggio,
                        cliente.getNum_p(), persone, alloggio, cliente.getCognome_cliente(), totale, pagato, stato);

                // Imposta il messaggio di successo da visualizzare nella vista
                applicationMessage = "Prenotazione aggiunta con successo";
                request.setAttribute("applicationMessage", applicationMessage);

                // Recupera le prenotazioni del cliente per la visualizzazione nella vista
                List<Prenotazione> prenotazioni = prenotazioneDAO.findByClienteId(cliente.getNum_p());
                request.setAttribute("prenotazioni", prenotazioni);

                // Inoltra alla vista successiva
                request.setAttribute("viewUrl", "confPrenotazioneAdmin/confPrenotazioneAdmin");

                // Commit della transazione
                daoFactory.commitTransaction();
            } else {
                // Cliente non trovato, gestisci l'errore
                // ...
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }


    public static void goToDipendentiManagement(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }
            // Esempio per luglio
            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

// Esempio per agosto
            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            List<Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            request.setAttribute("dipendenti",dipendenti);

            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            List <Cliente> clienti = clienteDAO.findAllClienti();

            Map<Long, Integer> clientePrenotazioniMap = new HashMap<>();
            for (Cliente cliente : clienti) {
                int numeroPrenotazioni = prenotazioneDAO.countByCliente(cliente.getNum_p());
                clientePrenotazioniMap.put(cliente.getNum_p(), numeroPrenotazioni);
            }
            request.setAttribute("clienti", clienti);
            request.setAttribute("clientePrenotazioniMap", clientePrenotazioniMap);



            request.setAttribute("viewUrl", "dipendentiManagement/dipendentiManagement");

            daoFactory.commitTransaction(); // Commit della transazione

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

    public static void goToAdminManagement(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }
            // Esempio per luglio
            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

// Esempio per agosto
            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            List<Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            request.setAttribute("dipendenti",dipendenti);

            AdminDAO adminDAO = daoFactory.getAdminDAO();
            List<Admin> admins = adminDAO.findAllAdmins();
            request.setAttribute("admins",admins);

            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            List <Cliente> clienti = clienteDAO.findAllClienti();

            Map<Long, Integer> clientePrenotazioniMap = new HashMap<>();
            for (Cliente cliente : clienti) {
                int numeroPrenotazioni = prenotazioneDAO.countByCliente(cliente.getNum_p());
                clientePrenotazioniMap.put(cliente.getNum_p(), numeroPrenotazioni);
            }
            request.setAttribute("clienti", clienti);
            request.setAttribute("clientePrenotazioniMap", clientePrenotazioniMap);



            request.setAttribute("viewUrl", "adminManagement/adminManagement");

            daoFactory.commitTransaction(); // Commit della transazione

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

    public static void viewDipendente(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction(); // Inizia la transazione

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();

            if (prenotazioneDAO == null) {
                throw new RuntimeException("PrenotazioneDAO is null");
            }

            // Recupera l'ID del cliente dalla richiesta
            Long DipId = Long.parseLong(request.getParameter("dipendenteId"));

            // Recupera il cliente specifico usando l'ID
            Dipendente dipendente = dipendenteDAO.findByDipId(DipId);


            List<Turno_lavoro> turni_lavoro = turnoLavoroDAO.findByIdDipTurno(DipId);

            // Imposta gli attributi nella richiesta per essere utilizzati nella JSP
            request.setAttribute("dipendente", dipendente);
            request.setAttribute("turnoLavoro", turni_lavoro);

            // Altri dati da caricare, ad esempio:
            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7);
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8);
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List<Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            request.setAttribute("dipendenti",dipendenti);

            List<Cliente> clienti = clienteDAO.findAllClienti();

            request.setAttribute("clienti", clienti);

            request.setAttribute("viewUrl", "viewDipendente/viewDipendente");

            daoFactory.commitTransaction(); // Commit della transazione

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
    public static void goToTurniManagement(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            // Ottieni l'istanza del DAO per i turni di lavoro
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();

            // Chiamata al metodo per trovare tutti i turni di lavoro
            List<Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAllWithDipendente();

            // Imposta gli attributi nella request per la JSP
            request.setAttribute("turniLavoro", turni_lavoro);

            // Imposta l'URL della vista da visualizzare nella JSP
            request.setAttribute("viewUrl", "turniManagement/turniManagement");

            daoFactory.commitTransaction(); // Commit della transazione

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

    public static void goToAdminHome(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        request.setAttribute("viewUrl","adminHome/adminHome");
    }


    public static void insert(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();


            // Recupera i parametri dalla richiesta per creare una nuova prenotazione
            Long numPrenotazione = null; // Potresti gestire la generazione del numero prenotazione, se necessario
            Date dataCheckin = Date.valueOf(request.getParameter("data_checkin"));
            Date dataCheckout = Date.valueOf(request.getParameter("data_checkout"));
            Long num_alloggio = Long.parseLong(request.getParameter("num_alloggio"));
            Long id_cliente = Long.parseLong(request.getParameter("id_cliente"));
            Long persone = Long.parseLong(request.getParameter("persone"));
            String alloggio = request.getParameter("alloggio");
            String cognomeP = request.getParameter("cognome_p");
            Long totale = Long.parseLong(request.getParameter("totale"));
            String pagato = request.getParameter("pagato");
            String stato = "confermato";


            // Chiamata alla funzione create del DAO per creare la prenotazione
            Prenotazione prenotazione = prenotazioneDAO.create(dataCheckin, dataCheckout,num_alloggio,id_cliente, persone, alloggio,cognomeP,totale,pagato,stato);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Prenotazione aggiunta con successo";

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);


            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "adminHome/adminHome");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void modPrenotazione(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();


            // Recupera i parametri dalla richiesta per aggiornare la prenotazione esistente
            Long numPrenotazione = Long.parseLong(request.getParameter("num_p")); // ID della prenotazione da modificare
            Date dataCheckin = Date.valueOf(request.getParameter("data_checkin"));
            Date dataCheckout = Date.valueOf(request.getParameter("data_checkout"));
            String cognomeP = request.getParameter("cognome_p");


            // Creiamo l'oggetto Cliente con i dati aggiornati
            Prenotazione prenotazione = new Prenotazione();
            prenotazione.setNum_prenotazione(numPrenotazione);
            prenotazione.setData_checkin(dataCheckin);
            prenotazione.setData_checkout(dataCheckout);
            prenotazione.setCognomeP(cognomeP);

            request.setAttribute("prenotazione", prenotazione);

            if (prenotazione == null) {
                throw new Exception("Prenotazione non trovata");
            }


            prenotazioneDAO.update(prenotazione);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "confPrenotazioneAdmin/confPrenotazioneAdmin");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void modOspite(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();


            // Recupera i parametri per l'aggiornamento del cliente
            Long num_p = Long.parseLong(request.getParameter("num_p"));
            String nome_cliente = request.getParameter("nome_cliente");
            String cognome_cliente = request.getParameter("cognome_cliente");
            String email = request.getParameter("email");
            String telefono = request.getParameter("telefono");
            String user_cliente = request.getParameter("user_cliente");
            String pass_cliente = request.getParameter("pass_cliente");

            // Creiamo l'oggetto Cliente con i dati aggiornati
            Cliente cliente = new Cliente();
            cliente.setNum_p(num_p);
            cliente.setNome_cliente(nome_cliente);
            cliente.setCognome_cliente(cognome_cliente);
            cliente.setEmail(email);
            cliente.setTelefono(telefono);
            cliente.setUser_cliente(user_cliente);
            cliente.setPass_cliente(pass_cliente);

            clienteDAO.update(cliente);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "adminHome/adminHome");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void deletePrenotazione(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per eliminare la prenotazione
            String num_prenotazioneStr = request.getParameter("num_prenotazione");

            if (num_prenotazioneStr != null && !num_prenotazioneStr.trim().isEmpty()) {
                Long num_prenotazione = Long.valueOf(num_prenotazioneStr);

                // Elimina la prenotazione tramite il DAO
                prenotazioneDAO.delete(num_prenotazione);

                daoFactory.commitTransaction();
                applicationMessage = "Prenotazione eliminata con successo";
            } else {
                applicationMessage = "Numero prenotazione non valido";
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            List<Prenotazione> deletedprenotazioni = prenotazioneDAO.findCancellate();
            request.setAttribute("deletedprenotazioni", deletedprenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successPrenotazione/successPrenotazione");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la prenotazione dell'alloggio", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void deleteForeverPrenotazione(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per eliminare la prenotazione
            String num_prenotazioneStr = request.getParameter("num_prenotazione");

            if (num_prenotazioneStr != null && !num_prenotazioneStr.trim().isEmpty()) {
                Long num_prenotazione = Long.valueOf(num_prenotazioneStr);

                // Elimina la prenotazione tramite il DAO
                prenotazioneDAO.deleteforever(num_prenotazione);

                daoFactory.commitTransaction();
                applicationMessage = "Prenotazione eliminata con successo";
            } else {
                applicationMessage = "Numero prenotazione non valido";
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            List<Prenotazione> deletedprenotazioni = prenotazioneDAO.findCancellate();
            request.setAttribute("deletedprenotazioni", deletedprenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "adminHome/adminHome");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la prenotazione dell'alloggio", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void confirmPrenotazione(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per eliminare la prenotazione
            String num_prenotazioneStr = request.getParameter("num_prenotazione");

            if (num_prenotazioneStr != null && !num_prenotazioneStr.trim().isEmpty()) {
                Long num_prenotazione = Long.valueOf(num_prenotazioneStr);

                // Elimina la prenotazione tramite il DAO
                prenotazioneDAO.confirm(num_prenotazione);

                daoFactory.commitTransaction();
                applicationMessage = "Prenotazione aggiornata con successo";
            } else {
                applicationMessage = "Numero prenotazione non valido";
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioniLuglio = prenotazioneDAO.findByMese(7); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniLuglio", prenotazioniLuglio);

            List<Prenotazione> prenotazioniAgosto = prenotazioneDAO.findByMese(8); // Utilizza il metodo corretto per il DAO
            request.setAttribute("prenotazioniAgosto", prenotazioniAgosto);

            List<Prenotazione> deletedprenotazioni = prenotazioneDAO.findCancellate();
            request.setAttribute("deletedprenotazioni", deletedprenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "adminHome/adminHome");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la prenotazione dell'alloggio", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void insertOspite(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per creare una nuovo cliente

            String Nome_cliente = String.valueOf(request.getParameter("nome_cliente"));
            String Cognome_cliente = String.valueOf(request.getParameter("cognome_cliente"));
            String Email = request.getParameter("email");
            String Telefono = request.getParameter("telefono");
            String User_cliente = request.getParameter("user_cliente");
            String Pass_cliente = request.getParameter("pass_cliente");


            // Chiamata alla funzione create del DAO per creare il cliente
            Cliente cliente = clienteDAO.create(Nome_cliente, Cognome_cliente, Email, Telefono,User_cliente, Pass_cliente);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Cliente aggiunto con successo";

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            request.setAttribute("prenotazioni", prenotazioni);

            List<Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "adminHome/adminHome");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento del cliente", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void insertTurno(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per creare un nuovo turno
            Long Id_dip_turno = Long.valueOf(request.getParameter("id_dip_turno"));
            String Cognome_turno = String.valueOf(request.getParameter("cognome_turno"));
            Date Data_turno = Date.valueOf(request.getParameter("data_turno"));
            String Ora_inizio = String.valueOf(request.getParameter("ora_inizio"));
            String Ora_fine = String.valueOf(request.getParameter("ora_fine"));

            // Chiamata alla funzione create del DAO per creare il turno
            Turno_lavoro turno_lavoro = turnoLavoroDAO.create(Id_dip_turno, Ora_inizio,Ora_fine,Cognome_turno,Data_turno,null);
            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Turno aggiunto con successo";

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            request.setAttribute("prenotazioni", prenotazioni);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            request.setAttribute("turni_lavoro",turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successTurno/successTurno");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento del cliente", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void deleteTurno(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per creare un nuovo cliente
            String turno_idStr = request.getParameter("turno_id");

            if (turno_idStr != null && !turno_idStr.trim().isEmpty()) {
                Long turno_id = Long.valueOf(turno_idStr);

                turno_lavoroDAO.delete(turno_id);

                daoFactory.commitTransaction();
                applicationMessage = "Turno eliminato con successo";
            } else {
                applicationMessage = "Numero turno non valido";
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            request.setAttribute("prenotazioni", prenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successTurno/successTurno");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la prenotazione dell'alloggio", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void modTurno(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();


            // Recupera i parametri dalla richiesta per aggiornare il turno di lavoro esistente
            Long turnoId = Long.parseLong(request.getParameter("turno_id")); // ID del turno di lavoro da modificare
            String oraInizio = request.getParameter("ora_inizio");
            String oraFine = request.getParameter("ora_fine");
            Long idDipTurno = Long.parseLong(request.getParameter("id_dip_turno"));
            Date dataTurno = Date.valueOf(request.getParameter("data_turno"));
            String cognomeTurno = request.getParameter("cognome_turno");

            // Creiamo l'oggetto Turno_lavoro con i dati aggiornati
            Turno_lavoro turnoLavoro = new Turno_lavoro();
            turnoLavoro.setTurno_id(turnoId);
            turnoLavoro.setOra_inizio(oraInizio);
            turnoLavoro.setOra_fine(oraFine);
            turnoLavoro.setId_dip_turno(idDipTurno);
            turnoLavoro.setData_turno(dataTurno);
            turnoLavoro.setCognome_turno(cognomeTurno);

            turnoLavoroDAO.update(turnoLavoro);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successTurno/successTurno");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }


    public static void deleteOspite(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;


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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per eliminare il cliente
            String num_pStr = request.getParameter("num_p");

            if (num_pStr != null && !num_pStr.trim().isEmpty()) {
                Long num_p = Long.valueOf(num_pStr);
                logger.info("Attempting to delete cliente with NUM_P: " + num_p);

                clienteDAO.delete(num_p);

                daoFactory.commitTransaction();
                applicationMessage = "Cliente eliminato con successo";
            } else {
                applicationMessage = "NUM_P cliente non valido";
                logger.warning("Invalid NUM_P: " + num_pStr);
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            request.setAttribute("prenotazioni", prenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successCliente/successCliente");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'eliminazione del cliente", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void occupaAlloggio(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per creare un nuovo cliente
            String num_alloggioStr = request.getParameter("num_alloggio");

            if (num_alloggioStr != null && !num_alloggioStr.trim().isEmpty()) {
                Long num_alloggio = Long.valueOf(num_alloggioStr);
                Alloggio alloggio = new Alloggio();
                alloggio.setNum_alloggio(num_alloggio);

                alloggioDAO.booked(alloggio);

                daoFactory.commitTransaction();
                applicationMessage = "Alloggio prenotato con successo";
            } else {
                applicationMessage = "Numero alloggio non valido";
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            request.setAttribute("prenotazioni", prenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "alloggiManagement/alloggiManagement");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la prenotazione dell'alloggio", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void liberaAlloggio(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            String num_alloggioStr = request.getParameter("num_alloggio");

            if (num_alloggioStr != null && !num_alloggioStr.trim().isEmpty()) {
                Long num_alloggio = Long.valueOf(num_alloggioStr);
                Alloggio alloggio = new Alloggio();
                alloggio.setNum_alloggio(num_alloggio);

                alloggioDAO.free(alloggio);

                daoFactory.commitTransaction();
                applicationMessage = "Alloggio liberato con successo";
            } else {
                applicationMessage = "Numero alloggio non valido";
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            request.setAttribute("prenotazioni", prenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "alloggiManagement/alloggiManagement");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la liberazione dell'alloggio", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void modAlloggio(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();


            // Recupera i parametri dalla richiesta per aggiornare l'alloggio esistente
            Long numAlloggio = Long.parseLong(request.getParameter("num_alloggio")); // ID dell'alloggio da modificare
            String tipo = request.getParameter("tipo");
            String capienza = request.getParameter("capienza");
            Long prezzoNotte = Long.parseLong(request.getParameter("prezzonotte"));


                // Creiamo l'oggetto Alloggio con i dati aggiornati
                Alloggio alloggio = new Alloggio();
                alloggio.setNum_alloggio(numAlloggio);
                alloggio.setTipo(tipo);
                alloggio.setCapienza(capienza);
                alloggio.setPrezzonotte(prezzoNotte);


                alloggioDAO.update(alloggio);

                daoFactory.commitTransaction();

                // Imposta il messaggio di successo o altro da visualizzare nella vista
                applicationMessage = "Alloggio modificato con successo";


            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successAlloggio/successAlloggio");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento della prenotazione", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }
    public static void processRegistraDipendente(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(DAOFactory.POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();

            // Recupera i parametri dalla richiesta per creare un nuovo dipendente
            String cf_dip = request.getParameter("cf_dip");
            String nome_dip = request.getParameter("nome_dip");
            String cognome_dip = request.getParameter("cognome_dip");
            String user_dip = request.getParameter("user_dip");
            String pass_dip = request.getParameter("pass_dip");
            Date data_n = Date.valueOf(request.getParameter("data_n")); // Converte la stringa in java.sql.Date
            Float salario = Float.parseFloat(request.getParameter("salario"));

            // Chiamata alla funzione create del DAO per creare il dipendente
            Dipendente dipendente = dipendenteDAO.create(cf_dip, nome_dip, cognome_dip, user_dip, pass_dip, data_n,salario);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo da visualizzare nella vista
            applicationMessage = "Dipendente registrato con successo";

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successDipendente/successDipendente");


        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la registrazione del dipendente", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void deleteDipendente(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;


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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            Turno_lavoroDAO turno_lavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();

            // Recupera i parametri dalla richiesta per eliminare il cliente
            String dipIdStr = request.getParameter("dipId");

            if (dipIdStr != null && !dipIdStr.trim().isEmpty()) {
                Long dipId = Long.valueOf(dipIdStr);
                logger.info("Attempting to delete cliente with dipId: " + dipIdStr);

                dipendenteDAO.delete(dipId);

                daoFactory.commitTransaction();
                applicationMessage = "Dipendente eliminato con successo";
            } else {
                applicationMessage = "id_dip dipendente non valido";
                logger.warning("Invalid id_dip: " + dipIdStr);
            }

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            request.setAttribute("prenotazioni", prenotazioni);

            List<Turno_lavoro> turni_lavoro = turno_lavoroDAO.findAll();
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successDipendente/successDipendente");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'eliminazione del cliente", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void modDipendente(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();
            MessaggioDAO messaggioDAO = daoFactory.getMessaggioDAO();
            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();


            // Recupera i parametri dalla richiesta per aggiornare la prenotazione esistente

            Long dipId = Long.parseLong(request.getParameter("dipId"));
            String cf_dip = request.getParameter("cf_dip");
            String nome_dip = request.getParameter("nome_dip");
            String cognome_dip = request.getParameter("cognome_dip");
            String user_dip = request.getParameter("user_dip");
            String pass_dip = request.getParameter("pass_dip");
            Date data_n = Date.valueOf(request.getParameter("data_n")); // Converte la stringa in java.sql.Date
            Float salario = Float.parseFloat(request.getParameter("salario"));


            // Creiamo l'oggetto Cliente con i dati aggiornati
            Dipendente dipendente = new Dipendente();
            dipendente.setDipId(dipId);
            dipendente.setCf_dip(cf_dip);
            dipendente.setNome_dip(nome_dip);
            dipendente.setCognome_dip(cognome_dip);
            dipendente.setUser_dip(user_dip);
            dipendente.setPass_dip(pass_dip);
            dipendente.setData_n(data_n);
            dipendente.setSalario(salario);

            dipendenteDAO.update(dipendente);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = "Dati aggiornati con successo";

            if(loggedAdmin != null){
                request.setAttribute("nome", loggedAdmin.getNome());
                request.setAttribute("cognome", loggedAdmin.getCognome());
            }

            List <Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni",prenotazioni);

            List <Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti",clienti);

            List <Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: "+ turni_lavoro.size());

            request.setAttribute("turnoLavoro", turni_lavoro);

            List <Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi",alloggi);

            List <Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: "+ dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            request.setAttribute("viewUrl", "successDipendente/successDipendente");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante l'inserimento del dipendente", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

    public static void processRegistraAdmin(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Admin loggedAdmin = null;

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

            daoFactory = DAOFactory.getDAOFactory(DAOFactory.POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            DipendenteDAO dipendenteDAO = daoFactory.getDipendenteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            AdminDAO adminDAO = daoFactory.getAdminDAO();
            Turno_lavoroDAO turnoLavoroDAO = daoFactory.getTurno_lavoroDAO();
            AlloggioDAO alloggioDAO = daoFactory.getAlloggioDAO();

            // Recupera i parametri dalla richiesta per creare un nuovo amministratore
            Long AdminId = Long.parseLong(request.getParameter("AdminId"));
            String Nome = request.getParameter("nome");
            String Cognome = request.getParameter("cognome");
            String CfAdmin = request.getParameter("cf_admin");
            String Username = request.getParameter("Username");
            String Password = request.getParameter("Password");

            // Chiamata alla funzione create del DAO per creare l'amministratore
            Admin admin = adminDAO.create(AdminId, Username, Password, Nome, Cognome, CfAdmin);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo da visualizzare nella vista
            applicationMessage = "Amministratore registrato con successo";

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            List<Prenotazione> prenotazioni = prenotazioneDAO.findAll();
            System.out.println("Number of prenotazioni found: " + prenotazioni.size());
            request.setAttribute("prenotazioni", prenotazioni);

            List<Cliente> clienti = clienteDAO.findAllClienti();
            System.out.println("Number of clienti found: " + clienti.size());
            request.setAttribute("clienti", clienti);

            List<Turno_lavoro> turni_lavoro = turnoLavoroDAO.findAll();
            System.out.println("turni di lavoro trovati: " + turni_lavoro.size());
            request.setAttribute("turni_lavoro", turni_lavoro);

            List<Alloggio> alloggi = alloggioDAO.findAll();
            request.setAttribute("alloggi", alloggi);

            List<Dipendente> dipendenti = dipendenteDAO.findAllDipendenti();
            System.out.println("turni di lavoro trovati: " + dipendenti.size());
            request.setAttribute("dipendenti", dipendenti);

            List<Admin> admins = adminDAO.findAllAdmins();
            request.setAttribute("admins", admins);

            request.setAttribute("viewUrl", "successAdmin/successAdmin");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la registrazione del dipendente", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante il rollback della transazione", t);
            }
            throw new RuntimeException(e);
        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
            } catch (Throwable t) {
                logger.log(Level.SEVERE, "Errore durante la chiusura della transazione", t);
            }
        }
    }

}

package com.villagevista.villagevista.controller;
import com.villagevista.villagevista.Model.Dao.*;
import com.villagevista.villagevista.Model.Mo.*;
import com.villagevista.villagevista.services.config.Configuration;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.villagevista.villagevista.services.logservice.LogService;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.villagevista.villagevista.Model.Dao.DAOFactory.POSTGRESJDBCIMPL;

public class ClienteHomeManagement {
    private ClienteHomeManagement() {

    }

    public static void goToModPrenotazioneCliente(HttpServletRequest request, HttpServletResponse response){
        //reindirizza alla pagina per inserire il turno
        request.setAttribute("viewUrl","modPrenotazioneCliente/modPrenotazioneCliente");
    }
    public static void goToPagamento(HttpServletRequest request, HttpServletResponse response){
        request.setAttribute("viewUrl","pagamento/pagamento");
    }

    public static void view(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Cliente loggedCliente = null;

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            ClienteDAO sessionClienteDAO = sessionDAOFactory.getClienteDAO();
            loggedCliente = sessionClienteDAO.findLoggedCliente();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);

            if (daoFactory == null) {
                throw new RuntimeException("DAOFactory is null");
            }

            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            if(prenotazioneDAO == null){
                throw new RuntimeException("PrenotazioneDAO is null");
            }

            List<Prenotazione> prenotazioni = prenotazioneDAO.findByCognome_cliente(loggedCliente.getCognome_cliente());
            System.out.println("Numero di prenotazioni per il cliente trovate: " + prenotazioni.size());
            request.setAttribute("prenotazioni", prenotazioni);

            List<Prenotazione> cancprenotazioni = prenotazioneDAO.findCancellateCliente(loggedCliente.getCognome_cliente());
            System.out.println("Numero di prenotazioni cancellate per il cliente trovate: " + cancprenotazioni.size());
            request.setAttribute("cancprenotazioni", cancprenotazioni);

            request.setAttribute("viewUrl", "clienteHome/clienteHome");

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
    public static void confPrenotazione(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Cliente loggedCliente = null;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            ClienteDAO sessionClienteDAO = sessionDAOFactory.getClienteDAO();
            loggedCliente = sessionClienteDAO.findLoggedCliente();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
            ClienteDAO clienteDAO = daoFactory.getClienteDAO();

            // Recupera i parametri dalla richiesta per creare una nuova prenotazione
            Date dataCheckin = Date.valueOf(request.getParameter("data_checkin"));
            Date dataCheckout = Date.valueOf(request.getParameter("data_checkout"));
            Long num_alloggio = Long.parseLong(request.getParameter("num_alloggio"));
            Long persone = Long.parseLong(request.getParameter("persone"));
            String alloggio = request.getParameter("tipoCamera");
            Long totale = Long.parseLong(request.getParameter("totale"));
            String pagamentoOpzione = request.getParameter("pagamentoOpzione");
            String pagato = pagamentoOpzione.equals("payNow") ? "già pagato" : "in struttura";
            String stato = request.getParameter("stato");

            // Recupera l'username del cliente loggato
            String user_cliente = loggedCliente.getUser_cliente();
            // Chiamata alla funzione del DAO per trovare il cliente tramite username
            Cliente cliente = clienteDAO.findByUser_cliente(user_cliente);

            if (cliente != null) {
                // Chiamata alla funzione create del DAO per creare la prenotazione
                Prenotazione prenotazione = prenotazioneDAO.create( dataCheckin, dataCheckout, num_alloggio, cliente.getNum_p(), persone, alloggio, cliente.getCognome_cliente(), totale, pagato,stato);

                // Imposta il messaggio di successo o altro da visualizzare nella vista
                applicationMessage = "Prenotazione aggiunta con successo";
                request.setAttribute("applicationMessage", applicationMessage);

                // Esempio di recupero delle prenotazioni del cliente per la visualizzazione nella vista
                List<Prenotazione> prenotazioni = prenotazioneDAO.findByCognome_cliente(cliente.getCognome_cliente());
                System.out.println("Numero di prenotazioni per il cliente trovate: " + prenotazioni.size());
                request.setAttribute("prenotazioni", prenotazioni);
            } else {
                // Cliente non trovato, gestire l'errore o l'eccezione
                // ...
            }

            daoFactory.commitTransaction();

            request.setAttribute("viewUrl", "confPrenotazione/confPrenotazione");

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
        Cliente loggedCliente = null;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            ClienteDAO sessionClienteDAO = sessionDAOFactory.getClienteDAO();
            loggedCliente = sessionClienteDAO.findLoggedCliente();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();

            // Recupera i parametri dalla richiesta per eliminare la prenotazione
            String num_prenotazioneStr = request.getParameter("num_prenotazione");

            if (num_prenotazioneStr != null && !num_prenotazioneStr.trim().isEmpty()) {
                Long num_prenotazione = Long.valueOf(num_prenotazioneStr);

                prenotazioneDAO.delete(num_prenotazione);

                daoFactory.commitTransaction();
                applicationMessage = "Prenotazione eliminata con successo";
            } else {
                applicationMessage = "Numero prenotazione non valido";
            }

            // Imposta gli attributi per la vista
            List <Prenotazione> prenotazioni = prenotazioneDAO.findByCognome_cliente(loggedCliente.getCognome_cliente());
            System.out.println("Numero di prenotazioni per il cliente trovate: " + prenotazioni.size());
            request.setAttribute("prenotazioni", prenotazioni);

            request.setAttribute("viewUrl", "cancPrenotazione/cancPrenotazione");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la cancellazione della prenotazione", e);
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
        Cliente loggedCliente = null;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            ClienteDAO sessionClienteDAO = sessionDAOFactory.getClienteDAO();
            loggedCliente = sessionClienteDAO.findLoggedCliente();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();

            // Recupera i parametri dalla richiesta per aggiornare la prenotazione esistente
            Long numPrenotazione = Long.parseLong(request.getParameter("num_p"));
            Date dataCheckin = Date.valueOf(request.getParameter("data_checkin"));
            Date dataCheckout = Date.valueOf(request.getParameter("data_checkout"));
            Long persone = Long.parseLong(request.getParameter("persone"));
            String alloggio = request.getParameter("alloggio");

            // Creiamo l'oggetto Cliente con i dati aggiornati
            Prenotazione prenotazione = new Prenotazione();
            prenotazione.setNum_prenotazione(numPrenotazione);
            prenotazione.setData_checkin(dataCheckin);
            prenotazione.setData_checkout(dataCheckout);
            prenotazione.setPersone(persone);
            prenotazione.setAlloggio(alloggio);
            prenotazione.setCognomeP(loggedCliente.getCognome_cliente());

            prenotazioneDAO.update(prenotazione);

            daoFactory.commitTransaction();

            if(loggedCliente != null){
                request.setAttribute("nome", loggedCliente.getNome_cliente());
                request.setAttribute("cognome", loggedCliente.getCognome_cliente());
            }

            // Imposta gli attributi per la vista
            List <Prenotazione> prenotazioni = prenotazioneDAO.findByCognome_cliente(loggedCliente.getCognome_cliente());
            System.out.println("Numero di prenotazioni per il cliente trovate: " + prenotazioni.size());
            request.setAttribute("prenotazioni", prenotazioni);


            request.setAttribute("viewUrl", "clienteHome/clienteHome");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la cancellazione della prenotazione", e);
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

    public static void disponibilita(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        DAOFactory sessionDAOFactory = null;
        Cliente loggedCliente = null;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            ClienteDAO sessionClienteDAO = sessionDAOFactory.getClienteDAO();
            loggedCliente = sessionClienteDAO.findLoggedCliente();

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


            List<Alloggio> disponibili = alloggioDAO.findDisponibilita(tipo, capienza, data_checkin, data_checkout);

            request.setAttribute("alloggiDisponibili", disponibili);
            request.setAttribute("data_checkin", data_checkin);
            request.setAttribute("data_checkout", data_checkout);
            request.setAttribute("alloggio", tipo);

            request.setAttribute("viewUrl","disponibiliPage/disponibiliPage");

            // Inoltra la richiesta alla vista per mostrare i risultati

        } catch (Exception e) {
        e.printStackTrace();
        // Reindirizziamo l'utente alla home con un messaggio di errore invece di restituire null
        request.setAttribute("error", "Errore tecnico: " + e.getMessage());
        request.setAttribute("viewUrl", "clienteHome/clienteHome");

    }

    }
}

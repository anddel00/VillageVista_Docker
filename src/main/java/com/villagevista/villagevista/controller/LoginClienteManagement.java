package com.villagevista.villagevista.controller;

import com.villagevista.villagevista.Model.Dao.*;
import com.villagevista.villagevista.Model.Mo.*;
import com.villagevista.villagevista.services.config.Configuration;
import com.villagevista.villagevista.services.logservice.LogService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.villagevista.villagevista.Model.Dao.DAOFactory.POSTGRESJDBCIMPL;

public class LoginClienteManagement {
    private  LoginClienteManagement(){}

    public static void view(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("viewUrl", "loginCliente.jsp");
    }
    public static void goToRegistraCliente(HttpServletRequest request, HttpServletResponse response) {
        // Reindirizza alla pagina per inserire il cliente
        request.setAttribute("viewUrl", "registraCliente/registraCliente");
    }

    public static void processLoginCliente(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory = null;
        DAOFactory daoFactory = null;
        Cliente loggedCliente = null;
        String applicationMessage = null;

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

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();
            Cliente cliente = clienteDAO.findByUser_cliente(username);


            if (cliente == null || cliente.getPass_cliente()==null || !cliente.getPass_cliente().equals(password)) {
                sessionClienteDAO.delete(null);
                applicationMessage = "Username e password errati!";
            } else {
                loggedCliente = sessionClienteDAO.create(cliente.getNome_cliente(), cliente.getCognome_cliente(), null,null, cliente.getUser_cliente(), null);

                request.getSession().setAttribute("nome", cliente.getNome_cliente());
                request.getSession().setAttribute("cognome", cliente.getCognome_cliente());
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            if (loggedCliente != null) {

                PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();
                MessaggioDAO messaggioDAO=daoFactory.getMessaggioDAO();

                List <Prenotazione> prenotazioni = prenotazioneDAO.findByCognome_cliente(loggedCliente.getCognome_cliente());
                request.setAttribute("prenotazioni",prenotazioni);

                List <Prenotazione> cancprenotazioni = prenotazioneDAO.findCancellateCliente(loggedCliente.getCognome_cliente());
                System.out.println("numero di prenotazioni per il cliente trovate " + prenotazioni.size());
                request.setAttribute("cancprenotazioni",cancprenotazioni);


                request.setAttribute("viewUrl", "clienteHome/clienteHome");

            } else {
                request.setAttribute("applicationMessage", applicationMessage);
                request.setAttribute("viewUrl", "loginCliente/loginCliente");

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
    public static void processRegistraCliente(HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            ClienteDAO clienteDAO = daoFactory.getClienteDAO();

            // Recupera i parametri dalla richiesta per creare una nuovo cliente

            String Nome_cliente = String.valueOf(request.getParameter("nome_cliente"));
            String Cognome_cliente = String.valueOf(request.getParameter("cognome_cliente"));
            String Email = request.getParameter("email");
            String Telefono = request.getParameter("telefono");
            String User_cliente = request.getParameter("user_cliente");
            String Pass_cliente = request.getParameter("pass_cliente");

            // Chiamata alla funzione create del DAO per creare il cliente
            Cliente cliente = clienteDAO.create(Nome_cliente, Cognome_cliente, Email, Telefono,User_cliente,Pass_cliente);

            daoFactory.commitTransaction();

            // Imposta il messaggio di successo o altro da visualizzare nella vista
            applicationMessage = ("ti sei registrato con successo");

            // Imposta gli attributi per la vista
            request.setAttribute("applicationMessage", applicationMessage);

            request.setAttribute("viewUrl", "successRegistra/successRegistra");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Errore durante la registrazione", e);
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

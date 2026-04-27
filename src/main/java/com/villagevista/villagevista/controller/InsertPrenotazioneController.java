package com.villagevista.villagevista.controller;

import com.villagevista.villagevista.Model.Dao.DAOFactory;
import com.villagevista.villagevista.Model.Dao.PrenotazioneDAO;
import com.villagevista.villagevista.Model.Mo.Prenotazione;
import com.villagevista.villagevista.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.villagevista.villagevista.Model.Dao.DAOFactory.POSTGRESJDBCIMPL;

public class InsertPrenotazioneController {

    private InsertPrenotazioneController() {}

    public static void view(HttpServletRequest request, HttpServletResponse response) {
        // Reindirizza alla pagina per inserire la prenotazione
        request.setAttribute("viewUrl", "addPrenotazione/addPrenotazione");
    }

    public static void insert (HttpServletRequest request, HttpServletResponse response) {
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        Logger logger = LogService.getApplicationLogger();

        try {
            Map<String, Object> sessionFactoryParameters = new HashMap<>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);

            daoFactory = DAOFactory.getDAOFactory(POSTGRESJDBCIMPL, sessionFactoryParameters);
            daoFactory.beginTransaction();

            PrenotazioneDAO prenotazioneDAO = daoFactory.getPrenotazioneDAO();

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
}


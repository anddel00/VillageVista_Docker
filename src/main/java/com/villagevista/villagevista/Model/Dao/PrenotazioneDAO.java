package com.villagevista.villagevista.Model.Dao;

import com.villagevista.villagevista.Model.Mo.Cliente;
import com.villagevista.villagevista.Model.Mo.Prenotazione;

import java.sql.Date;
import java.util.List;

public interface PrenotazioneDAO {

    public Prenotazione create(
            Date data_checkin,
            Date data_checkout,
            Long num_alloggio,
            Long id_cliente,
            Long persone,
            String alloggio,
            String cognome_p,
            Long totale,
            String pagato,
            String stato);
    public void update (Prenotazione prenotazione);
    public void delete (Long num_prenotazione);
    public void confirm (Long num_prenotazione);
    public Prenotazione findByNum_prenotazione(Long num_prenotazione);
    public List<Prenotazione>findByCognome_cliente(String cognome_p);
    public List <Prenotazione> findCancellateCliente (String cognome_p);
    public List <Prenotazione> findByClienteId (Long id_cliente);
    public List <Prenotazione> findCancellate();
    public List <Prenotazione> findByMese(int mese);
    public int countByCliente(Long id_cliente);

    public void deleteforever(Long num_prenotazione);

    public List<Prenotazione> findAll();
    public List<Prenotazione> findAllWithCliente();

}

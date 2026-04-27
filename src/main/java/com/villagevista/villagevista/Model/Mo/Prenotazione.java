package com.villagevista.villagevista.Model.Mo;

import java.util.Date;

public class Prenotazione {
    private Long num_prenotazione;
    private Long num_alloggio;
    private Long id_cliente;
    private Long persone;
    private String alloggio;
    private Date data_checkin;
    private Date data_checkout;
    private String cognome_p;
    private Long totale;
    private String pagato;
    private String stato;
    private Cliente cliente;

    public Long getNumPrenotazione() {return num_prenotazione;}
    public void setNum_prenotazione(Long num_prenotazione){this.num_prenotazione=num_prenotazione;}

    public Long getNum_alloggio(){return num_alloggio;}
    public void setNum_alloggio(Long num_alloggio){this.num_alloggio=num_alloggio;}
    public Long getId_cliente(){return id_cliente;}
    public void setId_cliente(Long id_cliente){this.id_cliente=id_cliente;}
    public Long getPersone(){return persone;}
    public void setPersone(Long persone){this.persone=persone;}
    public String getAlloggio(){return alloggio;}
    public void setAlloggio(String alloggio){this.alloggio=alloggio;}
    public java.sql.Date getDataCheckin(){return (java.sql.Date) data_checkin;}
    public void setData_checkin(Date data_checkin){this.data_checkin=data_checkin;}
    public java.sql.Date getDataCheckout(){return (java.sql.Date) data_checkout;}
    public void setData_checkout(Date data_checkout){this.data_checkout=data_checkout;}
    public String getCognomeP(){return cognome_p;}
    public void setCognomeP(String cognome_p){this.cognome_p = cognome_p;}
    public Long getTotale(){return totale;}
    public void setTotale(Long totale){this.totale = totale;}

    public String getPagato(){return pagato;}
    public void setPagato(String pagato){this.pagato = pagato;}

    public String getStato(){return stato;}
    public void setStato(String stato){this.stato = stato;}
    
    public Cliente getCliente() {return cliente;}
    public void setCliente(Cliente cliente) {this.cliente = cliente;}

}

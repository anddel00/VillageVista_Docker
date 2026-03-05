<%@ page import="com.villagevista.villagevista.Model.Mo.Prenotazione" %>
<%@ page import="com.villagevista.villagevista.Model.Dao.ClienteDAO" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Cliente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    List<Cliente> clienti = (List<Cliente>) request.getAttribute("clienti");
    Map<Long, Integer> clientePrenotazioniMap = (Map<Long, Integer>) request.getAttribute("clientePrenotazioniMap");
    List<Prenotazione> prenotazioniCliente = (List<Prenotazione>) request.getAttribute("prenotazioniCliente");

    Long clienteId = Long.parseLong(request.getParameter("clienteId"));

    // Recupera il cliente specifico utilizzando il clienteId
    Cliente cliente = null;
    for (Cliente c : clienti) {
        if (c.getNum_p() == clienteId) {
            cliente = c;
            break;
        }
    }

    // Se non trovi il cliente, potresti gestire un messaggio di errore o fallback
    if (cliente == null) {
        throw new RuntimeException("Cliente non trovato con ID: " + clienteId);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettaglio Cliente</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
<style>
    body {
        font-family: "Cactus Classical Serif", sans-serif;
        margin: 0;
        padding: 0;
        color: #333;
        background-color: #f8f9fa;
    }

    .page-title {
        color: #0066da;
        font-family: "Cactus Classical Serif", serif;
        margin-bottom: 20px;
    }

    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        bottom: 0;
        width: 200px;
        background-color: #007bff;
        padding-top: 20px;
        overflow-y: auto;
        color: white;
    }

    .sidebar ul {
        list-style-type: none;
        padding: 0;
        color: white;
    }

    .sidebar ul li {
        margin-bottom: 10px;
    }

    .sidebar li:nth-child(7) {
        background-color: #0066da;
    }

    .nav-link {
        display: block;
        padding: 10px 20px;
        text-decoration: none;
        color: white;
        transition: background-color 0.3s;
    }

    .nav-link:hover {
        background-color: #0066da;
    }

    .nav-icon {
        vertical-align: middle;
        width: 20px;
        height: 20px;
        margin-right: 10px;
    }

    .nav-text {
        vertical-align: middle;
        color: white;
    }

    .main-content {
        margin-left: 200px;
        padding: 20px;
        background-color: white;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .client-details {
        background-color: #2a5176;
        color: white;
        padding: 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        display: inline-grid; /* Utilizziamo inline-grid per allineare i contenuti */
        align-items: center; /* Allinea verticalmente i contenuti */
    }

    .client-details img {
        width: 16px;
        height: 16px;
        margin-right: 10px; /* Aggiungiamo margine a destra per separare l'immagine dal testo */
    }

    .client-details p {
        margin: 5px 0;
    }

    .prenotazioni-title {
        color: #007bff;
        font-size: 24px;
        margin-bottom: 20px;
    }

    .card {
        background-color: #e2eefd;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card:hover {
        background-color: #deedff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .label {
        font-size: 16px;
        background-color: #af0b19;
        padding: 10px;
        border-radius: 10px;
        color: white;
        margin-bottom: 10px;
    }

    .card-details {
        display: grid;
        grid-template-columns: 1fr 2fr; /* Layout a due colonne per le caratteristiche */
        gap: 10px;
    }

    .card-details p {
        margin: 5px 0;
        padding: 10px;
        background-color: #f0f0f0;
        border-radius: 5px;
    }

    .card-details p strong {
        font-weight: bold;
    }

    .card-details p:nth-child(even) {
        background-color: #e9ecef;
    }
    .card-details p strong {
        font-weight: bolder; /* Rende il testo in grassetto */
    }
    .new-prenotazione{
        margin-bottom: 20px;
        margin-top: 20px;
    }
    .new-prenotazione a{
        background-color: #00a900;
        padding: 8px;
        font-family: "Cactus Classical Serif",serif;
        font-size: 14px;
        color: white;
        text-decoration: none;
        border-radius: 5px;
    }
    .new-prenotazione a:hover{
        cursor: pointer;
        background-color: #0c8629;
    }
</style>
<body>
<div class="sidebar">
    <ul>
        <li>
            <a href="Dispatcher?controllerAction=HomeManagement.view" class="nav-link">
                <img src="images/homeb.png" alt="Home" class="nav-icon">
                <span class="nav-text">Home</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.view" class="nav-link">
                <img src="images/calendario.png" alt="Prenotazioni" class="nav-icon">
                <span class="nav-text">Prenotazioni</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToAlloggiManagement" class="nav-link">
                <img src="images/alloggiob.png" alt="Alloggio" class="nav-icon">
                <span class="nav-text">Alloggi</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToDipendentiManagement" class="nav-link">
                <img src="images/dipendentib.png" alt="Dipendenti" class="nav-icon">
                <span class="nav-text">Dipendenti</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToAdminManagement" class="nav-link">
                <img src="images/admin.png" alt="Clienti" class="nav-icon">
                <span class="nav-text">Amministratori</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToTurniManagement" class="nav-link">
                <img src="images/turnib.png" alt="Turni" class="nav-icon">
                <span class="nav-text">Turni</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToClientiManagement" class="nav-link">
                <img src="images/personeb.png" alt="Clienti" class="nav-icon">
                <span class="nav-text">Clienti</span>
            </a>
        </li>
    </ul>
</div>
<div class="main-content">
    <h1 class="page-title">Dettaglio Sig./Sig.ra <%= cliente.getCognome_cliente() %> <%= cliente.getNome_cliente() %></h1>
    <div class="client-details">
        <h3 class="contatti-title">Contatti</h3>
        <p><strong><img src="images/mail.png"> Email:</strong> <%= cliente.getEmail() %></p>
        <p><strong><img src="images/phone.png"> Telefono:</strong> <%= cliente.getTelefono() %></p>
    </div>

    <h2 class="prenotazioni-title">Storico Prenotazioni</h2>
    <div class="new-prenotazione">
        <a href="Dispatcher?controllerAction=AdminHomeManagement.goToAddPrenotazioneAdmin&idCliente=<%=cliente.getNum_p()%>" class="btn">Prenota per questo cliente</a>
    </div>
    <div id="prenotazioniList">
        <% if (prenotazioniCliente != null && !prenotazioniCliente.isEmpty()) {
            for (Prenotazione prenotazione : prenotazioniCliente) { %>
        <div class="card">
            <div class="label">Prenotazione N°: <%= prenotazione.getNumPrenotazione() %></div>
            <div class="card-details">
                <p><strong><b>Check-in:</b></strong> <%= prenotazione.getDataCheckin() %></p>
                <p><strong><b>Check-out:</b></strong> <%= prenotazione.getDataCheckout() %></p>
                <p><strong><b>Tipo di alloggio:</b></strong> <%= prenotazione.getAlloggio() %></p>
                <p><strong><b>N. Ospiti:</b></strong> <%= prenotazione.getPersone() %></p>
                <p><strong><b>Totale:</b></strong> € <%= prenotazione.getTotale() %></p>
                <p><strong><b>Stato:</b></strong> <%= prenotazione.getStato() %></p>
            </div>
        </div>
        <% } } else { %>
        <p>Nessuna prenotazione trovata per questo cliente.</p>
        <% } %>
    </div>
</div>
</body>
</html>
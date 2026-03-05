<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.List" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%
    List<Prenotazione> prenotazioni = (List<Prenotazione>) request.getAttribute("prenotazioni");
%>
<%
    List<Cliente> clienti = (List<Cliente>) request.getAttribute("clienti");

%>
<%
    List<Prenotazione> prenotazioniLuglio = (List<Prenotazione>) request.getAttribute("prenotazioniLuglio");
    List<Prenotazione> prenotazioniAgosto = (List<Prenotazione>) request.getAttribute("prenotazioniAgosto");
    List<Prenotazione> prenotazioniDicembre = (List<Prenotazione>) request.getAttribute("prenotazioniDicembre");

    List<Prenotazione> deletedprenotazioni = (List<Prenotazione>) request.getAttribute("deletedprenotazioni");
    String nome = (String) session.getAttribute("nome");
    String cognome = (String) session.getAttribute("cognome");
%>
<%List<Dipendente> dipendenti = (List<Dipendente>) request.getAttribute("dipendenti");%>
<%List<Turno_lavoro> turni_lavoro = (List<Turno_lavoro>) request.getAttribute("turni_lavoro");%>
<%List<Alloggio> alloggi = (List<Alloggio>) request.getAttribute("alloggi");%>
<%SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", sans-serif;
            margin: 0;
            padding: 0;
            color: #ffca00;
        }
        .welcome-message{
            margin-left: 220px;
            margin-bottom: 50px;
            font-size: 20px;
        }
        .prenotazioni-month{
            font-size: 34px;
            color: #0066da;
        }

        .calendar-section {
            margin-bottom: 40px;
        }
        .calendar {
            display: grid;
            grid-template-columns: 1fr repeat(31,minmax(20px,1fr)); /* 31 giorni + 1 colonna per alloggi */
            gap: 5px;
            background-color: #e6eefc;
            padding: 10px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            font-family: "Cactus Classical Serif", sans-serif;
        }
        .calendar .day, .calendar .alloggio {
            background-color: #fff;
            padding: 2px;
            border: 1px solid #ccc;
            text-align: center;
            color: #0066da;
            font-family: "Cactus Classical Serif", sans-serif;
        }
        .calendar .alloggio {
            grid-column: 1 / 2;
            background-color: #f2f2f2;
        }
        .calendar .prenotazione {
            background-color: #00a900;
            color: white;
            text-align: center;
            padding: 14px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            font-size: 14px;
            font-family: "Cactus Classical Serif", sans-serif;
        }
        .calendar .prenotazione:hover{
            cursor: pointer;
            background-color: #008600;
        }
        .calendar .empty {
            background-color: transparent;
            border: none;
        }

        .home-button img{
            vertical-align: middle;
            position: relative;
            width: 40px;
            height: 40px;
        }
        /* Stili per la sidebar */
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
            color: white;
        }
        .sidebar li:nth-child(2){
            background-color: #0066da;
        }

        .nav-link {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: #333;
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

        /* Stili per il contenuto principale */
        .main-content {
            margin-left: 200px;
            padding: 20px;
            font-family: sans-serif;
        }

        .calendar-section {
            margin-bottom: 40px;

        }

        .calendar {
            display: grid;
            grid-template-columns: repeat(32, 1fr);
            grid-template-rows: auto;
            gap: 1px;
            font-family: "Cactus Classical Serif", sans-serif;
        }
        .day {
            background-color: #fff;
            text-align: center;
            border: 1px solid #ccc;
            font-family: "Cactus Classical Serif", sans-serif;
        }
        .alloggio {
            background-color: #e0e0e0;
            text-align: center;
            border: 1px solid #ccc;
            font-family: "Cactus Classical Serif", sans-serif;
        }
        .popup {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            color: #0066da;
        }
        .popup-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            color: #0066da;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .popup button{
            margin-right: 10px;
        }
        #editPopupBtn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
        }
        #editPopupBtn:hover{
            background-color: #0162ce;
        }
        #deleteBtn {
            background-color: #cc0000;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
        }
        #deleteBtn:hover{
            background-color:#af0b19 ;
        }
        #deleteforeverBtn {
            background-color: #cc0000;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
            position: absolute; /* Posizionamento assoluto */
            bottom: 10px; /* A 10px dal fondo della card */
            right: 10px; /* A 10px dal lato destro della card */
        }
        #deleteforeverBtn:hover {
            background-color: #af0b19;
        }
        #confirmBtn {
            background-color: #00a900;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
        }
        #confirmBtn:hover{
            background-color: #008600;
        }
        .prenotazione.cancelled {
            background-color: red; /* Cambia il colore di sfondo */
            color: white; /* Cambia il colore del testo, se necessario */
        }
        .prenotazione.cancelled:hover{
            background-color:#af0b19 ;
        }
        .prenotazione.confirmed-unpaid {
            background-color: yellow;
            color: black; /* Puoi modificare il colore del testo se necessario */
        }
        .prenotazione.confirmed-unpaid:hover {
            background-color: #b89b0b;
        }
        .toggle-section-button {
            display: inline-grid;
            width: auto;
            margin: 20px auto;
            margin-bottom: 40px;
            padding: 10px 20px;
            background-color: #336699;
            color: white;
            text-align: center;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            border: 3px solid transparent;
            font-family: "Cactus Classical Serif", serif;
        }

        .toggle-section-button:hover {
            background-color: #deedff;
            border: 3px solid #0066da;
            color: black;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .active{
            background-color: #deedff;
            border: 3px solid #0066da;
            color: black;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .table-title {
            text-align: center;
            font-size: 24px;
            color: #0056b3;
            margin-bottom: 40px;
            margin-top: 40px;
        }
        .section{
            display: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            background-color: #e2eefd;
            padding: 20px;
            margin-bottom: 60px;
            border-radius: 15px;
            transform: translateY(-20px);
            animation: fadeInDown 2s forwards;
            z-index: 1;
            position: relative;
            text-align: left;
            border: 4px solid #0066da;
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            margin: 10px;
            padding: 30px;
            width: calc(100% - 40px);
            max-width: 800px;
            display: flex;
            align-items: center;
            border: 2px solid #0056b3;
            position: relative; /* Per posizionare elementi assoluti all'interno della card */
        }
            .card img {
                border-radius: 10px;
                margin-right: 5px;
                margin-left: 20px;
                width: 270px;
                height: 200px;
                object-fit: cover;
            }

        .card-details {
            flex: 1;
            margin-left: 20px;
            text-align: left;
        }
        .card-details img{
            width: 16px;
            height: 16px;

        }
        .card-details p {
            margin-left:  3px;
            margin-bottom: 7px;
            font-size: 18px;
            font-family: "Cactus Classical Serif",serif;
            color: #0056b3;
        }

        .label{
            background-color: #af0b19;
            color: white;
            font-family: "Cactus Classical Serif", sans-serif;
            padding: 5px;
        }

        /* Stili per il modal di conferma */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            color: #2a5176;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 5px;
            position: relative;
            color: #2a5176;

        }

        .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
        }

        .modal-buttons {
            text-align: center;
            margin-top: 20px;
        }

        .modal-buttons button:nth-child(1) {
            padding: 10px 20px;
            margin: 0 10px;
            cursor: pointer;
            background-color: #cc0000;
            color: white;
            border: none;
            border-radius: 5px;
        }
        .modal-buttons button:nth-child(1):hover {
            background-color:#af0b19 ;
        }

        .modal-buttons button:nth-child(2) {
            padding: 10px 20px;
            margin: 0 10px;
            cursor: pointer;
            background-color: #00a900;
            color: white;
            border: none;
            border-radius: 5px;


        }
        .modal-buttons button:nth-child(2):hover {
            background-color:#0c8629 ;
        }

    </style>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
<body>
<div class="welcome-message">
    <p>Benvenuto, <%= nome %> <%= cognome %>!</p>
</div>
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
    <div class="calendar-section">
        <h2 class="prenotazioni-month">Prenotazioni Luglio</h2>
        <div class="calendar">
            <div class="alloggio empty"></div>
            <% for (int day = 1; day <= 31; day++) { %>
            <div class="day"><%= day %></div>
            <% } %>
            <!-- Colonne degli alloggi e prenotazioni -->
            <%
                int totalAlloggi = 15; // Numero di alloggi
                for (int alloggio = 1; alloggio <= totalAlloggi; alloggio++) {
            %>
            <div class="alloggio">Alloggio <%= alloggio %></div>
            <% for (int day = 1; day <= 31;) { %>
            <%
                boolean isBooked = false;
                Prenotazione currentBooking = null;
                for (Prenotazione p : prenotazioniLuglio) {
                    if (p.getNum_alloggio() == alloggio && p.getDataCheckin().getDate() <= day && p.getDataCheckout().getDate() >= day) {
                        isBooked = true;
                        currentBooking = p;
                        break;
                    }
                }
                if (isBooked && currentBooking != null) {
                    Calendar checkinCalendar = Calendar.getInstance();
                    checkinCalendar.setTime(currentBooking.getDataCheckin());
                    Calendar checkoutCalendar = Calendar.getInstance();
                    checkoutCalendar.setTime(currentBooking.getDataCheckout());

                    int checkinDay = checkinCalendar.get(Calendar.DATE);
                    int checkoutDay = checkoutCalendar.get(Calendar.DATE);
                    int colspan = checkoutDay - checkinDay + 1;

                    if (checkoutCalendar.get(Calendar.MONTH) == Calendar.AUGUST) {
                        colspan = 31 - checkinDay + 1; // Limit colspan to days in July
                    }

                    boolean isConfirmed = currentBooking.getStato().equals("confermata");
                    boolean isPaid = currentBooking.getPagato().equals("già pagato");
                    boolean isUnpaidOnSite = currentBooking.getPagato().equals("in struttura");
                    boolean isCancelled = currentBooking.getStato().equals("Cancellata");
                    String prenotazioneClass = "prenotazione ";
                    if (isConfirmed && isPaid) {
                        prenotazioneClass += "paid";
                    } else if (isConfirmed && isUnpaidOnSite) {
                        prenotazioneClass += "confirmed-unpaid";
                    } else if (isCancelled) {
                        prenotazioneClass += "cancelled";
                    }
            %>
            <div class="<%= prenotazioneClass %>" style="grid-column: span <%= colspan %>;"
                 data-numero="<%= currentBooking.getNumPrenotazione() %>"
                 data-alloggio="<%= currentBooking.getAlloggio() %>"
                 data-people="<%= currentBooking.getPersone() %>"
                 data-totale="<%= currentBooking.getTotale() %>"
                 data-paid="<%= currentBooking.getPagato() %>"
                 data-status="<%= currentBooking.getStato() %>">
                <%= currentBooking.getCognomeP() %>
            </div>
            <%
                day += colspan;
            } else {
            %>
            <div class="day"></div>
            <%
                    day++;
                }
            %>
            <% } %>
            <% } %>
        </div>
    </div>
    <div class="calendar-section">
        <h2 class="prenotazioni-month">Prenotazioni Agosto</h2>
        <div class="calendar">
            <!-- Header con i giorni -->
            <div class="alloggio empty"></div>
            <% for (int day = 1; day <= 31; day++) { %>
            <div class="day"><%= day %></div>
            <% } %>

            <!-- Colonne degli alloggi e prenotazioni -->
            <%
                for (int alloggio = 1; alloggio <= totalAlloggi; alloggio++) {
            %>
            <div class="alloggio">Alloggio <%= alloggio %></div>
            <% for (int day = 1; day <= 31;) { %>
            <%
                boolean isBooked = false;
                Prenotazione currentBooking = null;
                for (Prenotazione p : prenotazioniAgosto) {
                    // Controlla se la prenotazione attraversa agosto
                    Calendar checkinCalendar = Calendar.getInstance();
                    checkinCalendar.setTime(p.getDataCheckin());
                    Calendar checkoutCalendar = Calendar.getInstance();
                    checkoutCalendar.setTime(p.getDataCheckout());

                    if (p.getNum_alloggio() == alloggio &&
                            (checkinCalendar.get(Calendar.MONTH) == Calendar.AUGUST && checkinCalendar.get(Calendar.DATE) <= day) &&
                            (checkoutCalendar.get(Calendar.MONTH) == Calendar.AUGUST && checkoutCalendar.get(Calendar.DATE) >= day ||
                                    checkoutCalendar.get(Calendar.MONTH) == Calendar.JULY && checkoutCalendar.get(Calendar.DATE) >= day)) {
                        isBooked = true;
                        currentBooking = p;
                        break;
                    }
                }
                if (isBooked && currentBooking != null) {
                    Calendar checkinCalendar = Calendar.getInstance();
                    checkinCalendar.setTime(currentBooking.getDataCheckin());
                    Calendar checkoutCalendar = Calendar.getInstance();
                    checkoutCalendar.setTime(currentBooking.getDataCheckout());

                    int checkinDay = checkinCalendar.get(Calendar.MONTH) == Calendar.AUGUST ? checkinCalendar.get(Calendar.DATE) : 1;
                    int checkoutDay = checkoutCalendar.get(Calendar.DATE);
                    int colspan = checkoutDay - checkinDay + 1;

                    boolean isConfirmed = currentBooking.getStato().equals("confermata");
                    boolean isPaid = currentBooking.getPagato().equals("già pagato");
                    boolean isUnpaidOnSite = currentBooking.getPagato().equals("in struttura");
                    boolean isCancelled = currentBooking.getStato().equals("Cancellata");
                    String prenotazioneClass = "prenotazione ";
                    if (isConfirmed && isPaid) {
                        prenotazioneClass += "paid";
                    } else if (isConfirmed && isUnpaidOnSite) {
                        prenotazioneClass += "confirmed-unpaid";
                    } else if (isCancelled) {
                        prenotazioneClass += "cancelled";
                    }

            %>
            <div class="<%= prenotazioneClass %>" style="grid-column: span <%= colspan %>;"
                 data-numero="<%= currentBooking.getNumPrenotazione() %>"
                 data-alloggio="<%= currentBooking.getAlloggio() %>"
                 data-people="<%= currentBooking.getPersone() %>"
                 data-totale="<%= currentBooking.getTotale() %>"
                 data-paid="<%= currentBooking.getPagato() %>"
                 data-status="<%= currentBooking.getStato() %>">
                <%= currentBooking.getCognomeP() %>
            </div>
            <%
                day += colspan;
            } else {
            %>
            <div class="day"></div>
            <%
                    day++;
                }
            %>
            <% } %>
            <% } %>
        </div>
    </div>
    <a href="#" class="toggle-section-button">Storico prenotazioni cancellate</a>

</div>

    <div class="section">
        <h1 class="table-title">STORICO PRENOTAZIONI CANCELLATE</h1>
    <div class="card-container">
        <% if (deletedprenotazioni == null || deletedprenotazioni.isEmpty()) { %>
        <div class="card">
            <p>Nessuna prenotazione trovata.</p>
        </div>
        <% } else { %>
        <% for (Prenotazione deletedprenotazione : deletedprenotazioni) {
            String tipoCamera = deletedprenotazione.getAlloggio();
            String immagineAlloggio = "";
            if (tipoCamera.equals("Camera matrimoniale")) {
                immagineAlloggio = "images/camera_doppia.jpg";
            } else if (tipoCamera.equals("Camera tripla")) {
                immagineAlloggio = "images/camera_tripla.jpg";
            } else if (tipoCamera.equals("Camera quadrupla")) {
                immagineAlloggio = "images/camera_quadrupla.jpg";
            } else if (tipoCamera.equals("Bungalow bilocale")) {
                immagineAlloggio = "images/bungalow_bilocale.jpg";
            } else if (tipoCamera.equals("Bungalow trilocale")) {
                immagineAlloggio = "images/bungalow_trilocale.jpg";
            }
        %>
        <div class="card">
            <div class="label">Prenotazione N°: <%= deletedprenotazione.getNumPrenotazione() %></div>
            <img src="<%= immagineAlloggio %>" alt="Alloggio">
            <div class="card-details">
                <p><img src="images/checkin.png"><strong>Sig./Sig.ra:</strong> <%= deletedprenotazione.getCognomeP() %></p>
                <p><img src="images/checkin.png"><strong>Check-in:</strong> <%= deletedprenotazione.getDataCheckin() %></p>
                <p><img src="images/checkout.png"><strong>Check-out:</strong> <%= deletedprenotazione.getDataCheckout() %></p>
                <p><img src="images/alloggio.png"><strong>Tipo di alloggio:</strong> <%= deletedprenotazione.getAlloggio() %></p>
                <p><img src="images/persone.png"><strong>N. Ospiti:</strong> <%= deletedprenotazione.getPersone() %></p>
                <p><strong>Totale:</strong> € <%= deletedprenotazione.getTotale() %></p>
            </div>
            <form id="deleteForeverForm" action="Dispatcher" method="post" style="display: inline;">
                <input type="hidden" name="controllerAction" value="AdminHomeManagement.deleteForeverPrenotazione">
                <input type="hidden" name="num_prenotazione" id="deleteForeverPrenotazione" value="<%= deletedprenotazione.getNumPrenotazione() %>">
                <button type="submit" id="deleteforeverBtn">Elimina definitivamente</button>
            </form>
        </div>
        <% } %>
        <% } %>
    </div>
</div>
<!-- Popup Modal -->
<div id="bookingPopup" class="popup">
    <div class="popup-content">
        <span class="close">&times;</span>
        <h3>Dettagli Prenotazione N. <span id="popupNumero"></span></h3>
        <p><strong><b>Persone:</b></strong> <span id="popupPeople"></span></p>
        <p><strong><b>Alloggio:</b></strong></strong> <span id="popupAlloggio"></span></p>
        <p><strong><b>Totale:</b></strong> <span id="popupTotale"></span></p>
        <p><strong><b>Pagato:</b></strong> <span id="popupPaid"></span></p>
        <p><strong><b>Stato:</b></strong> <span id="popupStatus"></span></p>
        <form id="editForm" action="Dispatcher" method="post" style="display: inline;">
            <input type="hidden" name="controllerAction" value="AdminHomeManagement.goToModPrenotazione">
            <input type="hidden" name="num_prenotazione" id="editNumPrenotazione">
            <button type="submit" id="editPopupBtn">Modifica</button>
        </form>
        <form id="deleteForm" action="Dispatcher" method="post" style="display: inline;">
            <input type="hidden" name="controllerAction" value="AdminHomeManagement.deletePrenotazione">
            <input type="hidden" name="num_prenotazione" id="deleteNumPrenotazione">
            <button type="submit" id="deleteBtn">Cancella</button>
        </form>
        <form id="confirmForm" action="Dispatcher" method="post" style="display: inline;">
            <input type="hidden" name="controllerAction" value="AdminHomeManagement.confirmPrenotazione">
            <input type="hidden" name="num_prenotazione" id="confirmNumPrenotazione">
            <button type="submit" id="confirmBtn">Pagato</button>
        </form>

    </div>
</div>
    <div id="confirmModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p id="confirmMessage">Sei sicuro di voler eliminare la prenotazione?</p>
            <div class="modal-buttons">
                <button id="confirmYes">Si</button>
                <button id="confirmNo">No</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var popup = document.getElementById("bookingPopup");
        var closeBtn = document.querySelector("#bookingPopup .close");
        var editPopupBtn = document.getElementById("editPopupBtn");
        var deleteBtn = document.getElementById("deleteBtn");
        var deleteForeverBtn = document.getElementById("deleteforeverBtn");
        var confirmModal = document.getElementById("confirmModal");
        var confirmMessageElement = document.getElementById("confirmMessage");
        var confirmYesBtn = document.getElementById("confirmYes");
        var confirmNoBtn = document.getElementById("confirmNo");

        // Mostra il popup di dettagli della prenotazione
        document.querySelectorAll(".prenotazione").forEach(function(element) {
            element.addEventListener("click", function() {
                document.getElementById("popupNumero").innerText = this.dataset.numero;
                document.getElementById("popupPeople").innerText = this.dataset.people;
                document.getElementById("popupTotale").innerText = this.dataset.totale;
                document.getElementById("popupAlloggio").innerText = this.dataset.alloggio;
                document.getElementById("popupPaid").innerText = this.dataset.paid;
                document.getElementById("popupStatus").innerText = this.dataset.status;
                document.getElementById("editNumPrenotazione").value = this.dataset.numero;
                document.getElementById("deleteNumPrenotazione").value = this.dataset.numero;
                document.getElementById("confirmNumPrenotazione").value = this.dataset.numero;

                popup.style.display = "block";
            });
        });

        // Chiudi il popup di dettagli della prenotazione
        closeBtn.addEventListener("click", function() {
            popup.style.display = "none";
        });

        // Chiudi il popup cliccando fuori
        window.addEventListener("click", function(event) {
            if (event.target === popup) {
                popup.style.display = "none";
            }
        });

        // Funzione per aprire il modal di conferma
        function openConfirmModal(message, callbackYes) {
            confirmMessageElement.innerText = message;
            confirmModal.style.display = "block";
            popup.style.display = "none"; // Nasconde il popup di dettagli

            confirmYesBtn.onclick = function() {
                callbackYes();
                confirmModal.style.display = "none";
                popup.style.display = "block"; // Riapre il popup di dettagli
            };

            confirmNoBtn.onclick = function() {
                confirmModal.style.display = "none";
                popup.style.display = "block"; // Riapre il popup di dettagli
            };
        }

        // Evento di click per il pulsante "Cancella"
        deleteBtn.addEventListener("click", function(event) {
            event.preventDefault();
            openConfirmModal("Sei sicuro di voler eliminare la prenotazione?", function() {
                document.getElementById("deleteForm").submit();
            });
        });

        // Evento di click per il pulsante "Elimina definitivamente"
        deleteForeverBtn.addEventListener("click", function(event) {
            event.preventDefault();
            openConfirmModal("Sei sicuro di voler eliminare definitivamente la prenotazione?", function() {
                document.getElementById("deleteForeverForm").submit();
            });
        });

        // Chiudi il modal di conferma cliccando sul simbolo "X"
        document.querySelector("#confirmModal .close").addEventListener("click", function() {
            confirmModal.style.display = "none";
            popup.style.display = "block"; // Riapre il popup di dettagli
        });

        // Chiudi il modal di conferma cliccando fuori dalla finestra
        window.addEventListener("click", function(event) {
            if (event.target === confirmModal) {
                confirmModal.style.display = "none";
                popup.style.display = "block"; // Riapre il popup di dettagli
            }
        });
    });

    document.addEventListener("DOMContentLoaded", function() {
        const toggleButton = document.querySelector('.toggle-section-button');
        const section = document.querySelector('.section');

        toggleButton.addEventListener('click', function(e) {
            e.preventDefault();
            if (section.style.display === 'none' || section.style.display === '') {
                section.style.display = 'block';
                toggleButton.classList.add('active');
            } else {
                section.style.display = 'none';
                toggleButton.classList.remove('active');
            }
        });
    });
</script>
</html>

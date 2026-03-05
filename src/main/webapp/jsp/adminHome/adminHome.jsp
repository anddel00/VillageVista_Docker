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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            --primary: #1e3a8a;
            --primary-hover: #1e40af;
            --sidebar-bg: #0f172a; /* Sfondo scuro per la sidebar */
            --bg-light: #f1f5f9;
            --text-dark: #334155;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;

            /* Colori Stato Prenotazioni */
            --status-confirmed: #10b981; /* Verde moderno */
            --status-unpaid: #f59e0b; /* Giallo/Ambra */
            --status-cancelled: #ef4444; /* Rosso chiaro */
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: var(--font-body);
            background-color: var(--bg-light);
            color: var(--text-dark);
            display: flex; /* Layout a due colonne (sidebar + main) */
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* --- 2. MOBILE HEADER (Visibile solo su smartphone) --- */
        .mobile-header {
            display: none;
            background-color: var(--sidebar-bg);
            color: white;
            padding: 15px 20px;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        .hamburger {
            background: none; border: none; color: white;
            font-size: 24px; cursor: pointer;
        }

        /* --- 3. SIDEBAR --- */
        .sidebar {
            width: 250px;
            background-color: var(--sidebar-bg);
            color: white;
            position: fixed;
            top: 0; bottom: 0; left: 0;
            overflow-y: auto;
            transition: transform 0.3s ease;
            z-index: 999;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
        }

        .sidebar-brand {
            padding: 25px 20px;
            font-family: var(--font-headings);
            font-size: 22px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            color: #fbbf24;
            text-align: center;
        }

        .sidebar ul { list-style: none; padding-top: 20px; }
        .sidebar li { margin-bottom: 5px; }

        .nav-link {
            display: flex; align-items: center;
            padding: 12px 20px;
            color: #cbd5e1;
            text-decoration: none;
            transition: all 0.2s ease;
            font-weight: 600;
        }
        .nav-link:hover, .sidebar li.active .nav-link {
            background-color: rgba(255,255,255,0.1);
            color: white;
            border-left: 4px solid var(--status-unpaid);
        }

        .nav-icon { width: 20px; height: 20px; margin-right: 15px; opacity: 0.8; filter: brightness(0) invert(1); }
        .nav-link:hover .nav-icon, .sidebar li.active .nav-icon { opacity: 1; }

        /* --- 4. MAIN CONTENT --- */
        .main-content {
            margin-left: 250px; /* Spazio per la sidebar */
            padding: 40px;
            flex-grow: 1;
            width: calc(100% - 250px);
            transition: margin-left 0.3s, width 0.3s;
        }

        .welcome-message {
            background: white;
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            font-size: 18px;
            font-weight: 600;
            color: var(--primary);
            display: flex; justify-content: space-between; align-items: center;
        }

        .prenotazioni-month {
            font-family: var(--font-headings);
            font-size: 28px;
            color: var(--primary);
            margin-bottom: 15px;
            margin-top: 30px;
        }

        /* --- 5. CALENDARIO SCORREVOLE --- */
        .calendar-section { margin-bottom: 50px; }

        /* IL TRUCCO PER IL MOBILE: Questo div permette lo scroll orizzontale */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            padding: 15px;
        }

        .calendar {
            display: grid;
            /* 32 Colonne. Impostiamo una larghezza minima di 30px per ogni giorno, così non si schiacciano mai! */
            grid-template-columns: 120px repeat(31, minmax(30px, 1fr));
            gap: 2px;
            min-width: 1000px; /* Forza il calendario ad essere largo, attivando lo scroll su mobile */
        }

        .day, .alloggio {
            background-color: #f8fafc;
            padding: 10px 5px;
            text-align: center;
            font-size: 12px;
            font-weight: 600;
            color: var(--text-muted);
            border-radius: 4px;
            border: 1px solid #e2e8f0;
        }

        .alloggio {
            background-color: var(--primary);
            color: white;
            text-align: left;
            padding-left: 10px;
            border: none;
        }

        .empty { background: transparent; border: none; }

        /* Le "Barre" delle prenotazioni */
        .prenotazione {
            background-color: var(--status-confirmed);
            color: white;
            text-align: center;
            padding: 8px 5px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            cursor: pointer;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            transition: filter 0.2s;
            margin-top: 2px; margin-bottom: 2px;
        }
        .prenotazione:hover { filter: brightness(1.1); }
        .prenotazione.cancelled { background-color: var(--status-cancelled); }
        .prenotazione.confirmed-unpaid { background-color: var(--status-unpaid); color: #000; }

        /* --- 6. STORICO CANCELLATE E CARD --- */
        .toggle-section-button {
            display: inline-block;
            margin: 20px 0 40px 0;
            padding: 12px 24px;
            background-color: white;
            color: var(--primary);
            border: 2px solid var(--primary);
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
        }
        .toggle-section-button:hover, .toggle-section-button.active {
            background-color: var(--primary);
            color: white;
        }

        .section {
            display: none;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            margin-bottom: 60px;
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        .table-title { color: var(--status-cancelled); font-size: 22px; margin-bottom: 30px; text-align: center; }

        .card-container { display: flex; flex-direction: column; gap: 20px; }

        .card {
            display: flex;
            background: #f8fafc;
            border-radius: 12px;
            border-left: 5px solid var(--status-cancelled);
            padding: 20px;
            position: relative;
        }

        .card img { width: 150px; height: 100px; object-fit: cover; border-radius: 8px; margin-right: 20px; }

        .card-details { flex: 1; }
        .card-details p { margin-bottom: 5px; font-size: 14px; color: var(--text-dark); }
        .card-details p img { width: 14px; height: 14px; margin-right: 8px; display: inline-block; vertical-align: middle; }

        .label {
            position: absolute; top: 15px; right: 20px;
            background: var(--status-cancelled); color: white;
            padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: bold;
        }

        /* Pulsanti nelle card e nei popup */
        button { font-family: var(--font-body); }
        .btn-action {
            padding: 8px 15px; border: none; border-radius: 6px; color: white; font-weight: 600;
            cursor: pointer; transition: filter 0.2s;
        }
        .btn-action:hover { filter: brightness(0.9); }
        .btn-danger { background-color: var(--status-cancelled); }
        .btn-primary { background-color: var(--primary); }
        .btn-success { background-color: var(--status-confirmed); }

        #deleteforeverBtn {
            position: absolute; bottom: 20px; right: 20px;
            background-color: var(--status-cancelled); color: white;
            border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer;
        }

        /* --- 7. MODALS (Popups) --- */
        .modal, .popup {
            display: none; position: fixed; z-index: 2000; left: 0; top: 0;
            width: 100%; height: 100%; background-color: rgba(15, 23, 42, 0.7);
            backdrop-filter: blur(5px); align-items: center; justify-content: center;
        }

        /* Uso Flexbox sul container del popup tramite JS per centrarlo perfettamente */
        .popup-content, .modal-content {
            background-color: white; margin: 10vh auto; padding: 30px;
            width: 90%; max-width: 450px; border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3); position: relative;
        }

        .close {
            position: absolute; top: 15px; right: 20px; font-size: 24px;
            color: var(--text-muted); cursor: pointer; transition: color 0.2s;
        }
        .close:hover { color: var(--status-cancelled); }

        .popup-content h3 { color: var(--primary); margin-bottom: 20px; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px;}
        .popup-content p { margin-bottom: 10px; font-size: 15px; }

        .popup-actions { margin-top: 25px; display: flex; gap: 10px; flex-wrap: wrap;}
        .modal-buttons { margin-top: 25px; display: flex; justify-content: flex-end; gap: 10px; }

        /* --- 8. MEDIA QUERIES PER SMARTPHONE --- */
        @media (max-width: 992px) {
            .mobile-header { display: flex; }

            /* Nascondiamo la sidebar di default su mobile */
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }

            /* Il main content occupa tutto lo spazio */
            .main-content {
                margin-left: 0; width: 100%; padding: 20px; padding-top: 80px; /* Spazio per l'header fisso */
            }

            .card { flex-direction: column; }
            .card img { width: 100%; height: 150px; margin-bottom: 15px; }
            .label { position: static; display: inline-block; margin-bottom: 15px; }
            #deleteforeverBtn { position: static; width: 100%; margin-top: 15px; }
        }
    </style>
</head>
<body>

<div class="mobile-header">
    <div style="font-family: var(--font-headings); font-size: 20px; color: #fbbf24;">VillageVista</div>
    <button class="hamburger" id="hamburgerBtn">☰</button>
</div>

<div class="sidebar" id="sidebar">
    <div class="sidebar-brand">VillageVista Staff</div>
    <ul>
        <li>
            <a href="Dispatcher?controllerAction=HomeManagement.view" class="nav-link">
                <img src="images/homeb.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Sito Pubblico
            </a>
        </li>
        <li class="active">
            <a href="Dispatcher?controllerAction=AdminHomeManagement.view" class="nav-link">
                <img src="images/calendario.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Prenotazioni
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToAlloggiManagement" class="nav-link">
                <img src="images/alloggiob.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Gestione Alloggi
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToDipendentiManagement" class="nav-link">
                <img src="images/dipendentib.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Dipendenti
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToAdminManagement" class="nav-link">
                <img src="images/admin.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Amministratori
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToTurniManagement" class="nav-link">
                <img src="images/turnib.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Turni di Lavoro
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToClientiManagement" class="nav-link">
                <img src="images/personeb.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Clienti
            </a>
        </li>
    </ul>
</div>

<div class="main-content" id="main-content">

    <div class="welcome-message">
        <span>👋 Benvenuto, <%= nome %> <%= cognome %>!</span>
        <span style="font-size: 14px; font-weight: normal; color: var(--text-muted);"><%= sdf.format(new java.util.Date()) %></span>
    </div>

    <div class="calendar-section">
        <h2 class="prenotazioni-month">Prenotazioni Luglio</h2>

        <div class="table-responsive">
            <div class="calendar">
                <div class="alloggio empty"></div>
                <% for (int day = 1; day <= 31; day++) { %>
                <div class="day"><%= day %></div>
                <% } %>

                <%
                    int totalAlloggi = 15;
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
                            colspan = 31 - checkinDay + 1;
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
                <div class="empty"></div>
                <%
                        day++;
                    }
                %>
                <% } %>
                <% } %>
            </div>
        </div>
    </div>

    <div class="calendar-section">
        <h2 class="prenotazioni-month">Prenotazioni Agosto</h2>

        <div class="table-responsive">
            <div class="calendar">
                <div class="alloggio empty"></div>
                <% for (int day = 1; day <= 31; day++) { %>
                <div class="day"><%= day %></div>
                <% } %>

                <%
                    for (int alloggio = 1; alloggio <= totalAlloggi; alloggio++) {
                %>
                <div class="alloggio">Alloggio <%= alloggio %></div>
                <% for (int day = 1; day <= 31;) { %>
                <%
                    boolean isBooked = false;
                    Prenotazione currentBooking = null;
                    for (Prenotazione p : prenotazioniAgosto) {
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
                <div class="empty"></div>
                <%
                        day++;
                    }
                %>
                <% } %>
                <% } %>
            </div>
        </div>
    </div>

    <a href="#" class="toggle-section-button" id="toggleStoricoBtn">Storico prenotazioni cancellate ▼</a>

    <div class="section" id="storicoSection">
        <h1 class="table-title">Storico Prenotazioni Cancellate</h1>
        <div class="card-container">
            <% if (deletedprenotazioni == null || deletedprenotazioni.isEmpty()) { %>
            <div style="text-align: center; color: var(--text-muted);">Nessuna prenotazione trovata.</div>
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
                <div class="label">Pren. N°: <%= deletedprenotazione.getNumPrenotazione() %></div>
                <img src="<%= immagineAlloggio %>" alt="Alloggio" onerror="this.src='https://via.placeholder.com/150x100?text=Alloggio'">
                <div class="card-details">
                    <p><strong>Cliente:</strong> <%= deletedprenotazione.getCognomeP() %></p>
                    <p><strong>Check-in:</strong> <%= deletedprenotazione.getDataCheckin() %></p>
                    <p><strong>Check-out:</strong> <%= deletedprenotazione.getDataCheckout() %></p>
                    <p><strong>Alloggio:</strong> <%= deletedprenotazione.getAlloggio() %></p>
                    <p><strong>N. Ospiti:</strong> <%= deletedprenotazione.getPersone() %></p>
                    <p><strong>Totale:</strong> € <%= deletedprenotazione.getTotale() %></p>
                </div>
                <form id="deleteForeverForm" action="Dispatcher" method="post" style="display: inline;">
                    <input type="hidden" name="controllerAction" value="AdminHomeManagement.deleteForeverPrenotazione">
                    <input type="hidden" name="num_prenotazione" value="<%= deletedprenotazione.getNumPrenotazione() %>">
                    <button type="submit" id="deleteforeverBtn" class="btn-action btn-danger">Elimina Definitivamente</button>
                </form>
            </div>
            <% } %>
            <% } %>
        </div>
    </div>
</div>

<div id="bookingPopup" class="popup">
    <div class="popup-content">
        <span class="close">&times;</span>
        <h3>Dettagli Prenotazione N. <span id="popupNumero"></span></h3>
        <p><strong>Persone:</strong> <span id="popupPeople"></span></p>
        <p><strong>Alloggio:</strong> <span id="popupAlloggio"></span></p>
        <p><strong>Totale:</strong> € <span id="popupTotale"></span></p>
        <p><strong>Stato Pagamento:</strong> <span id="popupPaid"></span></p>
        <p><strong>Stato Prenotazione:</strong> <span id="popupStatus"></span></p>

        <div class="popup-actions">
            <form id="editForm" action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="AdminHomeManagement.goToModPrenotazione">
                <input type="hidden" name="num_prenotazione" id="editNumPrenotazione">
                <button type="submit" id="editPopupBtn" class="btn-action btn-primary">Modifica</button>
            </form>
            <form id="confirmForm" action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="AdminHomeManagement.confirmPrenotazione">
                <input type="hidden" name="num_prenotazione" id="confirmNumPrenotazione">
                <button type="submit" id="confirmBtn" class="btn-action btn-success">Segna Pagato</button>
            </form>
            <form id="deleteForm" action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="AdminHomeManagement.deletePrenotazione">
                <input type="hidden" name="num_prenotazione" id="deleteNumPrenotazione">
                <button type="submit" id="deleteBtn" class="btn-action btn-danger">Cancella</button>
            </form>
        </div>
    </div>
</div>

<div id="confirmModal" class="modal">
    <div class="modal-content" style="max-width: 400px; text-align: center;">
        <h3 style="color: var(--status-cancelled); margin-bottom: 15px;">Attenzione</h3>
        <p id="confirmMessage">Sei sicuro di voler procedere?</p>
        <div class="modal-buttons" style="justify-content: center; margin-top: 20px;">
            <button id="confirmNo" class="btn-action btn-primary">Annulla</button>
            <button id="confirmYes" class="btn-action btn-danger">Sì, procedi</button>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {

        // --- LOGICA MENU HAMBURGER MOBILE ---
        const hamburgerBtn = document.getElementById('hamburgerBtn');
        const sidebar = document.getElementById('sidebar');

        hamburgerBtn.addEventListener('click', function() {
            sidebar.classList.toggle('open');
        });

        // Chiudi sidebar se clicco fuori su mobile
        document.addEventListener('click', function(e) {
            if(window.innerWidth <= 992 && !sidebar.contains(e.target) && e.target !== hamburgerBtn) {
                sidebar.classList.remove('open');
            }
        });

        // --- LOGICA POPUP E MODAL (TUA LOGICA ORIGINALE PRESERVATA) ---
        var popup = document.getElementById("bookingPopup");
        var closeBtn = document.querySelector("#bookingPopup .close");
        var editPopupBtn = document.getElementById("editPopupBtn");
        var deleteBtn = document.getElementById("deleteBtn");
        // Aggiornato: usiamo querySelectorAll perché ci possono essere più bottoni "Elimina definitivamente" nel ciclo
        var deleteForeverBtns = document.querySelectorAll("#deleteforeverBtn");
        var confirmModal = document.getElementById("confirmModal");
        var confirmMessageElement = document.getElementById("confirmMessage");
        var confirmYesBtn = document.getElementById("confirmYes");
        var confirmNoBtn = document.getElementById("confirmNo");

        document.querySelectorAll(".prenotazione").forEach(function(element) {
            element.addEventListener("click", function() {
                // Popup viene mostrato con flex per essere centrato dal CSS
                popup.style.display = "flex";
                document.getElementById("popupNumero").innerText = this.dataset.numero;
                document.getElementById("popupPeople").innerText = this.dataset.people;
                document.getElementById("popupTotale").innerText = this.dataset.totale;
                document.getElementById("popupAlloggio").innerText = this.dataset.alloggio;
                document.getElementById("popupPaid").innerText = this.dataset.paid;
                document.getElementById("popupStatus").innerText = this.dataset.status;
                document.getElementById("editNumPrenotazione").value = this.dataset.numero;
                document.getElementById("deleteNumPrenotazione").value = this.dataset.numero;
                document.getElementById("confirmNumPrenotazione").value = this.dataset.numero;
            });
        });

        closeBtn.addEventListener("click", function() { popup.style.display = "none"; });

        window.addEventListener("click", function(event) {
            if (event.target === popup) { popup.style.display = "none"; }
        });

        function openConfirmModal(message, callbackYes) {
            confirmMessageElement.innerText = message;
            confirmModal.style.display = "flex";
            popup.style.display = "none";

            // Rimuoviamo vecchi listener per evitare bug di click multipli
            var newConfirmYesBtn = confirmYesBtn.cloneNode(true);
            confirmYesBtn.parentNode.replaceChild(newConfirmYesBtn, confirmYesBtn);
            confirmYesBtn = newConfirmYesBtn;

            confirmYesBtn.onclick = function() {
                callbackYes();
                confirmModal.style.display = "none";
            };

            confirmNoBtn.onclick = function() {
                confirmModal.style.display = "none";
                popup.style.display = "flex";
            };
        }

        deleteBtn.addEventListener("click", function(event) {
            event.preventDefault();
            openConfirmModal("Sei sicuro di voler eliminare la prenotazione?", function() {
                document.getElementById("deleteForm").submit();
            });
        });

        // Gestione di TUTTI i pulsanti "Elimina definitivamente" nelle card
        deleteForeverBtns.forEach(function(btn) {
            btn.addEventListener("click", function(event) {
                event.preventDefault();
                var formToSubmit = this.closest("form"); // Prende il form esatto di QUESTA card
                openConfirmModal("Sei sicuro di voler eliminare definitivamente la prenotazione?", function() {
                    formToSubmit.submit();
                });
            });
        });

        window.addEventListener("click", function(event) {
            if (event.target === confirmModal) {
                confirmModal.style.display = "none";
            }
        });

        // --- TOGGLE STORICO ---
        const toggleButton = document.getElementById('toggleStoricoBtn');
        const section = document.getElementById('storicoSection');

        toggleButton.addEventListener('click', function(e) {
            e.preventDefault();
            if (section.style.display === 'none' || section.style.display === '') {
                section.style.display = 'block';
                toggleButton.classList.add('active');
                toggleButton.innerHTML = "Storico prenotazioni cancellate ▲";
            } else {
                section.style.display = 'none';
                toggleButton.classList.remove('active');
                toggleButton.innerHTML = "Storico prenotazioni cancellate ▼";
            }
        });
    });
</script>
</body>
</html>
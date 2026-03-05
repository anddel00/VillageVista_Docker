<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Dipendente" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Turno_lavoro" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.temporal.TemporalAdjusters" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.sql.Date" %>

<%
    List<Turno_lavoro> turni_lavoro = (List<Turno_lavoro>) request.getAttribute("turni_lavoro");

%>

<%
    String nome = (String) session.getAttribute("nome");
    String cognome = (String) session.getAttribute("cognome");
    String username = (String) session.getAttribute("username");
%>

<%
    List<Turno_lavoro> turniLavoro = (List<Turno_lavoro>) request.getAttribute("turni_lavoro");

    // Raggruppa i turni per settimana, considerando sabato come il primo giorno della settimana
    Map<Integer, List<Turno_lavoro>> turniByWeek = turniLavoro.stream().collect(Collectors.groupingBy(
            turno -> {
                LocalDate dataTurno = turno.getData_turno().toLocalDate();
                return dataTurno.with(TemporalAdjusters.previousOrSame(DayOfWeek.SATURDAY)).getDayOfYear();
            }
    ));

    SimpleDateFormat weekFormat = new SimpleDateFormat("'Settimana dal' dd/MM/yyyy", java.util.Locale.ITALIAN);
    SimpleDateFormat endweekFormat = new SimpleDateFormat("'al' dd/MM/yyyy", java.util.Locale.ITALIAN);
    SimpleDateFormat dayNameFormat = new SimpleDateFormat("EEEE dd MMMM yyyy", java.util.Locale.ITALIAN);

    LocalDate oggi = LocalDate.now();
    List<Turno_lavoro> turniOggi = turniLavoro.stream()
            .filter(turno -> turno.getData_turno().toLocalDate().equals(oggi))
            .collect(Collectors.toList());
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Dipendente Home</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            padding: 0;
            color: #2c3e50;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .welcome-message {
            font-size: 20px;
            font-family: "Cactus Classical Serif", serif;
            color: #2c3e50;
            margin-left: 215px;
        }
        .week-section {
            margin-bottom: 30px;
            padding: 15px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            color: #2c3e50;
            border: 2px solid #2c3e50;
            font-family: "Cactus Classical Serif", serif;
        }
        .week-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .section {
            background-color: #f3cf75;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 15px;
            transform: translateY(-20px);
            animation: fadeInDown 2s forwards;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            height: auto;
        }
        .section h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .turno {
            padding: 10px;
            background-color: #fff2c1;
            border-radius: 5px;
            margin-bottom: 10px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }
        .turno p {
            margin: 5px 0;
        }
        .turno strong {
            font-weight: bold;
            font-family: sans-serif;
        }
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 250px;
            background-color: #f0c320;
            padding-top: 20px;
            overflow-y: auto;
            color: #2c3e50;
            font-family: "Cactus Classical Serif", serif;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
            color: #2c3e50;
        }
        .sidebar ul li {
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .sidebar li:nth-child(2) {
            background-color: #b89b0b;
        }
        .nav-link {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: #2c3e50;
            transition: background-color 0.3s;
        }
        .nav-link:hover {
            background-color: #b89b0b;
        }
        .nav-icon {
            vertical-align: middle;
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }
        .nav-text {
            vertical-align: middle;
            color: #2c3e50;
        }
        .main-content {
            margin-left: 200px;
            padding: 20px;
            font-family: sans-serif;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <ul>
        <li>
            <a href="Dispatcher?controllerAction=HomeManagement.view" class="nav-link">
                <img src="images/home.png" alt="Prenotazioni" class="nav-icon">
                <span class="nav-text">Torna alla home</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.view" class="nav-link">
                <img src="images/userblack.png" alt="Home" class="nav-icon">
                <span class="nav-text">Turni di lavoro</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.goToDipendentePersonale" class="nav-link">
                <img src="images/clockblack.png" alt="Prenotazioni" class="nav-icon">
                <span class="nav-text">Area personale</span>
            </a>
        </li>
    </ul>
</div>
<div class="container">
    <div class="welcome-message">
        <p>Benvenuto, <%= request.getSession().getAttribute("nome") %> <%= request.getSession().getAttribute("cognome") %>!</p>
    </div>
    <div class="main-content">
        <div class="section">
            <h2>Il tuo turno di oggi</h2>
            <% if (turniOggi == null || turniOggi.isEmpty()) { %>
            <p>Nessun turno per oggi.</p>
            <% } else { %>
            <% for (Turno_lavoro turno : turniOggi) { %>
            <div class="turno">
                <p><strong>Data:</strong> <%= dayNameFormat.format(Date.valueOf(turno.getData_turno().toLocalDate())) %></p>
                <p><strong>Dalle:</strong> <%= turno.getOra_inizio() %></p>
                <p><strong>Alle:</strong> <%= turno.getOra_fine() %></p>
            </div>
            <% } %>
            <% } %>
        </div>
        <h1 class="table-title">Tutti i turni</h1>
        <% if (turniLavoro == null || turniLavoro.isEmpty()) { %>
        <p>Nessun turno trovato.</p>
        <% } else { %>
        <% for (Map.Entry<Integer, List<Turno_lavoro>> entry : turniByWeek.entrySet()) { %>
        <%
            LocalDate startOfWeek = entry.getValue().get(0).getData_turno().toLocalDate().with(TemporalAdjusters.previousOrSame(DayOfWeek.SATURDAY));
            LocalDate endOfWeek = startOfWeek.plusDays(6);
        %>
        <div class="week-section">
            <div class="week-title"><%= weekFormat.format(Date.valueOf(startOfWeek)) %> <%= endweekFormat.format(Date.valueOf(endOfWeek)) %></div>
            <% for (Turno_lavoro turno : entry.getValue()) { %>
            <div class="turno">
                <p><b><strong><%= dayNameFormat.format(Date.valueOf(turno.getData_turno().toLocalDate())) %></strong></b></p>
                <p><strong>Dalle:</strong> <%= turno.getOra_inizio() %></p>
                <p><strong>Alle:</strong> <%= turno.getOra_fine() %></p>
            </div>
            <% } %>
        </div>
        <% } %>
        <% } %>
    </div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.temporal.TemporalAdjusters" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Dipendente" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Turno_lavoro" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.*" %>

<%
    Dipendente dipendente = (Dipendente) request.getAttribute("dipendente");
    List<Turno_lavoro> turni_lavoro = (List<Turno_lavoro>) request.getAttribute("turniLavoro");

    // Raggruppa i turni per settimana, considerando sabato come il primo giorno della settimana
    Map<Integer, List<Turno_lavoro>> turniByWeek = new TreeMap<>(Collections.reverseOrder());
    turniByWeek.putAll(turni_lavoro.stream().collect(Collectors.groupingBy(
            turno -> turno.getData_turno().toLocalDate().with(TemporalAdjusters.previousOrSame(DayOfWeek.SATURDAY)).getDayOfYear()
    )));

    SimpleDateFormat weekFormat = new SimpleDateFormat("'Settimana dal' dd/MM/yyyy", java.util.Locale.ITALIAN);
    SimpleDateFormat endweekFormat = new SimpleDateFormat("'al' dd/MM/yyyy", java.util.Locale.ITALIAN);
    SimpleDateFormat dayNameFormat = new SimpleDateFormat("EEEE dd MMMM yyyy", java.util.Locale.ITALIAN);
%>
<html>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
    <title>Turni Dipendente</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        .main-content {
            max-width: 800px;
            margin: 0 auto;
            margin-left: 28%;
        }

        .page-title {
            color: #0066da;
            font-family: "Cactus Classical Serif", serif;
            margin-bottom: 20px;
            text-align: center;
        }

        .search-form {
            margin-bottom: 20px;
        }

        .search-bar {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .week-section {
            margin-bottom: 30px;
            padding: 15px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border: 2px solid #0066da;
        }

        .week-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #0066da;
        }

        .turno {
            padding: 10px;
            background-color: #f0f0f0;
            border-radius: 5px;
            margin-bottom: 10px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }
        .giorno{
            background-color: #2c3e50;
            color: white;
            padding: 3px;
            font-family: "Cactus Classical Serif",sans-serif;
        }

        .turno p {
            margin: 5px 0;
        }

        .turno strong {
            font-weight: bold;
            font-family: sans-serif;
        }

        .action-section {
            background-color: #2c3e50;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            display: inline-block;
        }

        .action-section-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: white;
        }

        .action-buttons {
            display: inline-flex;
            justify-content: space-around;
            align-items: center;
        }

        .action-buttons .btn {
            background-color: #007bff;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-family: sans-serif;
            font-size: 13px;
            margin-right: 20px;
            margin-left: 525px;
        }

        .action-buttons .btn:hover {
            background-color: #0056b3;
        }
        .action-buttons .delete{
            background-color: #cc0000;
            color: white;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-family: sans-serif;
            border: none;
            font-size: 13px;
        }
        .action-buttons .delete:hover {
            background-color: #af0b19;
            cursor: pointer;
        }

        .action-buttons form {
            margin: 0;
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
        .sidebar li:nth-child(6){
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
        .new-turno{
            margin-bottom: 20px;
        }
        .new-turno a{
            background-color: #00a900;
            color: white;
            font-family: "Cactus Classical Serif",serif;
            font-size: 14px;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
        }
        .new-turno a:hover{
            background-color: #0c8629;
            cursor: pointer;
        }



    </style>
</head>
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
    <h1 class="turni-title">Elenco turni registrati</h1>
    <div class="search-form">
        <input type="text" id="searchBar" class="search-bar" placeholder="Cerca per settimana, mese o cognome..." onkeyup="filterWeeks()">
    </div>
    <div class="new-turno">
        <a href="Dispatcher?controllerAction=AdminHomeManagement.goToInsertTurno" class="btn">Nuovo turno</a>
    </div>

    <% if (turni_lavoro == null || turni_lavoro.isEmpty()) { %>
    <p>Nessun turno di lavoro trovato.</p>
    <% } else { %>
    <% for (Map.Entry<Integer, List<Turno_lavoro>> entry : turniByWeek.entrySet()) {
       %>
    <%
        LocalDate startOfWeek = entry.getValue().get(0).getData_turno().toLocalDate().with(TemporalAdjusters.previousOrSame(DayOfWeek.SATURDAY));
        LocalDate endOfWeek = startOfWeek.plusDays(6);
    %>
    <div class="week-section">
        <div class="week-title"><%= weekFormat.format(Date.valueOf(startOfWeek)) %> <%= endweekFormat.format(Date.valueOf(endOfWeek)) %></div>
        <% for (Turno_lavoro turno : entry.getValue()) { %>
        <div class="turno">
            <p class="giorno"><b><strong><%= dayNameFormat.format(Date.valueOf(turno.getData_turno().toLocalDate())) %></strong></b></p>
            <p><strong>Dalle:</strong> <%= turno.getOra_inizio() %></p>
            <p><strong>Alle:</strong> <%= turno.getOra_fine() %></p>
            <p><Strong>Coperto da:</Strong><span class="cognome-turno"><%= turno.getCognome_turno() %></span></p>
            <div class="action-buttons">
                <a href="Dispatcher?controllerAction=AdminHomeManagement.goToModTurno&turno_id=<%= turno.getTurno_id() %>" class="btn">Modifica turno</a>
                <form id="deleteForm" action="Dispatcher" method="post">
                    <input type="hidden" name="controllerAction" value="AdminHomeManagement.deleteTurno">
                    <input type="hidden" name="turno_id" value="<%=turno.getTurno_id()%>">
                    <button type="submit" class="delete">Elimina turno</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
    <% } %>
</div>

<script>
    function filterWeeks() {
        var input, filter, weekSections, i, shouldDisplay;
        input = document.getElementById('searchBar');
        filter = input.value.trim().toUpperCase();
        weekSections = document.getElementsByClassName('week-section');

        for (i = 0; i < weekSections.length; i++) {
            shouldDisplay = false;

            // Controlla se il testo è presente nel titolo della settimana
            var weekTitles = weekSections[i].getElementsByClassName('week-title');
            for (var j = 0; j < weekTitles.length; j++) {
                var weekTitle = weekTitles[j].textContent || weekTitles[j].innerText;
                if (weekTitle.toUpperCase().indexOf(filter) > -1) {
                    shouldDisplay = true;
                    break;
                }
            }

            // Controlla se il testo è presente nel cognome del dipendente per ogni turno
            if (!shouldDisplay) {
                var turni = weekSections[i].getElementsByClassName('turno');
                for (var k = 0; k < turni.length; k++) {
                    var cognome = turni[k].getElementsByClassName('cognome-turno')[0].textContent || turni[k].getElementsByClassName('cognome-turno')[0].innerText;
                    if (cognome.toUpperCase().indexOf(filter) > -1) {
                        shouldDisplay = true;
                        break;
                    }
                }
            }

            // Se il filtro non è ancora attivo, controlla se corrisponde al mese
            if (!shouldDisplay) {
                var turniDates = weekSections[i].querySelectorAll('.giorno'); // Seleziona tutti gli elementi con classe .giorno
                for (var m = 0; m < turniDates.length; m++) {
                    var dateText = turniDates[m].textContent || turniDates[m].innerText;
                    // Confronta solo il mese nell'elemento .giorno
                    if (dateText.toUpperCase().indexOf(filter) > -1) {
                        shouldDisplay = true;
                        break;
                    }
                }
            }

            // Mostra o nasconde la settimana in base al risultato della ricerca
            if (shouldDisplay) {
                weekSections[i].style.display = "";
            } else {
                weekSections[i].style.display = "none";
            }
        }
    }
</script>
</body>
</html>
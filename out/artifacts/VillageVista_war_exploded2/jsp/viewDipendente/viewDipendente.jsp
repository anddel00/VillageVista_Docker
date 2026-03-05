<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.temporal.TemporalAdjusters" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Dipendente" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Turno_lavoro" %>
<%@ page import="java.sql.Date" %>

<%
  Dipendente dipendente = (Dipendente) request.getAttribute("dipendente");
  List<Turno_lavoro> turniLavoro = (List<Turno_lavoro>) request.getAttribute("turnoLavoro");

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
      padding: 10px 20px;
      text-decoration: none;
      border-radius: 5px;
      transition: background-color 0.3s;
      font-family: sans-serif;
      font-size: 14px;
      margin-right: 50px;
    }

    .action-buttons .btn:hover {
      background-color: #0056b3;
    }
    .action-buttons .delete{
      background-color: #cc0000;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      border-radius: 5px;
      transition: background-color 0.3s;
      font-family: sans-serif;
      border: none;
      font-size: 14px;
    }
    .action-buttons .delete:hover {
      background-color: #af0b19;
      cursor: pointer;
    }

    .action-buttons form {
      margin: 0;
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
      font-size: 16px;
    }

    .sidebar ul {
      list-style-type: none;
      padding: 0;
    }

    .sidebar li {
      margin-bottom: 10px;
    }

    .sidebar li:nth-child(4) {
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
  <h1 class="page-title">Area riservata di <%= dipendente.getNome_dip() %> <%= dipendente.getCognome_dip() %></h1>
  <div class="action-section">
    <div class="action-section-title">Azioni</div>
    <div class="action-buttons">
      <a href="Dispatcher?controllerAction=AdminHomeManagement.goToModDipendente&id=<%= dipendente.getDipId() %>" class="btn">Modifica dipendente</a>
      <form id="deleteForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="AdminHomeManagement.deleteDipendente">
        <input type="hidden" name="dipId" value="<%=dipendente.getDipId()%>">
        <button type="submit" class="delete">Elimina dipendente</button>
      </form>
    </div>
  </div>
  <h1 class="turni-title">I suoi turni registrati</h1>
  <div class="search-form">
    <input type="text" id="searchBar" class="search-bar" placeholder="Cerca settimana o giorno..." onkeyup="filterWeeks()">
  </div>

  <% if (turniLavoro == null || turniLavoro.isEmpty()) { %>
  <p>Nessun turno di lavoro trovato per questo dipendente.</p>
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

      // Se il filtro non è ancora attivo, controlla se corrisponde al mese
      if (!shouldDisplay) {
        var turniDates = weekSections[i].querySelectorAll('.turno p:first-child'); // Seleziona tutti gli elementi con classe .giorno
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
      weekSections[i].style.display = shouldDisplay ? "" : "none";
    }
  }
</script>
</body>
</html>
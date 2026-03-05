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
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dettagli Dipendente | VillageVista Staff</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

  <style>
    /* --- 1. CSS VARIABLES --- */
    :root {
      --primary: #1e3a8a;
      --primary-hover: #1e40af;
      --sidebar-bg: #0f172a;
      --bg-light: #f8fafc;
      --text-dark: #334155;
      --text-muted: #64748b;
      --font-headings: 'Playfair Display', serif;
      --font-body: 'Inter', sans-serif;
      --danger: #ef4444;
      --danger-hover: #dc2626;
      --success: #10b981;
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: var(--font-body);
      background-color: var(--bg-light);
      color: var(--text-dark);
      display: flex;
      min-height: 100vh;
      overflow-x: hidden;
    }

    /* --- 2. MOBILE HEADER --- */
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
      border-left: 4px solid #60a5fa; /* Colore Dipendenti */
    }

    .nav-icon { width: 20px; height: 20px; margin-right: 15px; opacity: 0.8; filter: brightness(0) invert(1); }
    .nav-link:hover .nav-icon, .sidebar li.active .nav-icon { opacity: 1; }

    /* --- 4. MAIN CONTENT --- */
    .main-content {
      margin-left: 250px;
      padding: 40px;
      flex-grow: 1;
      width: calc(100% - 250px);
      transition: margin-left 0.3s, width 0.3s;
    }

    /* --- 5. PROFILE HEADER (Ex Action Section) --- */
    .profile-header {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.05);
      padding: 30px;
      margin-bottom: 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 20px;
      border-left: 5px solid #60a5fa;
    }

    .profile-info h1 {
      color: var(--primary);
      font-family: var(--font-headings);
      font-size: 32px;
      margin-bottom: 5px;
    }

    .profile-info span {
      display: inline-block;
      background-color: #f1f5f9;
      color: var(--text-muted);
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 13px;
      font-weight: 600;
    }

    .profile-actions {
      display: flex;
      gap: 10px;
    }

    .btn-action {
      padding: 10px 20px;
      border: none;
      border-radius: 8px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      text-decoration: none;
      transition: transform 0.2s, background-color 0.2s;
      font-family: var(--font-body);
    }
    .btn-action:hover { transform: translateY(-2px); }

    .btn-edit { background-color: var(--primary); color: white; }
    .btn-edit:hover { background-color: var(--primary-hover); }

    .btn-delete { background-color: var(--danger); color: white; }
    .btn-delete:hover { background-color: var(--danger-hover); }

    /* --- 6. SEARCH BAR --- */
    .section-title {
      color: var(--primary);
      font-family: var(--font-headings);
      font-size: 24px;
      margin-bottom: 20px;
    }

    .search-container { margin-bottom: 30px; }
    .search-bar {
      width: 100%; padding: 15px 20px; font-size: 16px; font-family: var(--font-body);
      border: 1px solid #cbd5e1; border-radius: 12px; background-color: white;
      box-shadow: 0 4px 6px rgba(0,0,0,0.02); transition: all 0.3s ease; outline: none;
    }
    .search-bar:focus { border-color: var(--primary); box-shadow: 0 0 0 4px rgba(30, 58, 138, 0.1); }

    /* --- 7. GRIGLIA TURNI --- */
    .week-section {
      margin-bottom: 40px;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.05);
      padding: 25px;
    }

    .week-title {
      font-size: 18px;
      font-weight: 700;
      margin-bottom: 20px;
      color: var(--text-dark);
      border-bottom: 2px solid #f1f5f9;
      padding-bottom: 10px;
    }

    .turni-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
    }

    .turno {
      background-color: #f8fafc;
      border: 1px solid #e2e8f0;
      border-radius: 10px;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      transition: box-shadow 0.2s ease;
    }
    .turno:hover { box-shadow: 0 6px 15px rgba(0,0,0,0.08); }

    .giorno {
      background-color: var(--primary);
      color: white;
      padding: 10px 15px;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      font-weight: 600;
      text-align: center;
    }

    .turno-details {
      padding: 20px 15px;
      text-align: center;
    }

    .turno-details p {
      margin-bottom: 5px;
      font-size: 16px;
      color: var(--text-dark);
    }

    /* --- 8. MEDIA QUERIES --- */
    @media (max-width: 992px) {
      .mobile-header { display: flex; }
      .sidebar { transform: translateX(-100%); }
      .sidebar.open { transform: translateX(0); }
      .main-content { margin-left: 0; width: 100%; padding: 20px; padding-top: 80px; }
      .profile-header { flex-direction: column; align-items: flex-start; }
      .profile-actions { width: 100%; flex-direction: column; }
      .btn-action { width: 100%; text-align: center; }
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
    <li>
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
    <li class="active">
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

  <div class="profile-header">
    <div class="profile-info">
      <h1><%= dipendente.getNome_dip() %> <%= dipendente.getCognome_dip() %></h1>
      <span>ID Dipendente: <%= dipendente.getDipId() %></span>
    </div>
    <div class="profile-actions">
      <a href="Dispatcher?controllerAction=AdminHomeManagement.goToModDipendente&id=<%= dipendente.getDipId() %>" class="btn-action btn-edit">Modifica Anagrafica</a>
      <form id="deleteForm" action="Dispatcher" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare definitivamente questo dipendente?');" style="margin: 0;">
        <input type="hidden" name="controllerAction" value="AdminHomeManagement.deleteDipendente">
        <input type="hidden" name="dipId" value="<%=dipendente.getDipId()%>">
        <button type="submit" class="btn-action btn-delete">Elimina Dipendente</button>
      </form>
    </div>
  </div>

  <h2 class="section-title">Turni Programmati</h2>

  <div class="search-container">
    <input type="text" id="searchBar" class="search-bar" placeholder="🔍 Cerca settimana o giorno..." onkeyup="filterWeeks()">
  </div>

  <% if (turniLavoro == null || turniLavoro.isEmpty()) { %>
  <div style="text-align: center; color: var(--text-muted); padding: 40px; background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
    Nessun turno di lavoro trovato per questo dipendente.
  </div>
  <% } else { %>
  <% for (Map.Entry<Integer, List<Turno_lavoro>> entry : turniByWeek.entrySet()) { %>
  <%
    LocalDate startOfWeek = entry.getValue().get(0).getData_turno().toLocalDate().with(TemporalAdjusters.previousOrSame(DayOfWeek.SATURDAY));
    LocalDate endOfWeek = startOfWeek.plusDays(6);
  %>

  <div class="week-section">
    <div class="week-title">📅 <%= weekFormat.format(Date.valueOf(startOfWeek)) %> <%= endweekFormat.format(Date.valueOf(endOfWeek)) %></div>

    <div class="turni-grid">
      <% for (Turno_lavoro turno : entry.getValue()) { %>
      <div class="turno">
        <div class="giorno"><%= dayNameFormat.format(Date.valueOf(turno.getData_turno().toLocalDate())) %></div>
        <div class="turno-details">
          <p style="color: var(--text-muted); font-size: 14px;">Orario</p>
          <p><strong><%= turno.getOra_inizio() %> - <%= turno.getOra_fine() %></strong></p>
        </div>
      </div>
      <% } %>
    </div>

  </div>
  <% } %>
  <% } %>

</div>

<script>
  // --- FUNZIONE DI RICERCA (Aggiornata ai nuovi selettori) ---
  function filterWeeks() {
    var input, filter, weekSections, i, shouldDisplay;
    input = document.getElementById('searchBar');
    filter = input.value.trim().toUpperCase();
    weekSections = document.getElementsByClassName('week-section');

    for (i = 0; i < weekSections.length; i++) {
      shouldDisplay = false;

      var weekTitles = weekSections[i].getElementsByClassName('week-title');
      for (var j = 0; j < weekTitles.length; j++) {
        var weekTitle = weekTitles[j].textContent || weekTitles[j].innerText;
        if (weekTitle.toUpperCase().indexOf(filter) > -1) {
          shouldDisplay = true;
          break;
        }
      }

      if (!shouldDisplay) {
        // Ho cambiato qui per cercare dentro il div.giorno
        var turniDates = weekSections[i].querySelectorAll('.giorno');
        for (var m = 0; m < turniDates.length; m++) {
          var dateText = turniDates[m].textContent || turniDates[m].innerText;
          if (dateText.toUpperCase().indexOf(filter) > -1) {
            shouldDisplay = true;
            break;
          }
        }
      }

      weekSections[i].style.display = shouldDisplay ? "" : "none";
    }
  }

  // --- LOGICA MENU HAMBURGER MOBILE ---
  document.addEventListener("DOMContentLoaded", function() {
    const hamburgerBtn = document.getElementById('hamburgerBtn');
    const sidebar = document.getElementById('sidebar');

    hamburgerBtn.addEventListener('click', function() {
      sidebar.classList.toggle('open');
    });

    document.addEventListener('click', function(e) {
      if(window.innerWidth <= 992 && !sidebar.contains(e.target) && e.target !== hamburgerBtn) {
        sidebar.classList.remove('open');
      }
    });
  });
</script>
</body>
</html>
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
    String nome = (String) session.getAttribute("nome");
    String cognome = (String) session.getAttribute("cognome");

    List<Turno_lavoro> turniLavoro = (List<Turno_lavoro>) request.getAttribute("turni_lavoro");

    // Raggruppa i turni per settimana
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Dipendente | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            /* Palette Blu per il Dipendente */
            --primary: #2563eb;       /* Blu principale */
            --primary-hover: #1d4ed8;
            --primary-light: #eff6ff; /* Sfondo chiarissimo blu */
            --sidebar-bg: #1e3a8a;    /* Blu navy scuro per sidebar */

            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;

            --today-bg: #10b981;      /* Verde per evidenziare il turno odierno */
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
            color: #93c5fd; /* Azzurro chiaro */
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
            border-left: 4px solid #60a5fa;
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

        /* --- 5. TURNO DI OGGI (Highlight) --- */
        .today-section {
            background: linear-gradient(135deg, var(--primary), var(--sidebar-bg));
            color: white;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 40px;
            box-shadow: 0 10px 25px rgba(37, 99, 235, 0.2);
            position: relative;
            overflow: hidden;
        }

        .today-section h2 {
            font-family: var(--font-headings);
            font-size: 28px;
            margin-bottom: 20px;
        }

        .today-card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            padding: 20px;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-width: 400px;
        }

        .today-card p { font-size: 16px; }
        .today-card strong { color: #93c5fd; }

        .today-time {
            font-size: 24px;
            font-weight: 700;
            background: white;
            color: var(--primary);
            padding: 10px 15px;
            border-radius: 8px;
            display: inline-block;
            margin-top: 10px;
            text-align: center;
        }

        /* --- 6. GRIGLIA TUTTI I TURNI --- */
        .section-title {
            color: var(--text-dark);
            font-family: var(--font-headings);
            font-size: 24px;
            margin-bottom: 20px;
        }

        .week-section {
            margin-bottom: 40px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            padding: 25px;
            border-left: 5px solid var(--primary);
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
            background-color: var(--bg-light);
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .turno:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
        }

        .giorno {
            background-color: var(--primary-light);
            color: var(--primary);
            padding: 12px 15px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 700;
            text-align: center;
            border-bottom: 1px solid #e2e8f0;
        }

        .turno-details {
            padding: 20px 15px;
            text-align: center;
            flex-grow: 1;
        }

        .turno-details p {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-dark);
        }

        /* --- 7. MEDIA QUERIES --- */
        @media (max-width: 992px) {
            .mobile-header { display: flex; }
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .main-content { margin-left: 0; width: 100%; padding: 20px; padding-top: 80px; }
            .welcome-message { flex-direction: column; align-items: flex-start; gap: 5px;}
        }
    </style>
</head>
<body>

<div class="mobile-header">
    <div style="font-family: var(--font-headings); font-size: 20px; color: #93c5fd;">VillageVista</div>
    <button class="hamburger" id="hamburgerBtn">☰</button>
</div>

<div class="sidebar" id="sidebar">
    <div class="sidebar-brand">VillageVista Staff</div>
    <ul>
        <li>
            <a href="Dispatcher?controllerAction=HomeManagement.view" class="nav-link">
                <img src="images/homeb.png" alt="" class="nav-icon" onerror="this.src='https://via.placeholder.com/20x20?text=Home'">
                Torna al Sito
            </a>
        </li>
        <li class="active">
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.view" class="nav-link">
                <img src="images/calendario.png" alt="" class="nav-icon" onerror="this.src='https://via.placeholder.com/20x20?text=Turni'">
                Turni di Lavoro
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.goToDipendentePersonale" class="nav-link">
                <img src="images/userblack.png" alt="" class="nav-icon" onerror="this.src='https://via.placeholder.com/20x20?text=Area'">
                Area Personale
            </a>
        </li>
    </ul>
</div>

<div class="main-content" id="main-content">

    <div class="welcome-message">
        <span>👋 Ciao, <%= nome %> <%= cognome %>!</span>
    </div>

    <div class="today-section">
        <h2>Il tuo turno di oggi</h2>

        <% if (turniOggi == null || turniOggi.isEmpty()) { %>
        <div class="today-card">
            <p>Oggi sei di riposo. Goditi la giornata!</p>
        </div>
        <% } else { %>
        <% for (Turno_lavoro turno : turniOggi) { %>
        <div class="today-card">
            <p><strong>Data:</strong> <%= dayNameFormat.format(Date.valueOf(turno.getData_turno().toLocalDate())) %></p>
            <div class="today-time">
                ⏱️ <%= turno.getOra_inizio() %> - <%= turno.getOra_fine() %>
            </div>
        </div>
        <% } %>
        <% } %>
    </div>

    <h2 class="section-title">Calendario Turni</h2>

    <% if (turniLavoro == null || turniLavoro.isEmpty()) { %>
    <div style="text-align: center; color: var(--text-muted); padding: 40px; background: white; border-radius: 12px;">
        Nessun turno assegnato.
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
                    <p><%= turno.getOra_inizio() %> - <%= turno.getOra_fine() %></p>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <% } %>
    <% } %>

</div>

<script>
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
<%@ page import="com.villagevista.villagevista.Model.Mo.Dipendente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Recuperiamo l'oggetto una volta sola per tenere pulito l'HTML sotto
    Dipendente dipendente = (Dipendente) request.getAttribute("dipendente");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Personale | VillageVista Dipendente</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            /* Palette Blu per il Dipendente */
            --primary: #2563eb;
            --sidebar-bg: #1e3a8a;
            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
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
            color: #93c5fd;
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
            display: flex;
            flex-direction: column;
            align-items: center; /* Centriamo il contenuto su schermi grandi */
        }

        .page-header {
            width: 100%;
            max-width: 800px; /* Non facciamo allargare troppo la card */
            margin-bottom: 30px;
            text-align: left;
        }

        .page-title {
            color: var(--primary);
            font-family: var(--font-headings);
            font-size: 32px;
        }

        /* --- 5. PROFILE CARD --- */
        .profile-card {
            background: white;
            width: 100%;
            max-width: 800px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            padding: 40px;
            border-top: 6px solid var(--primary);
        }

        .profile-header-info {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 1px solid #e2e8f0;
        }

        .avatar-placeholder {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #dbeafe;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: bold;
            font-family: var(--font-headings);
        }

        .profile-name {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .profile-role {
            font-size: 15px;
            color: var(--text-muted);
            background-color: #f1f5f9;
            padding: 4px 12px;
            border-radius: 20px;
            display: inline-block;
        }

        .data-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .data-item {
            display: flex;
            flex-direction: column;
        }

        .data-label {
            font-size: 13px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .data-value {
            font-size: 18px;
            color: var(--text-dark);
            font-weight: 600;
        }

        .salary-highlight {
            color: var(--success);
            background: #d1fae5;
            padding: 4px 10px;
            border-radius: 8px;
            display: inline-block;
        }

        /* --- 6. MEDIA QUERIES --- */
        @media (max-width: 992px) {
            .mobile-header { display: flex; }
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .main-content { margin-left: 0; width: 100%; padding: 20px; padding-top: 80px; }
            .profile-card { padding: 25px; }
            .profile-header-info { flex-direction: column; text-align: center; }
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
        <li>
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.view" class="nav-link">
                <img src="images/calendario.png" alt="" class="nav-icon" onerror="this.src='https://via.placeholder.com/20x20?text=Turni'">
                Turni di Lavoro
            </a>
        </li>
        <li class="active">
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.goToDipendentePersonale" class="nav-link">
                <img src="images/userblack.png" alt="" class="nav-icon" onerror="this.src='https://via.placeholder.com/20x20?text=Area'">
                Area Personale
            </a>
        </li>
    </ul>
</div>

<div class="main-content" id="main-content">

    <div class="page-header">
        <h1 class="page-title">Il Mio Profilo</h1>
    </div>

    <div class="profile-card">

        <div class="profile-header-info">
            <div class="avatar-placeholder">
                <%= dipendente.getNome_dip().substring(0, 1).toUpperCase() %>
            </div>
            <div>
                <div class="profile-name"><%= dipendente.getNome_dip() %> <%= dipendente.getCognome_dip() %></div>
                <div class="profile-role">Dipendente Struttura</div>
            </div>
        </div>

        <div class="data-grid">
            <div class="data-item">
                <span class="data-label">Username di Accesso</span>
                <span class="data-value"><%= dipendente.getUser_dip() %></span>
            </div>

            <div class="data-item">
                <span class="data-label">Codice Fiscale</span>
                <span class="data-value" style="font-family: monospace; letter-spacing: 1px;"><%= dipendente.getCf_dip() %></span>
            </div>

            <div class="data-item">
                <span class="data-label">Data di Nascita</span>
                <span class="data-value"><%= dipendente.getData_n() %></span>
            </div>

            <div class="data-item">
                <span class="data-label">Stipendio Attuale</span>
                <span class="data-value salary-highlight">€ <%= dipendente.getSalario() %> / mese</span>
            </div>
        </div>

    </div>

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
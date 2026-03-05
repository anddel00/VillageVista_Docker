<%@ page import="com.villagevista.villagevista.Model.Mo.Dipendente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Admin> admins = (List<Admin>) request.getAttribute("admins");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Amministratori | VillageVista Staff</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES (Design System) --- */
        :root {
            --primary: #1e3a8a;
            --sidebar-bg: #0f172a;
            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;

            /* Colori Specifici Amministratore */
            --admin-color: #d97706; /* Ambra scuro */
            --admin-light: #fef3c7; /* Sfondo badge ambra */

            --success: #10b981;
            --success-hover: #059669;
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
            /* Evidenziatore Ambra per gli Admin */
            border-left: 4px solid var(--admin-color);
        }

        .nav-icon { width: 20px; height: 20px; margin-right: 15px; opacity: 0.8; filter: brightness(0) invert(1); }
        .nav-link:hover .nav-icon, .sidebar li.active .nav-icon { opacity: 1; }

        /* --- 4. MAIN CONTENT & TOP ACTIONS --- */
        .main-content {
            margin-left: 250px;
            padding: 40px;
            flex-grow: 1;
            width: calc(100% - 250px);
            transition: margin-left 0.3s, width 0.3s;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
        }

        .page-title {
            color: var(--primary);
            font-family: var(--font-headings);
            font-size: 32px;
        }

        .btn-success {
            display: inline-block;
            background-color: var(--success);
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.2s, transform 0.2s;
            box-shadow: 0 4px 10px rgba(16, 185, 129, 0.2);
        }
        .btn-success:hover {
            background-color: var(--success-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(16, 185, 129, 0.3);
        }

        /* BARRA DI RICERCA */
        .search-container {
            margin-bottom: 30px;
            position: relative;
        }
        .search-bar {
            width: 100%;
            padding: 15px 20px;
            font-size: 16px;
            font-family: var(--font-body);
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            transition: all 0.3s ease;
            outline: none;
        }
        .search-bar:focus {
            border-color: var(--admin-color);
            box-shadow: 0 0 0 4px rgba(217, 119, 6, 0.1);
        }

        /* --- 5. GRIGLIA CARDS AMMINISTRATORI --- */
        .employee-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        /* Notare che qui la card non ha l'hover state interattivo (transform/shadow forte)
           perché nel tuo codice originale la card dell'admin non ha un link di dettaglio a differenza del dipendente */
        .employee-card {
            display: flex;
            flex-direction: column;
            background-color: white;
            border-radius: 12px;
            padding: 25px;
            color: var(--text-dark);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #f1f5f9;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            border-bottom: 1px solid #f1f5f9;
            padding-bottom: 15px;
        }

        .employee-name {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary);
            margin: 0;
            line-height: 1.2;
        }

        /* Badge ID Amministratore */
        .admin-id-badge {
            background-color: var(--admin-light);
            color: var(--admin-color);
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        .employee-card-footer {
            margin-top: auto;
            padding-top: 15px;
            font-size: 12px;
            color: #94a3b8;
            font-family: monospace;
            text-align: left;
        }

        /* --- 6. MEDIA QUERIES --- */
        @media (max-width: 992px) {
            .mobile-header { display: flex; }
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .main-content { margin-left: 0; width: 100%; padding: 20px; padding-top: 80px; }
            .page-header { flex-direction: column; align-items: flex-start; }
            .btn-success { width: 100%; text-align: center; }
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
        <li>
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToDipendentiManagement" class="nav-link">
                <img src="images/dipendentib.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Dipendenti
            </a>
        </li>
        <li class="active">
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

    <div class="page-header">
        <h1 class="page-title">Gestione Amministratori</h1>
        <a href="Dispatcher?controllerAction=AdminHomeManagement.goToInsertAdmin" class="btn-success">
            + Registra Nuovo Admin
        </a>
    </div>

    <div class="search-container">
        <input type="text" id="searchBar" class="search-bar" placeholder="🔍 Cerca amministratore..." onkeyup="filterEmployees()">
    </div>

    <div id="employeeList" class="employee-grid">
        <% if (admins != null && !admins.isEmpty()) {
            for (Admin admin : admins) { %>

        <div class="employee-card">

            <div class="card-header">
                <h3 class="employee-name"><%= admin.getNome() %> <%= admin.getCognome() %></h3>
                <span class="admin-id-badge">ID: <%= admin.getAdminId() %></span>
            </div>

            <div class="employee-card-footer">
                CF: <%= admin.getCf_admin() %>
            </div>

        </div>

        <% } } else { %>
        <div style="grid-column: 1 / -1; text-align: center; color: var(--text-muted); padding: 40px;">
            Nessun amministratore registrato nel sistema.
        </div>
        <% } %>
    </div>

</div>

<script>
    function filterEmployees() {
        var input, filter, employeeList, cards, card, i, txtValue;
        input = document.getElementById('searchBar');
        filter = input.value.toUpperCase();
        employeeList = document.getElementById('employeeList');
        cards = employeeList.getElementsByClassName('employee-card');

        for (i = 0; i < cards.length; i++) {
            card = cards[i];
            txtValue = card.textContent || card.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                card.style.display = "";
            } else {
                card.style.display = "none";
            }
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
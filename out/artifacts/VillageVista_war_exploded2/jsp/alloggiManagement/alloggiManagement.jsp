<%@ page import="com.villagevista.villagevista.Model.Mo.Alloggio" %>
<%@ page import="java.util.List" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Prenotazione" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Alloggio> alloggi = (List<Alloggio>) request.getAttribute("alloggi");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Alloggi | VillageVista Staff</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES (Design System) --- */
        :root {
            --primary: #1e3a8a;
            --primary-hover: #1e40af;
            --sidebar-bg: #0f172a;
            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;

            /* Colori per azioni e stati */
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --success: #10b981;
            --success-hover: #059669;
            --warning: #f59e0b;
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
            border-left: 4px solid var(--warning);
        }

        .nav-icon { width: 20px; height: 20px; margin-right: 15px; opacity: 0.8; filter: brightness(0) invert(1); }
        .nav-link:hover .nav-icon, .sidebar li.active .nav-icon { opacity: 1; }

        /* --- 4. MAIN CONTENT & TABLE --- */
        .content {
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
            margin-bottom: 30px;
        }

        .page-title {
            color: var(--primary);
            font-family: var(--font-headings);
            font-size: 32px;
        }

        /* Container per rendere la tabella scrollabile su mobile */
        .table-responsive {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            overflow-x: auto; /* Permette lo scroll orizzontale */
            width: 100%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 700px; /* Forza una larghezza minima per evitare schiacciamenti */
        }

        th, td {
            padding: 15px 20px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        th {
            background-color: #f8fafc;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: #f1f5f9;
        }

        td {
            color: var(--text-dark);
            font-size: 15px;
            vertical-align: middle;
        }

        /* --- 5. BADGES & BOTTONI --- */
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-align: center;
        }
        .badge-blocked { background-color: #fee2e2; color: var(--danger); }
        .badge-free { background-color: #d1fae5; color: var(--success); }

        .action-cell form {
            display: inline-block;
            margin-right: 5px;
        }

        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            color: white;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
            font-family: var(--font-body);
        }

        .btn-action:active { transform: scale(0.95); }

        .btn-edit { background-color: var(--primary); }
        .btn-edit:hover { background-color: var(--primary-hover); }

        .btn-block { background-color: var(--danger); }
        .btn-block:hover { background-color: var(--danger-hover); }

        .btn-free { background-color: var(--success); }
        .btn-free:hover { background-color: var(--success-hover); }

        /* --- 6. MEDIA QUERIES --- */
        @media (max-width: 992px) {
            .mobile-header { display: flex; }
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .content {
                margin-left: 0; width: 100%; padding: 20px; padding-top: 80px;
            }
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
        <li class="active">
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

<div class="content" id="main-content">
    <div class="page-header">
        <h1 class="page-title">Gestione Alloggi</h1>
    </div>

    <div class="table-responsive">
        <table>
            <thead>
            <tr>
                <th>N° Alloggio</th>
                <th>Tipologia</th>
                <th>Capienza</th>
                <th>Prezzo Notte</th>
                <th>Stato</th>
                <th>Azioni</th>
            </tr>
            </thead>
            <tbody>
            <% for (Alloggio alloggio : alloggi) { %>
            <tr>
                <td><strong>#<%= alloggio.getNum_alloggio() %></strong></td>
                <td><%= alloggio.getTipo() %></td>
                <td><%= alloggio.getCapienza() %> Persone</td>
                <td><strong>€ <%= alloggio.getPrezzonotte()%></strong></td>

                <td>
                    <% if ("SI".equals(alloggio.getOccupato())) { %>
                    <span class="badge badge-blocked">Bloccato</span>
                    <% } else { %>
                    <span class="badge badge-free">Libero</span>
                    <% } %>
                </td>

                <td class="action-cell">
                    <form action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="AdminHomeManagement.goToModAlloggio">
                        <input type="hidden" name="num_alloggio" value="<%= alloggio.getNum_alloggio() %>">
                        <button type="submit" class="btn-action btn-edit">Modifica</button>
                    </form>

                    <% if ("NO".equals(alloggio.getOccupato())) { %>
                    <form action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="AdminHomeManagement.occupaAlloggio">
                        <input type="hidden" name="num_alloggio" value="<%= alloggio.getNum_alloggio() %>">
                        <button type="submit" class="btn-action btn-block">Blocca</button>
                    </form>
                    <% } else if ("SI".equals(alloggio.getOccupato())) { %>
                    <form action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="AdminHomeManagement.liberaAlloggio">
                        <input type="hidden" name="num_alloggio" value="<%= alloggio.getNum_alloggio() %>">
                        <button type="submit" class="btn-action btn-free">Sblocca</button>
                    </form>
                    <% } %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
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
    });
</script>

</body>
</html>
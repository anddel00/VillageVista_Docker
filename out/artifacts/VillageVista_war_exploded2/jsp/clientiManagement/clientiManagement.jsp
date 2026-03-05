<%@ page import="com.villagevista.villagevista.Model.Mo.Cliente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Cliente> clienti = (List<Cliente>) request.getAttribute("clienti");
    Map<Long, Integer> clientePrenotazioniMap = (Map<Long, Integer>) request.getAttribute("clientePrenotazioniMap");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Clienti | VillageVista Staff</title>

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
            border-left: 4px solid var(--success); /* Verde per i clienti */
        }

        .nav-icon { width: 20px; height: 20px; margin-right: 15px; opacity: 0.8; filter: brightness(0) invert(1); }
        .nav-link:hover .nav-icon, .sidebar li.active .nav-icon { opacity: 1; }

        /* --- 4. MAIN CONTENT & SEARCH --- */
        .main-content {
            margin-left: 250px;
            padding: 40px;
            flex-grow: 1;
            width: calc(100% - 250px);
            transition: margin-left 0.3s, width 0.3s;
        }

        .page-header { margin-bottom: 30px; }
        .page-title { color: var(--primary); font-family: var(--font-headings); font-size: 32px; }

        .search-container { margin-bottom: 30px; position: relative; }
        .search-bar {
            width: 100%; padding: 15px 20px; font-size: 16px; font-family: var(--font-body);
            border: 1px solid #cbd5e1; border-radius: 12px; background-color: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02); transition: all 0.3s ease; outline: none;
        }
        .search-bar:focus { border-color: var(--success); box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.1); }

        /* --- 5. GRIGLIA CLIENTI --- */
        .client-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        /* Usiamo un div contenitore per la card per evitare problemi tra link e bottoni */
        .client-card-wrapper {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #f1f5f9;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .client-card-wrapper:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.1);
            border-color: #cbd5e1;
        }

        /* La parte cliccabile che porta al dettaglio del cliente */
        .client-link {
            text-decoration: none;
            color: var(--text-dark);
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .card-header {
            display: flex; justify-content: space-between; align-items: flex-start;
            margin-bottom: 15px; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px;
        }

        .client-name { font-size: 18px; font-weight: 700; color: var(--primary); margin: 0; }

        .client-details p { font-size: 14px; color: var(--text-muted); margin-bottom: 8px; }
        .client-details strong { color: var(--text-dark); }

        /* La barra delle azioni in fondo alla card */
        .card-actions {
            padding: 15px 25px;
            background-color: #f8fafc;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Badge dinamico per le prenotazioni */
        .badge-prenotazioni {
            padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: bold;
        }
        .badge-new { background-color: #e2e8f0; color: var(--text-muted); }
        .badge-vip { background-color: #d1fae5; color: var(--success); }

        .btn-delete {
            background-color: var(--danger);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
            font-family: var(--font-body);
        }
        .btn-delete:hover { background-color: var(--danger-hover); }

        /* --- 6. MEDIA QUERIES --- */
        @media (max-width: 992px) {
            .mobile-header { display: flex; }
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .main-content { margin-left: 0; width: 100%; padding: 20px; padding-top: 80px; }
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
        <li class="active">
            <a href="Dispatcher?controllerAction=AdminHomeManagement.goToClientiManagement" class="nav-link">
                <img src="images/personeb.png" alt="" class="nav-icon" onerror="this.style.display='none'">
                Clienti
            </a>
        </li>
    </ul>
</div>

<div class="main-content" id="main-content">

    <div class="page-header">
        <h1 class="page-title">Anagrafica Clienti</h1>
    </div>

    <div class="search-container">
        <input type="text" id="searchBar" class="search-bar" placeholder="🔍 Cerca per nome, cognome, email o telefono..." onkeyup="filterClients()">
    </div>

    <div id="clientList" class="client-grid">
        <% if (clienti != null && !clienti.isEmpty()) {
            for (Cliente cliente : clienti) {
                Integer numPrenotazioni = clientePrenotazioniMap.get(cliente.getNum_p());
                if(numPrenotazioni == null) numPrenotazioni = 0;
        %>

        <div class="client-card-wrapper post-card">

            <a href="Dispatcher?controllerAction=AdminHomeManagement.viewCliente&clienteId=<%= cliente.getNum_p() %>" class="client-link">
                <div class="card-header">
                    <h3 class="client-name"><%= cliente.getNome_cliente() %> <%= cliente.getCognome_cliente() %></h3>
                </div>

                <div class="client-details">
                    <p><strong>Email:</strong> <%= cliente.getEmail() %></p>
                    <p><strong>Telefono:</strong> <%= cliente.getTelefono() %></p>
                </div>
            </a>

            <div class="card-actions">
                <% if(numPrenotazioni > 1) { %>
                <span class="badge-prenotazioni badge-vip"><%= numPrenotazioni %> Prenotazioni (Abituale)</span>
                <% } else { %>
                <span class="badge-prenotazioni badge-new"><%= numPrenotazioni %> Prenotazioni</span>
                <% } %>

                <form action="Dispatcher" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare questo cliente?');" style="margin: 0;">
                    <input type="hidden" name="controllerAction" value="AdminHomeManagement.deleteOspite">
                    <input type="hidden" name="num_p" value="<%=cliente.getNum_p()%>">
                    <button type="submit" class="btn-delete">Elimina</button>
                </form>
            </div>
        </div>

        <% } } else { %>
        <div style="grid-column: 1 / -1; text-align: center; color: var(--text-muted); padding: 40px;">
            Nessun cliente registrato nel sistema.
        </div>
        <% } %>
    </div>

</div>

<script>
    function filterClients() {
        var input, filter, clientList, cards, card, i, txtValue;
        input = document.getElementById('searchBar');
        filter = input.value.toUpperCase();
        clientList = document.getElementById('clientList');
        // Usa la classe del wrapper per la ricerca
        cards = clientList.getElementsByClassName('client-card-wrapper');

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
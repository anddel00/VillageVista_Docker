<%@ page import="com.villagevista.villagevista.Model.Mo.Dipendente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Dipendente> dipendenti = (List<Dipendente>) request.getAttribute("dipendenti");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Elenco Dipendenti</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: "Cactus Classical Serif", sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #f8f9fa;
        }
        .page-title {
            color: #0066da;
            font-family: "Cactus Classical Serif", serif;
            margin-bottom: 20px;
            text-align: center;
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
        .sidebar li:nth-child(4){
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

        .main-content {
            margin-left: 200px;
            padding: 20px;
        }
        .search-bar {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .employee-card {
            display: block;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #e2eefd;
            color: #333;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-decoration: none;
            transition: background-color 0.3s, box-shadow 0.3s;
        }
        .employee-card:hover {
            background-color: #deedff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .employee-card-content {
            margin-bottom: 10px;
        }
        .employee-card-footer {
            font-size: 14px;
            color: #007bff;
        }
        .employee-card strong {
            font-weight: bold;
        }
        .action-button{
            margin-top: 10px;
            margin-bottom: 25px;
        }
        .action-button a{
            padding: 8px;
            border-radius: 8px;
            text-decoration: none;
            background-color: #00a900;
            color: white;
        }

        .action-button a:hover{
           background-color: #0c8629;
            cursor: pointer;
            transform: scale(1.05);
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
    <h1 class="page-title">Gestione Dipendenti</h1>
    <input type="text" id="searchBar" class="search-bar" placeholder="Cerca dipendente..." onkeyup="filterEmployees()">
    <div class="action-button">
        <a href="Dispatcher?controllerAction=AdminHomeManagement.goToInsertDipendente">Registra nuovo dipendente</a>
    </div>
    <div id="employeeList">
        <% if (dipendenti != null) {
            for (Dipendente dipendente : dipendenti) { %>
        <a href="Dispatcher?controllerAction=AdminHomeManagement.viewDipendente&dipendenteId=<%= dipendente.getDipId() %>" class="employee-card">
            <div class="employee-card-content">
                <p><strong>Cognome:</strong> <%= dipendente.getCognome_dip() %></p>
                <p><strong>Nome:</strong> <%= dipendente.getNome_dip() %></p>
                <p><strong>Data di nascita:</strong> <%= dipendente.getData_n() %></p>
                <p><strong>Salario:</strong> <%= dipendente.getSalario() %> €/mese</p>
                <div class="employee-card-footer">
                    <p><strong>Codice fiscale:</strong> <%= dipendente.getCf_dip() %></p>
                </div>
            </div>
        </a>
        <% } } %>
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
</script>
</body>
</html>
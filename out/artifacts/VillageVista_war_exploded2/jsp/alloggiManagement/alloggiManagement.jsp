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
    <title>Gestione Alloggi</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            padding: 0;
            color: #ffca00;
        }
        .page-title{
            color: #0066da;
            font-family: "Cactus Classical Serif",serif;
        }

        .home-button img {
            vertical-align: middle;
            position: relative;
            width: 40px;
            height: 40px;
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
        .sidebar li:nth-child(3){
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


        .content {
            margin-left: 220px;
            padding: 20px;
            font-family: "Cactus Classical Serif",serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
            color: #0066da;
        }

        th {
            background-color: #007bff;
            color: white;
        }
        th:nth-child(4){
            background-color: #93def5;
            color: black;
        }

        .action-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        .action-button:hover {
            background-color: #0056b3;
        }

        .block-button {
            background-color: #dc3545;
        }
        .block-button:hover{
            background-color: #af0b19;
        }

        .free-button {
            background-color: #28a745;
        }
        .free-button:hover{
            background-color: #0c8629;
        }
    </style>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
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
<div class="content">
    <h1 class="page-title">Gestione Alloggi</h1>
    <table>
        <thead>
        <tr>
            <th>Numero</th>
            <th>Tipologia</th>
            <th>Capienza</th>
            <th>Prezzo per notte</th>
            <th>BLOCCATO</th>
            <th>Azioni</th>
        </tr>
        </thead>
        <tbody>
        <% for (Alloggio alloggio : alloggi) { %>
        <tr>
            <td><%= alloggio.getNum_alloggio() %></td>
            <td><%= alloggio.getTipo() %></td>
            <td><%= alloggio.getCapienza() %></td>
            <td><%= alloggio.getPrezzonotte()%> €</td>
            <td><%= alloggio.getOccupato() %></td>
            <td>
                <form action="Dispatcher" method="post" style="display:inline;">
                    <input type="hidden" name="controllerAction" value="AdminHomeManagement.goToModAlloggio">
                    <input type="hidden" name="num_alloggio" value="<%= alloggio.getNum_alloggio() %>">
                    <button type="submit" class="action-button">Modifica</button>
                </form>
                <% if ("NO".equals(alloggio.getOccupato())) { %>
                <form action="Dispatcher" method="post" style="display:inline;">
                    <input type="hidden" name="controllerAction" value="AdminHomeManagement.occupaAlloggio">
                    <input type="hidden" name="num_alloggio" value="<%= alloggio.getNum_alloggio() %>">
                    <button type="submit" class="action-button block-button">Blocca</button>
                </form>
                <% } else if ("SI".equals(alloggio.getOccupato())) { %>
                <form action="Dispatcher" method="post" style="display:inline;">
                    <input type="hidden" name="controllerAction" value="AdminHomeManagement.liberaAlloggio">
                    <input type="hidden" name="num_alloggio" value="<%= alloggio.getNum_alloggio() %>">
                    <button type="submit" class="action-button free-button">Libera</button>
                </form>
                <% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
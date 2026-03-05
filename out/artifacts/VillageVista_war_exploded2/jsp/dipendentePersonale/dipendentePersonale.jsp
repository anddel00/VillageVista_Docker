<%@ page import="com.villagevista.villagevista.Model.Mo.Dipendente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Dipendente</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
    <style>
        /* Stili per la barra laterale */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 250px;
            background-color: #f0c320;
            padding-top: 20px;
            overflow-y: auto;
            color: #2c3e50;
            font-family: "Cactus Classical Serif", serif;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
            color: #2c3e50;
        }
        .sidebar ul li {
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .sidebar li:nth-child(3) {
            background-color: #b89b0b;
        }
        .nav-link {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: #2c3e50;
            transition: background-color 0.3s;
        }
        .nav-link:hover {
            background-color: #b89b0b;
        }
        .nav-icon {
            vertical-align: middle;
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }
        .nav-text {
            vertical-align: middle;
            color: #2c3e50;
        }

        /* Stili per il corpo principale */
        .main-content {
            margin-left: 30%;
            padding: 20px;
            font-family: 'Cactus Classical Serif', sans-serif;
            font-size: 22px;
            background-color: #fafafa;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            color: #2c3e50;
            width: 56%;
            margin-bottom: 100px;
        }
        .page-title {
            margin-top: 50px;
            margin-left: 20%;
            margin-bottom: 70px;
            font-family: "Cactus Classical Serif", serif;
            font-size: 32px;
            color: #2c3e50;
            text-align: center;
        }
        .main-content h3 {
            font-family: 'Cactus Classical Serif', serif;
            color: #333;
        }
        .main-content p {
            margin-bottom: 10px;
            line-height: 1.5;
            background-color: white;
            padding: 4px;
        }
        .main-content p span {
            font-weight: bold;
            color: #2c3e50;
        }
        .main-content .label {
            color: #b89b0b;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1 class="page-title">Area personale</h1>
<div class="sidebar">
    <ul>
        <li>
            <a href="Dispatcher?controllerAction=HomeManagement.view" class="nav-link">
                <img src="images/home.png" alt="Home" class="nav-icon">
                <span class="nav-text">Torna alla home</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.view" class="nav-link">
                <img src="images/userblack.png" alt="Turni" class="nav-icon">
                <span class="nav-text">Turni di lavoro</span>
            </a>
        </li>
        <li>
            <a href="Dispatcher?controllerAction=DipendenteHomeManagement.goToDipendentePersonale" class="nav-link">
                <img src="images/clockblack.png" alt="Personale" class="nav-icon">
                <span class="nav-text">Area personale</span>
            </a>
        </li>
    </ul>
</div>
<div class="main-content">
    <h3>I tuoi dati</h3>
    <p><span class="label">Username:</span> <%= ((Dipendente) request.getAttribute("dipendente")).getUser_dip() %></p>
    <p><span class="label">Nome:</span> <%= ((Dipendente) request.getAttribute("dipendente")).getNome_dip() %></p>
    <p><span class="label">Cognome:</span> <%= ((Dipendente) request.getAttribute("dipendente")).getCognome_dip() %></p>
    <p><span class="label">Data di nascita:</span> <%= ((Dipendente) request.getAttribute("dipendente")).getData_n() %></p>
    <p><span class="label">Codice Fiscale:</span> <%= ((Dipendente) request.getAttribute("dipendente")).getCf_dip() %></p>
    <br>
    <p><span class="label">Stipendio attuale:</span> <%= ((Dipendente) request.getAttribute("dipendente")).getSalario()%> €/mese</p>
</div>
</body>
</html>
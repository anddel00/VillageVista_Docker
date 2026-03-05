<%@ page import="com.villagevista.villagevista.Model.Mo.Cliente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Cliente> clienti = (List<Cliente>) request.getAttribute("clienti");
    Map<Long, Integer> clientePrenotazioniMap = (Map<Long, Integer>) request.getAttribute("clientePrenotazioniMap");

%>
<html>
<head>
    <title>Title</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
<style>
    body {
        font-family: "Cactus Classical Serif", sans-serif;
        margin: 0;
        padding: 0;
        color: #ffca00;
    }
    .page-title{
        color: #0066da;
        font-family: "Cactus Classical Serif",serif;
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
    .sidebar li:nth-child(7){
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
    .post-card {
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

    .post-card:hover {
        background-color: #deedff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }
    .post-card-content {
        margin-bottom: 10px;
    }
    .post-card-footer {
        font-size: 14px;
        color: #af0b19;
    }
    .search-bar {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }
    #deleteForm button{
        background-color: #cc0000;
        padding: 8px;
        border-radius: 5px;
        font-family: "Cactus Classical Serif",serif;
        color: white;
        text-decoration: none;
        border: none;
        margin: 10px;
        margin-left: 0;
    }
    #deleteForm button:hover{
        cursor: pointer;
        background-color: #af0b19;
        transform: scale(1.05);
    }
</style>
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
    <h1 class="page-title">Gestione clienti</h1>
    <input type="text" id="searchBar" class="search-bar" placeholder="Cerca cliente..." onkeyup="filterClients()">
    <div id="clientList">
        <% if (clienti != null) {
            for (Cliente cliente : clienti) { %>

        <a href="Dispatcher?controllerAction=AdminHomeManagement.viewCliente&clienteId=<%= cliente.getNum_p() %>" class="post-card">
            <p><strong>Cognome:</strong> <%= cliente.getCognome_cliente() %></p>
            <p><strong>Nome:</strong> <%= cliente.getNome_cliente() %></p>
            <p><strong>Email:</strong> <%= cliente.getEmail() %></p>
            <p><strong>Telefono:</strong> <%= cliente.getTelefono() %></p>
            <div class="post-card-footer">
                <p><strong>Prenotazioni:</strong> <%= clientePrenotazioniMap.get(cliente.getNum_p()) %></p>
                <div class="action">
                    <form id="deleteForm" action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="AdminHomeManagement.deleteOspite">
                        <input type="hidden" name="num_p" value="<%=cliente.getNum_p()%>">
                        <button type="submit" class="delete">Elimina cliente</button>
                    </form>
                </div>
            </div>
        </a>
        <% } } %>
    </div>

</div>

</body>
<script>
    function filterClients() {
        var input, filter, clientList, cards, card, i, txtValue;
        input = document.getElementById('searchBar');
        filter = input.value.toUpperCase();
        clientList = document.getElementById('clientList');
        cards = clientList.getElementsByClassName('post-card');

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
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Cliente" %>
<%@ page import="java.util.List" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Prenotazione" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Messaggio" %>
<%
  String nome = (String) session.getAttribute("nome_cliente");
  String cognome = (String) session.getAttribute("cognome_cliente");
%>
<% List <Prenotazione> prenotazioni = (List<Prenotazione>) request.getAttribute("prenotazioni");%>
<% List <Prenotazione> cancprenotazioni = (List<Prenotazione>) request.getAttribute("cancprenotazioni");%>
<html>
<head>
    <title>Cliente Home</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            padding: 0;
            align-items: center;
            background: linear-gradient(to bottom right, #1972ef, #f0c320);
        }
        .home-button {
            display: flex;
            font-size: 16px;
            background-color: #96c8fc;
            border: 2px solid transparent;
            border-radius: 5px;
            color: black;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
            width: 40px;
            height: 40px;
            padding: 5px;
            align-items: center;
            box-shadow: 0 4px 8px #2c3e50;
        }
        .home-button:hover {
            background-color: #83b9fc;
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            border: 2px solid #f0c320;
        }
        .home-button img{
            vertical-align: middle;
            position: relative;
            width: 40px;
            height: 40px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            z-index: 1;
        }
        .section{
            display: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            background-color: #e2eefd;
            padding: 20px;
            margin-bottom: 60px;
            border-radius: 15px;
            transform: translateY(-20px);
            animation: fadeInDown 2s forwards;
            z-index: 1;
            position: relative;
            text-align: left;
            border: 4px solid #f0c320;
        }

        table {
            width: 100%;
            border-collapse: separate;
            margin-bottom: 20px;
            border-radius: 20px;
            border-spacing: 8px;

        }
        .table-title{
            font-size: 20px;
            font-family: "Cactus Classical Serif",serif;
            margin-top:10px;
            margin-bottom: 10px;
            margin-left: 20px;
        }
        tbody{
            display: block;
            max-height: 200px; /* Imposta l'altezza massima del corpo della tabella */
            overflow-y: scroll;
        }

        thead, tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed; /* Mantiene la larghezza fissa delle colonne */
        }
        th, td {
            padding: 10px;
            text-align: center;
            white-space: nowrap;
        }
        th {
            background-color : #f0c320;
            color: black;
            border: none;
            border-radius: 20px;
        }
        th:last-child{
            color: transparent;
            background-color: transparent;
            width: 32px;
            height: 32px;
            justify-content: center;
            align-items: center;
            border-radius: 50%;

        }
        td:last-child{
            background-color: #cc0000;
            width: 32px;
            height: 32px;
            justify-content: center;
            align-items: center;
            border-radius: 50%;

        }
        td:last-child:hover{
            background-color: #ff1a1a;
        }
        th.Npren{
            word-wrap: break-word;
        }
        td {
            background-color: #fff2c1;
            color: rgba(0, 0, 0, 0.88);
            border: none;
            border-radius: 20px;
        }

        .button-image {
            display: inline-block;
            justify-content: center;
            align-items: center;
            padding: 5px 7px;
            background-color: #336699;
            color: #ffca00;
            text-decoration: none;
            border-radius: 100px;
            transition: background-color 0.3s ease, transform 0.5s ease;
            border: 1px solid transparent;
            margin-left: 17px;
            height: 30px;
            width: 30px;
            margin-bottom: 20px;
            transform: rotate(180deg);
        }

        .button-image:hover {
            border: 1px solid;
            border-color: #f0c320;
            transform: scale(1.10);
        }

        .button-wrapper {
            position: relative;
            display: inline-block;
        }

        .hidden-buttons {
            display: none;
            flex-direction: row; /* Posiziona i bottoni in colonna */
            margin-top: 10px; /* Spazio tra il bottone principale e i bottoni nascosti */
            margin-left: 17px;
            transition: opacity 0.3s ease, height 0.3s ease;
            opacity: 0;
            height: 0;
        }

        .hidden-buttons .button {
            margin-top: 10px; /* Spazio tra i bottoni */
            padding: 8px 12px;
            background-color: #336699;
            color: #ffca00;
            text-decoration: none;
            border-radius: 100px;
            border: 1px solid transparent;
            display: inline-block;
            margin-right: 15px;
            transition: transform 0.3s ease;

        }
        .hidden-buttons .button:hover{
            border: 1px solid #f0c320;
            transform: scale(1.10);
        }

        .button-image img {
            width: 10px; /* Regola la larghezza dell'immagine */
            height: 10px; /* Regola l'altezza dell'immagine */
            cursor: pointer;
        }

        /* Mostra i bottoni quando il wrapper ha la classe 'active' */
        .button-wrapper.active .hidden-buttons {
            display: flex; /* Cambia a flex per posizionare i bottoni in colonna */
        }

        .hidden-buttons.show {
            display: flex;
            opacity: 1;
            height: auto;
        }

        .hidden-buttons.hide {
            display: none;
            opacity: 0;
            height: 0;
        }


        .delete-button img {
            width: 20px; /* Regola la larghezza dell'immagine */
            height: 20px; /* Regola l'altezza dell'immagine */
            display: block;
            margin: auto;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .welcome-message {
            font-size: 20px;
            font-family: "Cactus Classical Serif", serif;
            color: #ffc900;
            text-shadow: 0 4px 8px #2c3e50;
        }
        .header {
            background-color: transparent;
            color: #fff;
            padding: 10px 0;
            text-align: center;
            height: auto;
            margin-bottom: 50px;
        }
        .header img{
            border: 1px solid #ffd243;
            position: absolute;
            top: 20px;
            left: 44%;
            border-radius: 20px;
        }
        .form-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding: 20px;
            background-color: rgba(125, 185, 243, 0.49); /* Sfumatura blu chiara */
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            margin-bottom: 50px;

        }

        .form-container form {
            display: flex;
            flex-wrap: nowrap;
            align-items: center;
            width: 100%;
            margin-bottom: auto;

        }

        .form-container input[type="date"],
        .form-container input[type="text"],
        .form-container input[type="number"],
        .form-container select {
            margin-right: 10px;
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #f0c320;
            font-family: "Cactus Classical Serif", serif;
            flex: 1; /* Fa sì che i campi occupino la stessa larghezza */
            margin-bottom: 10px; /* Spazio inferiore uniforme */
        }

        .form-container button[type="submit"] {
            background-color: #336699;
            border: 2px solid transparent;
            border-radius: 5px;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            font-family: "Cactus Classical Serif", serif;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
        }

        .form-container button[type="submit"]:hover {
            background-color: #336699;
            transform: scale(1.05);
            border: 2px solid #f0c320;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .informazioni-utili {
            background-color: rgb(255, 255, 255); /* Sfumatura blu chiara */
            padding: 80px;
            margin-bottom: 60px;
            border-radius: 15px;
            transform: translateY(-20px);
            animation: fadeInDown 2s forwards;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            color: black; /* Colore del testo */
            font-family: "Cactus Classical Serif", serif; /* Font del testo */

        }

        .informazioni-utili h2 {
            text-align: center;
            margin-top: 30px;
            margin-bottom: 40px;
            font-size: 24px; /* Dimensione del titolo */
        }

        .informazioni-utili p {
            text-align: justify; /* Testo giustificato */
            line-height: 1.6; /* Altezza della linea */
            margin-bottom: 10px;
        }
        .section {
            padding: 20px;
        }
        .table-title {
            text-align: center;
            font-size: 24px;
            color: #336699;
            margin-bottom: 40px;
            margin-top: 40px;
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            margin: 10px;
            padding: 30px;
            width: calc(100% - 40px);
            max-width: 800px;
            display: flex;
            align-items: center;
            border: 2px solid #f0c320;
        }
        .card img {
            border-radius: 10px;
            margin-right: 5px;
            width: 350px;
            height: 255px;
            object-fit: cover;
        }
        .card-details {
            flex: 1;
            margin-left: 20px;
        }
        .card-details img{
            width: 16px;
            height: 16px;
        }
        .card-details p {
            margin-left:  3px;
            margin-bottom: 7px;
            font-size: 18px;
            font-family: "Cactus Classical Serif",serif;
        }
        .card-details .actions {
            margin-top: 10px;
        }
        .card-details .actions a {
            text-decoration: none;
            color: #336699;
            margin-right: 10px;
            font-weight: bold;
        }
        .label {
            top: 10px;
            left: 10px;
            background-color: #d9534f;
            color: white;
            padding: 5px 10px;
            border-radius: 3px;
            font-weight: bold;
            font-size: 18px;
            bottom: 30px;
            margin-top: -200px;
            margin-right: -130px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            z-index: 20;
        }
        .toggle-button img {
            width: 20px;
            height: 20px;
        }

        .section.message button{
            background-color: #336699;
            border: 2px solid transparent;
            border-radius: 5px;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            font-family: "Cactus Classical Serif", serif;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
            margin-top: 20px;
        }
        .inserisci{
            color: white;
            font-family: "Cactus Classical Serif",serif;
            font-size: 22px;
            text-shadow: 0 4px 8px #2c3e50;
        }

        .section.message button:hover{
            background-color: #336699;
            transform: scale(1.05);
            border: 2px solid #f0c320;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .section.message textarea{
            height: 150px;
            width: 100%;
            font-family: "Cactus Classical Serif",serif;
            border: 1px solid #f0c320;
            border-radius: 5px;
        }
        .section.message h1{
            font-family: "Cactus Classical Serif",serif;
            font-size: 20px;
            margin-left: 2px;
        }
        .toggle-section-button {
            display: block;
            width: fit-content;
            margin: 20px auto;
            margin-bottom: 40px;
            padding: 10px 20px;
            background-color: #336699;
            color: white;
            text-align: center;
            border-radius: 10px;
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
            border: 3px solid transparent;
            font-family: "Cactus Classical Serif", serif;
            margin-left: 0px;


        }
        .toggle-section-button:hover {
            background-color: #deedff;
            border: 3px solid #f0c320;
            color: black;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .section-deleted{
            display: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            background-color: #e2eefd;
            padding: 20px;
            margin-bottom: 60px;
            border-radius: 15px;
            transform: translateY(-20px);
            animation: fadeInDown 2s forwards;
            z-index: 1;
            position: relative;
            text-align: left;
            border: 4px solid #f0c320;
        }
        .toggle-section-deleted-button {
            display: block;
            width: fit-content;
            margin: 20px auto;
            margin-bottom: 40px;
            padding: 10px 20px;
            background-color: #336699;
            color: white;
            text-align: center;
            border-radius: 10px;
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
            border: 3px solid transparent;
            font-family: "Cactus Classical Serif", serif;
            margin-left: 0px;


        }
        .toggle-section-deleted-button:hover {
            background-color: #deedff;
            border: 3px solid #f0c320;
            color: black;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .active{
            background-color: #deedff;
            border: 3px solid #f0c320;
            color: black;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }


    </style>
</head>
<body>
<header class="header">
    <img src="images/Logo.png"  height="90" width="140" alt="LOGO"/>
</header>
<div class="container">
    <div class="welcome-message">
        <p>Benvenuto, <%= request.getSession().getAttribute("nome") %> <%= request.getSession().getAttribute("cognome") %>!</p>
    </div>
    <a href="Dispatcher?controllerAction=HomeManagement.view" class="home-button">
        <img src="images/home.png" alt="Home">
    </a>
    <h3 class="inserisci">Verifica qui la disponilità</h3>
    <div class="form-container">
        <form action="Dispatcher" method="post">
            <input type="hidden" name="controllerAction" value="ClienteHomeManagement.disponibilita">
            <input type="date" id="data_checkin" name="data_checkin" required><br>
            <input type="date" id="data_checkout" name="data_checkout"  required><br>
            <input type="number" name="persone" placeholder="Per quante persone?" required min="1" max="5"><br>
            <select name="alloggio" required>
                <option value="">Tipologia</option>
                <option value="bungalow">Bungalow</option>
                <option value="camera">Camera</option>
            </select><br>
            <button type="submit">Controlla disponibilità</button>
        </form>
    </div>
    <a href="#" class="toggle-section-button">Le tue prenotazioni</a>
    <div class="section">
        <h1 class="table-title">PRENOTAZIONI EFFETTUATE</h1>
        <div class="card-container">
            <% if (prenotazioni == null || prenotazioni.isEmpty()) { %>
            <div class="card">
                <p>Nessuna prenotazione trovata.</p>
            </div>
            <% } else { %>
            <% for (Prenotazione prenotazione : prenotazioni) {
                String tipoCamera = prenotazione.getAlloggio();
                String immagineAlloggio = "";
                if (tipoCamera.equals("Camera matrimoniale")) {
                    immagineAlloggio = "images/camera_doppia.jpg";
                } else if (tipoCamera.equals("Camera tripla")) {
                    immagineAlloggio = "images/camera_tripla.jpg";
                } else if (tipoCamera.equals("Camera quadrupla")) {
                    immagineAlloggio = "images/camera_quadrupla.jpg";
                } else if (tipoCamera.equals("Bungalow bilocale")) {
                    immagineAlloggio = "images/bungalow_bilocale.jpg";
                } else if (tipoCamera.equals("Bungalow trilocale")) {
                    immagineAlloggio = "images/bungalow_trilocale.jpg";
                }
            %>
            <div class="card">
                <div class="label">Prenotazione N°: <%= prenotazione.getNumPrenotazione() %></div>
                <img src="<%= immagineAlloggio %>" alt="Alloggio">
                <div class="card-details">
                    <p><img src="images/checkin.png"><strong>Check-in:</strong> <%= prenotazione.getDataCheckin() %></p>
                    <p><img src="images/checkout.png"><strong>Check-out:</strong> <%= prenotazione.getDataCheckout() %></p>
                    <p><img src="images/alloggio.png"><strong>Tipo di alloggio:</strong> <%= prenotazione.getAlloggio() %></p>
                    <p><img src="images/persone.png"><strong>N. Ospiti:</strong> <%= prenotazione.getPersone() %></p>
                    <p><strong>Totale:</strong> € <%= prenotazione.getTotale() %></p>
                    <p><strong>Modalità di pagamento:</strong> <%= prenotazione.getPagato() %></p>
                </div>
            </div>
            <% } %>
            <% } %>
        </div>
    </div>
    <a href="#" class="toggle-section-deleted-button">Le tue prenotazioni cancellate</a>
    <div class="section-deleted">
    <h1 class="table-title">PRENOTAZIONI CANCELLATE</h1>
    <div class="card-container">
        <% if (cancprenotazioni == null || cancprenotazioni.isEmpty()) { %>
        <div class="card">
            <p>Nessuna prenotazione trovata.</p>
        </div>
        <% } else { %>
        <% for (Prenotazione cancprenotazione : (List<Prenotazione>) request.getAttribute("cancprenotazioni")) {
            String tipoCamera = cancprenotazione.getAlloggio();
            String immagineAlloggio = "";
            if (tipoCamera.equals("Camera matrimoniale")) {
                immagineAlloggio = "images/camera_doppia.jpg";
            } else if (tipoCamera.equals("Camera tripla")) {
                immagineAlloggio = "images/camera_tripla.jpg";
            } else if (tipoCamera.equals("Camera quadrupla")) {
                immagineAlloggio = "images/camera_quadrupla.jpg";
            } else if (tipoCamera.equals("Bungalow bilocale")) {
                immagineAlloggio = "images/bungalow_bilocale.jpg";
            } else if (tipoCamera.equals("Bungalow trilocale")) {
                immagineAlloggio = "images/bungalow_trilocale.jpg";
            }
        %>

        <div class="card">
            <div class="label">Prenotazione N°: <%= cancprenotazione.getNumPrenotazione() %></div>
            <img src="<%= immagineAlloggio %>" alt="Alloggio">
            <div class="card-details">
                <p><img src="images/checkin.png"><strong>Check-in:</strong> <%= cancprenotazione.getDataCheckin() %></p>
                <p><img src="images/checkout.png"><strong>Check-out:</strong> <%= cancprenotazione.getDataCheckout() %></p>
                <p><img src="images/alloggio.png"><strong>Tipo di alloggio:</strong> <%= cancprenotazione.getAlloggio() %></p>
                <p><img src="images/persone.png"><strong>N. Ospiti:</strong> <%= cancprenotazione.getPersone() %></p>
                <p><strong>Totale:</strong> € <%= cancprenotazione.getTotale() %></p>
            </div>
        </div>
        <% } %>
        <% } %>
    </div>
    </div>
    <div class="informazioni-utili">
        <h2>INFORMAZIONI UTILI PER I NOSTRI CLIENTI</h2>
        <p></p>
        <p>In questa pagina può prenotare il Suo soggiorno</p>
        <p>Le nostre informazioni più importanti:</p>
        <p>Per prenotare solo il pernottamento con la colazione è necessario saldare l'importo del primo pernottamento, per aderire alla promo pasti è necessario saldare tutto il soggiorno in anticipo. </p>
        <p><b>Tutti i pagamenti non sono rimborsabili</b>, in caso di cancellazione <b>entro 7 giorni dal check-in</b>, su richiesta, verrà effettuato un buono pari al 100% dell'importo speso da utilizzare in pernottamenti presso la nostra struttura entro la fine della stagione lavorativa 2024. Il buono è cedibile a terzi.</p>
        <p>Prenotando in anticipo il pasto (promo pasto) si ha la possibilità di scegliere due portate dal menu del nostro bistrot a un prezzo bloccato senza pagare il coperto. Il menù è consultabile online. Se ci sono intolleranze o allergie chiediamo cortesemente di comunicarlo al momento del check in. Le bevande non sono incluse. Non è possibile portare bevande dall’esterno.</p>
        <p>Il parcheggio è gratuito (non custodito) per i nostri clienti, consiste nello spazio antistante il villaggio che si stacca dalla strada per 200 metri tramite il nostro viale privato.</p>
        <p>L'uso della piscina è gratuito per gli ospiti del villaggio, è necessario utilizzare una cuffia prima di immergersi. L'orario di apertura è dalle 9.00 alle 19.00. La chiusura stagionale avviene intorno al 10/15 ottobre.</p>
        <p>La reception apre alle 7.30 e chiude alle 22.30, non c'è il portiere notturno.
            I check in li effettuiamo dalle 14.00 alle 19.00 e i check out devono essere effettuati entro le 10.30.</p>
        <p>Tassa di soggiorno: 2 euro per persona al giorno, non è inclusa nel prezzo dell'alloggio.</p>

        <p><b>Per utleriori informazioni non esiti a contattarci tramite email o tramite whatsapp</b></p>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggleButtons = document.querySelectorAll('.toggle-button');

        toggleButtons.forEach(button => {
            button.addEventListener('click', function (e) {
                e.preventDefault(); // Previene il comportamento di default del link
                const wrapper = this.closest('.button-wrapper');
                const hiddenButtons = wrapper.querySelector('.hidden-buttons');
                hiddenButtons.classList.toggle('show'); // Aggiungi/rimuovi la classe 'show'
                hiddenButtons.classList.toggle('hide'); // Aggiungi/rimuovi la classe 'hide'

// Aggiungi la logica per allungare la tabella se necessario
                const tableContainer = wrapper.closest('.table-container');
                if (hiddenButtons.classList.contains('show')) {
                    tableContainer.style.marginBottom = '50px'; // Regola la distanza in base alle tue esigenze
                } else {
                    tableContainer.style.marginBottom = '0px';
                }
            });
        });
    });

        document.addEventListener("DOMContentLoaded", function() {
        const toggleButton = document.querySelector('.toggle-section-button');
        const section = document.querySelector('.section');

        toggleButton.addEventListener('click', function(e) {
        e.preventDefault();
            if (section.style.display === 'none' || section.style.display === '') {
                section.style.display = 'block';
                toggleButton.classList.add('active');
            } else {
                section.style.display = 'none';
                toggleButton.classList.remove('active');
            }
    });
    });
    document.addEventListener("DOMContentLoaded", function() {
        const toggleButton = document.querySelector('.toggle-section-deleted-button');
        const section = document.querySelector('.section-deleted');

        toggleButton.addEventListener('click', function(e) {
            e.preventDefault();
            if (section.style.display === 'none' || section.style.display === '') {
                section.style.display = 'block';
                toggleButton.classList.add('active');
            } else {
                section.style.display = 'none';
                toggleButton.classList.remove('active');
            }        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        var dataCheckin = document.getElementById('data_checkin');
        var dataCheckout = document.getElementById('data_checkout');

        // Imposta l'evento di cambio valore per il campo data di check-in
        dataCheckin.addEventListener('input', function() {
            validateDates();
        });

        // Imposta l'evento di cambio valore per il campo data di check-out
        dataCheckout.addEventListener('input', function() {
            validateDates();
        });

        // Funzione per validare la data di check-in e check-out rispetto alla data odierna
        function validateDates() {
            var today = new Date();
            var checkinDate = new Date(dataCheckin.value);
            var checkoutDate = new Date(dataCheckout.value);

            // Verifica se la data di check-in è precedente alla data odierna
            if (checkinDate < today) {
                dataCheckin.setCustomValidity('La data di check-in non può essere precedente alla data odierna.');
            } else {
                dataCheckin.setCustomValidity('');
            }

            // Verifica se la data di check-out è precedente alla data di check-in
            if (checkoutDate < checkinDate) {
                dataCheckout.setCustomValidity('La data di check-out non può essere precedente alla data di check-in.');
            } else {
                dataCheckout.setCustomValidity('');
            }
        }
    });
</script>
</body>
</html>


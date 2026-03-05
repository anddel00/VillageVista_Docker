<%@ page import="com.villagevista.villagevista.Model.Mo.Alloggio" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Soluzioni Disponibili</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
<style>
    /* styles.css */

    /* Stili per il contenitore principale */
    .container {
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        background-color: #f8f8f8;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        font-family: 'Cactus Classical Serif',sans-serif;
    }

    /* Stili per il titolo */
    h1 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
        font-family: 'Cactus Classical Serif',sans-serif;
    }

    /* Stili per i singoli post di alloggio */
    .alloggio-post {
        display: flex;
        margin-bottom: 20px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 15px;
        font-family: 'Cactus Classical Serif',sans-serif;
    }

    /* Stili per le immagini dell'alloggio */
    .alloggio-image img {
        width: 200px;
        height: 150px;
        object-fit: cover;
        border-radius: 5px;
    }

    /* Stili per i dettagli dell'alloggio */
    .alloggio-details {
        flex: 1;
        padding-left: 20px;
    }

    .alloggio-details .post-title {
        font-size: 20px;
        margin-bottom: 10px;
        color: #333;
    }

    .alloggio-details p {
        margin-bottom: 8px;
        color: #666;
    }
    .alloggio-details p.numero{
        margin-bottom: 8px;
        color: #007bff;
    }

    /* Stili per le azioni dell'alloggio */
    .alloggio-actions form {
        margin-top: 10px;
    }

    .alloggio-actions button {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 10px;
    }

    .alloggio-actions button:hover {
        background-color: #45a049;
        transform: scale(1.05);
    }

    /* Stili per il blocco del prezzo */
    .prezzo {
        text-align: right;
        background-color: #e5eef8;
        border-radius: 6px;
        padding: 8px;

    }

    .prezzo p {
        margin-bottom: 5px;
        color: #af0b19;
    }

    .prezzo strong {
        color: #666;
    }
</style>
<body>
<div class="container">
    <h1>Soluzioni Disponibili</h1>
    <%
        List<Alloggio> alloggiDisponibili = (List<Alloggio>) request.getAttribute("alloggiDisponibili");
        Date dataCheckin = (Date) request.getAttribute("data_checkin");
        Date dataCheckout = (Date) request.getAttribute("data_checkout");
        Long idCliente = (Long) request.getAttribute("idCliente");

        if (alloggiDisponibili != null && !alloggiDisponibili.isEmpty()) {
            long diff = TimeUnit.DAYS.convert(dataCheckout.getTime() - dataCheckin.getTime(), TimeUnit.MILLISECONDS);

            for (Alloggio alloggio : alloggiDisponibili) {
                Long prezzonotte = alloggio.getPrezzonotte();
                Long costoTotale = (prezzonotte != null ? prezzonotte : 0) * diff;
    %>
    <div class="alloggio-post">
        <div class="alloggio-image">
            <%
                int persone = Integer.parseInt(alloggio.getCapienza());
                String tipo = alloggio.getTipo();
                String tipoCamera = "";

                if (tipo.equalsIgnoreCase("camera")) {
                    if (persone == 2) {
                        tipoCamera = "Camera matrimoniale";
                    } else if (persone == 3) {
                        tipoCamera = "Camera tripla";
                    } else if (persone == 4) {
                        tipoCamera = "Camera quadrupla";
                    } else {
                        tipoCamera = "Camera per " + persone + " persone";
                    }
                } else if (tipo.equalsIgnoreCase("bungalow")) {
                    if (persone == 2 || persone == 3) {
                        tipoCamera = "Bungalow bilocale";
                    } else if (persone == 4 || persone == 5) {
                        tipoCamera = "Bungalow trilocale";
                    }
                } else {
                    tipoCamera = "Alloggio per " + persone + " persone";
                }
            %>
        </div>
        <div class="alloggio-details">
            <!-- Dettagli dell'alloggio -->
            <h2 class="post-title"><%= tipoCamera %></h2>
            <p class="numero"><strong>N° Alloggio:</strong> <%= alloggio.getNum_alloggio() %></p>
            <p><strong>Ospiti:</strong> <%= alloggio.getCapienza() %></p>
            <p><strong>Data di arrivo:</strong> <%= dataCheckin %></p>
            <p><strong>Data di partenza:</strong> <%= dataCheckout %></p>

            <div class="alloggio-actions">
                <!-- Form per la prenotazione -->
                <form action="Dispatcher" method="post">
                    <input type="hidden" name="controllerAction" value="AdminHomeManagement.confPrenotazione">
                    <!-- Campi nascosti per passare i parametri della prenotazione -->
                    <input type="hidden" name="data_checkin" value="<%= dataCheckin %>">
                    <input type="hidden" name="data_checkout" value="<%= dataCheckout %>">
                    <input type="hidden" name="num_alloggio" value="<%= alloggio.getNum_alloggio()%>">
                    <input type="hidden" name="persone" value="<%= persone %>">
                    <input type="hidden" name="tipoCamera" value="<%= tipoCamera %>">
                    <input type="hidden" name="totale" value="<%= costoTotale %>">
                    <input type="hidden" name="pagato" value="in struttura">
                    <input type="hidden" name="stato" value="confermata">
                    <input type="hidden" name="idCliente" value="<%= idCliente %>">
                    <button type="submit">Prenota per il cliente</button>
                </form>
            </div>
        </div>
        <div class="prezzo">
            <!-- Prezzo per notte e totale -->
            <p><strong>Prezzo per notte</strong></p>
            <p> €<%= prezzonotte %></p>
            <p><strong>Totale</strong></p>
            <p>€<%= costoTotale %></p>
        </div>
    </div>
    <% } %>
    <% } else { %>
    <!-- Nessun alloggio disponibile -->
    <p>Nessun alloggio disponibile per i criteri selezionati.</p>
    <% } %>
</div>
</body>
</html>
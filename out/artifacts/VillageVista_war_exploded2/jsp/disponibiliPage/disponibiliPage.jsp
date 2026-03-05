<%@ page import="com.villagevista.villagevista.Model.Mo.Alloggio" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Alloggi Disponibili</title>
    <style>
        body {
            font-family: "Cactus Classical Serif",serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
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
            margin-top: 110px;
            padding: 20px;
            background-color: rgba(125, 185, 243, 0.49); /* Sfumatura blu chiara */
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            margin-bottom: 50px;
            margin-left: 50px;
            margin-right: 50px;
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

        .container {
            width: 90%;
            margin: auto;
            overflow: hidden;
            padding: 20px;
            background-color: rgba(125, 185, 243, 0.49); /* Sfumatura blu chiara */
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .alloggi-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .alloggio-post {
            display: flex;
            align-items: flex-start;
            background: #f9f9f9;
            margin: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 95%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .post-title{
            font-size: 32px;
            font-family: "Cactus Classical Serif",serif;
            margin: 30px;
        }

        .alloggio-image {
            flex: 0 0 auto;
            margin-right: 20px;
            margin-left: 20px;
            margin-top: 45px;
            margin-bottom: 40px;
        }

        .alloggio-image img {
            max-width: 400px;
            border-radius: 10px;
        }

        .alloggio-details {
            flex: 1 1 auto; /* Flessibile, larghezza automatica */
            margin-left: 20px; /* Spazio a sinistra delle caratteristiche */
            font-size: 24px;
            margin-top:40px;

        }
        .alloggio-details h2 {
            margin: 0;
            padding-bottom: 30px;
            color: #000000;

        }

        .alloggio-details p {
            margin: 5px 0;
            color: #000000;
            font-family: "Cactus Classical Serif",sans-serif;
        }
        .alloggio-actions {
            display: flex;
            margin-top: 25px; /* Posiziona l'area delle azioni in fondo al contenitore */
            gap: 10px; /* Spazio tra i pulsanti */
        }
        .alloggio-details img{
            height:24px;
            width: 24px;
            margin-right: 5px;
        }

        .alloggio-actions button,
        .alloggio-actions a {
            margin-top: 5px;
            background-color: #336699;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-family: "Cactus Classical Serif", serif;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
            font-size: 16px;
            text-decoration: none; /* Rimuovi la sottolineatura dai link */
        }
        .alloggio-actions button:hover{
            transform: scale(1.05);
            background-color: #f9d64e;
            color: black;
        }

        .alloggio-actions a:hover {
            transform: scale(1.05);
            background-color: #f9d64e;
            color: black;
        }

        .btn-maggiori-dettagli {
            margin-left: 20px;
            background-color: #f0c320;
            color: #333;
            font-size: 16px;
        }

        .btn-maggiori-dettagli:hover {
            transform: scale(1.05);
            background-color: #f9d64e;
            color: black;
        }
        .caratteristiche-addizionali {
            display: none; /* Inizialmente nascoste */
            margin-top: 10px; /* Spazio tra le caratteristiche e il resto del contenuto */
            padding-top: 10px; /* Spazio interno sopra le caratteristiche */
            border-top: 1px solid #ddd; /* Linea divisoria sopra le caratteristiche */
            color: #016401;
            font-family: "Cactus Classical Serif",sans-serif;
        }
        .caratteristiche-addizionali img{
            height:24px;
            width: 24px;
            margin-right: 5px;
            margin-top: 5px;

        }

        .caratteristiche-addizionali.show {
          display: none;/* Mostra le caratteristiche quando la classe 'show' è presente */
            color: #016401;

        }

        .caratteristiche-addizionali.hide {
            display: block; /* Nasconde le caratteristiche quando la classe 'hide' è presente */
            color: #016401;
        }
        .prezzo{
            text-align: center;
            display: table-column;
            justify-content: center;
            font-family: "Cactus Classical Serif",serif;
            font-size: 28px;
            margin: 20px;
            margin-top:45px;
            padding: 20px;
            background: linear-gradient(to top right, #eaf4fc, #e5f0fc);
            border-radius: 10px;
            color: #0066da;
        }
        .prezzo p{
            margin-top: 5px;
            margin-bottom: 5px;
        }

    </style>
</head>
<body>
<header class="header">
    <img src="images/Logo.png"  height="90" width="140" alt="LOGO"/>
</header>
<div class="form-container">
    <form action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="ClienteHomeManagement.disponibilita">
        <input type="date" name="data_checkin" required><br>
        <input type="date" name="data_checkout"  required><br>
        <input type="number" name="persone" placeholder="Per quante persone?" required><br>
        <select name="alloggio" required>
            <option value="">Tipologia</option>
            <option value="Bungalow">Bungalow</option>
            <option value="Camera">Camera</option>
        </select><br>
        <button type="submit">Controlla disponibilità</button>
    </form>
</div>
<div class="container">
    <h1>Soluzioni Disponibili</h1>
    <%
        List<Alloggio> alloggiDisponibili = (List<Alloggio>) request.getAttribute("alloggiDisponibili");
        java.sql.Date dataCheckin = (java.sql.Date) request.getAttribute("data_checkin");
        java.sql.Date dataCheckout = (java.sql.Date) request.getAttribute("data_checkout");
        if (alloggiDisponibili != null && !alloggiDisponibili.isEmpty()) {
    %>
    <div class="alloggi-list">
        <%
            long diff = (dataCheckout.getTime() - dataCheckin.getTime()) / (1000 * 60 * 60 * 24);
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
                    String imagePath = "";

                    if (tipo.equalsIgnoreCase("camera")) {
                        if (persone == 2) {
                            tipoCamera = "Camera matrimoniale";
                            imagePath = "images/camera_doppia.jpg";
                        } else if (persone == 3) {
                            tipoCamera = "Camera tripla";
                            imagePath = "images/camera_tripla.jpg";
                        } else if (persone == 4) {
                            tipoCamera = "Camera quadrupla";
                            imagePath = "images/camera_quadrupla.jpg";
                        } else {
                            tipoCamera = "Camera per " + persone + " persone";
                            imagePath = "images/camera_default.jpg";
                        }
                    } else if (tipo.equalsIgnoreCase("bungalow")) {
                        if (persone == 2 || persone == 3) {
                            tipoCamera = "Bungalow bilocale";
                            imagePath = "images/bungalow_bilocale.jpg";
                        } else if (persone == 4 || persone == 5) {
                            tipoCamera = "Bungalow trilocale";
                            imagePath = "images/bungalow_trilocale.jpg";
                        }
                    } else {
                        tipoCamera = "Alloggio per " + persone + " persone";
                        imagePath = "images/alloggio_default.jpg";
                    }
                %>
                <img src="<%= imagePath %>" alt="<%= tipoCamera %>">
            </div>
            <div class="alloggio-details">
                <h2 class="post-title"><%= tipoCamera %></h2>
                <p><strong><img src="images/persone.png"></img>Ospiti:</strong> <%= alloggio.getCapienza() %></p>
                <p><strong><img src="images/checkin.png"></img>Data di arrivo:</strong> <%= dataCheckin %></p>
                <p><strong><img src="images/checkout.png"></img>Data di partenza:</strong> <%= dataCheckout %></p>

                <div class="caratteristiche-addizionali show">
                    <p><strong><img src="images/colazione.png"></img>Colazione inclusa nel prezzo</strong></p>
                    <p><strong><img src="images/piscina.png"></img>Ingresso in piscina gratuito</strong></p>
                    <p><strong><img src="images/wifi.png"></img>Wi-fi</strong></p>
                    <p><strong><img src="images/condizionata.png"></img>Aria condizionata</strong></p>
                </div>
                <div class="alloggio-actions">
                    <a href="Dispatcher?controllerAction=ClienteHomeManagement.goToPagamento&id=<%= alloggio.getNum_alloggio() %>&costoTotale=<%= costoTotale %>&dataCheckin=<%= dataCheckin %>&dataCheckout=<%= dataCheckout %>&persone=<%= persone %>&alloggio=<%= tipoCamera %>">
                        Prenota
                    </a>
                    <button type="button" class="btn-maggiori-dettagli">Servizi inclusi</button>
                </div>
            </div>
            <div class="prezzo">
                <p><strong>Prezzo per notte</strong></p>
                <p> €<%= prezzonotte %></p>
                <p><strong>Totale</strong></p>
                <p>€<%= costoTotale %></p>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <p>Nessun alloggio disponibile per i criteri selezionati.</p>
    <% } %>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var btnsMaggioriDettagli = document.querySelectorAll('.btn-maggiori-dettagli');

        btnsMaggioriDettagli.forEach(function(btn) {
            btn.addEventListener('click', function() {
                var alloggioPost = this.closest('.alloggio-post');
                var caratteristicheAddizionali = alloggioPost.querySelector('.caratteristiche-addizionali');
                caratteristicheAddizionali.classList.toggle('hide');
            });
        });
    });
</script>
</body>
</html>
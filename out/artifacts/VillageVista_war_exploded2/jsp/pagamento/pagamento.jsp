<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pagamento</title>
    <!-- Includi qui eventuali stili CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: "Cactus Classical Serif", serif;
        }
        .mb-4{
            font-family: "Cactus Classical Serif", sans-serif;
            margin-top: 40px;

        }
        .container {
            width: 80%;
            margin: auto;
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        .alloggio-details {
            margin-bottom: 30px;
        }
        .immagineAlloggio img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 40px;
        }
        .dettagli-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            flex-wrap: nowrap;
        }
        .dettagli-container .dettaglio {
            flex: 0 0 50%;
            max-width: 75%;
            padding: 20px;
            box-sizing: border-box;
            text-align: left;
        }
        .dettagli-container .dettaglio h2 {
            margin-bottom: 40px;
            margin-top: 40px;
            font-size: 24px;
            color: #007bff;
        }
        .dettagli-container .dettaglio p {
            margin-bottom: 10px;
            font-size: 22px;
            margin-top: 20px;
            font-family: "Cactus Classical Serif", sans-serif;
            color: #026702;
        }
        .dettagli-container .dettaglio p img {
            height: 20px;
            width: 20px;
            margin-right: 10px;
        }
        .payment-options {
            width: 100%;
            margin-top: 40px;
            padding: 20px;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            border: solid 2px rgba(0, 0, 0, 0.2);
        }
        .payment-options img{
            width: 30px;
            height: 30px;
        }
        .payment-options p{
            font-size: 16px;
            color: #96c8fc;
        }
        .payment-options h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #007bff;
        }
        .payment-options .option {
            margin-bottom: 20px;
            font-size: 20px;
            font-family: "Cactus Classical Serif",serif;
        }
        .payment-options .option input {
            margin-right: 10px;
        }
        .payment-options .option img {
            margin-left: 10px;
        }
        .form-pagamento form {
            max-width: 400px;
            margin: auto;
            margin-top: 40px;
        }
        .form-pagamento label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            text-align: left;
        }
        .form-pagamento input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 4px solid #f0c320;
            border-radius: 5px;
        }
        .form-pagamento input:focus {
            outline: none;
        }
        .form-pagamento button {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            border: solid 2px transparent;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
        }
        .form-pagamento button:hover {
            background-color: #336699;
            transform: scale(1.05);
            border: 2px solid #f0c320;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="mb-4">Riepilogo prenotazione</h1>
        <%
        // Recupera i parametri dalla richiesta
        Long idAlloggio = Long.valueOf(request.getParameter("id"));
        Long costoTotale = Long.valueOf(request.getParameter("costoTotale"));
        String tipoCamera = request.getParameter("alloggio");
        Long persone = Long.valueOf(request.getParameter("persone"));
        Date dataCheckin = Date.valueOf(request.getParameter("dataCheckin"));
        Date dataCheckout = Date.valueOf(request.getParameter("dataCheckout"));
        String stato = request.getParameter("stato");

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

    <div class="dettagli-container">
        <div class="dettaglio alloggio-details">
            <div class="immagineAlloggio">
                <img src="<%= immagineAlloggio %>" alt="<%= tipoCamera%>">
            </div>
            <p><img src="images/alloggio.png"></img><strong><%= tipoCamera %></strong></p>
            <p><img src="images/checkin.png"></img> Check-in: <strong><%= dataCheckin %></strong></p>
            <p><img src="images/checkout.png"></img> Check-out: <strong><%= dataCheckout %></strong></p>
            <p><img src="images/persone.png"></img> <strong><%= persone %></strong></p>
            <br>
            <p><strong><img src="images/colazione.png"></img> Colazione inclusa nel prezzo</strong></p>
            <p><strong><img src="images/piscina.png"></img> Ingresso in piscina gratuito</strong></p>
            <p><strong><img src="images/wifi.png"></img> Wi-fi</strong></p>
            <p><strong><img src="images/condizionata.png"></img> Aria condizionata</strong></p>
            <p><strong>Totale:</strong> € <%= costoTotale %> <i>(include tasse e costi)</i></p>
        </div>

        <div class="dettaglio">
            <div class="payment-options">
                <h2>Quando vuoi pagare?</h2>
                <div class="option">
                    <input type="radio" id="payLater" name="paymentOption" value="payLater" checked>
                    <label for="payLater">Paga in struttura</label>
                    <p>Nessun addebito verrà effettuato sulla tua carta di credito. I dati della carta servono solo per garantire la prenotazione.</p>
                    <img src="images/cash.png">
                </div>
                <div class="option">
                    <input type="radio" id="payNow" name="paymentOption" value="payNow">
                    <label for="payNow">Paga ora</label>
                    <p>Pagherai in modo sicuro quando completerai la prenotazione.</p>
                    <img src="images/carta.png">
                </div>
            </div>
            <div class="dettaglio form-pagamento">
                <h2><strong>Procedi al pagamento</strong></h2>
                <form>
                    <!-- Campi per i dettagli carta di credito, ad esempio -->
                    <label for="nomeCarta">Nome sulla Carta</label>
                    <input type="text" id="nomeCarta" name="nomeCarta" required>

                    <label for="numeroCarta">Numero Carta di Credito</label>
                    <input type="text" id="numeroCarta" name="numeroCarta" required>

                    <label for="scadenzaCarta">Scadenza Carta di Credito (MM/YY)</label>
                    <input type="text" id="scadenzaCarta" name="scadenzaCarta" required>

                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" name="cvv" required maxlength="3">
                </form>
            <form action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="ClienteHomeManagement.confPrenotazione">
                    <!-- Campi nascosti per passare i parametri della prenotazione -->
                <input type="hidden" name="data_checkin" value="<%= dataCheckin %>">
                <input type="hidden" name="data_checkout" value="<%= dataCheckout %>">
                <input type="hidden" name="num_alloggio" value="<%= idAlloggio %>">
                <input type="hidden" name="persone" value="<%= persone %>">
                <input type="hidden" name="tipoCamera" value="<%= tipoCamera %>">
                <input type="hidden" name="totale" value="<%= costoTotale %>">
                <input type="hidden" name="pagamentoOpzione" value="">
                <input type="hidden" name="stato" value="confermata">
                    <button type="submit">Paga € <%= costoTotale %> e prenota</button>
                </form>
            </div>
        </div>
    </div>
    <!-- Includi qui eventuali script JavaScript -->
</body>
<script>
    // Aggiorna il valore del campo nascosto pagamentoOpzione in base alla selezione dell'utente
    document.querySelectorAll('input[name="paymentOption"]').forEach((element) => {
        element.addEventListener('change', function() {
            document.querySelector('input[name="pagamentoOpzione"]').value = this.value;
        });
    });
    // Imposta il valore iniziale al caricamento della pagina
    document.querySelector('input[name="pagamentoOpzione"]').value = document.querySelector('input[name="paymentOption"]:checked').value;

    document.addEventListener('DOMContentLoaded', function() {
        const scadenzaCartaInput = document.getElementById('scadenzaCarta');
        const numeroCartaInput = document.getElementById('numeroCarta');

        scadenzaCartaInput.addEventListener('input', function(e) {
            let input = e.target.value;

            // Rimuove tutti i caratteri non numerici
            input = input.replace(/\D/g, '');

            if (input.length > 2) {
                input = input.slice(0, 2) + '/' + input.slice(2, 4);
            }

            // Limita la lunghezza del campo a 5 caratteri
            if (input.length > 5) {
                input = input.slice(0, 5);
            }

            e.target.value = input;
        });

        numeroCartaInput.addEventListener('input', function(e) {
            let input = e.target.value;

            // Rimuove tutti i caratteri non numerici
            input = input.replace(/\D/g, '');

            // Limita l'input a un massimo di 16 cifre
            if (input.length > 16) {
                input = input.slice(0, 16);
            }

            // Inserisce uno spazio ogni 4 cifre
            let formattedInput = '';
            for (let i = 0; i < input.length; i += 4) {
                formattedInput += input.slice(i, i + 4) + ' ';
            }

            // Rimuove l'ultimo spazio se presente
            formattedInput = formattedInput.trim();

            e.target.value = formattedInput;
        });
    });
</script>
</html>


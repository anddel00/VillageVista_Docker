<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Cliente" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%-- Includi gli attributi necessari dal controller --%>
<%
    Long clienteId = (Long) request.getAttribute("clienteId");
    Cliente cliente = (Cliente) request.getAttribute("cliente");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Nuova Prenotazione - Admin</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
<style>
    /* Stili per il container principale */
    .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f9f9f9;
        border: 2px solid #2c3e50;
        border-radius: 5px;
        font-family: 'Cactus Classical Serif',sans-serif;
    }

    /* Stili per il titolo */
    h1 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 24px;
        color: #2c3e50;
        font-family: 'Cactus Classical Serif',sans-serif;
    }

    /* Stili per i gruppi di form */
    .form-group {
        margin-bottom: 15px;
    }

    /* Stili per le etichette */
    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        font-family: 'Cactus Classical Serif',sans-serif;
        color: #2c3e50;
    }

    /* Stili per gli input e select */
    input[type="date"],
    input[type="number"],
    select {
        width: 100%;
        padding: 8px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-family: 'Cactus Classical Serif',sans-serif;
    }

    /* Stili per il pulsante di invio */
    .btn-submit {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        font-family: 'Cactus Classical Serif',sans-serif;
        margin-left: 25%;
    }

    .btn-submit:hover {
        background-color: #45a049;
        cursor: pointer;
        transform: scale(1.05);
    }

    /* Stili per la form in generale */
    .booking-form {
        max-width: 400px;
        margin: 0 auto;
    }
</style>
<body>
<div class="container">
    <h1>Nuova Prenotazione per <%= cliente.getCognome_cliente() %> <%= cliente.getNome_cliente() %></h1>
    <form action="Dispatcher" method="post" class="booking-form">
        <input type="hidden" name="controllerAction" value="AdminHomeManagement.disponibilita">
        <input type="hidden" name="idCliente" value="<%= clienteId %>">

        <div class="form-group">
            <label>Data Check-in:</label>
            <input type="date" name="data_checkin" required>
        </div>

        <div class="form-group">
            <label>Data Check-out:</label>
            <input type="date" name="data_checkout" required>
        </div>

        <div class="form-group">
            <label>Numero di persone:</label>
            <input type="number" name="persone" placeholder="Per quante persone?" required min="1" max="5">
        </div>

        <div class="form-group">
            <label>Tipologia di alloggio:</label>
            <select name="alloggio" required>
                <option value="">Tipologia</option>
                <option value="bungalow">Bungalow</option>
                <option value="camera">Camera</option>
            </select>
        </div>

        <button type="submit" class="btn-submit">Controlla disponibilità</button>
    </form>
</div>
</body>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var dataCheckin = document.getElementsByName('data_checkin')[0];
        var dataCheckout = document.getElementsByName('data_checkout')[0];

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
</html>
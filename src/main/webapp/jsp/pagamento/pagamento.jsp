<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conferma Prenotazione | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700&family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            --primary: #1e3a8a;
            --primary-hover: #172554;
            --accent: #d97706;
            --accent-hover: #b45309;
            --bg-page: #f1f5f9;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
            --success: #10b981;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: var(--font-body);
            background-color: var(--bg-page);
            color: var(--text-dark);
            line-height: 1.6;
        }

        /* --- HEADER --- */
        .page-header {
            background-color: var(--primary);
            padding: 20px 5%;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .logo-img { height: 50px; border-radius: 8px; }

        /* --- MAIN LAYOUT --- */
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr 1.2fr; /* Due colonne: Sinistra riepilogo, Destra Pagamento */
            gap: 40px;
            align-items: start;
        }

        .title-main {
            font-family: var(--font-headings);
            font-size: 32px;
            color: var(--primary);
            margin-bottom: 30px;
            grid-column: 1 / -1;
            text-align: center;
        }

        /* --- RIEPILOGO ALLOGGIO (Colonna Sx) --- */
        .summary-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
        }

        .summary-img { width: 100%; height: 250px; object-fit: cover; display: block; }

        .summary-content { padding: 30px; }
        .summary-title { font-family: var(--font-headings); font-size: 24px; color: var(--primary); margin-bottom: 20px; }

        .summary-list { list-style: none; margin-bottom: 20px; border-bottom: 1px solid #f1f5f9; padding-bottom: 20px;}
        .summary-list li { display: flex; align-items: center; gap: 10px; margin-bottom: 10px; font-weight: 600; color: var(--text-dark);}
        .summary-list img { width: 20px; height: 20px; opacity: 0.7;}

        .features-list { list-style: none; color: #166534; font-size: 14px; font-weight: 600; margin-bottom: 20px;}
        .features-list li { display: flex; align-items: center; gap: 8px; margin-bottom: 8px;}
        .features-list img { width: 16px;}

        .total-price-box {
            background: #fdfcf6;
            padding: 20px;
            border-radius: 10px;
            border: 1px dashed var(--accent);
            text-align: center;
        }
        .total-label { display: block; font-size: 14px; color: var(--text-muted); text-transform: uppercase; font-weight: 700; margin-bottom: 5px;}
        .total-val { font-size: 32px; font-weight: 800; color: var(--text-dark); line-height: 1;}
        .total-note { font-size: 12px; color: var(--text-muted); display: block; margin-top: 5px;}

        /* --- FORM PAGAMENTO (Colonna Dx) --- */
        .payment-section {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
        }

        .payment-title { font-size: 20px; font-weight: 700; margin-bottom: 20px; color: var(--primary); }

        .radio-option {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            padding: 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .radio-option:hover { border-color: #cbd5e1; background: #f8fafc; }
        /* Quando il radio è checkato, cambia lo stile del div padre tramite JS o CSS:has (se supportato) */

        .radio-option input[type="radio"] { margin-top: 4px; transform: scale(1.2); accent-color: var(--primary); }
        .radio-content { flex-grow: 1; }
        .radio-title { font-weight: 700; font-size: 16px; display: block; margin-bottom: 5px; color: var(--text-dark);}
        .radio-desc { font-size: 13px; color: var(--text-muted); line-height: 1.4;}
        .radio-icon { width: 30px; height: 30px; object-fit: contain; }

        /* Form Carta */
        .card-details-form { margin-top: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; margin-bottom: 8px;}
        .form-control {
            width: 100%;
            padding: 15px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
            font-family: var(--font-body);
            background-color: #f8fafc;
            outline: none;
            transition: border-color 0.3s;
        }
        .form-control:focus { border-color: var(--primary); background-color: white; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }

        .btn-submit {
            width: 100%;
            background-color: var(--accent);
            color: white;
            border: none;
            padding: 18px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
            font-family: var(--font-body);
            box-shadow: 0 4px 15px rgba(217, 119, 6, 0.3);
        }
        .btn-submit:hover { background-color: var(--accent-hover); transform: translateY(-2px); box-shadow: 0 6px 20px rgba(217, 119, 6, 0.4); }

        /* --- RESPONSIVE --- */
        @media (max-width: 900px) {
            .container { grid-template-columns: 1fr; gap: 30px; }
            .title-main { font-size: 28px; }
            .payment-section { padding: 30px 20px; }
        }
    </style>
</head>
<body>

<%
    // Recupero Parametri
    String idAlloggioStr = request.getParameter("id");
    String costoTotaleStr = request.getParameter("costoTotale");
    String tipoCamera = request.getParameter("alloggio");
    String personeStr = request.getParameter("persone");
    String checkinStr = request.getParameter("dataCheckin");
    String checkoutStr = request.getParameter("dataCheckout");

    // Preveniamo NullPointerException sulle viste
    String idAlloggio = (idAlloggioStr != null) ? idAlloggioStr : "0";
    String costoTotale = (costoTotaleStr != null) ? costoTotaleStr : "0";
    String persone = (personeStr != null) ? personeStr : "0";
    String dataCheckin = (checkinStr != null) ? checkinStr : "";
    String dataCheckout = (checkoutStr != null) ? checkoutStr : "";

    // Logica Immagini (come originale)
    String immagineAlloggio = "images/camera_doppia.jpg";
    if (tipoCamera != null) {
        if (tipoCamera.toLowerCase().contains("tripla")) immagineAlloggio = "images/camera_tripla.jpg";
        else if (tipoCamera.toLowerCase().contains("quadrupla")) immagineAlloggio = "images/camera_quadrupla.jpg";
        else if (tipoCamera.toLowerCase().contains("bilocale")) immagineAlloggio = "images/bungalow_bilocale.jpg";
        else if (tipoCamera.toLowerCase().contains("trilocale")) immagineAlloggio = "images/bungalow_trilocale.jpg";
    }
%>

<header class="page-header">
    <a href="Dispatcher?controllerAction=ClienteHomeManagement.view">
        <img src="images/Logo.png" alt="VillageVista" class="logo-img" onerror="this.style.display='none'">
    </a>
</header>

<div class="container">
    <h1 class="title-main">Conferma e Paga</h1>

    <aside class="summary-card">
        <img src="<%= immagineAlloggio %>" alt="Alloggio" class="summary-img" onerror="this.src='https://via.placeholder.com/600x400?text=Alloggio'">

        <div class="summary-content">
            <h2 class="summary-title"><%= tipoCamera %></h2>

            <ul class="summary-list">
                <li><img src="images/checkin.png" alt="in" onerror="this.style.display='none'"> Check-in: <%= dataCheckin %></li>
                <li><img src="images/checkout.png" alt="out" onerror="this.style.display='none'"> Check-out: <%= dataCheckout %></li>
                <li><img src="images/persone.png" alt="ospiti" onerror="this.style.display='none'"> <%= persone %> Ospiti</li>
            </ul>

            <ul class="features-list">
                <li><img src="images/colazione.png" alt="*" onerror="this.style.display='none'"> Colazione inclusa</li>
                <li><img src="images/piscina.png" alt="*" onerror="this.style.display='none'"> Ingresso in piscina</li>
                <li><img src="images/wifi.png" alt="*" onerror="this.style.display='none'"> Wi-fi Free</li>
                <li><img src="images/condizionata.png" alt="*" onerror="this.style.display='none'"> Aria condizionata</li>
            </ul>

            <div class="total-price-box">
                <span class="total-label">Totale da Pagare</span>
                <span class="total-val">€ <%= costoTotale %></span>
                <span class="total-note">Tasse e costi di servizio inclusi</span>
            </div>
        </div>
    </aside>

    <main class="payment-section">

        <form action="Dispatcher" method="post" id="checkoutForm">
            <input type="hidden" name="controllerAction" value="ClienteHomeManagement.confPrenotazione">
            <input type="hidden" name="data_checkin" value="<%= dataCheckin %>">
            <input type="hidden" name="data_checkout" value="<%= dataCheckout %>">
            <input type="hidden" name="num_alloggio" value="<%= idAlloggio %>">
            <input type="hidden" name="persone" value="<%= persone %>">
            <input type="hidden" name="tipoCamera" value="<%= tipoCamera %>">
            <input type="hidden" name="totale" value="<%= costoTotale %>">
            <input type="hidden" name="stato" value="confermata">

            <input type="hidden" name="pagamentoOpzione" id="pagamentoOpzione" value="payLater">

            <h3 class="payment-title">1. Modalità di Pagamento</h3>

            <label class="radio-option" id="opt-payLater" style="border-color: var(--primary); background: #f8fafc;">
                <input type="radio" name="paymentOption" value="payLater" checked>
                <div class="radio-content">
                    <span class="radio-title">Paga in Struttura</span>
                    <span class="radio-desc">Nessun addebito ora. I dati della carta servono solo a garanzia della prenotazione.</span>
                </div>
                <img src="images/cash.png" class="radio-icon" alt="Cash" onerror="this.style.display='none'">
            </label>

            <label class="radio-option" id="opt-payNow">
                <input type="radio" name="paymentOption" value="payNow">
                <div class="radio-content">
                    <span class="radio-title">Paga Subito</span>
                    <span class="radio-desc">Addebito immediato per l'intero importo della vacanza.</span>
                </div>
                <img src="images/carta.png" class="radio-icon" alt="Card" onerror="this.style.display='none'">
            </label>

            <h3 class="payment-title" style="margin-top: 40px;">2. Dati della Carta</h3>

            <div class="card-details-form">
                <div class="form-group">
                    <label for="nomeCarta">Titolare della Carta</label>
                    <input type="text" id="nomeCarta" name="nomeCarta" class="form-control" placeholder="Mario Rossi" required>
                </div>

                <div class="form-group">
                    <label for="numeroCarta">Numero Carta</label>
                    <input type="text" id="numeroCarta" name="numeroCarta" class="form-control" placeholder="0000 0000 0000 0000" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="scadenzaCarta">Scadenza</label>
                        <input type="text" id="scadenzaCarta" name="scadenzaCarta" class="form-control" placeholder="MM/YY" required>
                    </div>

                    <div class="form-group">
                        <label for="cvv">Codice di Sicurezza (CVV)</label>
                        <input type="password" id="cvv" name="cvv" class="form-control" placeholder="123" required maxlength="3">
                    </div>
                </div>
            </div>

            <button type="submit" class="btn-submit">
                Conferma e Paga € <%= costoTotale %>
            </button>

        </form>
    </main>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        // --- LOGICA RADIO BUTTONS (Grafica e Campo Nascosto) ---
        const radioBtns = document.querySelectorAll('input[name="paymentOption"]');
        const hiddenOpt = document.getElementById('pagamentoOpzione');
        const optPayLater = document.getElementById('opt-payLater');
        const optPayNow = document.getElementById('opt-payNow');

        radioBtns.forEach(btn => {
            btn.addEventListener('change', function() {
                // Aggiorna il campo nascosto da inviare al server
                hiddenOpt.value = this.value;

                // Aggiorna la grafica dei box
                if (this.value === 'payNow') {
                    optPayNow.style.borderColor = 'var(--primary)';
                    optPayNow.style.background = '#f8fafc';
                    optPayLater.style.borderColor = '#e2e8f0';
                    optPayLater.style.background = 'white';
                } else {
                    optPayLater.style.borderColor = 'var(--primary)';
                    optPayLater.style.background = '#f8fafc';
                    optPayNow.style.borderColor = '#e2e8f0';
                    optPayNow.style.background = 'white';
                }
            });
        });

        // --- FORMATTAZIONE CAMPI CARTA DI CREDITO ---
        const scadenzaCartaInput = document.getElementById('scadenzaCarta');
        const numeroCartaInput = document.getElementById('numeroCarta');
        const cvvInput = document.getElementById('cvv');

        // Formatta Scadenza MM/YY
        scadenzaCartaInput.addEventListener('input', function(e) {
            let input = e.target.value.replace(/\D/g, ''); // Solo numeri
            if (input.length > 2) {
                input = input.slice(0, 2) + '/' + input.slice(2, 4);
            }
            if (input.length > 5) {
                input = input.slice(0, 5);
            }
            e.target.value = input;
        });

        // Formatta Numero Carta con Spazi
        numeroCartaInput.addEventListener('input', function(e) {
            let input = e.target.value.replace(/\D/g, ''); // Solo numeri
            if (input.length > 16) {
                input = input.slice(0, 16);
            }
            let formattedInput = '';
            for (let i = 0; i < input.length; i += 4) {
                formattedInput += input.slice(i, i + 4) + ' ';
            }
            e.target.value = formattedInput.trim();
        });

        // Forza solo numeri nel CVV
        cvvInput.addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
    });
</script>

</body>
</html>
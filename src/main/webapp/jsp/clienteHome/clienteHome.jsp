<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Cliente" %>
<%@ page import="java.util.List" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Prenotazione" %>
<%@ page import="com.villagevista.villagevista.Model.Mo.Messaggio" %>

<%
    String nome = (String) session.getAttribute("nome_cliente");
    String cognome = (String) session.getAttribute("cognome_cliente");
    List<Prenotazione> prenotazioni = (List<Prenotazione>) request.getAttribute("prenotazioni");
    List<Prenotazione> cancprenotazioni = (List<Prenotazione>) request.getAttribute("cancprenotazioni");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Personale | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            --primary: #1e3a8a;
            --accent: #d97706;
            --accent-hover: #b45309;
            --bg-page: #f8fafc;
            --text-dark: #334155;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
            --danger: #ef4444;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: var(--font-body);
            background-color: var(--bg-page);
            color: var(--text-dark);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* --- 2. HEADER & HERO --- */
        .hero {
            background-image: linear-gradient(rgba(30, 58, 138, 0.8), rgba(30, 58, 138, 0.9)), url('images/mare_sfondo.jpeg');
            background-size: cover;
            background-position: center;
            padding: 40px 5% 100px 5%;
            text-align: center;
            color: white;
            position: relative;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .logo { height: 60px; border-radius: 8px; }

        .btn-home {
            display: flex; align-items: center; gap: 8px; color: white;
            text-decoration: none; font-weight: 600; background-color: rgba(255,255,255,0.2);
            padding: 10px 20px; border-radius: 8px; transition: background-color 0.3s;
        }
        .btn-home:hover { background-color: rgba(255,255,255,0.3); }

        .welcome-title { font-family: var(--font-headings); font-size: 42px; margin-bottom: 10px; }
        .welcome-subtitle { font-size: 18px; opacity: 0.9; }

        /* --- 3. BARRA PRENOTAZIONE --- */
        .booking-bar-wrapper {
            max-width: 1000px;
            margin: -60px auto 40px auto;
            padding: 0 20px;
            position: relative;
            z-index: 10;
        }

        .booking-bar {
            background: white; padding: 20px; border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            display: flex; align-items: flex-end; gap: 15px;
        }

        .input-group { display: flex; flex-direction: column; flex: 1; }
        .input-group label {
            font-size: 13px; font-weight: 600; color: var(--text-muted);
            margin-bottom: 5px; text-transform: uppercase; letter-spacing: 0.5px;
        }

        .booking-bar input, .booking-bar select {
            width: 100%; padding: 12px 15px; border: 1px solid #cbd5e1;
            border-radius: 8px; font-family: var(--font-body); font-size: 15px;
            color: var(--text-dark); outline: none; transition: border-color 0.3s;
            background-color: #f8fafc;
        }
        .booking-bar input:focus, .booking-bar select:focus { border-color: var(--accent); }

        .btn-book {
            background-color: var(--accent); color: white; border: none;
            padding: 14px 24px; border-radius: 8px; font-size: 16px; font-weight: bold;
            cursor: pointer; transition: background-color 0.3s, transform 0.2s;
            height: 100%; white-space: nowrap; font-family: var(--font-body);
        }
        .btn-book:hover { background-color: var(--accent-hover); transform: translateY(-2px); }

        /* --- 4. CONTAINER PRINCIPALE E BOTTONI TOGGLE --- */
        .main-container { max-width: 1200px; margin: 0 auto; padding: 0 20px 60px 20px; }

        .toggle-btn {
            display: inline-block; background-color: white; color: var(--primary);
            border: 2px solid var(--primary); padding: 12px 24px; border-radius: 8px;
            font-size: 16px; font-weight: 600; cursor: pointer; text-decoration: none;
            margin-bottom: 20px; margin-right: 10px; transition: all 0.3s;
        }
        .toggle-btn:hover, .toggle-btn.active { background-color: var(--primary); color: white; }

        .toggle-btn-danger { border-color: var(--danger); color: var(--danger); }
        .toggle-btn-danger:hover, .toggle-btn-danger.active { background-color: var(--danger); color: white; }

        .collapsible-section {
            display: none; animation: fadeIn 0.4s ease forwards; margin-bottom: 40px;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        /* --- 5. GRIGLIA PRENOTAZIONI --- */
        .grid-cards {
            display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 30px; margin-top: 20px;
        }

        .card {
            background: white; border-radius: 12px; overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.3s ease;
            position: relative; display: flex; flex-direction: column;
        }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }

        .card-img-wrapper { position: relative; height: 200px; }
        .card-img-wrapper img { width: 100%; height: 100%; object-fit: cover; }

        .badge-numero {
            position: absolute; top: 15px; left: 15px; background: rgba(0,0,0,0.7);
            color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px;
            font-weight: bold; backdrop-filter: blur(5px);
        }

        .card-details { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; }

        .card-title {
            font-family: var(--font-headings); font-size: 22px; color: var(--primary);
            margin-bottom: 15px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px;
        }

        .data-row { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 14px; }
        .data-row span:first-child { color: var(--text-muted); }
        .data-row span:last-child { font-weight: 600; color: var(--text-dark); }

        .card-price {
            margin-top: auto; padding-top: 15px; border-top: 1px solid #e2e8f0;
            display: flex; justify-content: space-between; align-items: center;
        }
        .price-val { font-size: 20px; font-weight: bold; color: var(--primary); }
        .badge-pagamento {
            font-size: 12px; padding: 4px 8px; border-radius: 6px; font-weight: bold;
            background: #f1f5f9; color: var(--text-muted);
        }

        /* --- 6. INFORMAZIONI UTILI --- */
        .info-box {
            background: white; border-radius: 16px; padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); margin-top: 40px; border-top: 5px solid var(--accent);
        }
        .info-box h2 { font-family: var(--font-headings); color: var(--primary); font-size: 28px; margin-bottom: 25px; text-align: center; }
        .info-content p { margin-bottom: 15px; position: relative; padding-left: 20px; }
        .info-content p::before { content: '•'; position: absolute; left: 0; color: var(--accent); font-weight: bold; }

        /* --- 7. MEDIA QUERIES --- */
        @media (max-width: 768px) {
            .booking-bar { flex-direction: column; align-items: stretch; }
            .btn-book { margin-top: 10px; }
            .welcome-title { font-size: 32px; }
            .toggle-btn { width: 100%; margin-right: 0; text-align: center; }
            .info-box { padding: 25px 20px; }
        }
    </style>
</head>
<body>

<div class="hero">
    <div class="header-top">
        <img src="images/Logo.png" alt="VillageVista Logo" class="logo" onerror="this.src='https://via.placeholder.com/120x60?text=Logo'">
        <a href="Dispatcher?controllerAction=HomeManagement.view" class="btn-home">
            ← Logout / Torna al Sito
        </a>
    </div>

    <h1 class="welcome-title">Benvenuto, <%= request.getSession().getAttribute("nome") %> <%= request.getSession().getAttribute("cognome") %>!</h1>
    <p class="welcome-subtitle">Trova l'alloggio perfetto per le tue prossime vacanze.</p>
</div>

<div class="booking-bar-wrapper">
    <form class="booking-bar" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="ClienteHomeManagement.disponibilita">

        <div class="input-group">
            <label for="data_checkin">Check-in</label>
            <input type="date" id="data_checkin" name="data_checkin" required>
        </div>

        <div class="input-group">
            <label for="data_checkout">Check-out</label>
            <input type="date" id="data_checkout" name="data_checkout" required>
        </div>

        <div class="input-group">
            <label>Ospiti</label>
            <input type="number" name="persone" placeholder="N° persone" required min="1" max="5">
        </div>

        <div class="input-group">
            <label>Tipologia</label>
            <select name="alloggio" required>
                <option value="">Tipologia</option>
                <option value="bungalow">Bungalow</option>
                <option value="camera">Camera</option>
            </select>
        </div>

        <button type="submit" class="btn-book">Verifica disponibilità</button>
    </form>
</div>

<div class="main-container">

    <a href="#" class="toggle-btn" id="btn-attive">Le Tue Prenotazioni Attive</a>
    <a href="#" class="toggle-btn toggle-btn-danger" id="btn-cancellate">Storico Cancellate</a>

    <div class="collapsible-section" id="sec-attive">
        <div class="grid-cards">
            <% if (prenotazioni == null || prenotazioni.isEmpty()) { %>
            <div style="grid-column: 1/-1; text-align: center; padding: 40px; background: white; border-radius: 12px; color: var(--text-muted);">
                Nessuna prenotazione attiva al momento. Usa il form qui sopra per prenotare!
            </div>
            <% } else { %>
            <% for (Prenotazione p : prenotazioni) {
                String imgPath = "images/camera_doppia.jpg";
                if (p.getAlloggio().contains("tripla")) imgPath = "images/camera_tripla.jpg";
                if (p.getAlloggio().contains("quadrupla")) imgPath = "images/camera_quadrupla.jpg";
                if (p.getAlloggio().contains("bilocale")) imgPath = "images/bungalow_bilocale.jpg";
                if (p.getAlloggio().contains("trilocale")) imgPath = "images/bungalow_trilocale.jpg";
            %>
            <div class="card">
                <div class="card-img-wrapper">
                    <span class="badge-numero">N° <%= p.getNumPrenotazione() %></span>
                    <img src="<%= imgPath %>" alt="Alloggio" onerror="this.src='https://via.placeholder.com/400x200?text=Immagine+Alloggio'">
                </div>
                <div class="card-details">
                    <h3 class="card-title"><%= p.getAlloggio() %></h3>

                    <div class="data-row"><span>Check-in:</span> <span><%= p.getDataCheckin() %></span></div>
                    <div class="data-row"><span>Check-out:</span> <span><%= p.getDataCheckout() %></span></div>
                    <div class="data-row"><span>Ospiti:</span> <span><%= p.getPersone() %> Persone</span></div>

                    <div class="card-price">
                        <span class="price-val">€ <%= p.getTotale() %></span>
                        <span class="badge-pagamento"><%= p.getPagato() %></span>
                    </div>
                </div>
            </div>
            <% } %>
            <% } %>
        </div>
    </div>

    <div class="collapsible-section" id="sec-cancellate">
        <div class="grid-cards">
            <% if (cancprenotazioni == null || cancprenotazioni.isEmpty()) { %>
            <div style="grid-column: 1/-1; text-align: center; padding: 40px; background: white; border-radius: 12px; color: var(--text-muted);">
                Nessuna prenotazione cancellata nello storico.
            </div>
            <% } else { %>
            <% for (Prenotazione p : cancprenotazioni) {
                String imgPath = "images/camera_doppia.jpg";
                if (p.getAlloggio().contains("tripla")) imgPath = "images/camera_tripla.jpg";
                if (p.getAlloggio().contains("quadrupla")) imgPath = "images/camera_quadrupla.jpg";
                if (p.getAlloggio().contains("bilocale")) imgPath = "images/bungalow_bilocale.jpg";
                if (p.getAlloggio().contains("trilocale")) imgPath = "images/bungalow_trilocale.jpg";
            %>
            <div class="card" style="opacity: 0.8;">
                <div class="card-img-wrapper" style="filter: grayscale(80%);">
                    <span class="badge-numero" style="background: var(--danger);">Cancellata (N° <%= p.getNumPrenotazione() %>)</span>
                    <img src="<%= imgPath %>" alt="Alloggio" onerror="this.src='https://via.placeholder.com/400x200?text=Immagine+Alloggio'">
                </div>
                <div class="card-details">
                    <h3 class="card-title" style="color: var(--text-muted);"><%= p.getAlloggio() %></h3>
                    <div class="data-row"><span>Check-in:</span> <span><%= p.getDataCheckin() %></span></div>
                    <div class="data-row"><span>Check-out:</span> <span><%= p.getDataCheckout() %></span></div>
                    <div class="data-row"><span>Ospiti:</span> <span><%= p.getPersone() %></span></div>
                    <div class="card-price"><span class="price-val" style="color: var(--text-muted);">€ <%= p.getTotale() %></span></div>
                </div>
            </div>
            <% } %>
            <% } %>
        </div>
    </div>

    <div class="info-box">
        <h2>Informazioni Utili per il Soggiorno</h2>
        <div class="info-content">
            <p><strong>Prenotazioni e Pagamenti:</strong> Per prenotare solo il pernottamento con colazione è necessario saldare l'importo del primo pernottamento. Per aderire alla promo pasti è richiesto il saldo anticipato dell'intero soggiorno.</p>
            <p><strong>Cancellazioni:</strong> Tutti i pagamenti non sono rimborsabili. In caso di cancellazione entro 7 giorni dal check-in, su richiesta, verrà emesso un buono pari al 100% dell'importo speso, utilizzabile entro la fine della stagione e cedibile a terzi.</p>
            <p><strong>Ristorazione:</strong> La "Promo Pasto" include due portate dal menu bistrot a prezzo bloccato, senza costo di coperto (bevande escluse). Segnalare allergie/intolleranze al check-in. Non è consentito introdurre bevande dall'esterno.</p>
            <p><strong>Servizi Inclusi:</strong> Parcheggio gratuito non custodito (viale privato di 200m). Uso gratuito della piscina (obbligo di cuffia, aperta 9:00 - 19:00, chiusura stagionale metà ottobre).</p>
            <p><strong>Orari Struttura:</strong> Reception aperta dalle 7:30 alle 22:30 (no portiere notturno). Check-in dalle 14:00 alle 19:00. Check-out entro le 10:30.</p>
            <p><strong>Tassa di Soggiorno:</strong> 2 Euro per persona al giorno (non inclusa nel prezzo dell'alloggio).</p>
        </div>
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var dataCheckin = document.getElementById('data_checkin');
        var dataCheckout = document.getElementById('data_checkout');

        dataCheckin.addEventListener('input', function() {
            validateDates();
        });

        dataCheckout.addEventListener('input', function() {
            validateDates();
        });

        function validateDates() {
            var today = new Date();
            // Evita che orari sfasati blocchino la data di oggi
            today.setHours(0,0,0,0);

            var checkinDate = new Date(dataCheckin.value);
            var checkoutDate = new Date(dataCheckout.value);

            if (checkinDate < today) {
                dataCheckin.setCustomValidity('La data di check-in non può essere precedente alla data odierna.');
            } else {
                dataCheckin.setCustomValidity('');
            }

            if (checkoutDate < checkinDate) {
                dataCheckout.setCustomValidity('La data di check-out non può essere precedente alla data di check-in.');
            } else {
                dataCheckout.setCustomValidity('');
            }
        }

        const btnAttive = document.getElementById('btn-attive');
        const btnCancellate = document.getElementById('btn-cancellate');
        const secAttive = document.getElementById('sec-attive');
        const secCancellate = document.getElementById('sec-cancellate');

        btnAttive.addEventListener('click', function(e) {
            e.preventDefault();
            if(secAttive.style.display === 'block') {
                secAttive.style.display = 'none';
                btnAttive.classList.remove('active');
            } else {
                secAttive.style.display = 'block';
                secCancellate.style.display = 'none';
                btnAttive.classList.add('active');
                btnCancellate.classList.remove('active');
            }
        });

        btnCancellate.addEventListener('click', function(e) {
            e.preventDefault();
            if(secCancellate.style.display === 'block') {
                secCancellate.style.display = 'none';
                btnCancellate.classList.remove('active');
            } else {
                secCancellate.style.display = 'block';
                secAttive.style.display = 'none';
                btnCancellate.classList.add('active');
                btnAttive.classList.remove('active');
            }
        });
    });
</script>
</body>
</html>
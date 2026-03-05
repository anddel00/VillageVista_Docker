<%@ page import="com.villagevista.villagevista.Model.Mo.Alloggio" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Alloggio> alloggiDisponibili = (List<Alloggio>) request.getAttribute("alloggiDisponibili");
    java.sql.Date dataCheckin = (java.sql.Date) request.getAttribute("data_checkin");
    java.sql.Date dataCheckout = (java.sql.Date) request.getAttribute("data_checkout");

    // Calcolo giorni (salvaguardando il caso di date nulle o differenze a zero)
    long diff = 1;
    if (dataCheckin != null && dataCheckout != null) {
        diff = (dataCheckout.getTime() - dataCheckin.getTime()) / (1000 * 60 * 60 * 24);
        if (diff <= 0) diff = 1;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alloggi Disponibili | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        /* --- CSS VARIABLES (Design System Cliente) --- */
        :root {
            --primary: #1e3a8a;
            --primary-hover: #172554;
            --accent: #d97706;
            --accent-hover: #b45309;
            --bg-page: #f8fafc;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
            --success: #16a34a;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: var(--font-body);
            background-color: var(--bg-page);
            color: var(--text-dark);
            line-height: 1.6;
        }

        /* --- HEADER & LOGO --- */
        .page-header {
            background-color: var(--primary);
            padding: 15px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .logo-img { height: 60px; border-radius: 8px; }

        .btn-back-header {
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.1);
            padding: 10px 20px;
            border-radius: 8px;
            transition: background 0.3s;
        }
        .btn-back-header:hover { background: rgba(255,255,255,0.2); }

        /* --- SEARCH BAR (Responsive) --- */
        .search-container {
            background: white;
            padding: 20px;
            margin: -20px auto 40px auto;
            max-width: 1100px;
            width: 90%;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            position: relative;
            z-index: 10;
        }

        .search-container form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            align-items: end;
        }

        .input-group { display: flex; flex-direction: column; gap: 5px; }
        .input-group label { font-size: 12px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; }

        .search-container input, .search-container select {
            padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 14px;
            outline: none; font-family: var(--font-body); background-color: #f8fafc;
        }
        .search-container input:focus, .search-container select:focus { border-color: var(--accent); }

        .btn-search {
            background-color: var(--primary); color: white; border: none; padding: 14px;
            border-radius: 8px; font-weight: 700; cursor: pointer; transition: background 0.3s;
            font-family: var(--font-body);
        }
        .btn-search:hover { background-color: var(--primary-hover); }

        /* --- MAIN CONTENT --- */
        .container { max-width: 1100px; margin: 0 auto; padding: 0 20px 60px 20px; }
        .title-main { font-family: var(--font-headings); font-size: 32px; color: var(--primary); margin-bottom: 30px; text-align: center; }

        /* --- ALLOGGIO CARD (Horizontal Layout) --- */
        .alloggio-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            display: flex;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
            transition: transform 0.3s ease, box-shadow 0.3s;
        }
        .alloggio-card:hover { transform: translateY(-5px); box-shadow: 0 12px 25px rgba(0,0,0,0.1); }

        .card-image {
            width: 380px;
            aspect-ratio: 4 / 3; /* Blocca le proporzioni dell'immagine in modo assoluto */
            align-self: flex-start; /* Dice all'immagine di NON allungarsi col testo */
            flex-shrink: 0;
            position: relative;
        }

        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .card-content {
            flex-grow: 1;
            padding: 30px;
            display: flex;
            flex-direction: column;
            min-height: 100%; /* Si assicura che il testo riempia sempre la card */
        }        .post-title { font-family: var(--font-headings); font-size: 28px; color: var(--primary); margin-bottom: 15px; line-height: 1.2;}

        .meta-info { display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px; }
        .meta-item { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: 600; color: var(--text-muted); }
        .meta-item img { width: 18px; height: 18px; opacity: 0.7;}

        /* --- SERVICES (Collapsible) --- */
        .caratteristiche-addizionali {
            background: #fdfcf6; border: 1px dashed var(--accent);
            border-radius: 10px; padding: 15px; margin-bottom: 20px;
            display: none; grid-template-columns: 1fr 1fr; gap: 10px;
            animation: fadeIn 0.3s ease;
        }
        .caratteristiche-addizionali.show { display: grid; }
        .service-tag { display: flex; align-items: center; gap: 8px; font-size: 13px; color: #166534; font-weight: 600; }
        .service-tag img { width: 16px; }

        /* --- PRICE & ACTIONS --- */
        .card-footer {
            margin-top: auto; padding-top: 20px; border-top: 1px solid #f1f5f9;
            display: flex; justify-content: space-between; align-items: center;
        }

        .price-display { display: flex; flex-direction: column; }
        .price-total { font-size: 32px; font-weight: 800; color: var(--primary); line-height: 1; }
        .price-night { font-size: 13px; color: var(--text-muted); margin-top: 4px;}

        .actions-group { display: flex; gap: 10px; }
        .btn {
            padding: 12px 24px; border-radius: 8px; font-weight: 700; cursor: pointer;
            transition: all 0.2s; font-family: var(--font-body); border: none; text-decoration: none; font-size: 15px; text-align: center;
        }

        .btn-book { background-color: var(--accent); color: white; box-shadow: 0 4px 12px rgba(217, 119, 6, 0.3); }
        .btn-book:hover { background-color: var(--accent-hover); transform: scale(1.03); }

        .btn-details { background-color: #f1f5f9; color: var(--text-dark); border: 1px solid #e2e8f0; }
        .btn-details:hover { background-color: #e2e8f0; }

        /* --- EMPTY STATE --- */
        .empty-state { text-align: center; padding: 60px 20px; background: white; border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .empty-state h2 { color: var(--text-muted); margin-bottom: 10px;}

        /* --- RESPONSIVE --- */
        @media (max-width: 900px) {
            .alloggio-card { flex-direction: column; }
            .card-image { width: 100%; height: 250px; }
            .search-container { margin-top: 20px; }
        }

        @media (max-width: 600px) {
            .page-header { flex-direction: column; gap: 15px; }
            .card-footer { flex-direction: column; gap: 20px; align-items: stretch; text-align: center; }
            .actions-group { flex-direction: column; }
            .caratteristiche-addizionali.show { grid-template-columns: 1fr; }
            .search-container form { grid-template-columns: 1fr 1fr; }
            .btn-search { grid-column: 1 / -1; }
        }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

<header class="page-header">
    <a href="Dispatcher?controllerAction=ClienteHomeManagement.view">
        <img src="images/Logo.png" alt="LOGO" class="logo-img" onerror="this.style.display='none'">
    </a>

    <a href="Dispatcher?controllerAction=ClienteHomeManagement.view" class="btn-back-header">
        ← Torna all'Area Riservata
    </a>
</header>

<div class="search-container">
    <form action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="ClienteHomeManagement.disponibilita">
        <div class="input-group">
            <label>Check-in</label>
            <input type="date" name="data_checkin" value="<%= dataCheckin != null ? dataCheckin : "" %>" required>
        </div>
        <div class="input-group">
            <label>Check-out</label>
            <input type="date" name="data_checkout" value="<%= dataCheckout != null ? dataCheckout : "" %>" required>
        </div>
        <div class="input-group">
            <label>Ospiti</label>
            <input type="number" name="persone" placeholder="N°" required min="1" max="5">
        </div>
        <div class="input-group">
            <label>Tipologia</label>
            <select name="alloggio" required>
                <option value="Bungalow">Bungalow</option>
                <option value="Camera">Camera</option>
            </select>
        </div>
        <button type="submit" class="btn-search">Aggiorna Ricerca</button>
    </form>
</div>

<div class="container">

    <% if (alloggiDisponibili != null && !alloggiDisponibili.isEmpty()) { %>
    <h1 class="title-main">Abbiamo trovato <%= alloggiDisponibili.size() %> soluzioni perfette per te</h1>
    <div class="alloggi-list">
        <%
            for (Alloggio alloggio : alloggiDisponibili) {
                Long prezzonotte = alloggio.getPrezzonotte();
                Long costoTotale = (prezzonotte != null ? prezzonotte : 0) * diff;

                int persone = Integer.parseInt(alloggio.getCapienza());
                String tipo = alloggio.getTipo();
                String tipoCamera = "";
                String imagePath = "";

                if (tipo.equalsIgnoreCase("camera")) {
                    if (persone == 2) { tipoCamera = "Camera Matrimoniale"; imagePath = "images/camera_doppia.jpg"; }
                    else if (persone == 3) { tipoCamera = "Camera Tripla"; imagePath = "images/camera_tripla.jpg"; }
                    else if (persone == 4) { tipoCamera = "Camera Quadrupla"; imagePath = "images/camera_quadrupla.jpg"; }
                    else { tipoCamera = "Camera per " + persone + " persone"; imagePath = "images/camera_default.jpg"; }
                } else if (tipo.equalsIgnoreCase("bungalow")) {
                    if (persone <= 3) { tipoCamera = "Bungalow Bilocale"; imagePath = "images/bungalow_bilocale.jpg"; }
                    else { tipoCamera = "Bungalow Trilocale"; imagePath = "images/bungalow_trilocale.jpg"; }
                } else {
                    tipoCamera = "Alloggio per " + persone + " persone"; imagePath = "images/alloggio_default.jpg";
                }
        %>

        <article class="alloggio-card">
            <div class="card-image">
                <img src="<%= imagePath %>" alt="<%= tipoCamera %>" onerror="this.src='https://via.placeholder.com/400x300?text=VillageVista'">
            </div>

            <div class="card-content">
                <h2 class="post-title"><%= tipoCamera %></h2>

                <div class="meta-info">
                    <div class="meta-item"><img src="images/persone.png" alt="Ospiti" onerror="this.style.display='none'"> <%= alloggio.getCapienza() %> Ospiti</div>
                    <div class="meta-item"><img src="images/checkin.png" alt="In" onerror="this.style.display='none'"> In: <%= dataCheckin %></div>
                    <div class="meta-item"><img src="images/checkout.png" alt="Out" onerror="this.style.display='none'"> Out: <%= dataCheckout %></div>
                </div>

                <div class="caratteristiche-addizionali hide">
                    <div class="service-tag"><img src="images/colazione.png" alt="*"> Colazione inclusa nel prezzo</div>
                    <div class="service-tag"><img src="images/piscina.png" alt="*"> Ingresso in piscina gratuito</div>
                    <div class="service-tag"><img src="images/wifi.png" alt="*"> Wi-fi Free</div>
                    <div class="service-tag"><img src="images/condizionata.png" alt="*"> Aria condizionata</div>
                </div>

                <div class="card-footer">
                    <div class="price-display">
                        <span class="price-total">€ <%= costoTotale %></span>
                        <span class="price-night">€ <%= prezzonotte %> / notte per <%= diff %> notti</span>
                    </div>

                    <div class="actions-group">
                        <button type="button" class="btn btn-details btn-maggiori-dettagli">Servizi Inclusi</button>
                        <a class="btn btn-book" href="Dispatcher?controllerAction=ClienteHomeManagement.goToPagamento&id=<%= alloggio.getNum_alloggio() %>&costoTotale=<%= costoTotale %>&dataCheckin=<%= dataCheckin %>&dataCheckout=<%= dataCheckout %>&persone=<%= persone %>&alloggio=<%= tipoCamera %>">
                            Prenota
                        </a>
                    </div>
                </div>
            </div>
        </article>
        <% } %>
    </div>
    <% } else { %>
    <div class="empty-state">
        <span style="font-size: 40px;">😔</span>
        <h2>Nessun alloggio disponibile</h2>
        <p>Non ci sono alloggi liberi per le date o i criteri selezionati.</p>
    </div>
    <% } %>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const btnsMaggioriDettagli = document.querySelectorAll('.btn-maggiori-dettagli');

        btnsMaggioriDettagli.forEach(function(btn) {
            btn.addEventListener('click', function() {
                const alloggioPost = this.closest('.alloggio-card');
                const caratteristiche = alloggioPost.querySelector('.caratteristiche-addizionali');
                const isShowing = caratteristiche.classList.toggle('show');
                this.textContent = isShowing ? 'Chiudi Info' : 'Servizi Inclusi';
                this.style.backgroundColor = isShowing ? '#e2e8f0' : '#f1f5f9';
            });
        });
    });
</script>
</body>
</html>
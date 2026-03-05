<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Villaggio Mare | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES (Palette Colori Moderna) --- */
        :root {
            --primary-color: #1e3a8a; /* Navy Blue elegante */
            --accent-color: #d97706; /* Oro/Ambra morbido */
            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-light: #f1f5f9;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
        }

        /* --- 2. RESET E REGOLE BASE --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-body);
            color: var(--text-dark);
            background-color: var(--bg-light);
            line-height: 1.6;
        }

        h1, h2, h3 {
            font-family: var(--font-headings);
            color: var(--primary-color);
        }

        /* --- 3. HERO SECTION (Sostituisce il vecchio backgroundimg) --- */
        .hero {
            /* Sostituisci l'URL con il tuo percorso reale */
            background-image: linear-gradient(rgba(30, 58, 138, 0.6), rgba(30, 58, 138, 0.4)), url('images/mare_sfondo.jpeg');
            background-size: cover;
            background-position: center;
            height: 100vh; /* 80% dell'altezza dello schermo */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        /* --- 4. NAVIGAZIONE ED EFFETTI HOVER --- */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 5%;
            background: rgba(30, 58, 138, 0.95);
            backdrop-filter: blur(10px);
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .header img.logo {
            height: 60px;
            border-radius: 8px;
            transition: transform 0.3s ease;
        }

        .header img.logo:hover {
            transform: scale(1.05);
        }

        .nav-links {
            display: flex;
            gap: 25px;
            align-items: center;
        }

        /* Stile base per i link di testo */
        .nav-link {
            color: var(--text-light);
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            padding-bottom: 5px;
            transition: color 0.3s ease;
        }

        /* Effetto sottolineatura animata al passaggio del mouse */
        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0%;
            height: 2px;
            background-color: var(--accent-color);
            transition: width 0.3s ease;
        }

        .nav-link:hover {
            color: var(--accent-color);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* Stato Attivo (Pagina Corrente) */
        .nav-link.active {
            color: var(--accent-color);
        }

        .nav-link.active::after {
            width: 100%; /* La sottolineatura rimane fissa */
        }

        /* Bottone Prenota: molto visibile */
        .btn-prenota {
            background-color: var(--accent-color);
            color: white !important;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(217, 119, 6, 0.4);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        .btn-prenota:hover {
            background-color: #b45309;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(217, 119, 6, 0.6);
        }

        .btn-prenota:active {
            transform: translateY(1px); /* Effetto "pressione" del click */
        }

        /* Bottone Backoffice: discreto, per lo staff */
        .btn-backoffice {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            padding: 6px 14px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            transition: all 0.3s ease;
            margin-left: 15px; /* Lo stacca un po' dal resto */
        }

        .btn-backoffice:hover {
            color: white;
            border-color: white;
            background-color: rgba(255, 255, 255, 0.1);
        }

        /* --- 5. SEZIONE OFFERTE (CSS GRID) --- */
        .section-container {
            padding: 80px 5%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            font-size: 36px;
            margin-bottom: 40px;
        }

        .grid-cards {
            display: grid;
            /* Magia del responsive: crea colonne che si adattano allo schermo */
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }

        .card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .card-content {
            padding: 25px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            align-items: center;
            text-align: center;
        }

        .card-title {
            font-size: 22px;
            margin-bottom: 15px;
        }

        .card-text {
            color: #64748b;
            font-size: 15px;
            margin-bottom: 20px;
            flex-grow: 1; /* Spinge il bottone in fondo */
        }

        .btn-scopri {
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 6px;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .btn-scopri:hover {
            background-color: #172554;
        }

        /* --- 6. RECENSIONI --- */
        .bg-reviews {
            background-color: #e2e8f0;
        }

        .review-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            border-left: 5px solid var(--accent-color);
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .review-name {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 18px;
            margin-bottom: 10px;
        }

        .review-text {
            font-style: italic;
            color: #475569;
        }

        /* --- 7. FOOTER & CONTATTI --- */
        .footer {
            background-color: var(--primary-color);
            color: var(--text-light);
            padding: 60px 5% 20px;
            text-align: center;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .contact-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            font-size: 15px;
        }

        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.1);
            padding-top: 20px;
            font-size: 14px;
            opacity: 0.8;
        }
        /* --- 8. ANIMAZIONI DI INGRESSO (Fade In Up) --- */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-up {
            opacity: 0; /* Partono invisibili */
            animation: fadeInUp 0.8s ease-out forwards;
        }

        /* Ritardi per far apparire le cose in sequenza */
        .delay-1 { animation-delay: 0.2s; }
        .delay-2 { animation-delay: 0.4s; }

        /* --- 9. MENU MOBILE (Hamburger) E MEDIA QUERIES --- */

        /* Pulsante Hamburger (nascosto di default su desktop) */
        .menu-toggle {
            display: none;
            flex-direction: column;
            justify-content: space-between;
            width: 30px;
            height: 21px;
            cursor: pointer;
            z-index: 101; /* Sopra il menu mobile */
        }

        .menu-toggle span {
            display: block;
            height: 3px;
            width: 100%;
            background-color: var(--text-light);
            border-radius: 3px;
            transition: all 0.3s ease;
        }

        /* --- STILI PER DISPOSITIVI MOBILI (max-width: 768px) --- */
        @media screen and (max-width: 768px) {

            .header {
                padding: 15px 5%; /* Riduciamo il padding su mobile */
            }

            /* Adattiamo il logo per schermi piccoli */
            .header img.logo {
                height: 45px;
            }

            /* Mostriamo il pulsante hamburger */
            .menu-toggle {
                display: flex;
            }

            /* Nascondiamo e stiliamo il menu di navigazione per mobile */
            .nav-links {
                position: absolute;
                top: 0;
                right: -100%; /* Nascosto fuori dallo schermo a destra */
                width: 250px;
                height: 100vh; /* Alto quanto tutto lo schermo */
                background-color: var(--primary-color);
                flex-direction: column;
                align-items: flex-start;
                padding: 80px 30px 30px 30px; /* Spazio in alto per la X */
                gap: 20px;
                transition: right 0.4s ease-in-out;
                box-shadow: -5px 0 15px rgba(0,0,0,0.2);
            }

            /* Classe aggiunta tramite JS per mostrare il menu */
            .nav-links.mobile-active {
                right: 0;
            }

            /* Adattiamo i link per la vista verticale */
            .nav-link {
                font-size: 18px;
                width: 100%;
                padding-bottom: 10px;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }

            .nav-link::after {
                display: none; /* Rimuoviamo la linea hover su mobile */
            }

            .btn-prenota {
                width: 100%;
                justify-content: center;
                margin-top: 10px;
            }

            .btn-backoffice {
                margin-left: 0;
                margin-top: auto; /* Lo spinge in fondo al menu */
                width: 100%;
                text-align: center;
            }

            /* Animazione della "X" per l'hamburger quando è attivo */
            .menu-toggle.active span:nth-child(1) {
                transform: translateY(9px) rotate(45deg);
            }
            .menu-toggle.active span:nth-child(2) {
                opacity: 0;
            }
            .menu-toggle.active span:nth-child(3) {
                transform: translateY(-9px) rotate(-45deg);
            }

            /* Adattamenti vari per mobile */
            .hero {
                height: 60vh; /* Hero più piccola su mobile */
            }

            .section-title {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>

<header class="header">
    <a href="#">
        <img src="images/Logo.png" alt="Logo Villaggio Mare" class="logo" onerror="this.src='https://via.placeholder.com/140x60?text=Logo'">
    </a>
    <div class="menu-toggle" id="mobile-menu">
        <span></span>
        <span></span>
        <span></span>
    </div>
    <nav class="nav-links" id="nav-links">
        <a href="#" class="nav-link active">Home</a>
        <a href="Dispatcher?controllerAction=HomeManagement.goToCamere" class="nav-link">Camere</a>
        <a href="Dispatcher?controllerAction=HomeManagement.goToBungalow" class="nav-link">Bungalow</a>
        <a href="Dispatcher?controllerAction=HomeManagement.goToGallery" class="nav-link">Gallery</a>

        <a href="Dispatcher?controllerAction=HomeManagement.goToLoginCliente" class="btn-prenota">
            Prenota <img src="images/calendario.png" alt="" width="18" onerror="this.style.display='none'">
        </a>

        <a href="Dispatcher?controllerAction=HomeManagement.goToBackoffice" class="btn-backoffice">Area Staff</a>
    </nav>
</header>

<div class="hero animate-fade-up">
</div>

<section class="section-container animate-fade-up delay-1">    <h2 class="section-title">I clienti apprezzano...</h2>

    <div class="grid-cards">
        <article class="card">
            <img src="images/camera_doppia.jpg" alt="Camera Matrimoniale" onerror="this.src='https://via.placeholder.com/400x220?text=Camera'">
            <div class="card-content">
                <h3 class="card-title">Camera Matrimoniale</h3>
                <p class="card-text">Ideale per coppie, completa di tutti i comfort per un soggiorno indimenticabile a due passi dal mare.</p>
                <a href="Dispatcher?controllerAction=HomeManagement.goToCamere" class="btn-scopri">Scopri di più</a>
            </div>
        </article>

        <article class="card">
            <img src="images/bungalow_trilocale.jpg" alt="Bungalow Trilocale" onerror="this.src='https://via.placeholder.com/400x220?text=Bungalow+Trilocale'">
            <div class="card-content">
                <h3 class="card-title">Bungalow Trilocale</h3>
                <p class="card-text">Perfetto per gruppi di amici o famiglie numerose, con spazi ampi e comfort per il tuo massimo relax.</p>
                <a href="Dispatcher?controllerAction=HomeManagement.goToBungalow" class="btn-scopri">Scopri di più</a>
            </div>
        </article>

        <article class="card">
            <img src="images/bungalow_bilocale.jpg" alt="Bungalow Bilocale" onerror="this.src='https://via.placeholder.com/400x220?text=Bungalow+Bilocale'">
            <div class="card-content">
                <h3 class="card-title">Bungalow Bilocale</h3>
                <p class="card-text">La soluzione ideale per le tue vacanze di Ferragosto. Intimo, accogliente e dotato di ogni necessità.</p>
                <a href="Dispatcher?controllerAction=HomeManagement.goToBungalow" class="btn-scopri">Scopri di più</a>
            </div>
        </article>
    </div>
</section>

<section class="section-container bg-reviews animate-fade-up delay-2">
    <h2 class="section-title">Dicono di noi</h2>
    <div class="grid-cards">
        <div class="review-card">
            <div class="review-name">Sara</div>
            <div class="review-text">"Esperienza indimenticabile, abbiamo ricevuto qualsiasi comfort che ci aspettavamo. Torneremo sicuramente!"</div>
        </div>
        <div class="review-card">
            <div class="review-name">Luca</div>
            <div class="review-text">"Weekend fantastico, abbiamo soggiornato in piena tranquillità godendoci la brezza marina."</div>
        </div>
        <div class="review-card">
            <div class="review-name">Mattia</div>
            <div class="review-text">"Villaggio stupendo a due passi dal mare. Il personale è stato estremamente cortese."</div>
        </div>
    </div>
</section>

<footer class="footer" id="contatti">
    <h2 style="color: white; margin-bottom: 40px; font-family: var(--font-body);">I Nostri Contatti</h2>
    <div class="contact-grid">
        <div class="contact-item">
            <strong>Telefono</strong>
            <span>+39 123 456 789</span>
        </div>
        <div class="contact-item">
            <strong>WhatsApp</strong>
            <span>+39 123 456 789</span>
        </div>
        <div class="contact-item">
            <strong>Email</strong>
            <span>info@villaggiomare.it</span>
        </div>
        <div class="contact-item">
            <strong>Indirizzo</strong>
            <span>Via delle Spiagge 10, Mare (IT)</span>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 VillageVista® - Progetto realizzato da Andrea Del Fatto</p>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const menuToggle = document.getElementById('mobile-menu');
        const navLinks = document.getElementById('nav-links');

        menuToggle.addEventListener('click', () => {
            // Attiva l'animazione dell'hamburger (si trasforma in X)
            menuToggle.classList.toggle('active');
            // Fa slittare il menu laterale
            navLinks.classList.toggle('mobile-active');
        });

        // Chiudi il menu se si clicca su un link (utile su mobile)
        const links = document.querySelectorAll('.nav-link');
        links.forEach(link => {
            link.addEventListener('click', () => {
                menuToggle.classList.remove('active');
                navLinks.classList.remove('mobile-active');
            });
        });
    });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES (Palette Unificata) --- */
        :root {
            --primary-color: #1e3a8a;
            --accent-color: #d97706;
            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-light: #f1f5f9;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
        }

        /* --- 2. RESET E REGOLE BASE --- */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: var(--font-body);
            color: var(--text-dark);
            background-color: var(--bg-light);
            line-height: 1.6;
            overflow-x: hidden;
        }
        h1, h2, h3 { font-family: var(--font-headings); color: var(--primary-color); }

        /* --- 3. HEADER & MENU (Identico alle altre pagine) --- */
        .header {
            display: flex; justify-content: space-between; align-items: center;
            padding: 20px 5%; background: rgba(30, 58, 138, 0.95); backdrop-filter: blur(10px);
            position: sticky; top: 0; z-index: 100; box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .header img.logo { height: 60px; border-radius: 8px; transition: transform 0.3s ease; }
        .header img.logo:hover { transform: scale(1.05); }
        .nav-links { display: flex; gap: 25px; align-items: center; }
        .nav-link {
            color: var(--text-light); text-decoration: none; font-weight: 600;
            font-size: 15px; text-transform: uppercase; letter-spacing: 1px;
            position: relative; padding-bottom: 5px; transition: color 0.3s ease;
        }
        .nav-link::after {
            content: ''; position: absolute; bottom: 0; left: 0;
            width: 0%; height: 2px; background-color: var(--accent-color); transition: width 0.3s ease;
        }
        .nav-link:hover { color: var(--accent-color); }
        .nav-link:hover::after { width: 100%; }
        .nav-link.active { color: var(--accent-color); }
        .nav-link.active::after { width: 100%; }

        .btn-prenota {
            background-color: var(--accent-color); color: white !important;
            padding: 10px 24px; border-radius: 8px; text-decoration: none; font-weight: bold;
            display: flex; align-items: center; gap: 8px; box-shadow: 0 4px 15px rgba(217, 119, 6, 0.4);
            transition: all 0.3s ease;
        }
        .btn-prenota:hover { background-color: #b45309; transform: translateY(-3px); }
        .btn-backoffice {
            color: rgba(255, 255, 255, 0.7); text-decoration: none; font-size: 13px;
            font-weight: 600; padding: 6px 14px; border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 20px; transition: all 0.3s ease; margin-left: 15px;
        }
        .btn-backoffice:hover { color: white; border-color: white; background-color: rgba(255, 255, 255, 0.1); }

        /* --- 4. PAGE HEADER --- */
        .page-header {
            background-color: var(--primary-color);
            background-image: linear-gradient(rgba(30, 58, 138, 0.8), rgba(30, 58, 138, 0.8)), url('images/spiaggia.jpg');
            background-size: cover;
            background-position: center;
            height: 35vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .page-title {
            color: white; font-size: 48px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        /* --- 5. GALLERY STYLES --- */
        .section-container {
            padding: 60px 5%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .gallery-group {
            margin-bottom: 60px;
        }

        .gallery-title {
            font-size: 32px;
            margin-bottom: 25px;
            color: var(--primary-color);
            border-left: 5px solid var(--accent-color);
            padding-left: 15px;
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        .gallery-item {
            position: relative;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            aspect-ratio: 4 / 3; /* Mantiene tutte le foto con le stesse proporzioni */
            cursor: pointer;
        }

        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Taglia l'immagine per riempire il quadrato senza deformarla */
            transition: transform 0.6s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        .gallery-item:hover img {
            transform: scale(1.1); /* L'immagine si ingrandisce al passaggio del mouse */
        }

        /* --- 6. ANIMAZIONI & MOBILE MENU --- */
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        .animate-fade-up { opacity: 0; animation: fadeInUp 0.8s ease-out forwards; }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }

        .menu-toggle { display: none; flex-direction: column; justify-content: space-between; width: 30px; height: 21px; cursor: pointer; z-index: 101; }
        .menu-toggle span { display: block; height: 3px; width: 100%; background-color: var(--text-light); border-radius: 3px; transition: all 0.3s ease; }

        @media screen and (max-width: 768px) {
            .header { padding: 15px 5%; }
            .header img.logo { height: 45px; }
            .menu-toggle { display: flex; }
            .nav-links {
                position: absolute; top: 0; right: -100%; width: 250px; height: 100vh;
                background-color: var(--primary-color); flex-direction: column; align-items: flex-start;
                padding: 80px 30px 30px 30px; gap: 20px; transition: right 0.4s ease-in-out; box-shadow: -5px 0 15px rgba(0,0,0,0.2);
            }
            .nav-links.mobile-active { right: 0; }
            .nav-link { font-size: 18px; width: 100%; padding-bottom: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); }
            .nav-link::after { display: none; }
            .btn-prenota { width: 100%; justify-content: center; margin-top: 10px; }
            .btn-backoffice { margin-left: 0; margin-top: auto; width: 100%; text-align: center; }
            .menu-toggle.active span:nth-child(1) { transform: translateY(9px) rotate(45deg); }
            .menu-toggle.active span:nth-child(2) { opacity: 0; }
            .menu-toggle.active span:nth-child(3) { transform: translateY(-9px) rotate(-45deg); }
        }
    </style>
</head>
<body>

<header class="header">
    <a href="Dispatcher?controllerAction=HomeManagement.view">
        <img src="images/Logo.png" alt="Logo Villaggio Mare" class="logo" onerror="this.src='https://via.placeholder.com/140x60?text=Logo'">
    </a>
    <div class="menu-toggle" id="mobile-menu">
        <span></span><span></span><span></span>
    </div>
    <nav class="nav-links" id="nav-links">
        <a href="Dispatcher?controllerAction=HomeManagement.view" class="nav-link">Home</a>
        <a href="Dispatcher?controllerAction=HomeManagement.goToCamere" class="nav-link">Camere</a>
        <a href="Dispatcher?controllerAction=HomeManagement.goToBungalow" class="nav-link">Bungalow</a>
        <a href="#" class="nav-link active">Gallery</a>
        <a href="Dispatcher?controllerAction=HomeManagement.view#contatti" class="nav-link">Contatti</a>

        <a href="Dispatcher?controllerAction=HomeManagement.goToLoginCliente" class="btn-prenota">
            Prenota <img src="images/calendario.png" alt="" width="18" onerror="this.style.display='none'">
        </a>
        <a href="Dispatcher?controllerAction=HomeManagement.goToBackoffice" class="btn-backoffice">Area Staff</a>
    </nav>
</header>

<div class="page-header animate-fade-up">
    <h1 class="page-title">La Nostra Struttura</h1>
</div>

<main class="section-container">

    <div class="gallery-group animate-fade-up delay-1">
        <h2 class="gallery-title">La Reception</h2>
        <div class="gallery-grid">
            <div class="gallery-item">
                <img src="images/reception.jpg" alt="La Reception" onerror="this.src='https://via.placeholder.com/600x400?text=Reception'">
            </div>
        </div>
    </div>

    <div class="gallery-group animate-fade-up delay-2">
        <h2 class="gallery-title">Il Nostro Bar</h2>
        <div class="gallery-grid">
            <div class="gallery-item">
                <img src="images/bar2.jpg" alt="Il Bar" onerror="this.src='https://via.placeholder.com/600x400?text=Bar'">
            </div>
        </div>
    </div>

    <div class="gallery-group animate-fade-up delay-3">
        <h2 class="gallery-title">La Sala Ristorante</h2>
        <div class="gallery-grid">
            <div class="gallery-item">
                <img src="images/sala1.jpg" alt="Ristorante - Vista 1" onerror="this.src='https://via.placeholder.com/600x400?text=Sala+Ristorante+1'">
            </div>
            <div class="gallery-item">
                <img src="images/sala2.jpg" alt="Ristorante - Vista 2" onerror="this.src='https://via.placeholder.com/600x400?text=Sala+Ristorante+2'">
            </div>
        </div>
    </div>

    <div class="gallery-group animate-fade-up delay-4">
        <h2 class="gallery-title">La Spiaggia Privata</h2>
        <div class="gallery-grid">
            <div class="gallery-item">
                <img src="images/spiaggia.jpg" alt="Spiaggia Privata" onerror="this.src='https://via.placeholder.com/600x400?text=Spiaggia'">
            </div>
        </div>
    </div>

</main>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const menuToggle = document.getElementById('mobile-menu');
        const navLinks = document.getElementById('nav-links');

        menuToggle.addEventListener('click', () => {
            menuToggle.classList.toggle('active');
            navLinks.classList.toggle('mobile-active');
        });

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
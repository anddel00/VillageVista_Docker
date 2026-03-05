<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Villaggio Mare</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            padding: 0;
        }
        .welcome{
            text-align: center;
            font-size: 32px;
            font-family: "Caveat-classical", cursive;
            color: #f3dd8b;
        }
        .logo-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .backgroundimg{
            width: 100%;
            height:750px;
            margin: 0;
            padding: 0;
            position: relative;
            border-bottom: 2px solid #336699;
        }

        .backgroundimg img.background {
                      width: 100%;
                      height: 100%;
                      object-fit: cover;
                      object-position: center;
                       opacity: 0.7;
                  }

        .footer {
            position: fixed;
            min-height: 10px;
            margin-bottom: auto;
            bottom: -100px;
            width: 100%;
            background-color: #336699; /* Sfondo del menu nav */
            color: white;
            text-align: center;
            padding: 20px 0; /* Spaziatura interna del footer */
            transition: bottom 0.3s ease;
            font-family: "Cactus Classical Serif",serif;
            font-size: 10px;
            border-top: 2px solid #f0c320;
            z-index: 10;
            box-shadow: 0 -5px 10px rgba(0, 0, 0, 0.5);

        }
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to top right, #1972ef, #4e8ff1);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000; /* Assicura che sia sopra tutto il resto */
        }
        .loading-screen img {
            border: 1px solid #ffd243; /* Bordo giallo attorno all'immagine del logo */
            border-radius: 20px; /* Bordo arrotondato, opzionale */
        }
        .header img{
            border: 1px solid #ffd243;
            position: absolute;
            top: 20px;
            left: 44%;
            border-radius: 20px;
        }

        .main-content {
            display: none; /* Nasconde il contenuto principale durante il caricamento */
            margin-bottom: 150px;
        }
        .header {
            background-color: transparent;
            color: #fff;
            padding: 10px 0;
            text-align: center;
            height: auto;
        }
        .nav {
            background-color: #336699;
            text-align: center;
            max-height: 0;
            transition: max-height 3s ease-out;
            margin-top: 20px;
            font-family: "Cactus Classical Serif",serif;
            position: absolute;
            width: 100%;
            top: 110px;
            z-index: 10;
        }

        .nav a {
            display: inline-block;
            padding: 15px 25px;
            text-decoration: none;
            color: white;
            transition: opacity 3s ease-out, color 0.5s, border-color 0.8s;
            opacity: 0;
            font-family: "Cactus Classical Serif",serif;
            z-index: 10;
            font-size: 20px;
            border: 2px solid transparent;
        }
        .nav a:nth-child(2){
            color: #ffd579;
            border-top: 2px solid #f0c320;
            border-bottom: 2px solid #f0c320;
            transition: opacity 4s ease-out, color 0.5s, border-color 0.6s;
        }
        .nav a:hover {
            color: #ffd579;
            transition: opacity 0.8s;
            border-top: 2px solid #f0c320;
            border-bottom: 2px solid #f0c320;
        }
        .cactus-classical-serif-regular {
            font-family: "Cactus Classical Serif", serif;
            font-weight: 400;
            font-style: normal;

        }
        .caveat-classical {
                     font-family: "Caveat", cursive;
                     font-optical-sizing: auto;
                     font-weight: 400;
                     font-style: normal;
                 }
        .nav.show {
            max-height: 200px;
        }
        .nav.show a {
            opacity: 1;
        }
        .prenotaLink {
            position: absolute;
            left: 0; /* Posiziona il link "Prenota" all'inizio del menu nav */
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: transparent;
            transition: color 0.8s ease;
            font-family: "Cactus Classical Serif",serif;
            z-index: 10;
        }
        .prenotaLink:hover {
            color: #f0c320;
        }
        .prenotaLink img {
            vertical-align: middle; /* Allinea verticalmente l'immagine con il testo */
            margin-left: 5px; /* Aggiunge uno spazio tra il testo e l'immagine */
            border: 1px solid transparent;
        }
        .prenotaLink:hover img {
            border: 1px solid transparent; /* Bordo giallo attorno all'immagine*/

        }

        .backofficeLink {
            position: absolute;
            right: 0; /* Posiziona il link "Backoffice" alla fine del menu nav */
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: transparent;
            transition: color 0.8s ease;
            font-family: "Cactus Classical Serif",serif;
        }

        .backofficeLink:hover {
            color: #f0c320;
        }

        .post-section {
            display: flex;
            overflow-x: scroll; /* Nasconde la barra di scorrimento inferiore */
            white-space: nowrap;
            padding: 20px;
            background-color: white;
            position: relative;
            top: 70px;
            scroll-behavior: smooth; /* Aggiunge un effetto di scorrimento liscio */
            z-index: 10;
            margin-bottom: 20px;
        }
        .post-section::-webkit-scrollbar {
            display: none; /* Nasconde la barra di scorrimento in WebKit */
            z-index: 10;
        }
.offerte-title{
    transition: opacity 1s ease, transform 1s ease;
    font-size:42px;
    text-align: center;
    margin-bottom: 20px;
    margin-left: 45px;
    margin-top:100px;
}

        .post {
            height: auto;
            width: 460px;
            background-color: white;
            margin-right: 40px;
            flex: 0 0 auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            font-family: "Cactus Classical Serif", serif;
            text-align: center;
            padding: 10px;
            box-sizing: border-box;
            z-index: 10;
            border: 2px solid #336699;
            color: #ffca00;
        }

        .post:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }
        .descrizione-offerta{
            position: relative;
            z-index: 10;
            margin: 0;
            text-align: center;
        }
        .descrizione-offerta p{
            color: #0056b3;
            text-align: center;
            z-index: 10;
        }
        .vetrina-title{
            color: #2a5176;
            z-index: 10;
            font-size: 22px;
        }

        .container {
            display: flex;
            justify-content: space-between;
            margin-top: 80px;
            padding: 0 20px;
            z-index: 10;
            position: relative;
        }
        .recensione-container {
            width: 48%; /* Larghezza dei container delle recensioni */
            border: 1px solid transparent; /* Bordo dei container */
            border-radius: 10px; /* Arrotondamento dei bordi */
            padding: 20px; /* Spaziatura interna */
            z-index: 10;
            margin-bottom: 20px;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .recensione-box {
            height: 200px; /* Altezza del box della recensione */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            border-radius: 8px; /* Arrotondamento dei bordi */
            margin-bottom: 10px; /* Margine inferiore tra i box delle recensioni */
            z-index: 10;
            font-family: "Cactus Classical Serif",serif;
            padding: 20px;
            border: 3px solid transparent;
            transition: background-color 0.5s, color 0.5s, border-color 0.5s;

        }
        .recensione-box:hover{
            background-color: #336394;
            color: #f0c320;
            border: 3px solid #f0c320;
        }
        .recensione-name{
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .recensione-text {
            font-size: 26px; /* Dimensione del testo */
            line-height: 1.5;
            font-family: "Caveat-classical", cursive;
        }
        .recensioni-title {
            transition: opacity 1s ease, transform 1s ease;
            font-size:42px;
            text-align: center;
            margin-bottom: 20px;
            margin-left: 45px;
            margin-top:100px;
        }
        .contact-section {
            background-color: #336699;
            color: white;
            padding: 40px 20px;
            text-align: center;
            font-family: "Cactus Classical Serif", serif;
            border-top: 2px solid #f0c320;
            border-bottom: 2px solid #f0c320;

            position: relative;
            z-index: 10;
        }

        .contact-section h2 {
            margin-bottom: 40px;
            font-size: 28px;
        }

        .contact-item {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .contact-item img {
            vertical-align: middle;
            margin-right: 10px;
        }
        .scopri{
            background-color: #0066da;
            color: white;
            text-decoration: none;
            padding: 10px;
            border-radius: 5px;
            cursor:pointer;
            display: inline-block;
        }
        .scopri:hover{
            background-color: #0056b3;
        }


    </style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">


    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">

    <script>
        window.onload = function() {
            // Nascondi la schermata di caricamento e mostra il contenuto principale dopo 3 secondi
            setTimeout(function() {
                document.querySelector('.loading-screen').style.display = 'none';
                document.querySelector('.main-content').style.display = 'block';
                document.body.style.overflow = 'auto'; // Ripristina lo scroll

                // Aggiungi la classe "show" per mostrare il menu di navigazione con transizione
                setTimeout(function() {
                    var nav = document.querySelector('.nav');
                    nav.classList.add('show');
                }, 1200); // Attendi un breve momento prima di attivare la transizione del menu
            }, 1500); //Tempo di loading della pagina
        };

        window.onscroll = function() {
            var footer = document.getElementById("footer");
            // Mostra il footer quando si scende oltre una certa altezza dalla cima della pagina
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                footer.style.bottom = "0";
            } else {
                // Nascondi il footer quando si risale sopra la certa altezza
                footer.style.bottom = "-100px";
            }
        }
    </script>
</head>
<body>
<div class="loading-screen">
    <div class="logo-container">
    <img src="images/Logo.png" height="160" width="220" alt="LOGO"/>
    <h1 class="welcome">La tua vacanza inizia qui</h1>
    </div>
</div>
<div class="main-content">
    <div class="backgroundimg">
        <img src="images/mare_sfondo.jpeg" class="background" height="780" width="100%"/>
<header class="header">
    <img src="images/Logo.png"  height="90" width="140" alt="LOGO"/>
</header>

<nav class="nav">
    <a href="Dispatcher?controllerAction=HomeManagement.goToLoginCliente" class="prenotaLink">Prenota<img src="images/calendario.png" alt="calendario" width="24" height="24"></a> <!-- Link per la prenotazione -->
    <a href="#">HOME</a>
    <a href="Dispatcher?controllerAction=HomeManagement.goToCamere">CAMERE</a>
    <a href="Dispatcher?controllerAction=HomeManagement.goToBungalow">BUNGALOW</a>
    <a href="Dispatcher?controllerAction=HomeManagement.goToGallery">GALLERY</a>
    <a href="#contatti">CONTATTI</a>
    <a href="Dispatcher?controllerAction=HomeManagement.goToBackoffice" class="backofficeLink">Backoffice</a>
    <!-- Link per il backoffice -->
</nav>
    </div>

    <h2 class="offerte-title">I clienti apprezzano...</h2>
    <div class="post-section">
        <div class="post">
            <img src="images/camera_doppia.jpg" alt="Camera Matrimoniale" style="width: 100%; height: 54%;">
            <br>
            <div class="descrizione-offerta">
                <h3 class="vetrina-title">Camera matrimoniale</h3>
                <p>Scopri la nostra camera matrimoniale </p>
                <p> ideale per coppie,completa di tutti </p>
                <p>i comfort per un soggiorno indimenticabile.</p>
                <a class="scopri" href="Dispatcher?controllerAction=HomeManagement.goToCamere">Scopri</a>
            </div>
        </div>
        <div class="post">
            <img src="images/bungalow_trilocale.jpg" alt="Bungalow Trilocale" style="width: 100%; height: 54%;">
            <div class="descrizione-offerta">
                <h3 class="vetrina-title">Bungalow trilocale</h3>
                <p>Esplora il nostro bungalow trilocale </p>
                <p>perfetto per gruppi di amici, </p>
                <p>con spazi ampi e comfort per il tuo relax.</p>
                <a class="scopri" href="Dispatcher?controllerAction=HomeManagement.goToBungalow">Scopri</a>
            </div>
        </div>
        <div class="post">
            <img src="images/bungalow_bilocale.jpg" alt="Bungalow Bilocale" style="width: 100%; height: 75%;">
            <div class="descrizione-offerta">
                <h3 class="vetrina-title">Bungalow bilocale</h3>
                <p>Scopri il nostro bungalow bilocale per</p>
                <p>le tue vacanze di Ferragosto, ideale </p>
                <p>per famiglie di tre persone in cerca </p>
                <p>di relax e divertimento.</p>
                <a class="scopri" href="Dispatcher?controllerAction=HomeManagement.goToBungalow">Scopri</a>
            </div>
        </div>
    </div>
    <h1 class="recensioni-title">Diconono di noi...</h1>
    <div class="container">
        <div class="recensione-container">
            <div class="recensione-box">
                <p class="recensione-name">Sara</p>
                <p class="recensione-text">"Esperienza indimenticabile, abbiamo ricevuto qualisasi comfort che ci aspettavamo"</p>
            </div>
            <div class="recensione-box">
                <p class="recensione-name">Luca</p>
                <p class="recensione-text">"Weekend fantastico, abbiamo soggornato in piena tranquillità"</p>
            </div>
        </div>
        <div class="recensione-container">
            <div class="recensione-box">
                <p class="recensione-name">Mattia</p>
                <p class="recensione-text">"Villaggio stupendo a due passi dal mare, ritorneremo"</p>
            </div>
            <div class="recensione-box">
                <p class="recensione-name">Carlo</p>
                <p class="recensione-text">" Siamo stati benissimo, vacanza indimenticabile "</p>
            </div>
        </div>
    </div>
    <div class="contact-section" id="contatti">
        <h2>Contatti</h2>
        <div class="contact-item">
            <img src="images/call.png" alt="Telefono" width="24" height="24"> Telefono: +39 123 456 789
        </div>
        <div class="contact-item">
            <img src="images/phone.png" alt="WhatsApp" width="24" height="24"> WhatsApp: +39 123 456 789
        </div>
        <div class="contact-item">
            <img src="images/mail.png" alt="Email" width="24" height="24"> Email: info@villaggiomare.it
        </div>
        <div class="contact-item">
            <img src="images/location.png" alt="Indirizzo" width="24" height="24"> Indirizzo: Via delle Spiagge, 10, 00000 Mare, Italia
        </div>
    </div>



    <footer class="footer" id="footer">
       <h2> Andrea Del Fatto</h2>
        <h2>VillageVista®</h2>
    </footer>

</div>
</body>
</html>

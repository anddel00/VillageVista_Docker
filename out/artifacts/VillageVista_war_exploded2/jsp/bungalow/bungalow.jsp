<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Villaggio Turistico</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to top right, #ccdeff, #93def5);
        }
        .header {
            background-color: transparent;
            color: #fff;
            padding: 10px 0;
            text-align: center;
            height: auto;
            margin-bottom: 50px;
        }
        .header img {
            border: 1px solid #ffd243;
            position: absolute;
            top: 20px;
            left: 44%;
            border-radius: 20px;
        }
        .nav {
            background-color: #336699;
            text-align: center;
            margin-top: 20px;
            font-family: "Cactus Classical Serif", serif;
            position: relative;
            width: 100%;
            top: 110px;
            transition: opacity 0.4s ease-out, color 0.5s;
        }
        .nav a {
            display: inline-block;
            padding: 15px 25px;
            text-decoration: none;
            color: white;
            transition: opacity 0.4s ease-out, color 0.5s, border-color 0.8s;
            opacity: 0;
            font-family: "Cactus Classical Serif", serif;
            font-size: 20px;
            border: 2px solid transparent;
        }
        .nav a:nth-child(3) {
            color: #ffd579;
            border-top: 2px solid #f0c320;
            border-bottom: 2px solid #f0c320;
            transition: opacity 0.4s ease-out, color 0.5s, border-color 0.6s;
        }
        .nav a:hover {
            color: #ffd579;
            transition: opacity 0.8s;
            border-top: 2px solid #f0c320;
            border-bottom: 2px solid #f0c320;
        }
        .home-button img {
            vertical-align: middle;
            position: relative;
            width: 40px;
            height: 40px;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            margin-top: 40px;
        }
        h2 {
            text-align: center;
            margin-top: 70px;
            font-family: "Caveat-classical", cursive;
            font-size: 40px;
            text-shadow: #464545;
            color: #336699;
        }
        .room-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 40px;
        }
        .room-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: calc(33% - 40px);
            max-width: 300px;
            margin-bottom: 20px;
            transition: transform 0.3s;
            align-items: center;
            justify-items: center;
        }
        .room-card img {
            width: 100%;
            height: 200px;
        }
        .room-card:hover {
            transform: translateY(-20px);
        }
        .room-description {
            padding: 15px;
            text-align: center;
            font-family: "Cactus Classical Serif", serif;
            font-size: 18px;
            color: #333;
        }
        .verifica-button {
            position: relative;
            bottom: 10px;
            display: inline-block;
            margin-top: 30px;
            left: 42%;
            transform: translateX(-50%);
            background-color: #336699;
            color: white;
            border: 2px solid transparent;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            text-decoration: none; /* Rimuove la sottolineatura */
        }
        .verifica-button:hover {
            background-color: #2a5176;
            border-color: #f0c320;
        }
        .nav.show {
            max-height: 200px;
            opacity: 1;
        }
        .nav.show a {
            opacity: 1;
        }
        .informazioni-aggiuntive{
            padding: 20px;
            margin: auto;
            width: auto;
            height: auto;
            border: 2px solid #8da9d7;
            border-radius: 20px;
            font-family: "Cactus Classical Serif",serif;
            font-size: 16px;
        }
            .incluso {
                border: 2px solid #8da9d7;
                display: table;
                padding: 3px;
                border-radius: 5px;
            }
        .informazioni-aggiuntive img{
            width: 16px;
            height: 16px;
            margin-right: 8px;
        }
    </style>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">

<body>
<nav class="nav">
    <a href="Dispatcher?controllerAction=HomeManagement.view">HOME</a>
    <a href="Dispatcher?controllerAction=HomeManagement.goToCamere">CAMERE</a>
    <a href="Dispatcher?controllerAction=HomeManagement.goToBungalow">BUNGALOW</a>
    <a href="Dispatcher?controllerAction=HomeManagement.goToGallery">GALLERY</a>
    <a href="#">CONTATTI</a>
    <!-- Link per il backoffice -->
</nav>
<div class="container">
    <header class="header">
        <img src="images/Logo.png" height="90" width="140" alt="LOGO"/>
    </header>
    <h2>I nostri bungalow</h2>
    <div class="room-wrapper">
        <div class="room-card">
            <img src="images/bungalow_bilocale.jpg" alt="Camera Matrimoniale" class="camera-doppia">
            <div class="room-description">
                <h3>Bungalow Bilocale</h3>
                <p>Disponibili da 2 o 3 posti, perfetto quindi per coppie o per piccole famiglie, con letto matrimoniale, angolo cottura e tutti i comfort.</p>
                <br>
                <a href="Dispatcher?controllerAction=HomeManagement.goToLoginCliente" class="verifica-button">Verifica disponibilità</a>
            </div>
        </div>
        <div class="room-card">
            <img src="images/bungalow_trilocale.jpg" alt="Camera Tripla">
            <div class="room-description">
                <h3>Bungalow Trilocale</h3>
                <p>Disponibili da 4 o 5 posti, ideali per famiglie numerose o gruppi di amici, con una stanza da letto matrimoniale e una stanza con letto singolo e/o a castello.</p>
                <a href="Dispatcher?controllerAction=HomeManagement.goToLoginCliente" class="verifica-button">Verifica disponibilità</a>
            </div>
        </div>
        <div class="informazioni-aggiuntive">
            <p>Tutti nostri bungalow sono dotati di:</p>
            <p class="incluso"><img src="images/condizionata.png">Aria condizionata</p>
            <p class="incluso"><img src="images/tv.png">Tv</p>
            <p class="incluso"><img src="images/wifi.png">Wi-Fi</p>
            <p class="incluso"><img src="images/cucina.png">Ampia cucina</p>
            <p class="incluso"><img src="images/microonde.png">Microonde</p>
            <p class="incluso"><img src="images/frigo.png">Frigorifero con reparto freezer</p>
            <p>Il servizio biancheria da letto e da bagno <u><strong>non</strong></u> è incluso</p>
            <br>
            <p>I bungalow sono situati a pian terreno e forniti di un ampio patio esterno pavimentato</p>
            <p>corredato di tavolo e sedie per consumare i pasti in compagnia e al fresco, rilassandosi in piena tranquillità</p>
        </div>
    </div>
</div>
<script>
    window.onload = function() {
        setTimeout(function() {
            var nav = document.querySelector('.nav');
            nav.classList.add('show');
        }, 800);
    }
</script>
</body>
</html>

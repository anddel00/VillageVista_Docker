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
        .nav a:nth-child(4) {
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
            margin-top: 50px;
            font-family: "Caveat-classical", cursive;
            font-size: 40px;
            text-shadow: #464545;
            color: #336699;
        }
        .image-wrapper{
            width: 100%;
            max-width: 800px;
            margin: 20px auto;
            padding: 10px;
        }

        .image-wrapper img {
            width: 100%;
            border-radius: 30px;
            box-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        .nav.show {
            max-height: 200px;
            opacity: 1;
        }
        .nav.show a {
            opacity: 1;
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
    <a href="Dispatcher?controllerAction=HomeManagement.view#contatti">CONTATTI</a>
    <!-- Link per il backoffice -->
</nav>
<div class="container">
    <header class="header">
        <img src="images/Logo.png" height="90" width="140" alt="LOGO"/>
    </header>
    <h2>La reception . . .</h2>
    <div class="image-wrapper">
        <img src="images/reception.jpg" alt="Reception 1">
    </div>
    <h2>Il nostro bar. . .</h2>
    <div class="image-wrapper">
        <img src="images/bar2.jpg" alt="Bar 2">
    </div>
    <h2>La sala ristorante . . .</h2>
    <div class="image-wrapper">
        <img src="images/sala1.jpg" alt="Ristorante 1">
    </div>
    <div class="image-wrapper">
        <img src="images/sala2.jpg" alt="Ristorante 2">
    </div>
    <h2>La spiaggia . . .</h2>
    <div class="image-wrapper">
        <img src="images/spiaggia.jpg" alt="Spiaggia">
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Prenotazione effettuata</title>
</head>
<style>
    body {
        font-family: "Cactus Classical Serif", serif;
        margin: 0;
        height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        background: linear-gradient(to bottom right, #1972ef, #f0c320);
    }
    .home-button {
        display: flex;
        font-size: 16px;
        background-color: #96c8fc;
        border: 2px solid transparent;
        border-radius: 5px;
        color: black;
        text-decoration: none;
        transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
        width: 40px;
        height: 40px;
        padding: 5px;
        align-items: center;
        text-shadow: 0 4px 8px #2c3e50;
    }
    .home-button:hover {
        background-color: #83b9fc;
        transform: scale(1.05);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        border: 2px solid #f0c320;
    }
    .home-button img{
        vertical-align: middle;
        position: relative;
        width: 40px;
        height: 40px;
    }
    .message{
        font-family: "Cactus Classical Serif",serif;
        font-size: 34px;
        color: white;
        text-shadow: 0 4px 8px #2c3e50;
    }
    .message-due{
        font-family: "Cactus Classical Serif",serif;
        font-size: 24px;
        color: white;
        text-shadow: 0 4px 8px #2c3e50;
        margin-bottom: 50px;
    }
    .label {
        margin-top: 10px;
        font-size: 16px;
        color: white;
        text-shadow: 0 4px 8px #2c3e50;
        font-family: "Cactus Classical Serif",serif;
    }
</style>
<body>

<h1 class="message">PRENOTAZIONE CANCELLATA CON SUCCESSO!</h1>
<h1 class="message-due">Se hai bisogno di maggiorni informazioni non esitare a contattarci</h1>

<a href="Dispatcher?controllerAction=ClienteHomeManagement.view" class="home-button">
    <img src="images/home.png" alt="Home">
</a>
<p class="label">Torna alla tua home</p>


</body>
</html>

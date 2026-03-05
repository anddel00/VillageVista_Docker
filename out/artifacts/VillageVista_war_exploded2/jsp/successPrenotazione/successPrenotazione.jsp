<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Prenotazione confermata</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: "Cactus Classical Serif",serif;
            background-color: #f0f0f0;
            margin: 20px;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            font-family: "Cactus Classical Serif",serif;
        }
        h1 {
            color: #333;
            text-align: center;
            font-family: "Cactus Classical Serif",serif;
        }
        .nav-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #2c3e50;
            font-weight: bold;
            padding: 8px;
            font-family: "Cactus Classical Serif",serif;
        }
        .nav-link:hover {
            text-decoration:none;
            background-color: #0056b3;
            cursor: pointer;
            color: white;
        }
        .message{
            color: #af0b19;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="message">Prenotazione eliminata correttamente</h1>

    <a href="Dispatcher?controllerAction=AdminHomeManagement.view" class="nav-link">Torna alla pagina di planning</a>
</div>
</body>
</html>
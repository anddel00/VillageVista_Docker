<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Prenotazione</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            padding: 0;
            color: #ffca00;
            background-color: #2c3e50;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(51, 102, 153, 0.2);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            animation: fadeInDown 2s forwards;
            text-align: center;
            font-family: "Cactus Classical Serif", serif;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #fff;
            font-family: "Cactus Classical Serif", serif;
        }
        input[type="text"], input[type="date"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-family: "Cactus Classical Serif", serif;
        }
        button {
            width: 96%;
            padding: 10px;
            background-color: #336699;
            color: #ffca00;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border: 2px solid transparent;
            font-family: "Cactus Classical Serif", serif;
            font-size: 16px;
        }
        button:hover {
            border: 2px solid #f0c320;
        }
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Modifica la tua prenotazione</h1>
    <form action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="ClienteHomeManagement.modPrenotazione">
        <input type="text" name="num_p" placeholder="N.prenotazione" required>
        <input type="date" name="data_checkin" placeholder="Data Check-in" required><br>
        <input type="date" name="data_checkout" placeholder="Data Check-out" required><br>
        <input type="text" name="cognome_p" placeholder="Cognome" required><br>
        <button type="submit" value="Aggiungi prenotazione">Modifica</button>
    </form>
</div>
</body>
</html>


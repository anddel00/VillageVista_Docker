<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Cliente</title>
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
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            text-align: center;
            width: 350px;
            margin: 20px 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-container form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .login-form h2 {
            margin-bottom: 30px;
            font-family: "Cactus Classical Serif", serif;
            font-size: 28px;
            margin-top: 20px;
        }
        .login-form p {
            margin-bottom: 40px;
            font-family: "Cactus Classical Serif", serif;
            font-size: 16px;
            color: #666;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            margin: 10px 0;
            padding: 10px;
            width: 80%;
            border: 1px solid #1972ef;
            border-radius: 10px;
        }
        .login-form button {
            margin: 20px 0;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: 2px solid transparent;
            border-radius: 10px;
            background: #96c8fc;
            color: black;
            font-family: "Cactus Classical Serif", serif;
            width: 40%;
            transition: border-color 0.3s, transform 0.3s, box-shadow 0.3s;
        }

        .login-form button:hover {
            background: #83b9fc;
            transform: scale(1.10);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            border: 2px solid #f0c320;


        }

        .register-link {
            margin-top: 20px;
            font-family: "Cactus Classical Serif", serif;
            font-size: 16px;
            color: #666;
        }
        .register-link a {
            margin: 20px 0;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: 2px solid transparent;
            border-radius: 10px;
            background: #96c8fc;
            color: black;
            font-family: "Cactus Classical Serif", serif;
            width: 40%;
            transition: border-color 0.3s, transform 0.3s, box-shadow 0.3s;
            display: inline-block;
            text-decoration: none;
        }
        .register-link a:hover {
            background: #83b9fc;
            transform: scale(1.10);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            border: 2px solid #f0c320;
        }
    </style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
</head>
<body>
<div class="login-container">
    <div class="login-form">
        <h2>Login Cliente</h2>
        <p>Accedi per prenotare o per verificare la disponibilità</p>
        <form action="Dispatcher" method="post">
            <input type="hidden" name="controllerAction" value="LoginClienteManagement.processLoginCliente">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <div class="register-link">
            oppure <b>registrati</b> se non lo hai ancora fatto!
            <br>
            <div>
                <a href="Dispatcher?controllerAction=LoginClienteManagement.goToRegistraCliente" class="button">Registrati qui</a>
           </div>
        </div>
    </div>
</div>
</body>
</html>

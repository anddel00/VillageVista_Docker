<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Backoffice Login</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: row;
        }
        .split {
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .left {
            background: linear-gradient(to top right, #1972ef, #4e8ff1);
        }
        .right {
            background: linear-gradient(to top right, #f0c320, #e1c74d);
        }
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
            text-align: center;
            width: 350px;
            height: 400px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .login-container-dip {
            border: 4px solid #f0c320;
        }
        .login-container-admin {
            border: 4px solid #1972ef;
        }
        .login-form h2 {
            margin-bottom: 10px; /* Reduced bottom margin */
            font-family: "Cactus Classical Serif", serif;
            font-size: 28px;
            margin-top: 0;
        }
        .login-form p {
            margin-bottom: 40px; /* Add margin for spacing */
            font-family: "Cactus Classical Serif", serif;
            font-size: 16px;
            color: #666;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            margin: 10px 10px;
            padding: 10px;
            width: 80%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .login-container-dip input[type="text"],
        .login-container-dip input[type="password"] {
            border: 1px solid #f0c320;
        }
        .login-container-admin input[type="text"],
        .login-container-admin input[type="password"] {
            border: 1px solid #1972ef;
        }
        .login-form button {
            margin: 20px 0;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: 3px solid transparent;
            border-radius: 5px;
            background: #96c8fc;
            color: black;
            font-family: "Cactus Classical Serif", serif;
            width: 40%;
            transition: border-color 0.3s, transform 0.3s, box-shadow 0.3s; /* Smooth transition for border color, transform, and box-shadow */
        }
        .login-form button:hover {
            background: #83b9fc;
            transform: scale(1.10); /* Slightly enlarge the button */
            box-shadow: 0 4px 12px rgba(0,0,0,0.2); /* Add shadow effect */
        }
        .login-form-dip-button:hover {
            border-color: #f0c320; /* Only change the border color */
        }
        .login-form-admin-button:hover {
            border-color: #1972ef; /* Only change the border color */
        }
    </style>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
</head>
<body>
<div class="split left">
    <div class="login-container login-container-dip">
        <div class="login-form">
            <h2>Dipendente</h2>
            <p>Inserisci le tue credenziali per accedere</p>
            <form action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="BackofficeLogin.processLoginDipendente">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button class="login-form-dip-button" type="submit">Login</button>
            </form>
        </div>
    </div>
</div>
<div class="split right">
    <div class="login-container login-container-admin">
        <div class="login-form">
            <h2>Amministratore</h2>
            <p>Inserisci le tue credenziali per accedere</p>
            <form action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="BackofficeLogin.processLoginAdmin">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button class="login-form-admin-button" type="submit">Login</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>

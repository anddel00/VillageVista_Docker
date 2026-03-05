
    <title>Title</title><%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="it">
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Cactus+Classical+Serif&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
        <meta charset="UTF-8">
        <title>Registrazione completata</title>
        <style>
            body {
                font-family: "Cactus Classical Serif", sans-serif;
                background: linear-gradient(to bottom right, #1972ef, #f0c320);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                background: #dbe6f3;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                text-align: center;
                border: 1px solid #0c8629;
            }
            h1 {
                color: #0066da;
            }
            a {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                text-decoration: none;
                color: white;
                background-color: #007bff;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            a:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
    <div class="container">
        <h1>Registrazione avvenuta con successo!</h1>
        <a href="Dispatcher?controllerAction=HomeManagement.goToLoginCliente">Ritorna alla pagina di login</a>
    </div>
    </body>
    </html>
<%--
  Created by IntelliJ IDEA.
  User: andreadelfatto
  Date: 19/06/24
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Nuovo cliente</title>
    <style>
        body {
            font-family: "Cactus Classical Serif", serif;
            margin: 0;
            padding: 0;
            color: #ffca00;
            background: linear-gradient(to bottom right, #1972ef, #f0c320);
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(51, 102, 153, 0.2);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.6);
            animation: fadeInDown 2s forwards;
            text-align: center;
            font-family: "Cactus Classical Serif", serif;

        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #fff;
            font-size: 20px;
            font-family: "Cactus Classical Serif", serif;
        }
        input[type="text"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-family: "Cactus Classical Serif", serif;
        }
        button {
            width: 50%;
            padding: 10px;
            background-color: #83b9fc;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            border: 2px solid transparent;
            font-family: "Cactus Classical Serif", serif;
            font-size: 16px;
            transition: border-color 0.3s, transform 0.3s, box-shadow 0.3s, background-color 0.3s ease;
        }
        button:hover {
            border: 2px solid #f0c320;
            transform: scale(1.10);

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
    <h1>Completa i campi</h1>
    <form action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="LoginClienteManagement.processRegistraCliente">
        <input type="text" name="nome_cliente" placeholder="Nome" required><br>
        <input type="text" name="cognome_cliente" placeholder="Cognome" required><br>
        <input type="text" name="email" placeholder="Telefono" required><br>
        <input type="text" name="telefono" placeholder="Email" required><br>
        <input type="text" name ="user_cliente" placeholder="Username" required><br>
        <input type="text" name ="pass_cliente" placeholder="Password" required><br>
        <button type="submit" value="Registra ospite">Registrati!</button>
    </form>
</div>

</body>
</html>

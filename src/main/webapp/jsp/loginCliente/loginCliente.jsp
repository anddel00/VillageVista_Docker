<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accesso Cliente | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            --primary-color: #1e3a8a; /* Navy Blue */
            --accent-color: #d97706;  /* Oro/Ambra */
            --text-dark: #334155;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        /* --- 2. SFONDO E LAYOUT --- */
        body {
            font-family: var(--font-body);
            color: var(--text-dark);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            /* Usiamo l'immagine del mare come sfondo, oscurata per far risaltare la card */
            background-image: linear-gradient(rgba(15, 23, 42, 0.7), rgba(30, 58, 138, 0.7)), url('images/mare_sfondo.jpeg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        /* Tasto torna al sito pubblico */
        .back-home {
            position: absolute;
            top: 25px;
            left: 25px;
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: opacity 0.3s;
            opacity: 0.8;
        }
        .back-home:hover { opacity: 1; }

        /* --- 3. LOGIN CARD --- */
        .login-card {
            background: white;
            padding: 40px 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 420px;
            text-align: center;
            margin: 20px;
            animation: fadeIn 0.6s ease-out forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo-img {
            width: 120px;
            margin-bottom: 20px;
            border-radius: 8px;
        }

        .login-card h2 {
            font-family: var(--font-headings);
            font-size: 32px;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .login-card p {
            font-size: 15px;
            color: var(--text-muted);
            margin-bottom: 30px;
        }

        /* --- 4. FORM --- */
        .login-form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 14px 15px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-family: var(--font-body);
            font-size: 15px;
            transition: all 0.3s ease;
            background-color: #f8fafc;
            outline: none;
        }

        .login-form input:focus {
            border-color: var(--accent-color);
            background-color: white;
            box-shadow: 0 0 0 4px rgba(217, 119, 6, 0.1);
        }

        .btn-login {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 5px;
            font-family: var(--font-body);
            box-shadow: 0 4px 10px rgba(30, 58, 138, 0.2);
        }

        .btn-login:hover {
            background-color: #172554;
            transform: translateY(-2px);
        }

        /* --- 5. DIVISORE E REGISTRAZIONE --- */
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 25px 0;
            color: var(--text-muted);
            font-size: 14px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e2e8f0;
        }

        .divider::before { margin-right: .5em; }
        .divider::after { margin-left: .5em; }

        .btn-register {
            display: block;
            background-color: white;
            color: var(--accent-color);
            border: 2px solid var(--accent-color);
            padding: 12px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            background-color: var(--accent-color);
            color: white;
            box-shadow: 0 4px 10px rgba(217, 119, 6, 0.2);
        }

        /* --- 6. MEDIA QUERIES --- */
        @media (max-width: 480px) {
            .login-card { padding: 30px 20px; }
            .back-home { top: 15px; left: 15px; font-size: 14px; }
        }
    </style>
</head>
<body>

<a href="Dispatcher?controllerAction=HomeManagement.view" class="back-home">
    ← Torna alla Home
</a>

<div class="login-card">
    <img src="images/Logo.png" alt="VillageVista Logo" class="logo-img" onerror="this.style.display='none'">

    <h2>Benvenuto</h2>
    <p>Accedi per gestire le tue prenotazioni</p>

    <form class="login-form" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="LoginClienteManagement.processLoginCliente">

        <input type="text" name="username" placeholder="Username o Email" required autocomplete="username">
        <input type="password" name="password" placeholder="Password" required autocomplete="current-password">

        <button type="submit" class="btn-login">Accedi</button>
    </form>

    <div class="divider">Nuovo cliente?</div>

    <a href="Dispatcher?controllerAction=LoginClienteManagement.goToRegistraCliente" class="btn-register">
        Registrati ora
    </a>
</div>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Staff - Accesso | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            --dipendente-color: #60a5fa; /* Azzurro più chiaro per contrastare lo scuro */
            --admin-color: #fbbf24;      /* Giallo/Oro più luminoso */
            --text-light: #ffffff;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-body);
            color: var(--text-light);
            min-height: 100vh;
            display: flex;
            flex-direction: row;
        }

        /* --- 2. LAYOUT SPLIT (Responsive) --- */
        .split {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            position: relative;
        }

        /* Gradienti di sfondo più ricchi per esaltare l'effetto vetro */
        .left {
            background: linear-gradient(135deg, #0f172a, #1e3a8a, #3b82f6);
        }

        .right {
            background: linear-gradient(135deg, #451a03, #92400e, #d97706);
        }

        /* --- 3. EFFETTO GLASSMORPHISM --- */
        .login-container {
            /* Sfondo semi-trasparente */
            background: rgba(255, 255, 255, 0.1);

            /* Il trucco magico: sfochiamo ciò che sta dietro */
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px); /* Per Safari */

            /* Bordi sottili semi-trasparenti per simulare il riflesso del vetro */
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-top: 1px solid rgba(255, 255, 255, 0.5);
            border-left: 1px solid rgba(255, 255, 255, 0.5);

            padding: 40px 30px;
            border-radius: 20px;

            /* Ombra marcata per separare il "vetro" dallo sfondo */
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);

            text-align: center;
            width: 100%;
            max-width: 380px;
            position: relative;
            z-index: 10;
        }

        /* Rimuoviamo il border-top massiccio di prima, non serve col vetro */
        /* .login-container-dip { border-top: ... } */
        /* .login-container-admin { border-top: ... } */

        .login-form h2 {
            font-family: var(--font-headings);
            font-size: 36px;
            margin-bottom: 5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3); /* Ombra per leggibilità */
        }

        /* I titoli ora usano i colori brillanti */
        .login-container-dip h2 { color: var(--dipendente-color); }
        .login-container-admin h2 { color: var(--admin-color); }

        .login-form p {
            font-size: 15px;
            color: rgba(255, 255, 255, 0.8); /* Bianco leggermente trasparente */
            margin-bottom: 30px;
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
        }

        /* --- 4. STILE DEI FORM --- */
        .login-form form {
            display: flex;
            flex-direction: column;
            gap: 20px; /* Più spazio tra gli input nel glassmorphism */
        }

        /* Gli input diventano semi-trasparenti per seguire il tema */
        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 14px 15px;
            background: rgba(0, 0, 0, 0.15); /* Sfondo scuro semi-trasparente */
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            font-size: 15px;
            font-family: var(--font-body);
            color: white; /* Testo digitato bianco */
            transition: all 0.3s ease;
            outline: none;
        }

        /* Colore del placeholder (il testo grigio "Username") */
        .login-form input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        /* Effetto Focus sugli input */
        .login-container-dip input:focus {
            border-color: var(--dipendente-color);
            background: rgba(0, 0, 0, 0.3);
            box-shadow: 0 0 10px rgba(96, 165, 250, 0.2);
        }

        .login-container-admin input:focus {
            border-color: var(--admin-color);
            background: rgba(0, 0, 0, 0.3);
            box-shadow: 0 0 10px rgba(251, 191, 36, 0.2);
        }

        /* Pulsanti di invio - Manteniamo i colori accesi per contrastare il vetro */
        .login-form button {
            margin-top: 10px;
            padding: 14px;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            border: none;
            border-radius: 10px;
            color: #1e293b; /* Testo scuro sul bottone chiaro per massimo contrasto */
            font-family: var(--font-body);
            transition: transform 0.2s, background-color 0.3s, box-shadow 0.2s;
        }

        .btn-dipendente {
            background-color: var(--dipendente-color);
            box-shadow: 0 4px 15px rgba(96, 165, 250, 0.4);
        }
        .btn-dipendente:hover {
            background-color: #93c5fd; /* Azzurro ancora più chiaro all'hover */
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(96, 165, 250, 0.6);
        }

        .btn-admin {
            background-color: var(--admin-color);
            box-shadow: 0 4px 15px rgba(251, 191, 36, 0.4);
        }
        .btn-admin:hover {
            background-color: #fcd34d; /* Giallo più chiaro all'hover */
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(251, 191, 36, 0.6);
        }

        /* Pulsante torna alla home */
        .back-home {
            position: absolute;
            top: 20px;
            left: 20px;
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            z-index: 20;
            opacity: 0.7;
            transition: opacity 0.3s;
            text-shadow: 0 1px 3px rgba(0,0,0,0.5);
        }
        .back-home:hover { opacity: 1; }

        /* --- 5. MEDIA QUERIES --- */
        @media (max-width: 768px) {
            body { flex-direction: column; }
            .split { min-height: 50vh; }
        }
    </style>
</head>
<body>

<a href="Dispatcher?controllerAction=HomeManagement.view" class="back-home">← Torna al sito</a>

<div class="split left">
    <div class="login-container login-container-dip">
        <div class="login-form">
            <h2>Dipendente</h2>
            <p>Accedi al pannello operativo</p>

            <form action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="BackofficeLogin.processLoginDipendente">
                <input type="text" name="username" placeholder="Username" required autocomplete="username">
                <input type="password" name="password" placeholder="Password" required autocomplete="current-password">
                <button class="btn-dipendente" type="submit">Accedi</button>
            </form>

        </div>
    </div>
</div>

<div class="split right">
    <div class="login-container login-container-admin">
        <div class="login-form">
            <h2>Amministratore</h2>
            <p>Accedi al pannello di controllo</p>

            <form action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="BackofficeLogin.processLoginAdmin">
                <input type="text" name="username" placeholder="Username" required autocomplete="username">
                <input type="password" name="password" placeholder="Password" required autocomplete="current-password">
                <button class="btn-admin" type="submit">Accedi</button>
            </form>

        </div>
    </div>
</div>

</body>
</html>
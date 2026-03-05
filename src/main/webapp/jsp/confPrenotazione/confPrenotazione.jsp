<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prenotazione Confermata | VillageVista</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700&family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        /* --- 1. CSS VARIABLES --- */
        :root {
            --primary: #1e3a8a;
            --accent: #d97706;
            --bg-page: #f1f5f9;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --font-headings: 'Playfair Display', serif;
            --font-body: 'Inter', sans-serif;
            --success: #10b981;
            --success-light: #d1fae5;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        /* --- 2. LAYOUT CENTRATO --- */
        body {
            font-family: var(--font-body);
            background-color: var(--bg-page);
            color: var(--text-dark);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            /* Sfondo opzionale leggermente sfumato */
            background-image: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
        }

        /* --- 3. SUCCESS CARD --- */
        .success-card {
            background: white;
            padding: 50px 40px;
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.08);
            text-align: center;
            max-width: 500px;
            width: 90%;
            /* Animazione di comparsa morbida e "rimbalzante" */
            opacity: 0;
            transform: scale(0.9);
            animation: popIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
        }

        @keyframes popIn {
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* --- 4. ICONA DI SUCCESSO --- */
        .icon-circle {
            width: 90px;
            height: 90px;
            background-color: var(--success-light);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 25px auto;
            color: var(--success);
        }

        .icon-circle svg {
            width: 45px;
            height: 45px;
            stroke-width: 3;
            stroke-linecap: round;
            stroke-linejoin: round;
            animation: drawCheck 0.5s ease-out 0.4s forwards;
            stroke-dasharray: 100;
            stroke-dashoffset: 100;
        }

        @keyframes drawCheck {
            to { stroke-dashoffset: 0; }
        }

        /* --- 5. TESTI --- */
        .title {
            font-family: var(--font-headings);
            font-size: 32px;
            color: var(--primary);
            margin-bottom: 15px;
            line-height: 1.2;
        }

        .subtitle {
            font-size: 16px;
            color: var(--text-dark);
            font-weight: 600;
            margin-bottom: 10px;
        }

        .description {
            font-size: 15px;
            color: var(--text-muted);
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .info-box {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            padding: 15px;
            border-radius: 12px;
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 35px;
        }
        .info-box strong { color: var(--primary); }

        /* --- 6. BOTTONE --- */
        .btn-home {
            display: inline-block;
            width: 100%;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            padding: 16px 20px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(30, 58, 138, 0.2);
        }

        .btn-home:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(30, 58, 138, 0.3);
        }

        /* --- RESPONSIVE --- */
        @media (max-width: 480px) {
            .success-card { padding: 40px 25px; }
            .title { font-size: 28px; }
            .icon-circle { width: 70px; height: 70px; }
            .icon-circle svg { width: 35px; height: 35px; }
        }
    </style>
</head>
<body>

<div class="success-card">

    <div class="icon-circle">
        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M5 13l4 4L19 7"></path>
        </svg>
    </div>

    <h1 class="title">Prenotazione Confermata!</h1>

    <p class="subtitle">Grazie per aver scelto VillageVista.</p>
    <p class="description">Non vediamo l'ora di darti il benvenuto. Il tuo soggiorno è stato registrato con successo nei nostri sistemi.</p>

    <div class="info-box">
        Potrai consultare tutti i dettagli della prenotazione, inclusi gli orari di check-in e check-out, direttamente nella tua <strong>Area Riservata</strong>.
    </div>

    <a href="Dispatcher?controllerAction=ClienteHomeManagement.view" class="btn-home">
        Vai alla tua Area Riservata
    </a>

</div>

</body>
</html>
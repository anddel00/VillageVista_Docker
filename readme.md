# 🏖️ VillageVista - Cloud-Native PMS & Booking Engine

[![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)](https://www.java.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Render](https://img.shields.io/badge/Render-%23430098.svg?style=for-the-badge&logo=render&logoColor=white)](https://render.com/)

**VillageVista** è una soluzione enterprise completa per la gestione di villaggi turistici. L'applicazione coniuga un potente **PMS (Property Management System)** lato amministrativo con un **Booking Engine** moderno e intuitivo per il cliente finale. 

Il progetto è nato con l'obiettivo di gestire l'intero ciclo di vita del soggiorno: dalla ricerca della disponibilità al checkout, includendo la gestione operativa dello staff.

## 🚀 Key Features

### 🏨 Booking Engine (Area Cliente)
- **Real-time Availability:** Algoritmo di ricerca avanzato per alloggi liberi filtrati per data, capienza e tipologia.
- **Responsive Checkout:** Processo di prenotazione fluido e ottimizzato per dispositivi mobile.
- **Area Riservata:** Gestione dello storico prenotazioni e comunicazioni.

### 📊 PMS Dashboard (Area Admin)
- **Controllo Totale:** Monitoraggio occupazione, gestione anagrafiche e flussi finanziari.
- **Resource Management:** Configurazione alloggi, prezzi e categorie.

### 👥 Staff Portal (Area Dipendenti)
- **Turnistica Dinamica:** Accesso riservato per la consultazione dei turni di lavoro.
- **Permessi Granulari:** Sistema di autorizzazioni basato su ruoli per garantire la sicurezza dei dati.

## 🛠️ Tech Stack & Architecture

L'applicazione segue i principi dello sviluppo **Object-Oriented** e le best practice del software design:

- **Backend:** Java 21+ con pattern **MVC (Model-View-Controller)**.
- **Data Access:** Pattern **DAO (Data Access Object)** con factory per astrazione totale della persistenza.
- **Frontend:** JSP, CSS3 (Custom Grid/Flexbox), JavaScript (ES6).
- **Database:** MySQL 8.0 ospitato su **Aiven Cloud**.
- **DevOps:** Containerizzazione con **Docker**, automazione deploy tramite pipeline **CI/CD** su **Render**.

## 📦 Installazione e Deploy Locale

Per avviare l'intero ecosistema localmente tramite Docker:

```bash
git clone [https://github.com/anddel00/VillageVista_Docker.git](https://github.com/anddel00/VillageVista_Docker.git)
cd VillageVista_Docker
docker-compose up --build


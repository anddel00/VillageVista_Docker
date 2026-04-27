# Schema Logico del Database (VillageVista)

Di seguito è riportato lo schema logico relazionale del database migrato su PostgreSQL.

**CLIENTE** (
&nbsp;&nbsp;&nbsp;&nbsp;<u>num_p</u>: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;nome_cliente: VARCHAR(15), 
&nbsp;&nbsp;&nbsp;&nbsp;cognome_cliente: VARCHAR(15), 
&nbsp;&nbsp;&nbsp;&nbsp;email: VARCHAR(30), 
&nbsp;&nbsp;&nbsp;&nbsp;telefono: VARCHAR(30), 
&nbsp;&nbsp;&nbsp;&nbsp;user_cliente: VARCHAR(45), 
&nbsp;&nbsp;&nbsp;&nbsp;pass_cliente: VARCHAR(45)
)

**ALLOGGIO** (
&nbsp;&nbsp;&nbsp;&nbsp;<u>num_alloggio</u>: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;tipo: VARCHAR(20), 
&nbsp;&nbsp;&nbsp;&nbsp;capienza: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;descrizione: VARCHAR(255), 
&nbsp;&nbsp;&nbsp;&nbsp;prezzo_notte: NUMERIC(10,2)
)

**PRENOTAZIONE** (
&nbsp;&nbsp;&nbsp;&nbsp;<u>num_prenotazione</u>: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;data_checkin: DATE, 
&nbsp;&nbsp;&nbsp;&nbsp;data_checkout: DATE, 
&nbsp;&nbsp;&nbsp;&nbsp;persone: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;alloggio: VARCHAR(50), 
&nbsp;&nbsp;&nbsp;&nbsp;cognome_p: VARCHAR(50), 
&nbsp;&nbsp;&nbsp;&nbsp;totale: NUMERIC(10,2), 
&nbsp;&nbsp;&nbsp;&nbsp;pagato: VARCHAR(20), 
&nbsp;&nbsp;&nbsp;&nbsp;stato: VARCHAR(20), 
&nbsp;&nbsp;&nbsp;&nbsp;*num_alloggio*: INT (FK -> ALLOGGIO), 
&nbsp;&nbsp;&nbsp;&nbsp;*id_cliente*: INT (FK -> CLIENTE)
)

**DIPENDENTE** (
&nbsp;&nbsp;&nbsp;&nbsp;<u>dipid</u>: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;nome_dip: VARCHAR(15), 
&nbsp;&nbsp;&nbsp;&nbsp;cognome_dip: VARCHAR(15), 
&nbsp;&nbsp;&nbsp;&nbsp;cf_dip: CHAR(9), 
&nbsp;&nbsp;&nbsp;&nbsp;data_n: DATE, 
&nbsp;&nbsp;&nbsp;&nbsp;salario: NUMERIC(10,2), 
&nbsp;&nbsp;&nbsp;&nbsp;user_dip: VARCHAR(45), 
&nbsp;&nbsp;&nbsp;&nbsp;pass_dip: VARCHAR(45)
)

**TURNO_LAVORO** (
&nbsp;&nbsp;&nbsp;&nbsp;<u>turno_id</u>: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;ora_inizio: VARCHAR(5), 
&nbsp;&nbsp;&nbsp;&nbsp;ora_fine: VARCHAR(5), 
&nbsp;&nbsp;&nbsp;&nbsp;cognome_turno: VARCHAR(50), 
&nbsp;&nbsp;&nbsp;&nbsp;data_turno: DATE, 
&nbsp;&nbsp;&nbsp;&nbsp;*id_dip_turno*: INT (FK -> DIPENDENTE)
)

**ADMIN** (
&nbsp;&nbsp;&nbsp;&nbsp;<u>num_ad</u>: INT, 
&nbsp;&nbsp;&nbsp;&nbsp;nome_ad: VARCHAR(15), 
&nbsp;&nbsp;&nbsp;&nbsp;cognome_ad: VARCHAR(15), 
&nbsp;&nbsp;&nbsp;&nbsp;user_ad: VARCHAR(45), 
&nbsp;&nbsp;&nbsp;&nbsp;pass_ad: VARCHAR(45)
)

---

*(Nota: Le chiavi primarie sono sottolineate, le chiavi esterne (Foreign Key) sono in corsivo e precedute da un asterisco).*

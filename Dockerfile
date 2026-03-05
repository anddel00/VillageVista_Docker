# ==========================================
# FASE 1: BUILD (Compilazione con Maven)
# ==========================================
# Usiamo un'immagine con Maven e Java 21 preinstallati
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Diciamo a Docker di lavorare in una cartella chiamata /app
WORKDIR /app

# Copiamo prima il pom.xml (aiuta Docker a fare cache delle librerie)
COPY pom.xml .

# Copiamo tutto il codice sorgente
COPY src ./src

# Lanciamo Maven per compilare il file .war (ignoriamo i test per fare prima)
RUN mvn clean package -DskipTests

# ==========================================
# FASE 2: RUN (Esecuzione con Tomcat)
# ==========================================
# Usiamo un'immagine pulita con solo Tomcat 10 e Java 21
FROM tomcat:10.1-jdk21

# Puliamo la cartella di default di Tomcat per evitare conflitti
RUN rm -rf /usr/local/tomcat/webapps/*

# TRUCCO INGEGNERISTICO:
# Copiamo il file .war dalla Fase 1 (build) e lo rinominiamo in ROOT.war
# Tomcat, vedendo "ROOT.war", lo aprirà nell'URL principale (/) senza creare percorsi strani
COPY --from=build /app/target/VillageVista-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Esponiamo la porta 8080 per il web
EXPOSE 8080

# Avviamo Tomcat
CMD ["catalina.sh", "run"]
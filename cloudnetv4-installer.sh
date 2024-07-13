#!/bin/bash

# Überprüfen, ob das Skript als root ausgeführt wird
if [ "$(id -u)" -ne 0 ]; then
  echo "Bitte führen Sie das Script als root aus."
  exit 1
fi

# Begrüßung
echo " /$$$$$$$                      /$$$$$$$$ /$$   /$$   /$$     /$$           /$$          "
echo "| $$__  $$                    | $$_____/| $$$ | $$  | $$    | $$          |__/       "   
echo "| $$  \ $$  /$$$$$$   /$$$$$$$| $$      | $$$$| $$ /$$$$$$  | $$  /$$$$$$  /$$ /$$$$$$$ "
echo "| $$  | $$ |____  $$ /$$_____/| $$$$$   | $$ $$ $$|_  $$_/  | $$ /$$__  $$| $$| $$__  $$"
echo "| $$  | $$  /$$$$$$$|  $$$$$$ | $$__/   | $$  $$$$  | $$    | $$| $$$$$$$$| $$| $$  \ $$"
echo "| $$  | $$ /$$__  $$ \____  $$| $$      | $$\  $$$  | $$ /$$| $$| $$_____/| $$| $$  | $$"
echo "| $$$$$$$/|  $$$$$$$ /$$$$$$$/| $$$$$$$$| $$ \  $$  |  $$$$/| $$|  $$$$$$$| $$| $$  | $$"
echo "|_______/  \_______/|_______/ |________/|__/  \__/   \___/  |__/ \_______/|__/|__/  |__/"
                                                                                        
                                                                                        

echo "Verwenden Sie die Pfeiltasten, um eine Option auszuwählen, und drücken Sie Enter."
echo ""
echo "1) Installieren"
echo "2) Deinstallieren"

menu() {
    local choice
    read -p "Wählen Sie eine Option: " choice
    case $choice in
        1) install_cloudnet ;;
        2) uninstall_cloudnet ;;
        *) echo "Ungültige Auswahl" && menu ;;
    esac
}

install_cloudnet() {
    echo "Starte die Installation..."

    # Update der Paketliste
    echo "Aktualisiere die Paketliste..."
    apt update

    # Installiere wget und unzip
    echo "Installiere wget..."
    apt install -y wget

    echo "Installiere unzip..."
    apt install -y unzip

    # Erstelle das Verzeichnis /home/cloud und wechsle hinein
    echo "Erstelle das Verzeichnis /home/cloud..."
    cd /home
    mkdir -p cloud
    cd cloud

    # Lade CloudNet herunter
    echo "Lade CloudNet herunter..."
    wget https://github.com/CloudNetService/CloudNet/releases/download/4.0.0-RC10/CloudNet.zip

    # Entpacke CloudNet.zip
    echo "Entpacke CloudNet.zip..."
    unzip CloudNet.zip

    # Entferne nicht benötigte Startdateien
    echo "Entferne nicht benötigte Startdateien..."
    rm -r start.bat
    rm -r start.command

    # Mache die start.sh Datei ausführbar
    echo "Mache die start.sh Datei ausführbar..."
    chmod +x start.sh

    # Starte CloudNet
    echo "Starte CloudNet..."
    ./start.sh

    # Abschlussnachricht
    echo "Installation abgeschlossen und CloudNet gestartet."
}


# Deinstallation von CloudNet
uninstall_cloudnet() {
    echo "Starte die Deinstallation..."

    # Lösche das CloudNet-Verzeichnis
    echo "Lösche das Verzeichnis /home/cloud..."
    rm -rf /home/cloud

    # Abschlussnachricht
    echo "Deinstallation abgeschlossen."
}

# Hauptmenü aufrufen
menu

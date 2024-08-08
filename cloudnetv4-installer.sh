#!/bin/bash

# Ueberpruefen, ob das Skript als root ausgefuehrt wird
if [ "$(id -u)" -ne 0 ]; then
  echo "Bitte fuehren Sie das Script als root aus."
  exit 1
fi

# Begruessung
echo " ____            _____       _   _      _       "
echo "|  _ \  __ _ ___| ____|_ __ | |_| | ___(_)_ __  "
echo "| | | |/ _\` / __|  _| | '_ \| __| |/ _ \ | '_ \ "
echo "| |_| | (_| \__ \ |___| | | | |_| |  __/ | | | |"
echo "|____/ \__,_|___/_____|_| |_|\__|_|\___|_|_| |_|"
echo ""
echo "        Thanks for using my script              "
echo "           Discord: dasentlein                  "
                                                                                        
                                                                                        

echo "Verwenden Sie die Pfeiltasten, um eine Option auszuwaehlen, und druecken Sie Enter."
echo ""
echo "1) Installieren"
echo "2) Deinstallieren"

menu() {
    local choice
    read -p "Waehlen Sie eine Option: " choice
    case $choice in
        1) install_cloudnet ;;
        2) uninstall_cloudnet ;;
        *) echo "Ungueltige Auswahl" && menu ;;
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

        echo "Installiere screen..."
    apt install -y screen

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

    # Entferne nicht benoetigte Startdateien
    echo "Entferne nicht benoetigte Startdateien..."
    rm -r start.bat
    rm -r start.command

    # Mache die start.sh Datei ausfuehrbar
    echo "Mache die start.sh Datei ausfuehrbar..."
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

    # Loesche das CloudNet-Verzeichnis
    echo "Loesche das Verzeichnis /home/cloud..."
    rm -rf /home/cloud

    # Abschlussnachricht
    echo "Deinstallation abgeschlossen."
}

# Hauptmenue aufrufen
menu

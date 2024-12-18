#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo "Bitte fuehren Sie das Script als root aus."
  exit 1
fi

clear

echo " ____            _____       _   _      _       "
echo "|  _ \  __ _ ___| ____|_ __ | |_| | ___(_)_ __  "
echo "| | | |/ _\` / __|  _| | '_ \| __| |/ _ \ | '_ \ "
echo "| |_| | (_| \__ \ |___| | | | |_| |  __/ | | | |"
echo "|____/ \__,_|___/_____|_| |_|\__|_|\___|_|_| |_|"
echo "Wählen Sie eine Sprache / Choose a language:"
echo "1) Deutsch"
echo "2) English"

language_menu() {
    local language_choice
    read -p "Option: " language_choice
    case $language_choice in
        1) language="de" ;;
        2) language="en" ;;
        *) echo "Ungültige Auswahl / Invalid choice" && language_menu ;;
    esac
}

language_menu

echo " ____            _____       _   _      _       "
echo "|  _ \  __ _ ___| ____|_ __ | |_| | ___(_)_ __  "
echo "| | | |/ _\` / __|  _| | '_ \| __| |/ _ \ | '_ \ "
echo "| |_| | (_| \__ \ |___| | | | |_| |  __/ | | | |"
echo "|____/ \__,_|___/_____|_| |_|\__|_|\___|_|_| |_|"

if [ "$language" == "de" ]; then
    greeting="Verwenden Sie die Pfeiltasten, um eine Option auszuwählen, und drücken Sie Enter."
    install_option="1) Installieren"
    uninstall_option="2) Deinstallieren"
    choose_option="Wählen Sie eine Option: "
    invalid_choice="Ungültige Auswahl"
    start_install="Starte die Installation..."
    update_packages="Aktualisiere die Paketliste..."
    install_wget="Installiere wget..."
    install_unzip="Installiere unzip..."
    create_dir="Erstelle das Verzeichnis /home/cloud..."
    download_cloudnet="Lade CloudNet herunter..."
    unzip_cloudnet="Entpacke CloudNet.zip..."
    remove_unused="Entferne nicht benötigte Startdateien..."
    make_executable="Mache die start.sh Datei ausführbar..."
    start_cloudnet="Starte CloudNet..."
    installation_complete="Installation abgeschlossen und CloudNet gestartet."
    start_uninstall="Starte die Deinstallation..."
    remove_dir="Lösche das Verzeichnis /home/cloud..."
    uninstall_complete="Deinstallation abgeschlossen."
    install_java="Installiere Java.."
else
    greeting="Use the arrow keys to select an option, and press Enter."
    install_option="1) Install"
    uninstall_option="2) Uninstall"
    choose_option="Choose an option: "
    invalid_choice="Invalid choice"
    start_install="Starting installation..."
    update_packages="Updating package list..."
    install_wget="Installing wget..."
    install_unzip="Installing unzip..."
    create_dir="Creating /home/cloud directory..."
    download_cloudnet="Downloading CloudNet..."
    unzip_cloudnet="Unzipping CloudNet.zip..."
    remove_unused="Removing unnecessary start files..."
    make_executable="Making start.sh executable..."
    start_cloudnet="Starting CloudNet..."
    installation_complete="Installation complete and CloudNet started."
    start_uninstall="Starting uninstallation..."
    remove_dir="Removing /home/cloud directory..."
    uninstall_complete="Uninstallation complete."
    install_java="Installing Java.."
fi

menu() {
    echo "$greeting"
    echo ""
    echo "$install_option"
    echo "$uninstall_option"
    echo ""
    local choice
    read -p "$choose_option" choice
    case $choice in
        1) install_cloudnet ;;
        2) uninstall_cloudnet ;;
        *) echo "$invalid_choice" && menu ;;
    esac
}

install_cloudnet() {
    echo "$start_install"
    echo "$update_packages"
    apt update
    echo "$install_wget"
    apt install -y wget
    echo "$install_unzip"
    apt install -y unzip
    echo "$install_java"
    wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
    sudo dpkg -i jdk-21_linux-x64_bin.deb
    echo "$create_dir"
    cd /home
    mkdir -p cloud
    cd cloud
    echo "$download_cloudnet"
    wget https://github.com/CloudNetService/CloudNet/releases/download/4.0.0-RC11.1/CloudNet.zip
    echo "$unzip_cloudnet"
    unzip CloudNet.zip
    echo "$remove_unused"
    rm -r start.bat
    rm -r start.command
    echo "$make_executable"
    chmod +x start.sh
    echo "$start_cloudnet"
    ./start.sh
    echo "$installation_complete"
}

uninstall_cloudnet() {
    echo "$start_uninstall"
    echo "$remove_dir"
    rm -rf /home/cloud
    rm -r cloudnetv4-installer.sh
    echo "$uninstall_complete"
}

menu

#!/bin/bash

# Vérifier si pip est installé
if ! command -v pip &> /dev/null; then
    echo "pip n'est pas installé. Veuillez l'installer avant d'exécuter ce script."
    exit 1
fi

# Mettre à jour les paquets du système
echo "Mise à jour des paquets du système..."
sudo apt update && sudo apt upgrade -y

# Installer les dépendances système nécessaires
echo "Installation des dépendances système..."
sudo apt install -y python3-dev libmysqlclient-dev libpq-dev build-essential pkg-config

# Installer Flask et ses extensions
echo "Installation des dépendances Flask..."
pip install flask flask-restx flask-bcrypt flask-jwt-extended flask_sqlalchemy flask-testing

# Installer le client pour la base de données
echo "Installation du client de base de données..."
pip install mysqlclient

echo "Tous les packages ont été installés avec succès."

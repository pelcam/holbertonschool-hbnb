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

# Installer pytest et ses extensions
echo "Installation des dépendances de test..."
pip install pytest pytest-flask pytest-mock

# Installer le client pour la base de données
echo "Installation du client de base de données..."
pip install mysqlclient

# Vérification si pytest est installé correctement
if ! command -v pytest &> /dev/null; then
    echo "Erreur : pytest n'a pas pu être installé."
    exit 1
fi

# Afficher un message d'information
echo "Pour exécuter vos tests, utilisez la commande suivante :"
echo "pytest -s -v --disable-warnings"

echo "Tous les packages ont été installés avec succès."

#!/bin/bash

# Vérifier si pip est installé
if ! command -v pip &> /dev/null
then
    echo "pip n'est pas installé. Veuillez l'installer avant d'exécuter ce script."
    exit 1
fi

# Installer les packages Flask et ses extensions
pip install flask flask-restx flask-bcrypt flask-jwt-extended flask_sqlalchemy

echo "Les dépendances Flask ont été installées avec succès."

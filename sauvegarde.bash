#!/bin/bash

# Dossier de destination des sauvegardes
dossier_sauvegarde="/tmp/sauvegarde"

# Création du dossier de sauvegarde s'il n'existe pas
mkdir -p "$dossier_sauvegarde"

# Date et heure pour nommer les fichiers
horodatage=$(date +"%Y-%m-%d_%H-%M-%S")

# Fichier de log
fichier_log="$dossier_sauvegarde/sauvegarde_$horodatage.log"

# Parcourir les utilisateurs dans /home
for utilisateur in /home/*; do
    if [[ -d "$utilisateur" ]]; then
        nom_utilisateur=$(basename "$utilisateur")
        fichier_sauvegarde="$dossier_sauvegarde/${nom_utilisateur}_$horodatage.tar.gz"

        # Sauvegarde avec conservation des permissions
        if tar -czpf "$fichier_sauvegarde" "$utilisateur" 2>> "$fichier_log"; then
            echo "Sauvegarde réussie pour $nom_utilisateur" >> "$fichier_log"
        else
            echo "Échec de la sauvegarde pour $nom_utilisateur" >> "$fichier_log"
        fi
    fi
done

echo "Sauvegarde terminée. Veuillez consultez le fichier log: $fichier_log"

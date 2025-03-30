#!/bin/bash

# Lire tous les noms qui représentent les prénoms et noms de famille
while IFS=' ' read -r premier dernier; do
    # Vérifier que les valeurs ne sont pas vides
    if [[ -z "$premier" || -z "$dernier" ]]; then
        continue
    fi

    # Tout mettre en minuscule
    premier="${premier,,}"
    dernier="${dernier,,}"

    # Créer un premier nom d'utilisateur
    utilisateur="${premier:0:1}${dernier}"
    compteur=1

    # Modifier le nom d'utilisateur si il existe déjà
    while id "$utilisateur" &>/dev/null; do
        utilisateur="${premier:0:1}${dernier}${compteur}"
        compteur=$((compteur + 1))
    done

    # Créer l'utilisateur avec un répertoire personnel
    if useradd -m "$utilisateur"; then
        echo "Le profil : '$utilisateur' a été créé. ($premier) ($dernier)"
    else
        echo "Erreur lors de la création de l'utilisateur '$utilisateur'."
    fi
done

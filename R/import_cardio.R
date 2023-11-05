# Jeu de données `cardio`
#
# description et métadonnées :
#   https://www.kaggle.com/sulianova/cardiovascular-disease-dataset
# données :
# https://www.kaggle.com/datasets/sulianova/cardiovascular-disease-dataset/download?datasetVersionNumber=1
# (il n'est pas possible d'utiliser read() avec cette URL car Kaggle ne permet
# pas le téléchargement direct des données. Il faut les charger manuellement)

# Note : vous n'avez pas besoin d'exécuter ce script ! Les données finales
# `cardio.rds` sont déjà dans le dossier `data` du projet. Il est ici à des fins
# de reproductibilité comme trace du prétraitement qui a été effectué.

# Configuration de l'environnement
SciViews::R("ml", lang = "fr")

# Étape 1 : importation des données ---------------------------------------

cardio_train <- read$csv2("data/data-raw/cardio_train.csv")
attr(cardio_train, "spec") <- NULL
attr(cardio_train, "problems") <- NULL


# Étape 2 : prétraitement des données -------------------------------------

# gender est 1 ou 2, mais on ne sait qui sont les hommes ou les femmes
group_by(cardio_train, gender) %>.%
  ssummarise(., n = fnobs(height), mean_height = fmean(height),
    mean_weight = fmean(weight))
# La taille et la masse moyenne du groupe 1 sont inférieures à celles du groupe
# 2. Donc, en toute logique, le groupe 1 est celui des femmes et le groupe 2
# celui des hommes
cardio_train <- mutate(cardio_train,
  gender = recode_factor(gender, "1" = "femme", "2" = "homme"))
# Pour cardio, nous préférons utiliser les niveaux "présence", "absence"
cardio_train <- mutate(cardio_train,
  cardio = recode_factor(cardio, "0" = "absence", "1" = "présence"))

# Pour les autres variables qualitatives, garder les niveaux 0, 1, 2, ou 3 tels
# quels et convertir seulement en facteurs ordonnés
cardio_train <- smutate(cardio_train, cholesterol = as.ordered(cholesterol),
  gluc = as.ordered(gluc), smoke = as.ordered(smoke), alco = as.ordered(alco),
  active = as.ordered(active))

# Notons que l'age en jours n'est pas très pratique et que la masse n'est très
# probablement pas en kg, mais nous ne changeons pas les unités ici.


# Étape 3 : ajout des labels et des unités --------------------------------

cardio_train <- labelise(cardio_train,
  label = list(
    id = "Identifiant",
    age = "Âge",
    gender = "Genre",
    height = "Hauteur",
    weight = "Masse",
    ap_hi = "Pression systolique",
    ap_lo = "Pression diastolique",
    cholesterol = "Cholestérol",
    gluc = "Glucose",
    smoke = "Fumeur",
    alco = "Alcool",
    active = "Actif",
    cardio = "Maladie cardiovasculaire"
  ),
  units = list(
    age = "jours",
    height = "cm",
    weight = "kg"
  ))
  # Note : unités pour ap_hi et ap_lo non spécifiées (mmHg ?)


# Étape 4 : sous-échantillonnage ------------------------------------------

# Le jeu de données est trop volumineux pour avoir des temps de calcul
# raisonnables dans la machine virtuelle Saturn Cloud. À des fins pédagogiques
# il est préférable de le réduire à environ 3000 items, sélectionnés
# aléatoirement.
set.seed(37412)
cardio <- sample_n(cardio_train, 3000)


# Étape 5 : sauvegarde des données ----------------------------------------

# Sauvegarder la version finale du jeu de données et nettoyer l'environnement
write$rds(cardio, "data/cardio.rds")
rm(cardio_train, cardio)

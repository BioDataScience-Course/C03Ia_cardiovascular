# Classification supervisée pour détecter des patients atteints de maladie cardiovasculaire

## Avant-propos

Ce projet nécessite d'avoir assimilé l'ensemble des notions des trois premiers modules du cours de science des données biologiques 3. Il correspond au dépôt GitHub <https://github.com/BioDataScience-Course/C03Ia_cardiovascular>.

## Objectif

Ce projet est **court**, **individuel** et **cadré**. Il vise à compléter votre apprentissage dans la réalisation, l'interprétation et l'évaluation des performances de classifieurs machine. Dans ce projet, vous devrez :

-   Modifier les proportions des classes dans un set d'apprentissage pour optimiser un classifieur, tout en prenant soin de calculer des métriques non biaisées grâce à la correction des probabilités *a priori*

-   Entraîner et optimiser quatre classifieurs différents (forêt aléatoire et machine à vecteurs supports) entre les deux documents à compléter

-   Comparer des classifieurs et choisir le meilleur

-   Étudier les performances de classifieurs binaires hors choix du seuil de détection grâce aux courbes ROC

## Consignes

Complétez les zones manquantes dans le fichier `cardio_proportions.qmd`. Ensuite, complétez le fichier `cardio_roc.qmd`.

## Informations sur les données

Les données employées (`data/cardiio.rds`) sont un sous-ensemble de 3000 items issus d'un jeu de données nommé `cardio_train.csv` qui reprend 70.000 observations. Les données originales complètes proviennent du site Kaggle sous le nom [**Cardiovascular Disease dataset**](https://www.kaggle.com/datasets/sulianova/cardiovascular-disease-dataset). Dans cet exercice, la taille du jeu de données a été réduite pour diminuer le temps de calcul et vous permettre d'expérimenter différentes options dans un délais raisonnable dans votre machine virtuelle Saturn Cloud.

Des métadonnées sont mises à disposition sur la page Kaggle (il faut toujours bien comprendre à quoi correspondent les différentes variables avant de commencer à analyser un jeu de données).

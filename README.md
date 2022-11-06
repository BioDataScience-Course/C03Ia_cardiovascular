# Exercices pratiques sur la classification supervisée, module 3 du cours de Science des données 3

## Introduction

Les maladies cardiovasculaires font partie des maladies les plus mortelles au monde. Il est de ce fait important de les détecter rapidement.

## Objectif

Ce projet est un projet **individuel**, **cadré** et d'une durée maximale de **2h**.

Dans ce projet, vous devrez :

-   Modifier les proportions de classes dans un set d'apprentissage afin d'optimiser un classifieur, tout en prenant soin de calculer des métriques non biaisées grâce à la correction des probabilités *a priori*

-   Entraîner et optimiser quatre classifieurs différents

-   Comparer les classifieurs et choisir le meilleur

## Consignes

Commencez ce projet par compléter les zones manquantes au sein du fichier `cardio_proportions.Rmd` (1h maximum). Ensuite, complétez le fichier `cardio_roc.Rmd`. Ces fichiers se trouvent dans le dossier `docs/`

Assurez-vous à la fin que vous pouvez compiler une version HTML des fichiers `docs/cardio_proportions.Rmd` et `docs/cardio_roc.Rmd` (bouton 'Knit') sans erreurs. Sinon, corrigez-les avant soumission finale. N'utilisez pas l'argument `echo=FALSE` dans vos chunks. Le code R qui génère les résultats doit rester visible dans la version HTML. Vérifiez que votre dernier commit + push est bien enregistré sur GitHub à la fin de l'exercice.

## Informations sur les données

Les données employées sont un sous-ensemble d'un tableau de données nommées cardio_train.csv qui comprend 70000 observations. Ces données ont été mises à disposition sur le site kaggle sous le nom [*Cardiovascular Disease dataset*](https://www.kaggle.com/datasets/sulianova/cardiovascular-disease-dataset) par Svetlana Ulianova. Aucune précision sur les auteurs et la licence n'est pas disponible. Des métadonnées sont néanmoins mises à disposition.

## Notes

### Plagiat

N'oubliez pas que le plagiat est interdit. Ce projet est individuel. Si jamais vous êtes bloqué et que vous avez fait appel ponctuellement à l'aide d'un de vos collègues ou de vos enseignants, vous devez l'indiquer à l'endroit concerné. On cite généralement un élément venant de quelqu'un d'autre comme (John Doe, comm. pers.) pour "communication personnelle". Citez vos sources. Les différents projets seront comparés pour détecter les copies non renseignées.

### Template

Ce projet est associé au template suivant : <https://github.com/BioDataScience-Course/C03Ia_cardiovascular>

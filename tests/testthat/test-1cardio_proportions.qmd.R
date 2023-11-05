# Vérifications de cardio_proportions.qmd
prop <- parse_rmd("../../cardio_proportions.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("cardio_proportions.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("cardio_proportions.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Feature engineering", "Classifieur initial",
    "Optimisation du rappel", "Discussion et conclusion", "Références")
    %in% (rmd_node_sections(prop) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "import", "importcomment", "clean", "corr",
    "corrcomment", "newvars", "table", "plot", "plotcomment",
    "rforest", "rf_confusion", "rf_metrics", "rf_metrics_corr", "varimp",
    "varimpcomment", "cardio_prop", "rforest2", "rf_confusion2", "rf_metrics2",
    "rf_metrics_corr2")
    %in% rmd_node_label(prop)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(prop))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(prop[[1]]$author != "___")
  expect_true(!grepl("__", prop[[1]]$author))
  expect_true(grepl("^[^_]....+", prop[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", prop[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", prop[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'import' & 'importcomment' : importation des données", {
  expect_true(is_identical_to_ref("import", "names"))
  # Les colonnes dans le tableau `cardio` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'import'.

  expect_true(is_identical_to_ref("import", "classes"))
  # La nature des variables (classe) dans le tableau `cardio` est incorrecte
  # Vérifiez le chunk d'importation des données `import`.

  expect_true(is_identical_to_ref("import", "nrow"))
  # Le nombre de lignes dans le tableau `cardio` est incorrect
  # Vérifiez l'importation des données dans le chunk d'importation `import` et
  # réexécutez-le pour corriger le problème.

  expect_true(is_identical_to_ref("importcomment"))
  # L'interprétation des tableaux de description des données est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'clean' : Nettoyage des données", {
  expect_true(is_identical_to_ref("clean", "names"))
  # Les colonnes dans le tableau `cardio2` remanié ne sont pas celles attendues
  # Votre jeu de données remanié n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'clean'.

  expect_true(is_identical_to_ref("clean", "classes"))
  # La nature des variables (classe) dans le tableau `cardio2` est incorrecte
  # Vérifiez le chunk de remaniement des données `clean`.

  expect_true(is_identical_to_ref("clean", "nrow"))
  # Le nombre de lignes dans le tableau `cardio2` est incorrect
  # Vérifiez le remaniement des données dans le chunk `clean` et réexécutez-le
  # pour corriger le problème.
})

test_that("Chunks 'corr', 'corrcomment' : Corrélation entre attributs", {
  expect_true(is_identical_to_ref("corr"))
  # Le graphique de corrélations n'est pas réalisé ou est incorrect
  # Relisez les consignes et vérifiez votre code concernant ce graphique.

  expect_true(is_identical_to_ref("corrcomment"))
  # L'interprétation du graphique des corrélations est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'newvars' : Calcul de nouvelles variables", {
  expect_true(is_identical_to_ref("newvars", "names"))
  # Les colonnes dans le tableau `cardio2` après ajout de variables calculées ne
  # sont pas celles attendues
  # Vérifiez vos calculs des trois nouvelles variables. Visualisez le tableau
  # obtenu et regarder les nouvelles colonnes pour voir ce qui ne va pas. Ce
  # test échoue si vous n'avez pas bien rempli le code du chunk 'newvars'.

  expect_true(is_identical_to_ref("newvars", "classes"))
  # La nature des variables (classe) dans le tableau `cardio2` après ajout de
  # nouveau attributs est incorrecte
  # Vérifiez le chunk de calcul des données `newvars`.

  expect_true(is_identical_to_ref("newvars", "nrow"))
  # Le nombre de lignes dans le tableau `cardio2` après ajout de variables
  # calculées est incorrect
  # Vérifiez le calcul des données dans le chunk `newvars` et réexécutez-le
  # pour corriger le problème.
})

test_that("Chunks 'table', 'plot', 'plotcomment' : Description des données par rapport à cardio", {
  expect_true(is_identical_to_ref("table"))
  # La table de contingence à double entrée n'est pas réalisé ou est incorrecte
  # Relisez les consignes et vérifiez votre code : vous devez préciser d'abord
  # cardio et puis gender pour obtenir la même table que celle de référence.

  expect_true(is_identical_to_ref("plot"))
  # Le graphique en barres de la présence ou non de maladie cardiovasculaire en
  # fonction de l'âge n'est pas réalisé ou est incorrect
  # Relisez les consignes et vérifiez votre code concernant ce graphique.
  # Vous devez calculer l'âge en années entières en transformant cette variable
  # à l'aide de la fonction `floor()`.

  expect_true(is_identical_to_ref("plotcomment"))
  # L'interprétation du graphique et du tableau est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'rforest', `rf_confusion', 'rf_metrics' & 'rf_metrics_corr' :
  forêt aléatoire", {
  expect_true(is_identical_to_ref("rforest"))
  # Le classifieur forêt aléatoire n'est pas réalisé ou est différent de
  # celui considéré comme optimal par vos enseignants.
  # Les consignes devraient vous guider pour réaliser le même classifieur.

  expect_true(is_identical_to_ref("rf_confusion"))
  # Vous n'avez pas obtenu la même matrice de confusion pour le classifieur
  # forêt aléatoire que vos enseignants, ou vous ne l'avez pas calculée.
  # Vérifiez vos calculs. N'oubliez pas que l'on vous demande de calculer cette
  # matrice de confusion à l'aide de la validation croisée 5 fois.

  expect_true(is_identical_to_ref("rf_metrics"))
  # Le calcul des métriques de performance pour votre classifieur forêt
  # aléatoire n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier. Considérez bien que l'on vous demande de
  # restreindre le nombre de métriques à calculer.

  expect_true(is_identical_to_ref("rf_metrics_corr"))
  # Le calcul des métriques de performance corrigées pour votre classifieur
  # forêt aléatoire n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier. Les probabilités a priori doivent être
  # spécifiées en considérant que la prévalence des maladies cardiovasculaires
  # est de 7%.
})

test_that("Chunks 'varimp', 'varimpcomment' : Importance des variables", {
  expect_true(is_identical_to_ref("varimp"))
  # Le graphique de l'importance des variables n'est pas réalisé ou est
  # incorrect
  # Relisez les consignes et vérifiez votre code concernant ce graphique. Ce
  # graphique est utilisé dans le cours en ligne dans la section sur la forêt
  # aléatoire.

  expect_true(is_identical_to_ref("varimpcomment"))
  # L'interprétation du graphique de l'importance des variables est
  # (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'cardio_prop' : Modification des proportions dans cardio3", {
  expect_true(is_identical_to_ref("cardio_prop", "names"))
  # Les colonnes dans le tableau `cardio3` après modification des propotions ne
  # sont pas celles attendues
  # Vérifiez vos calculs avec over_undersample(). Vous devez indiquer le poids
  # (weight=) de 1 pour la présence et de 1/2 pour absence afin de réduire cette
  # dernière catégorie de moitié. Ce test échoue si vous n'avez pas bien rempli
  # le code du chunk 'cardio_prop'.

  expect_true(is_identical_to_ref("cardio_prop", "classes"))
  # La nature des variables (classe) dans le tableau `cardio3` après
  # modification des proportions est incorrecte
  # Vérifiez le chunk de transformation du jeu de données `cardio_prop`.

  expect_true(is_identical_to_ref("cardio_prop", "nrow"))
  # Le nombre de lignes dans le tableau `cardio3` après modification des
  # proportions est incorrect
  # Vérifiez le calcul des proportions dans le chunk `cardio_prop` et
  # réexécutez-le pour corriger le problème.
})

test_that("Chunks 'rforest2', `rf_confusion2', 'rf_metrics2' & 'rf_metrics_corr2' : forêt aléatoire 2", {
  expect_true(is_identical_to_ref("rforest2"))
  # Le classifieur forêt aléatoire n'est pas réalisé ou est différent de
  # celui considéré comme optimal par vos enseignants.
  # Les consignes devraient vous guider pour réaliser le même classifieur.

  expect_true(is_identical_to_ref("rf_confusion2"))
  # Vous n'avez pas obtenu la même matrice de confusion pour le classifieur
  # forêt aléatoire que vos enseignants, ou vous ne l'avez pas calculée.
  # Vérifiez vos calculs. N'oubliez pas que l'on vous demande de calculer cette
  # matrice de confusion à l'aide de la validation croisée 5 fois.

  expect_true(is_identical_to_ref("rf_metrics2"))
  # Le calcul des métriques de performance pour votre classifieur forêt
  # aléatoire n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier. Considérez bien que l'on vous demande de
  # restreindre le nombre de métriques à calculer.

  expect_true(is_identical_to_ref("rf_metrics_corr2"))
  # Le calcul des métriques de performance corrigées pour votre classifieur
  # forêt aléatoire n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier. Les probabilités a priori doivent être
  # spécifiées en considérant que la prévalence des maladies cardiovasculaires
  # est de 7%.
})

test_that("La partie discussion et conclusion est-elle remplie ?", {
  expect_true(!(rmd_select(prop, by_section("Discussion et conclusion")) |>
    as_document() |> grepl("...votre discussion ici...", x = _,
      fixed = TRUE) |> any()))
  # La discussion et la conclusion ne sont pas faites
  # Remplacez "...votre discussion ici..." par vos phrases de commentaires
  # libres (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})

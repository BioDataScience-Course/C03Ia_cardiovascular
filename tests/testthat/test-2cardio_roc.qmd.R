# Vérifications de cardio_roc.qmd
roc <- parse_rmd("../../cardio_roc.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("cardio_roc.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("cardio_roc.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Forêt aléatoire", "Machine à vecteurs supports",
    "Comparaison des deux classifieurs",
    "Discussion et conclusion", "Références")
    %in% (rmd_node_sections(roc) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "import2", "split", "rf", "rf_mem", "rf_roc",
    "rf_auc", "svm", "svm_mem", "svm_roc", "svm_auc", "roc_compa")
    %in% rmd_node_label(roc)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(roc))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(roc[[1]]$author != "___")
  expect_true(!grepl("__", roc[[1]]$author))
  expect_true(grepl("^[^_]....+", roc[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", roc[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", roc[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunk 'import2' : importation des données", {
  expect_true(is_identical_to_ref("import2", "names"))
  # Les colonnes dans le tableau `cardio2` réimporté ne sont pas celles
  # attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'import2' ou si les données
  # `cardio2` dans cardio_proportions.qmd dont incorrectes. Assurez-vous que les
  # tests de préparation des données dans ce document sont tous passés avant de
  # travailler dans cardio_roc.qmd.

  expect_true(is_identical_to_ref("import2", "classes"))
  # La nature des variables (classe) dans le tableau `cardio2` est incorrecte
  # Vérifiez le chunk d'importation des données `import2`, ainsi que les données
  # dans `data/cardio2.rds`. Assurez-vous que les tests de préparation des
  # données dans ce document sont tous passés avant de travailler dans
  # cardio_roc.qmd.

  expect_true(is_identical_to_ref("import2", "nrow"))
  # Le nombre de lignes dans le tableau `cardio2` est incorrect
  # Vérifiez l'importation des données dans le chunk d'importation `import2` et
  # réexécutez-le pour corriger le problème. Assurez-vous que les tests de
  # préparation des données dans ce document sont tous passés avant de
  # travailler dans cardio_roc.qmd.
})

test_that("Chunk 'split' : séparation en sets d'apprentissage et de test", {
  expect_true(is_identical_to_ref("split", "names"))
  # Les colonnes dans le tableau `cardio2_train` d'apprentissage ne sont pas
  # celles attendues
  # Votre jeu de données splitté n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'split'.

  expect_true(is_identical_to_ref("split", "classes"))
  # La nature des variables (classe) dans le tableau `cardio2_train` est
  # incorrecte
  # Vérifiez le chunk de séparation des données `split`.

  expect_true(is_identical_to_ref("split", "nrow"))
  # Le nombre de lignes dans le tableau `cardio2_train` est incorrect
  # Vérifiez la séparation des données en sets d'apprentissage et de test (2/3 -
  # 1/3 avec stratification sur cardio) dans le chunk `split` et réexécutez-le
  # pour corriger le problème.
})

test_that("Chunks 'rf', `rf_mem', 'rf_roc' & 'rf_auc' : forêt aléatoire et courbes ROC", {
  expect_true(is_identical_to_ref("rf"))
  # Le classifieur forêt aléatoire n'est pas réalisé ou est différent de
  # celui considéré comme optimal par vos enseignants
  # Les consignes devraient vous guider pour réaliser le même classifieur.

  expect_true(is_identical_to_ref("rf_mem"))
  # Vous n'avez pas obtenu la même matrice d'appartenance pour le classifieur
  # forêt aléatoire que vos enseignants, ou vous ne l'avez pas calculée
  # Vérifiez vos calculs.

  expect_true(is_identical_to_ref("rf_roc"))
  # La courbe ROC de votre classifieur forêt aléatoire n'est pas calculée, ou
  # n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier. Vous devez utiliser les métriques tpr et
  # fpr.

  expect_true(is_identical_to_ref("rf_auc"))
  # Le calcul de l'aire sous la courbe ROC pour votre classifieur forêt
  # aléatoire n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier.
})

test_that("Chunks 'svm', `svm_mem', 'svm_roc' & 'svm_auc' : machine à vecteurs supports et courbes ROC", {
  expect_true(is_identical_to_ref("svm"))
  # Le classifieur machine à vecteurs supports n'est pas réalisé ou est
  # différent de celui considéré comme optimal par vos enseignants
  # Les consignes devraient vous guider pour réaliser le même classifieur.

  expect_true(is_identical_to_ref("svm_mem"))
  # Vous n'avez pas obtenu la même matrice d'appartenance pour le classifieur
  # machine à vecteurs supports que vos enseignants, ou vous ne l'avez pas
  # calculée
  # Vérifiez vos calculs.

  expect_true(is_identical_to_ref("svm_roc"))
  # La courbe ROC de votre classifieur machine à vecteurs supports n'est pas
  # calculée, ou n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier. Vous devez utiliser les métriques tpr et
  # fpr.

  expect_true(is_identical_to_ref("svm_auc"))
  # Le calcul de l'aire sous la courbe ROC pour votre classifieur machine à
  # vecteurs supports n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Relisez bien les consignes et corrigez votre code avant de refaire un rendu
  # du document Quarto pour revérifier.
})

test_that("La partie discussion et conclusion est-elle remplie ?", {
  expect_true(!(rmd_select(roc, by_section("Discussion et conclusion")) |>
    as_document() |> grepl("...votre discussion ici...", x = _,
      fixed = TRUE) |> any()))
  # La discussion et la conclusion ne sont pas faites
  # Remplacez "...votre discussion ici..." par vos phrases de commentaires
  # libres (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})

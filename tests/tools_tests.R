# Functions to test projects
# Copyright (c) 2023-2025, Philippe Grosjean (phgrosjean@sciviews.org) &
#   Guyliann Engels (Guyliann.Engels@umons.ac.be)
# Version 3.0.0 - Should use learnitgrid v1.0.0

suppressMessages(library(learnitgrid))
cache_data <- learnitgrid::copy_cache()
sddReporter <- learnitgrid::project_reporter()
learnitgrid::hook_last_chunk()
learnitgrid::hook_record()


# More functions and code ------------------------------------------------

# Nothing for now...
is_identical_to_ref <- function(name, part = NULL, attr = NULL) {
  ref <- read_ref(name)
  res <- read_res(name)

  if (!is.null(part)) {
    ref <- ref[[part]]
    res <- res[[part]]
  }

  if (!is.null(attr)) {
    ref <- attr(ref, attr)
    res <- attr(res, attr)
  }

  if (is.null(res) && is.null(ref))
    structure(FALSE, message = "Both res and ref are NULL")

  isTRUE(all.equal(res, ref))
  # identical(res, ref)
}

# Erreur entre des tests passé sous Mac Os et sous Linux sur SVM

list_round <- function(object, digits = 5) {
  rapply(object, round, classes = "numeric", how = "replace", digits = digits)
}

object_part_round <- function(object, part = "x", digits = 3) {
  res <- learnitgrid::object_part(object = object, part = part)
  list_round(res, digits = digits)
}

# Une empreinte MD5 (ROMD5) ne tolère aucune différence : même après arrondi,
# une valeur proche d'une frontière d'arrondi bascule d'un côté ou de l'autre
# selon la plateforme et le hash change. On enregistre donc des valeurs
# arrondies (RO + fun=) et on les compare avec une tolérance (is_near_ref()).

# Probabilités d'appartenance : dimensions, noms des classes, premières lignes
# (déjà visibles dans le document) et quantiles de chaque colonne
membership_round <- function(object, n = 6,
    probs = seq(0, 1, by = 0.1), digits = 4) {
  object <- as.matrix(object)
  list(
    dim = dim(object),
    colnames = colnames(object),
    head = round(head(object, n = n), digits = digits),
    quantiles = round(apply(object, 2L, quantile, probs = probs,
      names = FALSE), digits = digits)
  )
}

# Courbe ROC (objet ROCR performance) : métriques utilisées et taux de vrais
# positifs interpolés sur une grille fixe de taux de faux positifs, ce qui rend
# la comparaison indépendante du nombre exact de seuils
perf_grid_round <- function(object, grid = seq(0, 1, by = 0.01), digits = 4) {
  stopifnot(inherits(object, "performance"))
  x <- object@x.values[[1L]]
  y <- object@y.values[[1L]]
  list(
    class = class(object),
    x.name = object@x.name,
    y.name = object@y.name,
    y.grid = round(stats::approx(x, y, xout = grid, ties = max)$y,
      digits = digits)
  )
}

# Comparaison avec tolérance absolue (différence moyenne absolue sur les
# valeurs qui diffèrent), au lieu de l'égalité stricte
is_near_ref <- function(name, part = NULL, tolerance = 1e-3) {
  ref <- read_ref(name)
  res <- read_res(name)

  if (!is.null(part)) {
    ref <- ref[[part]]
    res <- res[[part]]
  }

  if (is.null(res) || inherits(res, "try-error") || inherits(ref, "try-error"))
    return(FALSE)

  isTRUE(all.equal(res, ref, tolerance = tolerance, scale = 1))
}


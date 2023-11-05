over_undersample <- function(x, weights = NULL,
  total = round(sum(weights * table(x))), min_warning = 10) {
  stopifnot(is.factor(x))
  levels_x <- levels(x)
  nlevels <- length(levels_x)
  stopifnot(nlevels >= 2)
  # There may not be empty levels
  table_x <- table(x)
  if (any(table_x == 0))
    stop("There may be no empty levels. Use droplevels() first?")
  if (any(table_x < min_warning))
    warning("Some levels have less than ", min_warning, " items.")
  # Default value for weights = get evenly distributed classes
  if (is.null(weights))
    weights <- length(x) / table_x / nlevels
  stopifnot(is.numeric(weights), length(weights) == nlevels)
  stopifnot(length(total) == 1, is.numeric(total), total > 0)
  # This is an error to generate less than min_warning * nlevels items
  if (total < min_warning * nlevels)
    stop("The total cannot be lower than min_warning * number of levels in x")
  # times is the number of times each item must be multiplied to get the desired
  # total number of items with the desired class distribution
  times <- weights / sum(weights * table_x) * total
  # For integer number of times, we replicate, but for fraction, we randomly
  # subsample
  # For the repetition, it is enough to use rep() with times[x] (times is
  # truncated by rep). times[x] selects the number of times each item must be
  # repeated, depending on its class, because the factor object internally
  # stores the levels as integers
  idx <- rep(1:length(x), times = times[x])
  # For the fraction part of times, we need to subsample each level
  frac <- times %% 1
  split_x <- split(1:length(x), x)
  for (i in 1:nlevels) {
    level <- levels_x[i]
    level_idx <- split_x[[level]]
    split_x[[level]] <- sample(level_idx,
      size = round(frac[[i]] * length(level_idx)))
  }
  # All indices are idx + unlisted split_x
  structure(sort(c(idx, unname(unlist(split_x)))), times = times)
}

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

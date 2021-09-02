# Note to future TAs: Consider using the rvest package in this repository so to
# allow students to have a consistent package environment for this course. This
# was not implemented yet only because materials are being made weekly so there
# was not yet a predefined list of packages students need for the course.

# Install packages from CRAN ------------------------------------------------
cran_prerequisites <- c(
  "remotes",
  "distill",
  "here",
  "tidyverse",
  "ggpubr",
  "patchwork",
  "psych",
  "broom",
  "car",
  "effectsize",
  "emmeans"
)

install.packages(cran_prerequisites)

# Install packages from GitHub ------------------------------------------------

# These packages are only available on GitHub. Future TAs, please check if the
# packages here have been released on CRAN, and if so have students install the
# CRAN version instead.
github_prerequisites <- c(
  "crsh/papaja",
)

purrr::map(github_prerequisites, remotes::install_github)

#' This is just a wrapper so you can all aov() and car::Anova() in a single
#' function for specifying ANOVA models with type 2 or 3 sums of squares. There
#' are also tidy() and emmeans() methods implemented below based on the
#' "aov_psyc" class returned by this wrapper function.
aov_psyc <- function(
  formula,
  data = NULL,
  type = 1,
  projections = FALSE,
  qr = TRUE,
  contrasts = NULL, ...) {

  model <- aov(formula, data = data, projections, qr, contrasts, ...)
  structure(
    list(aov = model, car = car::Anova(model, type = type)),
    class = "aov_psyc"
  )

}

#' Tidy an aov_psyc object
tidy.aov_psyc <- function(x, ...) {
  broom::tidy(x[["car"]])
}

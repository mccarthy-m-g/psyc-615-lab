# set default chunk options
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  echo = params$show_output,
  warning = params$show_output,
  message = params$show_output,
  fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
  dpi = 300,
  fig.width = 6,
  fig.asp = 0.618, # 1 / phi
  fig.show = "hold",
  cache.extra = knitr::rand_seed
)

# Function adapted from https://github.com/jacob-long/jtools/blob/master/R/theme_apa.R
apa_legend <- function(position = "topleft") {
  # Choose legend position. APA figures generally include legends that
  # are embedded on the plane, so there is no efficient way to have it
  # automatically placed correctly
  if (position == "topleft") {
    # manually position the legend (numbers being from 0,0 at bottom left of
    # whole plot to 1,1 at top right)
    ggplot2::theme(
      legend.position = c(.05, .95),
      legend.justification = c(.05, .95)
    )
  } else if (position == "topright") {
    ggplot2::theme(
      legend.position = c(.95, .95),
      legend.justification = c(.95, .95)
    )
  } else if (position == "topmiddle") {
    ggplot2::theme(
      legend.position = c(.50, .95),
      legend.justification = c(.50, .95)
    )
  } else if (position == "bottomleft") {
    ggplot2::theme(
      legend.position = c(.05, .05),
      legend.justification = c(.05, .05)
    )
  } else if (position == "bottomright") {
    ggplot2::theme(
      legend.position = c(.95, .05),
      legend.justification = c(.95, .05)
    )
  } else if (position == "bottommiddle") {
    ggplot2::theme(
      legend.position = c(.50, .05),
      legend.justification = c(.50, .05)
    )
  } else if (position == "none") {
    ggplot2::theme(legend.position = "none")
  } else {
    ggplot2::theme(legend.position = position)
  }
}

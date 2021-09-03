knit_assignment <- function(input, ...) {

  yaml_params <- rmarkdown::yaml_front_matter(input)$params
  name <- paste0(yaml_params$lastname, "_", yaml_params$firstname)
  number <- as.character(yaml_params$assignment)

  # Without code --------------------------------------------------------------

  filename <- paste0(name, "_Assignment_", number, ".docx")
  rmarkdown::render(
    input,
    params = list(show_output = FALSE),
    output_file = file.path(dirname(input), filename)
  )

  # With code -----------------------------------------------------------------

  # This appends a code chunk to the document that shows all code output
  # at the end
  input_lines <- stringi::stri_read_lines(input)
  input_echo <- c(
    input_lines,
    "",
    "# Output",
    "",
    "```{r all-output}",
    "mget(ls())",
    "```"
  )

  # Overwrite original Rmd. Note: the reason for overwriting the original
  # rather than copying to a temporary directory is because the here package
  # does not play nice with a temporary directory in this situation. Is this
  # method hackish? Yes, but it works and removes clutter from assignments that
  # might distract students new to R and R Markdown.
  stringi::stri_write_lines(
    input_echo,
    con = input
  )

  # Render assignment with code output
  filename <- paste0(name, "_Assignment_", number, "_OUTPUT.docx")
  rmarkdown::render(
    input,
    params = list(show_output = TRUE),
    output_file = file.path(dirname(input), filename),
    envir = new.env()
  )

  # Restore original Rmd. Again, a hackish but working solution.
  input_lines <- head(stringi::stri_read_lines(input), -6)
  stringi::stri_write_lines(
    input_lines,
    con = input
  )
}

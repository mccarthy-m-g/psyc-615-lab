knit_assignment <- function(input, ...) {

  yaml_params <- rmarkdown::yaml_front_matter(input)$params
  name <- paste0(yaml_params$lastname, "_", yaml_params$firstname)
  number <- as.character(yaml_params$assignment)

  # Without code
  filename <- paste0(name, "_Assignment_", number, ".docx")
  rmarkdown::render(
    input,
    params = list(show_output = FALSE),
    output_file = file.path(dirname(input), filename)
  )
  # With code
  filename <- paste0(name, "_Assignment_", number, "_OUTPUT.docx")
  rmarkdown::render(
    input,
    params = list(show_output = TRUE),
    output_file = file.path(dirname(input), filename)
  )

}

#' This function knits both required files for submitting assignments, with the
#' correct file names and display or hiding of R code. Because students are
#' using the here package for constructing file paths, the best way to make
#' this custom knit function work was to reconstruct the entire project in a
#' temporary directory, modify the temporary version of the input file, then
#' return the correct output in the assignment folder of the original input. As
#' a consequence, the speed of this function depends on the size of the project
#' directory for this lab. Students should be told not to store large files in
#' it for now.
knit_assignment <- function(input, ...) {

  # Temporary project ---------------------------------------------------------

  # Get paths to input project root and input file
  input_proj_root <- here::here()
  input_proj_root_name <- basename(input_proj_root)

  # Copy the entire project to a temporary directory
  temp_proj_root <- withr::local_tempdir()
  fs::dir_copy(input_proj_root, temp_proj_root)
  temp_proj_root <- fs::path(fs::as_fs_path(temp_proj_root), input_proj_root_name)

  # Get path to input file copy in the temporary directory
  input_rel_path  <- stringr::str_remove(input, input_proj_root)
  temp_input      <- fs::path(temp_proj_root, fs::as_fs_path(input_rel_path))

  #withr::local_dir(temp_proj_root)

  # Update temp input file ----------------------------------------------------

  # Parse YAML of input for its params. These are used for constructing the
  # output file name, as well as adding additional YAML parameters before
  # rendering.
  yaml_params <- rmarkdown::yaml_front_matter(input)$params
  name <- paste0(yaml_params$lastname, "_", yaml_params$firstname)
  number <- as.character(yaml_params$assignment)

  # Read lines of the input so that additions can be made to it behind the
  # scenes
  input_lines <- stringi::stri_read_lines(input)

  # Add new parameters to the input YAML that will construct the title page of
  # the rendered output
  input_lines <- c(
    input_lines[1:3],
    "author:",
    "  - name: |",
    "          `r params$firstname` `r params$lastname`",
    "",
    "          Student ID: `r params$studentid`",
    "",
    "          University of Calgary",
    "",
    "          PSYC 615---Lab",
    "",
    "          TAs: `r params$TAs`",
    input_lines[4:length(input_lines)]
  )

  # Overwrite temp input file with updates
  stringi::stri_write_lines(
    input_lines,
    con = temp_input
  )

  # Render assignment without code --------------------------------------------

  filename <- paste0(name, "_Assignment_", number, ".docx")
  rmarkdown::render(
    temp_input,
    params = list(show_output = FALSE),
    output_file = file.path(dirname(input), filename)
  )

  # Update temp input file again ----------------------------------------------

  # Appends a code chunk to the document that shows all code output at the end
  input_lines <- c(
    input_lines,
    "",
    "# All R Output",
    "",
    "```{r all-output}",
    "mget(ls())",
    "```"
  )

  # Overwrite temp input file with updates
  stringi::stri_write_lines(
    input_lines,
    con = temp_input
  )

  # Render assignment with code -----------------------------------------------

  filename <- paste0(name, "_Assignment_", number, "_OUTPUT.docx")
  rmarkdown::render(
    temp_input,
    params = list(show_output = TRUE),
    output_file = file.path(dirname(input), filename),
    envir = new.env()
  )
}

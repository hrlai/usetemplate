#' Create R script from a template
#'
#' Generates an R script from a template
#'
#' @param filename A character string of the filename of R script to be created,
#'   without the `.R` extension.
#' @param path_dest A character string of the destination directory. Defaults to
#'   the current directory.
#' @param path_template A character string of the template script directory.
#'   When it is NULL (the default), it will use the built-in template directory.
#' @param template A character string of the template filename, without the `.R`
#'   extension.
#' @param overwrite Logical; whether to overwrite an existing R script or not.
#'
#' @returns An R script stored in the `path_dest` directory.
#' @export
#'
#' @examples
#' \dontrun{usetemplate("test", template = "test_template")}

usetemplate <- function(
  filename,
  path_dest = ".",
  path_template = NULL,
  template = NULL,
  overwrite = FALSE
) {
  # use the built-in template directory if nothing is supplied
  if (is.null(path_template)) {
    path_template <- system.file("templates", package = "usetemplate")
  }

  path_template_full <- file.path(path_template, paste0(template, ".R"))

  if (!file.exists(path_template_full)) {
    cli::cli_alert_danger("Template not found!")
  }

  path_dest_full <- file.path(path_dest, paste0(filename, ".R"))

  # generate R script
  if (file.exists(path_dest_full)) {
    if (!overwrite) {
      cli::cli_alert_danger(
        "Skipping copy because destination file already exists."
      )
      cli::cli_alert_info("To overwrite, set {.code overwrite = TRUE}")
    } else {
      file.copy(path_template_full, path_dest_full, overwrite = TRUE)
      cli::cli_alert_warning("File overwritten at {path_dest}.")
    }
  } else {
    file.copy(path_template_full, path_dest_full, overwrite = FALSE)
    cli::cli_alert_success("File created at {path_dest}.")
  }
}

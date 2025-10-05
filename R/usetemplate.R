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
    template = NULL) {

  template <- paste0(template, ".R")

  if (is.null(path_template)) {
    path_template <- system.file("templates", template, package = "usetemplate")
  }

  if (path_template == "") {
    cli::cli_alert_danger("Template not found in package.")
  }

  path_dest <- file.path(path_dest, paste0(filename, ".R"))
  file.copy(path_template, path_dest, overwrite = FALSE)

  cli::cli_alert_success("File created at {path_dest}.")
}

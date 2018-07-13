#' @importFrom reticulate import_from_path

# Python parser namespace
py_namespace <- NULL

.onLoad <- function(libname, pkgname) {
  src_path <- system.file(
    "python",
    package = "pdfparse")

  py_namespace <- import_from_path("pdfparse", src_path, convert = FALSE)
  py_namespace <<- py_namespace$parse_pdf_impl
}

#' @title An R wrapper for PDF form extraction
#'
#' @description
#' Parse the Field data from PDF forms and store output into a tibble.
#' Optionally write out to csv file as well.
#'
#' @param filenames Path(s) to the PDF files to extract from
#' @param outfile Path to csv file output (optional)
#'
#' @return tibble of dim [n,m] for n files and m fields
#'
#' @importFrom readr read_csv


#' @export
parse_pdf <- function(filenames, outfile = NULL) {

  # Check filenames for errors and normalize
  filenames <- vapply(filenames, normalizePath, mustWork = TRUE, character(1))

  if (is.null(outfile)) {
    outfile <- tempfile(fileext = ".csv")
  }

  # Call the parser on the files and save to the outfile
  src_path <- system.file("", package = "pdfparse")
  system2(file.path(src_path, "pdfparse"), args = c(filenames, paste("-o", outfile)))



  return(read_csv(outfile))
}

#' @title An R wrapper for PDF form extraction
#'
#' @description
#' Parse the Field data from PDF forms and store output into a tibble
#'
#' @param filenames Path(s) to the PDF files to extract from
#'
#' @return tibble of dim [n,m] for n files and m fields
#'
#' @importFrom tibble as_tibble
#' @importFrom reticulate py_to_r


#' @export
parse_pdf <- function(filenames) {

  # Check filenames for errors and normalize
  filenames <- lapply(filenames, normalizePath, mustWork = TRUE)

  # Call the parser on the files and save to the outfile
  out <- py_namespace$parse_pdf_impl(filenames)

  out <- py_to_r(out)
  
  return(as_tibble(out))
}

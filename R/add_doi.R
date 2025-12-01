#' Add DOIs to References in a Word Document
#'
#' This function reads a Word document containing bibliographic references, fetches their corresponding DOIs
#' via the CrossRef API, and writes a new Word document with the DOIs appended to each reference.
#'
#' @param input_path Character. Path to the input Word document (.docx) containing references.
#'                   Can be absolute (e.g., "C:/Users/.../references.docx") or relative (e.g., "./references.docx").
#' @param output_path Character. Path where the output Word document with DOIs will be saved.
#'                    If the file exists, it will be overwritten.
#' @param reference_lines Numeric. Number of lines from the end of the document to treat as references. Default is 50.
#'                        Only lines with more than 30 characters are processed.
#' @import httr
#' @import jsonlite
#' @import officer
#' @importFrom utils tail URLencode
#' @return Character vector of references with appended DOIs. References that could not be matched return "NA".
#' @export
#'
#' @examples
#' \dontrun{
#' # Basic usage: fetch DOIs for last 50 lines in a Word document
#' add_doi(
#'   input_path  = "E:/references.docx",
#'   output_path = "E:/references_doi.docx",
#'   reference_lines = 50
#' )
#'
#' # Notes:
#' # - input_path must exist and contain references.
#' # - output_path will be overwritten if it exists.
#' # - Some references may return DOI "NA" if not found on CrossRef.
#' }
add_doi <- function(input_path, output_path, reference_lines = 50) {
   doc <- officer::read_docx(input_path)
  doc_text <- officer::docx_summary(doc)$text

  references <- tail(doc_text, reference_lines)
  references <- references[nchar(references) > 30]

  get_doi <- function(reference) {
    query <- paste0("https://api.crossref.org/works?query=", URLencode(reference))
    response <- tryCatch({ httr::GET(query) }, error = function(e) return(NULL))
    if (is.null(response) || httr::http_error(response)) return(NA)

    data <- tryCatch({ jsonlite::fromJSON(httr::content(response, as = "text", encoding = "UTF-8")) }, error = function(e) return(NULL))
    if (is.null(data) || length(data$message$items) == 0) return(NA)

    doi <- data$message$items$DOI[1]
    return(doi)
  }

  updated_references <- vector("character", length(references))
  for (i in seq_along(references)) {
    ref <- references[i]
    doi <- get_doi(ref)
    updated_references[i] <- paste0(ref, " DOI: https://doi.org/", ifelse(is.na(doi), "NA", doi))
  }

  # Print to R console
  print(updated_references)

  # Write to Word document
  doc_out <- officer::read_docx()
  for (line in updated_references) {
    doc_out <- officer::body_add_par(doc_out, line)
  }
  print(doc_out, target = output_path)

  return(updated_references)
}


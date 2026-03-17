#' Get books
#'
#' Retrieves book recommendations from the adem.books table.
#' Optionally filters by skill_id. Returns all books if no
#' skill is provided.
#'
#' @param skill Integer or NULL. The skill_id to filter by e.g. 5.
#'   If NULL, all books are returned.
#'
#' @return A data frame with columns: book_id, title,
#'   author, skill_id. Returns an empty data frame if no
#'   books are found.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Get all books
#' all_books <- get_books()
#'
#' # Get books for a specific skill
#' skill_books <- get_books(skill = 5)
#' }
get_books <- function(skill = NULL) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))
  # Base query
  query <- "SELECT book_id, title, author, skill_id
            FROM adem.books
            WHERE 1=1"
  # Add skill filter if provided
  if (!is.null(skill)) {
    query <- paste(query, glue::glue_sql(
      "AND skill_id = {skill}",
      .con = con
    ))
  }
  result <- DBI::dbGetQuery(con, query)
  return(result)
}

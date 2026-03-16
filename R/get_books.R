#' Get a book by its ID
#'
#' @param book_id The unique identifier of the book.
#' @return A data frame with columns: book_id, title, author, skill_id. Returns NULL if no book is found.
#' @export
get_books <- function(skill = NULL) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  query <- "SELECT book_id, title, author, skill_id
            FROM adem.books
            WHERE 1=1"

  if (!is.null(skill)) {
    query <- paste(query, glue::glue_sql(
      "AND skill_id = {skill}",
      .con = con
    ))
  }

  result <- DBI::dbGetQuery(con, query)
  return(result)
}

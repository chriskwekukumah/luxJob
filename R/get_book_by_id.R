#' Get a book by its ID
#'
#' @param book_id The unique identifier of the book.
#' @return A data frame with columns: book_id, title, author, skill_id. Returns NULL if no book is found.
#' @export
get_book_by_id <- function(book_id) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  query <- glue::glue_sql(
    "SELECT book_id, title, author, skill_id
     FROM adem.books
     WHERE book_id = {book_id}",
    .con = con
  )

  result <- DBI::dbGetQuery(con, query)

  if (nrow(result) == 0) return(NULL)

  return(result)
}

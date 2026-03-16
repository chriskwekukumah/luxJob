
#' Get book recommendation by ID
#'
#' Retrieves a single book recommendation from adem.books
#' table using its book_id. Returns NULL if not found.
#'
#' @param book_id Integer. The ID of the book e.g. 101
#'
#' @return A data frame with columns: book_id, title,
#'   author, skill_id
#'
#' @export
#'
#' @examples
#' \dontrun{
#' book <- get_book_by_id(101)
#' print(book)
#' }
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

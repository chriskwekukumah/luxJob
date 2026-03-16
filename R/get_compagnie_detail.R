#' Get a book by its ID
#'
#' @param book_id The unique identifier of the book.
#' @return A data frame with columns: book_id, title, author, skill_id. Returns NULL if no book is found.
#' @export
get_companies <- function(limit = 100) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  query <- glue::glue_sql(
    "SELECT company_id, name
     FROM adem.companies
     LIMIT {limit}",
    .con = con
  )

  result <- DBI::dbGetQuery(con, query)
  return(result)
}

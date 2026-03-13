get_book_by_id <- function(book_id) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  query <- glue::glue_sql(
    "SELECT book_id, title, author, skill_id
     FROM adem.books
     WHERE book_id = {book_id}",
    .con = con
  )

  result <- dbGetQuery(con, query)

  # Return NULL if not found
  if (nrow(result) == 0) return(NULL)

  return(result)
}

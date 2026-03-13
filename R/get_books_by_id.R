get_book_by_id <- function(book_id) {
  con <- connect_db()
  DBI:: dbGetQuery(con, "SELECT book_id,title,author,skill_id FROM adem.book_recommendations WHERE book_id={book_id} limit 100;")
  DBI::dbDisconnect(con)
}

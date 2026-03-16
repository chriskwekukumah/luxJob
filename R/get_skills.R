#' Get a book by its ID
#'
#' @param book_id The unique identifier of the book.
#' @return A data frame with columns: book_id, title, author, skill_id. Returns NULL if no book is found.
#' @export
get_skill <- function(){
  con <- connect_db()
  DBI:: dbGetQuery(con, "SELECT * From adem.skills limit 100;")
  DBI::dbDisconnect(con)
}






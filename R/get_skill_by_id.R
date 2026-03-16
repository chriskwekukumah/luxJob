#' Get a book by its ID
#'
#' @param book_id The unique identifier of the book.
#' @return A data frame with columns: book_id, title, author, skill_id. Returns NULL if no book is found.
#' @export
get_skill_by_id <- function(skill_id) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  query <- glue::glue_sql(
    "SELECT skill_id, skill_label
     FROM adem.skills
     WHERE skill_id = {skill_id}",
    .con = con
  )

  result <- DBI::dbGetQuery(con, query)
  return(result)
}

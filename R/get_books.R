#' @importFrom DBI dbDisconnect dbGetQuery
get_books <- function(skill = NULL) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  query <- "SELECT book_id, title, author, skill_id
            FROM adem.books
            WHERE 1=1"

  if (!is.null(skill)) {
    query <- paste(query, glue::glue_sql(
      "AND skill_id = {skill}",
      .con = con
    ))
  }

  result <- dbGetQuery(con, query)
  return(result)
}

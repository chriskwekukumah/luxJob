log_search <- function(user_id, query) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  log_query <- glue::glue_sql(
    "INSERT INTO adem.search_logs (user_id, query)
     VALUES ({user_id}, {query})",
    .con = con
  )

  tryCatch({
    dbExecute(con, log_query)
    return(TRUE)
  }, error = function(e) {
    return(FALSE)
  })
}

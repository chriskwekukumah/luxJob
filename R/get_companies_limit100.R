get_companies <- function(limit = 100) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  query <- glue::glue_sql(
    "SELECT company_id, company_name
     FROM adem.companies
     LIMIT {limit}",
    .con = con
  )

  result <- dbGetQuery(con, query)
  return(result)
}

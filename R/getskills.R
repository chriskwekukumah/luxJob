get_skills <- function(limit = 100) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  query <- glue::glue_sql(
    "SELECT skill_id, skill_label
     FROM adem.skills
     LIMIT {limit}",
    .con = con
  )

  result <- dbGetQuery(con, query)
  return(result)
}


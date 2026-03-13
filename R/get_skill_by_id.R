get_skill_by_id <- function(skill_id) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  query <- glue::glue_sql(
    "SELECT skill_id, skill_label
     FROM adem.skills
     WHERE skill_id = {skill_id}",
    .con = con
  )

  result <- dbGetQuery(con, query)
  return(result)
}

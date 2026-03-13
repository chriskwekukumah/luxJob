get_skill_by_id <- function(skill_id) {
  con <- connect_db()
  DBI:: dbGetQuery(con, "SELECT DISTINCT skill_id, skill_label From adem.skills WHERE skill_id = {skill_id}  limit 100;")
  DBI::dbDisconnect(con)
                             }



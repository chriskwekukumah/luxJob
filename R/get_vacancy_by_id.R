get_vacancy_by_id <- function(vacancy_id) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  # Get vacancy info
  vacancy_query <- glue::glue_sql(
    "SELECT *
     FROM adem.vacancies
     WHERE vacancy_id = {vacancy_id}",
    .con = con
  )

  vacancy <- dbGetQuery(con, vacancy_query)

  # Return NULL if vacancy not found
  if (nrow(vacancy) == 0) return(NULL)

  # Get skills required for that vacancy
  skills_query <- glue::glue_sql(
    "SELECT s.skill_id, s.skill_label
     FROM adem.skills s
     JOIN adem.vacancy_skills vs ON s.skill_id = vs.skill_id
     WHERE vs.vacancy_id = {vacancy_id}",
    .con = con
  )

  skills <- dbGetQuery(con, skills_query)

  # Return both as a list
  return(list(
    vacancy = vacancy,
    skills = skills
  ))
}

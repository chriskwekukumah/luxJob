#' Get a vacancy by its ID
#'
#' @param vacancy_id The unique identifier of the vacancy.
#'
#' @return A list with vacancy details and required skills.
#' @export
get_vacancy_by_id <- function(vacancy_id) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  # Get vacancy info
  vacancy_query <- glue::glue_sql(
    "SELECT *
     FROM adem.vacancies
     WHERE vacancy_id = {vacancy_id}",
    .con = con
  )

  vacancy <- DBI::dbGetQuery(con, vacancy_query)

  # Return NULL if vacancy not found
  if (nrow(vacancy) == 0) return(NULL)

  # Get skills required for that vacancy
  skills_query <- glue::glue_sql(
    "SELECT s.skill_id, s.skill_label
     FROM adem.vacancy_skills vs
     JOIN adem.skills s ON vs.skill_id = s.skill_id
     WHERE vs.vacancy_id = {vacancy_id}",
    .con = con
  )

  skills <- DBI::dbGetQuery(con, skills_query)

  return(list(vacancy = vacancy, skills = skills))
}

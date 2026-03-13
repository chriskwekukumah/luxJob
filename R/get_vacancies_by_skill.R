get_vacancies <- function(skill = NULL, company = NULL, canton = NULL, limit = 100) {
  con <- connect_db()
  on.exit(dbDisconnect(con))

  # Start with base query
  query <- "SELECT vacancy_id, company_id, occupation, canton, year, month
            FROM adem.vacancies
            WHERE 1=1"

  # Add filters dynamically if provided
  if (!is.null(skill)) {
    query <- paste(query, glue::glue_sql("AND vacancy_id IN (
                                            SELECT vacancy_id
                                            FROM adem.vacancy_skills
                                            WHERE skill_id = {skill})",
                                         .con = con))
  }

  if (!is.null(company)) {
    query <- paste(query, glue::glue_sql("AND company_id = {company}", .con = con))
  }

  if (!is.null(canton)) {
    query <- paste(query, glue::glue_sql("AND canton = {canton}", .con = con))
  }

  # Add limit at the end
  query <- paste(query, glue::glue_sql("LIMIT {limit}", .con = con))

  result <- dbGetQuery(con, query)
  return(result)
}

#' Get vacancies requiring a specific skill
#'
#' Retrieves all job vacancies that require a given skill from the ADEM database.
#' Returns vacancies ordered by most recent first (year, month DESC).
#'
#' @param con A `DBIConnection` object to the ADEM PostgreSQL database.
#' @param skill_name Character string. Exact `skill_label` from `adem.skills` table.
#'
#' @return A data frame with columns:
#'   \itemize{
#'     \item `vacancy_id`: Unique vacancy identifier
#'     \item `year`: Publication year
#'     \item `month`: Publication month
#'     \item `skill_label`: Matched skill label
#'   }
#'
#' @examples
#' \dontrun{
#' con <- connect_db()
#' get_vacancies_by_skill(con, "communication")
#' DBI::dbDisconnect(con)
#' }
#'
#' @export
get_vacancies_by_skill <- function(con, skill_name) {
  sql <- glue::glue_sql(
    "SELECT DISTINCT v.vacancy_id,
            v.year,
            v.month,
            s.skill_label
     FROM adem.vacancies AS v
     JOIN adem.vacancy_skills AS vs
       ON v.vacancy_id = vs.vacancy_id
     JOIN adem.skills AS s
       ON vs.skill_id = s.skill_id
     WHERE s.skill_label = {skill_name}
     ORDER BY v.year DESC, v.month DESC;",
    .con = con
  )

  DBI::dbGetQuery(con, sql)
}

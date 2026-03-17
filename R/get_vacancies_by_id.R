#' Get vacancies requiring a specific skill
#'
#' Retrieves all job vacancies that require a given skill
#' from the ADEM database by joining adem.vacancies,
#' adem.vacancy_skills and adem.skills tables.
#' Returns vacancies ordered by most recent first
#' (year, month DESC).
#'
#' @param con A \code{DBIConnection} object to the ADEM
#'   PostgreSQL database.
#' @param skill_name Character string. Exact
#'   \code{skill_label} from the \code{adem.skills}
#'   table e.g. "communication".
#'
#' @return A data frame with columns:
#'   \itemize{
#'     \item \code{vacancy_id}: Unique vacancy identifier
#'     \item \code{year}: Publication year
#'     \item \code{month}: Publication month
#'     \item \code{skill_label}: Matched skill label
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' con <- connect_db()
#' vacancies <- get_vacancies_by_skill(con, "communication")
#' print(vacancies)
#' DBI::dbDisconnect(con)
#' }
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

#' Get vacancies
#'
#' Retrieves job vacancies from the adem.vacancies table.
#' Supports optional filtering by skill, company, and canton.
#' Returns up to a specified number of results.
#'
#' @param skill Integer or NULL. The skill_id to filter
#'   vacancies by e.g. 5. If NULL, no skill filter is applied.
#' @param company Integer or NULL. The company_id to filter
#'   vacancies by e.g. 10. If NULL, no company filter is applied.
#' @param canton Character or NULL. The canton name to filter
#'   vacancies by e.g. "Luxembourg". If NULL, no canton filter
#'   is applied.
#' @param limit Integer. Maximum number of rows to return.
#'   Defaults to 100.
#'
#' @return A data frame with columns: vacancy_id, company_id,
#'   occupation, canton, year, month. Returns an empty data
#'   frame if no vacancies are found.
#'
#' @export
#'
#' @importFrom DBI dbDisconnect dbGetQuery
#'
#' @examples
#' \dontrun{
#' # Get all vacancies (up to 100)
#' all_vacancies <- get_vacancies()
#'
#' # Filter by skill and canton
#' filtered <- get_vacancies(skill = 5, canton = "Luxembourg")
#'
#' # Filter by company with custom limit
#' company_vacancies <- get_vacancies(company = 10, limit = 50)
#' }
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
    query <- paste(query, glue::

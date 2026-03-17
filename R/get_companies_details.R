#' Get company details by its ID
#'
#' Retrieves company information and associated vacancies
#' from the adem.companies and adem.vacancies tables
#' using the company_id. Returns NULL if not found.
#'
#' @param company_id Integer. The unique identifier of the
#'   company e.g. 10.
#'
#' @return A named list with two elements: \code{company}
#'   (a data frame with company info) and \code{vacancies}
#'   (a data frame with associated vacancies). Returns NULL
#'   if no company is found.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Get details for company with ID 10
#' details <- get_company_details(10)
#' print(details$company)
#' print(details$vacancies)
#' }
get_company_details <- function(company_id) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))
  company_query <- glue::glue_sql(
    "SELECT *
     FROM adem.companies
     WHERE company_id = {company_id}",
    .con = con
  )
  company <- DBI::dbGetQuery(con, company_query)
  if (nrow(company) == 0) return(NULL)
  vacancy_query <- glue::glue_sql(
    "SELECT *
     FROM adem.vacancies
     WHERE company_id = {company_id}",
    .con = con
  )
  vacancies <- DBI::dbGetQuery(con, vacancy_query)
  return(list(
    company = company,
    vacancies = vacancies
  ))
}

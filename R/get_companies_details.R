#' Get company details by its ID
#'
#' @param company_id The unique identifier of the company.
#' @return A named list with two elements: \code{company} (company info) and \code{vacancies} (associated vacancies). Returns NULL if no company is found.
#' @export
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

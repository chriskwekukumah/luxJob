#' Get a book by its ID
#'
#' @param book_id The unique identifier of the book.
#' @return A data frame with columns: book_id, title, author, skill_id. Returns NULL if no book is found.
#' @export
get_company_details <- function(company_id) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  # Get company info
  company_query <- glue::glue_sql(
    "SELECT *
     FROM adem.companies
     WHERE company_id = {company_id}",
    .con = con
  )

  company <- DBI::dbGetQuery(con, company_query)

  # Return NULL if company not found
  if (nrow(company) == 0) return(NULL)

  # Get vacancies for that company
  vacancy_query <- glue::glue_sql(
    "SELECT *
     FROM adem.vacancies
     WHERE company_id = {company_id}",
    .con = con
  )

  vacancies <- DBI::dbGetQuery(con, vacancy_query)

  # Return both as a list
  return(list(
    company = company,
    vacancies = vacancies
  ))
}

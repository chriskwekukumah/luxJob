#' Get sample companies from ADEM database
#'
#' Retrieves the first 100 companies from the `adem.companies` table.
#' Automatically establishes and closes the database connection.
#'
#' This is a convenience function for quick access to company data during
#' development or exploration. Uses `connect_db()` internally and always
#' closes the connection properly.
#'
#' @return A data frame with company data (up to 100 rows).
#'
#' @examples
#' \dontrun{
#' companies <- get_companies()
#' head(companies)
#' nrow(companies)
#' }
#'
#' @export
get_companies <- function() {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  result <- DBI::dbGetQuery(con, "SELECT * FROM adem.companies LIMIT 100;")
  return(result)
}

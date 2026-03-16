#' Connect to the ADEM PostgreSQL Database
#'
#' @description Establishes a connection to the PostgreSQL database using credentials
#' and host information stored in environment variables.
#'
#' @return A DBI connection object (class `PqConnection`)
#' @export
#'
#' @examples
#' \dontrun{
#' con <- connect_db()
#' DBI::dbListTables(con)
#' DBI::dbDisconnect(con)
#' }
connect_db <- function() {
  DBI::dbConnect(
    RPostgres::Postgres(),
    dbname   = Sys.getenv("DB_NAME"),
    host     = Sys.getenv("DB_HOST"),
    port     = Sys.getenv("DB_PORT"),
    user     = Sys.getenv("DB_USER"),
    password = Sys.getenv("DB_PASSWORD")
  )
}

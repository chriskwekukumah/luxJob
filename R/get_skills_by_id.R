#' Get skill details by ID
#'
#' Retrieves a specific skill from the ADEM database using its unique skill ID.
#' Returns skill information including ID and label.
#'
#' This function automatically establishes a database connection, executes the
#' query, and disconnects when finished. Uses parameterized query via
#' `glue::glue_sql()` for security.
#'
#' @param skill_id Character or integer skill identifier from `adem.skills` table.
#'
#' @return Data frame with columns `skill_id` and `skill_label`. Empty data frame
#'   if skill not found.
#'
#' @examples
#' \dontrun{
#' # Get skill with ID "skill_r"
#' skill_info <- get_skill_by_id("skill_r")
#' print(skill_info)
#'
#' # Returns empty data frame if skill doesn't exist
#' get_skill_by_id("nonexistent_skill")
#' }
#'
#' @export
get_skill_by_id <- function(skill_id) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))

  sql <- glue::glue_sql(
    "SELECT DISTINCT
       skill_id,
       skill_label
     FROM adem.skills
     WHERE skill_id = {skill_id}
     LIMIT 100;",
    .con = con
  )

  result <- DBI::dbGetQuery(con, sql)
  return(result)
}

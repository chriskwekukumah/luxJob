#' Get learning tracks
#'
#' @param skill_id The unique identifier of the skill to filter tracks by.
#' @return A data frame with columns: track_id, title, description, url. Returns all tracks if no skill_id is provided.
#' @export
get_learning_tracks <- function(skill_id = NULL) {
  con <- connect_db()
  on.exit(DBI::dbDisconnect(con))
  # Base query
  query <- "SELECT track_id, title, description, url
            FROM adem.learning_tracks
            WHERE 1=1"
  # Add skill filter if provided
  if (!is.null(skill_id)) {
    query <- paste(query, glue::glue_sql(
      "AND track_id IN (
            SELECT track_id
            FROM adem.learning_track_skills
            WHERE skill_id = {skill_id})",
      .con = con))
  }
  result <- DBI::dbGetQuery(con, query)
  return(result)
}

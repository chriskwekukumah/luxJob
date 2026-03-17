#' Get a learning track by its ID
#'
#' Retrieves a single learning track and its linked skills
#' from the adem.learning_tracks and adem.skills tables
#' using the track_id. Returns NULL if not found.
#'
#' @param track_id Integer. The unique identifier of the
#'   learning track e.g. 3.
#'
#' @return A named list with two elements: \code{track}
#'   (a data frame with columns: track_id, title, description, url)
#'   and \code{skills} (a data frame with columns: skill_id,
#'   skill_label). Returns NULL if no track is found.
#'
#' @export
#'
#' @importFrom DBI dbDisconnect dbGetQuery
#'
#' @examples
#' \dontrun{
#' # Get learning track with ID 3
#' track <- get_learning_track_by_id(3)
#' print(track$track)
#' print(track$skills)
#' }
get_learning_track_by_id <- function(track_id) {
  con <- connect_db()
  on.exit(dbDisconnect(con))
  # First query - get the track
  track_query <- glue::glue_sql(
    "SELECT track_id, title, description, url
     FROM adem.learning_tracks
     WHERE track_id = {track_id}",
    .con = con
  )
  track <- dbGetQuery(con, track_query)
  # Return NULL if not found
  if (nrow(track) == 0) return(NULL)
  # Second query - get linked skills
  skills_query <- glue::glue_sql(
    "SELECT s.skill_id, s.skill_label
     FROM adem.skills s
     JOIN adem.learning_track_skills lts ON s.skill_id = lts.skill_id
     WHERE lts.track_id = {track_id}",
    .con = con
  )
  skills <- dbGetQuery(con, skills_query)
  return(list(
    track = track,
    skills = skills
  ))
}

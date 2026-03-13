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

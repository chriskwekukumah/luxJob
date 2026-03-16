#Testing code for database connection and query execution
devtools::load_all()
# Function 1: connect_db()
con <- connect_db()
con
# Function 2: get_companies()
companies <- get_companies()

library(glue)
library(DBI)

# 1. Define your limit
my_limit <- 100

# 2. Construct the SQL query using glue
sql_query <- glue("SELECT * FROM adem.skills LIMIT {my_limit}")

# 3. Execute against your connection (assuming 'con' is established)
# result <- dbGetQuery(con, sql_query)

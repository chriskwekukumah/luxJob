# LuxJob

An R package to access Luxembourg job market data from the ADEM database.

## Installation
```r
devtools::install_github("chriskwekukumah/luxJob")
```

## Configuration

Create a `.Renviron` file in your project folder:
```
DB_HOST=your_host
DB_NAME=your_database_name
DB_USER=your_username
DB_PASSWORD=your_password
```

Restart RStudio after adding credentials.

## Usage
```r
library(Luxjob)

# Get all skills
skills <- get_skills(limit = 20)

# Get a specific skill
skill <- get_skill_by_id("skill_r")

# Get all companies
companies <- get_companies(limit = 50)

# Get company details
details <- get_company_details(42)
details$company
details$vacancies

# Get vacancies by skill and canton
vacancies <- get_vacancies(
  skill = "skill_python",
  canton = "Luxembourg"
)

# Get learning tracks
tracks <- get_learning_tracks(skill_id = "skill_r")

# Get books
books <- get_books(skill = "skill_python")

# Log a search
log_search(user_id = 1, query = "machine learning jobs")
```
```

**Step 6 — Scroll down and click "Commit new file"** ✅

---

## After committing on GitHub, pull in RStudio:
```
git pull

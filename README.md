# Introduction
Dive into the data job market! Understanding how data analyst roles demand varies across industry by considering multiple parameters like job location, salary averages, work from home salaries and processing the demand cycles. 

For the **SQL Queries** -> check them here: [project_queries_folder](/Project_queries/)



# Backgrounds



# Tools used
# The Analysis

```sql
SELECT
    job_iD, 
    job_title, 
    job_location,
    job_schedule_type, 
    salary_year_avg, 
    job_posted_date,
    name as company_name

FROM 
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id

WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' and 
    salary_year_avg is not NULL

ORDER BY
    salary_year_avg DESC

LIMIT 10

```

# My Learnings


# Conclution

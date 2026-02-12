/*
Ques: What are the most optimal skills to learn ( it's in high demand and high paying )?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security( high demand ) and financial benefits( high salaries), 
    offering strategic insights for career development in data analysis.
*/

with skills_demand as(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        and salary_year_avg is not NULL
        and job_work_from_home = TRUE
        

    GROUP BY
        skills_dim.skill_id
), average_salary as(
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0 ) as avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        and salary_year_avg is not NULL
        and job_work_from_home = TRUE

    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id, 
    skills_demand.skills, 
    demand_count, 
    avg_salary
FROM
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25


-- Consise code for the same above problem: 
SELECT
    skills_dim.skill_id, 
    skills_dim.skills, 
    count(skills_job_dim.job_id) as demand_count, 
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) as avg_salary

FROM job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL
    and job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
having
    count(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC, 
    demand_count DESC
LIMIT 25;
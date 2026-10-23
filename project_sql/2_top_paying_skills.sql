/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT
    job_id,
    job_title,
    salary_year_avg,
    cd.name as company_name
FROM job_postings_fact as jp
LEFT JOIN company_dim as cd
ON jp.company_id = cd.company_id
WHERE
    job_title_short = 'Data Analyst' AND job_location = 'Anywhere'AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
)

SELECT 
    tp.*,
    skills
FROM top_paying_jobs as tp
INNER JOIN skills_job_dim as sj
ON tp.job_id = sj.job_id
INNER JOIN skills_dim as sd
ON sj.skill_id = sd.skill_id
ORDER BY salary_year_avg DESC

/*
Here's the breakdown of the most demanded skills for data analysts in 2023, based on job postings:
SQL is leading with a bold count of 8.
Python follows closely with a bold count of 7.
Tableau is also highly sought after, with a bold count of 6.
Other skills like R, Snowflake, Pandas and Excel show varying degrees of demand.
*/
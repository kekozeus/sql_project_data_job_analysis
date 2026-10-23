/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focus on roles with specified salaries, regardless of location
- Why? It helps reveal how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve
*/


SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM  job_postings_fact as jp
INNER JOIN skills_job_dim as sj
ON jp.job_id = sj.job_id
INNER JOIN skills_dim as sd
ON sj.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25
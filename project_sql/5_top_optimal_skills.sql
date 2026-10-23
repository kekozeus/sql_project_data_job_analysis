/*
Question: What are the most optimal skills to learn (aka it's in high demand and high-paying skill?)
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions wuith specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sj.job_id) AS demand_count
    FROM  job_postings_fact as jp
    INNER JOIN skills_job_dim as sj
    ON jp.job_id = sj.job_id
    INNER JOIN skills_dim as sd
    ON sj.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND job_work_from_home = True
        AND salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id, sd.skills
), average_salary AS (
    SELECT
        sj.skill_id,
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
        sj.skill_id
)

SELECT
    sde.skill_id,
    sde.skills,
    demand_count,
    avg_salary
FROM
    skills_demand AS sde
INNER JOIN average_salary AS asa
ON sde.skill_id = asa.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 20

/*Find the count of the number of remote job postings per skill
-Display the top 5 skills by their demand in remote jobs
-Include skill ID, name, and count of postings requirin the skill
*/
WITH remote_job_skill AS (
SELECT
    skills_to_job.skill_id,
    COUNT(*) as skill_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact as job_postings
ON skills_to_job.job_id = job_postings.job_id
WHERE
    job_postings.job_work_from_home = True AND job_postings.job_title_short = 'Data Analyst'
GROUP BY 
    skills_to_job.skill_id
)
SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skill
INNER JOIN skills_dim as skills on skills.skill_id = remote_job_skill.skill_id
ORDER BY
    skill_count DESC
LIMIT 5
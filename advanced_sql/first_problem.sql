/*
This query retrieves the names of companies, job IDs, job health insurance status, and the quarter in which the jobs were posted for all job postings that were posted in the second quarter of 2023 and offer health insurance. The results are ordered by company name.
*/

SELECT DISTINCT
    company.name as company_name,
    jobs.job_title,
    jobs.job_health_insurance,
    EXTRACT(QUARTER FROM jobs.job_posted_date) AS quarter
FROM job_postings_fact AS jobs
JOIN company_dim AS company
    ON jobs.company_id = company.company_id
WHERE EXTRACT(YEAR FROM jobs.job_posted_date) = 2023
  AND EXTRACT(QUARTER FROM jobs.job_posted_date) = 2
  AND jobs.job_health_insurance = 'Yes'
ORDER BY company.name
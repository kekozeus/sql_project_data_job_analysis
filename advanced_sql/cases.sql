/* 
Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York' jobs as 'Local'
- Otherwise 'Onsite'
*/
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_type
FROM
    job_postings_fact
GROUP BY
    location_type


SELECT * FROM job_postings_fact
LIMIT 4 OFFSET 50;

SELECT
    job_title,
    job_location,
    CASE
        WHEN salary_year_avg < 50000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN 'Medium'
        ELSE 'High'
    END AS salary_range
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
LIMIT 10;
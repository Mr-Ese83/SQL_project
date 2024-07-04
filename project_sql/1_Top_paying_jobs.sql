-- Query: Top-Paying Jobs Overall
/*This query retrieves the top 10 highest-paying job titles along with their average annual salary,
job location, and job schedule type from the job_posting_fact table.
It excludes records where the average annual salary is NULL and 
orders the results by salary in descending order.
*/
SELECT 
    job_title_short,    -- The short title of the job
    salary_year_avg,    -- The average annual salary for the job
    job_location,       -- The location where the job is based
    job_schedule_type   -- The type of schedule for the job (e.g., full-time, part-time)
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;


/*
Query: Top 10 Highest-Paying Jobs by Company
-- This query retrieves job titles, their average annual salary, the company name,
and the job location from the job_posting_fact table.
-- It performs a LEFT JOIN with the company_dim table to include the company name for each job posting.
-- It filters out job postings with NULL salaries and orders the results by 
salary in descending order to get the highest-paying jobs.
-- The results are limited to the top 10 highest-paying job postings.
*/


SELECT 
    company_dim.name AS company_name,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_title_short,
    job_postings_fact.job_title,
    job_postings_fact.job_location
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;




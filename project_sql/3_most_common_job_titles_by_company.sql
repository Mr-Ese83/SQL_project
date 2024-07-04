-- Query: Most Common Job Titles by Company
/* This query finds the most common job titles posted by each company.
   It groups the job postings by company and job title, and counts the number of postings for each combination.
   Finally, it orders the results by count of job postings in descending order.
*/
SELECT 
    company_dim.name AS company_name,
    job_postings_fact.job_title_short,
    COUNT(*) AS job_posting_count
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
GROUP BY company_dim.name, job_postings_fact.job_title_short
ORDER BY job_posting_count DESC;

-- Question: What are the top 10 highest-paying job titles, which companies are offering these jobs, and what skills are required for these positions?

-- This query retrieves the top 10 highest-paying job titles, including the company name, average annual salary, and required skills.
-- It first defines a Common Table Expression (CTE) to select the top 10 highest-paying jobs.
-- Then, it joins the results with the skills tables to get the required skills for these positions.
-- Finally, it orders the results by salary in descending order and limits the final output to 10 rows.


WITH top_paying AS(
    SELECT 
        company_dim.name AS company_name,
        job_postings_fact.salary_year_avg,
        job_postings_fact.job_title_short,
        job_postings_fact.job_title,
        job_postings_fact.job_location,
        job_postings_fact.job_id
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE salary_year_avg IS NOT NULL 
    ORDER BY salary_year_avg DESC
  


)
SELECT 
    top_paying.company_name,
    top_paying.job_title_short,
    top_paying.salary_year_avg,
    skills_dim.skills
FROM top_paying
INNER JOIN skills_job_dim ON top_paying.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 10;




-- Question: What are the top 10 highest-paying 'Data Analyst' job titles that work from home(REMOTE), 
--which companies are offering these jobs, and what skills are required for these positions?

-- This query retrieves the top 10 highest-paying 'Data Analyst' job titles that are location flexible,
-- including the company name, job title, average annual salary, and required skills.
-- It first defines a Common Table Expression (CTE) to select the top 10 highest-paying 'Data Analyst' jobs.
-- Then, it joins the results with the skills tables to get the required skills for these positions.
-- Finally, it orders the results by salary in descending order and limits the final output to 10 rows.

WITH top_paying AS(
    SELECT 
        company_dim.name AS company_name,
        job_postings_fact.salary_year_avg,
        job_postings_fact.job_title_short,
        job_postings_fact.job_title,
        job_postings_fact.job_work_from_home,
        job_postings_fact.job_id
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst'
    AND job_work_from_home = 'True'
    ORDER BY salary_year_avg DESC
    


)
SELECT 
    top_paying.company_name,
    top_paying.job_title_short,
    top_paying.job_title,
    top_paying.salary_year_avg,
    skills_dim.skills
FROM top_paying
INNER JOIN skills_job_dim ON top_paying.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 30;



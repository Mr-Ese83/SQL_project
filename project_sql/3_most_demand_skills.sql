/*This query identifies the top 20 most in-demand skills across different job titles 
based on the number of job postings.
It determines which skills are most frequently required for each job title by counting 
the occurrences of each skill-job title combination.
*/



WITH count_posting AS(
    SELECT 
        job_postings_fact.job_title_short,
        skills_job_dim.skill_id,
        COUNT(*) AS number_of_count
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY skill_id,job_postings_fact.job_title_short
    
)
SELECT 
    count_posting.job_title_short,
    skills_dim.skills,
    count_posting.number_of_count
FROM count_posting
INNER JOIN skills_dim ON count_posting.skill_id = skills_dim.skill_id
ORDER BY number_of_count DESC
LIMIT 10;



/* 
   This query identifies the top 10 most in-demand skills for remote Data Analyst positions.
   It counts the number of job postings that require each skill for remote Data Analyst jobs and ranks the skills by their frequency.
   The query uses a Common Table Expression (CTE) to first calculate the number of job postings for each combination of job title, skill, and remote work status.
   Then, it selects the top 10 skills required for remote Data Analyst positions based on the count of job postings.
*/




WITH count_posting AS(
    SELECT 
        job_postings_fact.job_title_short,
        skills_job_dim.skill_id,
        job_postings_fact.job_work_from_home AS remote_workers,
        COUNT(*) AS number_of_count
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY skill_id,job_postings_fact.job_title_short,remote_workers
    
)
SELECT 
    count_posting.job_title_short,
    skills_dim.skills,
    count_posting.number_of_count
FROM count_posting
INNER JOIN skills_dim ON count_posting.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND count_posting.remote_workers = 'True'
ORDER BY number_of_count DESC
LIMIT 10;







/*
    Analysis: Top Skills for Remote Data Analyst Positions
    Question: Which skills are most frequently required for remote Data Analyst job postings?
    
    This query identifies the top 10 skills most frequently required for remote Data Analyst positions.
    It counts the number of job postings that list each skill and ranks the skills by their frequency.
*/

SELECT 
    job_postings_fact.job_title_short,
    skills_dim.skills,
    COUNT(*) AS count_job 
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 'True'
GROUP BY job_postings_fact.job_title_short,skills_dim.skills
ORDER BY count_job DESC 
LIMIT 10;










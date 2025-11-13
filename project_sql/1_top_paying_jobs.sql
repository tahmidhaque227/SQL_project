SELECT
    job_id,
    job_title,
    salary_year_avg,
    name as company_name
from job_postings_fact
left join company_dim on job_postings_fact.company_id=company_dim.company_id
where job_title_short='Data Engineer' and job_location='Anywhere' and salary_year_avg is not null
order by salary_year_avg DESC
limit 10;

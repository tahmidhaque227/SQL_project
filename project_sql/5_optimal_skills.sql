with skills_demand as (
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Engineer'and  salary_year_avg is not null
group by skills_dim.skill_id
), average_salary as (
SELECT 
    skills_job_dim.skill_id,
    round(Avg(salary_year_avg)) as avg_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Engineer' and salary_year_avg is not null
group by skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from skills_demand
inner join average_salary on skills_demand.skill_id=average_salary.skill_id 
order by 
    demand_count DESC,
    avg_salary DESC
limit 25;    

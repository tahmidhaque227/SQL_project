# Introduction
This project uncovers key **Data Engineering job trends** using SQL — revealing which roles pay the most, which skills are in highest demand, and which technologies drive top salaries. 💼 It’s a data-driven roadmap for anyone aiming to level up their data engineering career. 🚀

🔍Take a look at the SQL queries out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data engineering job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others' work to find optimal jobs.

Data hails from [Luke Barousse SQL Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data engineer jobs?  
2. What skills are required for these top-paying jobs?  
3. What skills are most in demand for data analysts?  
4. Which skills are associated with higher salaries?  
5. What are the most optimal skills to learn?

## 🛠️ Tools I Used
For my deep dive into the data engineering job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.  
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.  
- **Visual Studio Code:** My go-to for database management and executing SQL queries.  
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data engineering job market. Here's how I approached each question:

### 1. Top paying Data Engineering jobs
To uncover the top-paying positions, I analyzed data engineering jobs based on their average annual salary and location, with an emphasis on remote opportunities. This query showcases some of the most lucrative roles available in the field.

```sql
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
```
Here's the breakdown of the top data engineering jobs in 2023:

- *Engtal* offers the highest-paying Data Engineer roles, reaching up to $325,000 per year.

- Data Engineer and Staff Data Engineer positions dominate the top-paying list, showing strong demand in core engineering roles.

- Top companies like Meta, Twitch, and Signify Technology also offer salaries above $240,000 annually, reflecting competitive pay for senior data positions.

![Top Paying Roles](assets\1_top_paying_roles.png)
*Bar graph visualizing the salary for the top paying data engineering roles. Gemini generated this graph from my SQL query results.*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the
top-paying jobs, I joined the job postings with
the skills data, providing insights into what
employers value for high-compensation roles.

```sql
with top_paying_jobs as(
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name as company_name
from job_postings_fact
left join company_dim on job_postings_fact.company_id=company_dim.company_id
where job_title_short='Data Engineer'  and job_location='Anywhere' and salary_year_avg is not null
order by salary_year_avg DESC
limit 10
)
SELECT 
    top_paying_jobs.*,
    skills
from top_paying_jobs
inner join skills_job_dim on top_paying_jobs.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
order by salary_year_avg desc
```
Here is a breakdown of the skills required for the top-paying jobs:

- **Core Technology Demand:** Python (7 mentions), Spark (5 mentions), and Hadoop (3 mentions) are the three most frequently required skills.

- **Role Dominance:** The Data Engineer role is the most prevalent in this high-compensation bracket, dominating the overall required skills profile.

- **Skill Diversity:** The 10 job postings collectively require a total of 22 distinct skills, highlighting the need for a broad and specialized expertise.


![Top Paying Jobs Skills](assets\2_top_paying_jobs_skills.png)
*Bar graph visualizing the top paying skills for the data engineering roles. ChatGPT generated this graph from my SQL query results.*

### 3. In-demand skills for Data Engineering
This data analysis provides a comprehensive overview of the high-value job market, contrasting the top-paying jobs and the specialized skills they require (like Python and Spark) with the overall most demanded skills in the wider industry.

```sql
SELECT 
    skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Engineer'
group by skills
order by demand_count DESC
limit 5;
```
- **Foundational Languages:** SQL and Python are the two most required skills overall.

- **Cloud Market:** AWS and Azure show a massive, near-equal volume of demand.

- **Big Data:** Spark is the leading high-volume requirement for advanced processing

![In-demand skills](assets\3_top_demanded_skills.png)
*Bar graph visualizing the top in-demand skills for the data engineering roles. Gemini generated this graph from my SQL query results.*

### 4. Skills based on Salary
This data details the top 25 highest-paying skills in the market, based on the average annual salary associated with job postings requiring each skill.

```sql
SELECT 
    skills,
    round(Avg(salary_year_avg)) as avg_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Engineer' and salary_year_avg is not null
group by skills
order by avg_salary DESC
limit 25;
```
- **Highest-Paying Skill:** The top-paying skill is Node, with an average salary of $\$181,862$.
- **Specialization Pays More:** Highest salaries are commanded by niche, specialized technologies, not general, high-demand skills.
- **High Salary Floor:** All top 25 skills are highly valuable, with the minimum average salary still exceeding $\$140,000$

![Top Paying Skils](assets\4_top_paying_skills.png)

*Table of the average salary for the top 10 skills for data engineering*

### 5. Most Optimal Skills to Learn
This data identifies the 25 optimal skills by finding the best balance between high demand and high average salary.

```sql
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
```

- **Top Balance:** SQL and Python are the most balanced for high demand and high salary.

- **Scarcity Premium:** Skills with lower demand (like Spark) often lead to slightly higher average salaries.

- **High Compensation:** All 25 optimal skills are highly compensated, with a salary floor above $119,000.

![Top Optimal Skills](assets\5_optimal_skills.png)
*Table of the most optimal skills for data engineer*


# What I Learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table
maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG () into my data-summarizing sidekicks. 

- **Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusion


### Insights
1. **Top-Paying Data Engineering Jobs**: The highest-paying jobs for data engineers.
2. **Skills for Top-Paying Jobs**: High-paying data engineering jobs require advanced proficiency in Python, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is the most demanded skill in the data engineering job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as NODE and Mongo, are associated with the highest average salaries, indicating a premium on niche expertise. I
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data engineers to learn to maximize their market value.
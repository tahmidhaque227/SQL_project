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

/*
Here are insights from the Data Engineer skill analysis (2023 job postings):

Python dominates — It’s the most in-demand skill, appearing in nearly all postings.

Big data frameworks like Spark, Hadoop, and Kafka are essential for modern data pipelines.

Programming diversity — While Python leads, Scala, Go, and Java indicate value in language versatility.

Data handling & analysis tools such as Pandas, NumPy, and PySpark are key for data transformation and manipulation.

Cloud and DevOps integration — Tools like Kubernetes, Databricks, AWS, and GCP show a shift toward cloud-based, scalable infrastructure.

SQL remains relevant, highlighting the ongoing importance of structured data management.

[
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "python"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "spark"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "pandas"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "numpy"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "pyspark"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "hadoop"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "kafka"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "kubernetes"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "python"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "spark"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "pandas"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "numpy"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "pyspark"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "hadoop"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "kafka"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "salary_year_avg": "325000.0",
    "company_name": "Engtal",
    "skills": "kubernetes"
  },
  {
    "job_id": 270455,
    "job_title": "Data Engineer",
    "salary_year_avg": "300000.0",
    "company_name": "Durlston Partners",
    "skills": "sql"
  },
  {
    "job_id": 270455,
    "job_title": "Data Engineer",
    "salary_year_avg": "300000.0",
    "company_name": "Durlston Partners",
    "skills": "python"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "company_name": "Twitch",
    "skills": "spark"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "company_name": "Twitch",
    "skills": "hadoop"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "company_name": "Twitch",
    "skills": "kafka"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "company_name": "Twitch",
    "skills": "tensorflow"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "company_name": "Twitch",
    "skills": "keras"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "salary_year_avg": "251000.0",
    "company_name": "Twitch",
    "skills": "pytorch"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "python"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "scala"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "databricks"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "spark"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "AI Startup",
    "skills": "python"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "AI Startup",
    "skills": "scala"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "AI Startup",
    "skills": "r"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "AI Startup",
    "skills": "azure"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "python"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "scala"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "databricks"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "salary_year_avg": "250000.0",
    "company_name": "Signify Technology",
    "skills": "spark"
  },
  {
    "job_id": 151972,
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "company_name": "Movable Ink",
    "skills": "nosql"
  },
  {
    "job_id": 151972,
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "company_name": "Movable Ink",
    "skills": "aws"
  },
  {
    "job_id": 151972,
    "job_title": "Principal Data Engineer (Remote)",
    "salary_year_avg": "245000.0",
    "company_name": "Movable Ink",
    "skills": "gcp"
  },
  {
    "job_id": 204320,
    "job_title": "Staff Data Engineer",
    "salary_year_avg": "245000.0",
    "company_name": "Handshake",
    "skills": "go"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "company_name": "Meta",
    "skills": "sql"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "company_name": "Meta",
    "skills": "python"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "company_name": "Meta",
    "skills": "java"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "salary_year_avg": "242000.0",
    "company_name": "Meta",
    "skills": "perl"
  }
]
*/
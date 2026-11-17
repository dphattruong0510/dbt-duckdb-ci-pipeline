WITH job_postings AS ( 
    SELECT * 
    FROM {{ ref('job_postings') }}
)

SELECT
  DATE_TRUNC('month', search_date) AS month,
  search_term,
  COUNT(*) AS postings
FROM job_postings
GROUP BY
   DATE_TRUNC('month', search_date),
   search_term
ORDER BY 
  month, 
  search_term
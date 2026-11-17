WITH totals AS (
    SELECT 
        month, 
        SUM(postings) AS total_postings
    FROM {{ ref('jobs_per_month') }}
    GROUP BY month
),
remote AS (
    SELECT 
        DATE_TRUNC('month', search_date) AS month, 
        COUNT(*) AS remote_postings
    FROM {{ ref('job_postings') }}
    WHERE 
        job_work_from_home IS TRUE
    GROUP BY    
       DATE_TRUNC('month', search_date)
)

SELECT
    a.month, 
    total_postings,
    remote_postings,
    ROUND(100.0 * remote_postings/total_postings, 1) AS pct_remote
FROM 
    totals a
LEFT JOIN 
    remote b 
ON a.month = b.month
ORDER BY 
    month 

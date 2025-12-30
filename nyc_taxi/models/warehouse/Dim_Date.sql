{{ config(
    materialized='table',
    schema='analtycal'
) }}

WITH Digits AS (
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
Numbers AS (
    SELECT 
        d4.n*10000 + d3.n*1000 + d2.n*100 + d1.n*10 + d0.n AS n
    FROM Digits d0
    CROSS JOIN Digits d1
    CROSS JOIN Digits d2
    CROSS JOIN Digits d3
    CROSS JOIN Digits d4
),
dates AS (
    SELECT DATEADD(day, n, CAST('20080101' AS date)) AS full_date
    FROM Numbers
)

SELECT
    -- YYYYMMDD numeric key (safe math, no string conversion)
    (YEAR(full_date) * 10000) 
        + (MONTH(full_date) * 100) 
        + DAY(full_date) AS date_key,

    full_date,
    YEAR(full_date)  AS year,
    MONTH(full_date) AS month,
    DAY(full_date)   AS day,
    DATEPART(ISO_WEEK, full_date) AS week,
    DATENAME(weekday, full_date)  AS day_name,
    CASE WHEN MONTH(full_date) <= 6 THEN 'H1' ELSE 'H2' END AS half_year,
    DATEPART(quarter, full_date)  AS quarter,
    DATEPART(dayofyear, full_date) AS day_of_year,

    CASE 
        WHEN DATENAME(weekday, full_date) IN ('Saturday','Sunday') THEN 0
        ELSE 1
    END AS is_weekday,

    CASE 
        WHEN MONTH(full_date) = 12 AND DAY(full_date) = 25 THEN 1
        ELSE 0
    END AS is_holiday

FROM dates
WHERE full_date <= CAST(GETDATE() AS date)
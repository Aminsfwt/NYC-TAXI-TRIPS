{{ config(
    materialized='table',
    schema='analtycal'
) }}

WITH dim_payments AS
(
    SELECT
        payment_id,
        payment_method
    FROM {{ref('stg_payments')}}    
)
select 
    ROW_NUMBER() OVER(ORDER BY payment_id) AS payment_key,
    *,
    GETDATE() AS load_date 
FROM dim_payments
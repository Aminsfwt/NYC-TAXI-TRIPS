{{ config(
    materialized='table',
    schema='analtycal'
) }}

WITH dim_rates AS
(
    select
        rate_id,
        rate_code
    from {{ref('stg_rates')}}    
)
select
    ROW_NUMBER() OVER(ORDER BY rate_id) AS rate_key,
    rate_id,
    rate_code,
    GETDATE() AS load_date 
from dim_rates    


-- Staging rates table 

with src_rate AS
(
    select 
        rate_id,
        rate_code
    FROM {{source('src_data', 'Rates')}}   
)

select * from src_rate;
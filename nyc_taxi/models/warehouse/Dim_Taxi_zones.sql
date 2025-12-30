{{ config(
    materialized='table',
    schema='analtycal'
) }}

with dim_taxi_zones AS
(
    SELECT 
    LocationID,
    Borough,
    Zone,
    service_zone
    from {{ref('stg_taxi_zones')}}    
)

select 
    ROW_NUMBER() OVER(ORDER BY LocationID) as zone_key,
    LocationID,
    Borough,
    Zone,
    service_zone,
    GETDATE() AS load_date 
from dim_taxi_zones
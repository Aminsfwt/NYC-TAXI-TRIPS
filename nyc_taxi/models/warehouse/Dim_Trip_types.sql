 
{{ config(
    materialized='table',
    schema='analtycal'
) }}

with dim_trip_types AS
(
    select 
        trip_type_id,
        trip_type
    FROM {{ref('stg_trip_types')}}    
)
select 
    ROW_NUMBER() OVER(ORDER BY trip_type_id, trip_type) AS trip_key,
    trip_type_id,
    trip_type,
    GETDATE() AS load_date 
FROM dim_trip_types
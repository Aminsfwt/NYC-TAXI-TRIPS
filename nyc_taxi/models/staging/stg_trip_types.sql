

with src_trip_types AS
(
    select 
        trip_type_id,
        trip_type
    FROM {{source('src_data', 'trip_types')}}   
)

select * from src_trip_types;
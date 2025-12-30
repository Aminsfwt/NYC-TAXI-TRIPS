

with src_taxi_zones AS
(
    SELECT 
        LocationID,
        Borough,
        Zone,
        service_zone
    from {{source('src_data', 'taxi_zones')}}    
)

select * from src_taxi_zones
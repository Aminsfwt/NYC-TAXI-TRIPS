

with src_taxi_trips as 
(
    select 
        trip_info_id as trip_info_id,
        VendorID as venor_id,
        lpep_pickup_datetime as pickup_time,
        lpep_dropoff_datetime as dropoff_time,
        store_and_fwd_flag as trip_store_flag,
        RatecodeID as rate_id,
        PULocationID as pickup_location_id,
        DOLocationID as drop_location_id,
        passenger_count,
        trip_distance,
        fare_amount  as nontaxed_fare,
        extra as extra_charges,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        payment_type as payment_id ,
        trip_type as trip_id
    FROM {{source('src_data', 'taxi_trips')}}    
)

select * from src_taxi_trips
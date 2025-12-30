 
{{ config(
    materialized='table',
    schema='analtycal'
) }}

WITH fact_trips AS 
(
    select    
        trip_info_id,
        v.vendor_key,
        lp.zone_key as pickup_key,
        ld.zone_key as dropoff_key,
        p.payment_key,
        t.trip_key,
        dp.date_key as pickup_time_key,
        dd.date_key as dropoff_time_key,
        trip_store_flag,
        r.rate_key,
        passenger_count,
        trip_distance,
        nontaxed_fare,
        extra_charges,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount
    
FROM {{ref('stg_taxi_trips')}} st
LEFT JOIN {{ref('Dim_Vendors')}} v
        ON st.vendor_id = v.VendorID
LEFT JOIN {{ref('Dim_Taxi_zones')}} lp
        ON st.pickup_location_id = lp.LocationID
LEFT JOIN {{ref('Dim_Taxi_zones')}} ld
        ON st.drop_location_id = ld.LocationID
LEFT JOIN {{ref('Dim_Payments')}} p
        ON st.payment_id = p.payment_id
LEFT JOIN {{ref('Dim_Trip_types')}} t
        ON st.trip_id = t.trip_type_id 
LEFT JOIN {{ref('Dim_Date')}} dp   
        ON st.pickup_time = dp.full_date  
LEFT JOIN {{ref('Dim_Date')}} dd   
        ON st.dropoff_time = dd.full_date
LEFT JOIN {{ref('Dim_Rates')}} r
        ON st.trip_id = r.rate_id                                                   
)

select 
    ROW_NUMBER() OVER(ORDER BY trip_info_id) AS trip_info_key,
    *,
    GETDATE() AS load_date
FROM fact_trips 




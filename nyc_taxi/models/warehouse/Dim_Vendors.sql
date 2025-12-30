 
{{ config(
    materialized='table',
    schema='analtycal'
) }}

with dim_vendors AS
(
    select 
        VendorID,
        VendorName
    FROM {{ref('stg_vendors')}}    
)
select 
    ROW_NUMBER() OVER(ORDER BY VendorID, VendorName) AS vendor_key,
    VendorID,
    VendorName,
    GETDATE() AS load_date 
FROM dim_vendors





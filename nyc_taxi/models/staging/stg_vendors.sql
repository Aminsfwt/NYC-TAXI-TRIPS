

with src_vendors AS
(
    select 
        VendorID,
        VendorName
    FROM {{source('src_data', 'Vendors')}}   
)

select * from src_vendors;
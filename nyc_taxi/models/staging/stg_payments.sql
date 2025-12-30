
with src_payments AS
(
    select 
        payment_id,
        payment_method
    from {{source('src_data', 'payments')}}    
)

select * from src_payments

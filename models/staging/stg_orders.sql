-- models/staging/stg_orders.sql

with source as (

    select *
    from read_csv_auto('data/raw/orders.csv')

),

renamed as (

    select
        order_id,
        customer_id,
        order_date
    from source

)

select *
from renamed



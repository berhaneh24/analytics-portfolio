-- models/staging/stg_order_items.sql

with source as (

    select *
    from read_csv_auto('data/raw/order_items.csv')

),

renamed as (

    select
        order_id,
        product_id,
        quantity,
        unit_price
    from source

)

select *
from renamed


-- models/staging/stg_products.sql

with source as (

    select *
    from read_csv_auto('data/raw/products.csv')

),

renamed as (

    select
        product_id,
        product_name,
        category
    from source

)

select *
from renamed



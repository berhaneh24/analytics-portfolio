-- models/staging/stg_customers.sql

with source as (

    select *
    from read_csv_auto('data/raw/customers.csv')

),

renamed as (

    select
        customer_id,
        state,
        signup_date
    from source

)

select *
from renamed





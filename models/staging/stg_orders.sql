-- models/staging/stg_orders.sql

select
    order_id,
    customer_id,
    product_id,
    order_date,
    quantity,
    order_amount
from {{ source('raw', 'orders') }}

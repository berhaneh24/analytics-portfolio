-- models/intermediate/int_orders_enriched.sql

select
    o.order_id,
    o.order_date,
    o.quantity,
    o.order_amount,

    c.customer_id,
    c.first_name,
    c.last_name,
    c.customer_segment,

    p.product_id,
    p.product_name,
    p.category,
    p.price

from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id
left join {{ ref('stg_products') }} p
    on o.product_id = p.product_id

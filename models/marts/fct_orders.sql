-- models/marts/fct_orders.sql

with orders_enriched as (

  select *
  from {{ ref('int_orders_enriched') }}

)

select
  order_id,
  order_date,
  customer_id,
  product_id,
  quantity,
  price,
  order_amount,

  -- Revenue at the order-line level
  (quantity * price) as line_revenue

from orders_enriched

{{ config(materialized='table') }}

with orders_enriched as (
    select *
    from {{ ref('int_orders_enriched') }}
),

daily as (
    select
        cast(order_date as date) as order_date,
        category,

        count(distinct order_id) as orders,
        count(distinct customer_id) as customers,

        sum(coalesce(quantity, 0)) as units,
        sum(coalesce(quantity, 0) * coalesce(price, 0)) as revenue
    from orders_enriched
    group by 1, 2
)

select
    order_date,
    category,
    orders,
    customers,
    units,
    revenue,
    case when orders = 0 then 0 else revenue * 1.0 / orders end as aov
from daily
order by order_date desc, revenue desc

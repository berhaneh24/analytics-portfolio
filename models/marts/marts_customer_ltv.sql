{{ config(materialized='table') }}

with orders_enriched as (
    select *
    from {{ ref('int_orders_enriched') }}
),

customer_orders as (
    select
        customer_id,
        first_name,
        last_name,
        customer_segment,

        min(cast(order_date as date)) as first_order_date,
        max(cast(order_date as date)) as last_order_date,

        count(distinct order_id) as lifetime_orders,
        sum(coalesce(quantity, 0)) as lifetime_units,
        sum(coalesce(quantity, 0) * coalesce(price, 0)) as lifetime_revenue
    from orders_enriched
    group by 1, 2, 3, 4
)

select
    customer_id,
    first_name,
    last_name,
    customer_segment,

    first_order_date,
    last_order_date,

    lifetime_orders,
    lifetime_units,
    lifetime_revenue,

    case
        when lifetime_orders = 0 then 0
        else lifetime_revenue * 1.0 / lifetime_orders
    end as lifetime_aov
from customer_orders
order by lifetime_revenue desc

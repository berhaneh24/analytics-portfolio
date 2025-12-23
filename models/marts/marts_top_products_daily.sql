{{ config(materialized='table') }}

with orders_enriched as (
    select *
    from {{ ref('int_orders_enriched') }}
),

daily_product as (
    select
        cast(order_date as date) as order_date,
        product_id,
        product_name,
        category,

        sum(coalesce(quantity, 0)) as units,
        sum(coalesce(quantity, 0) * coalesce(price, 0)) as revenue,
        count(distinct order_id) as orders
    from orders_enriched
    group by 1, 2, 3, 4
),

ranked as (
    select
        *,
        row_number() over (
            partition by order_date
            order by revenue desc, units desc
        ) as revenue_rank
    from daily_product
)

select
    order_date,
    revenue_rank,
    product_id,
    product_name,
    category,
    orders,
    units,
    revenue
from ranked
where revenue_rank <= 10
order by order_date desc, revenue_rank

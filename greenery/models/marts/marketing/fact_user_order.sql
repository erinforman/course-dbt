{{
  config(
    materialized='table'
  )
}}

with users as (
    select 
        user_id,
        email,
        first_name,
        last_name,
        address_id,
        user_created_at
    from {{ ref('stg_users') }}
),

orders as (
    select 
        order_id,
        user_id,
        promo_id,
        order_cost_usd,
        shipping_cost_usd,
        order_total_usd,
        order_created_at,
        estimated_delivery_at,
        delivered_at,
        order_status,
        delivery_performance_in_days,
        delivery_performance
    from {{ ref('int_orders') }}
),

order_items as (
    select 
        order_id,
        count_of_products,
        count_of_distinct_products
    from {{ ref('int_order_items') }}
)

select
    u.*,
    o.order_id,
    o.promo_id,
    o.order_cost_usd,
    o.shipping_cost_usd,
    o.order_total_usd,
    o.order_created_at,
    o.estimated_delivery_at,
    o.delivered_at,
    o.order_status,
    o.delivery_performance_in_days,
    o.delivery_performance,
    i.count_of_products,
    i.count_of_distinct_products
from users u
inner join orders o
    on u.user_id = o.user_id
inner join order_items i 
    on o.order_id = i.order_id
{{
  config(
    materialized='table'
  )
}}

with orders as (
    select 
        user_id,
        order_id
    from {{ ref('stg_orders') }}
),

order_items as (
    select
        order_id,
        sum(quantity) as count_of_products,
        count(distinct product_id) as count_of_distinct_products
    from {{ ref('stg_order_items') }}
    group by 1
)

select 
    o.user_id, 
    o.order_id, 
    i.count_of_products,
    i.count_of_distinct_products
from orders o 
left join order_items i 
    on o.order_id = i.order_id 



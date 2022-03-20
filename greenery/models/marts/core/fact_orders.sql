{{
  config(
    materialized='table'
  )
}}

select
    o.order_id,
    o.user_id,
    o.promo_id,
    o.address_id,
    o.shipping_service,
    o.tracking_id,
    o.order_cost_usd,
    o.shipping_cost_usd,
    o.order_total_usd,
    o.order_created_at,
    o.estimated_delivery_at,
    o.delivered_at,
    o.order_status,
    o.delivery_performance_in_days,
    o.delivery_performance,
    p.promo_discount_usd
from {{ ref('int_orders') }} o 
left join {{ ref('stg_promos') }} p 
    on o.promo_id = p.promo_id
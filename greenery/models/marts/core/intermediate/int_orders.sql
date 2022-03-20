
{{
    config(
      materialized='table'
    )
  }}
  
with orders as (
  select * from {{ ref('stg_orders') }}
),

delivery_performance_in_days as (
  select
    order_id, 
    delivered_at::date - estimated_delivery_at::date as delivery_performance_in_days
  from orders
)

select
  o.*,
  d.delivery_performance_in_days,
  case 
      when d.delivery_performance_in_days < 0 then 'early'
      when d.delivery_performance_in_days = 0 then 'on_time'
      when d.delivery_performance_in_days > 0 then 'late'
      --assume late if estimated delivery has passed and delivered_at is null 
      when o.estimated_delivery_at is not null and timezone('utc', now()::date) > o.estimated_delivery_at then 'late'
      --unknown is reserved for orders that have been delivered but have no estimated delivery to measure performance against
      when o.estimated_delivery_at is null and o.delivered_at is not null then 'unknown'
      else null 
  end as delivery_performance
from orders o
left join delivery_performance_in_days d 
    on o.order_id = d.order_id
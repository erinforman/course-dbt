{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'orders') }}
),

renamed as (
    select
        order_id,
        user_id,
        promo_id,
        address_id,
        shipping_service,
        tracking_id,
        order_cost as order_cost_usd,
        shipping_cost as shipping_cost_usd,
        order_total as order_total_usd,
        created_at as order_created_at,
        estimated_delivery_at,
        delivered_at,
        status as order_status
    from
        source
)

select * from renamed
{{
  config(
    materialized='table'
  )
}}

select
    product_id,
    product_name,
    price_usd,
    inventory_count
from {{ ref('stg_products') }}

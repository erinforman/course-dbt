{{
  config(
    materialized='table'
  )
}}


with source as (
    select * from {{ source('src_postgres', 'products') }}
),

renamed as (
    select
        product_id,
        name as product_name,
        price as price_usd,
        inventory as inventory_count
    from
        source
)

select * from renamed
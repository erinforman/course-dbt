{{
  config(
    materialized='table'
  )
}}

with source as (
    select * from {{ source('src_postgres', 'promos') }}
),

renamed as (
    select
        promo_id,
        discount as promo_discount_usd,
        status as promo_status
    from
        source
)

select * from renamed
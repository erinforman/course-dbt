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
        name,
        price,
        inventory
    from
        source
)

select * from renamed
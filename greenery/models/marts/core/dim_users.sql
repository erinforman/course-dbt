{{
  config(
    materialized='table'
  )
}}

select
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.address_id,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    u.user_created_at,
    u.user_updated_at
from {{ ref('stg_users') }} as u
left join {{ ref('stg_addresses') }} as a
    on u.address_id = a.address_id

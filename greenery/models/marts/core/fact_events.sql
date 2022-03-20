{{
  config(
    materialized='table'
  )
}}

select
    event_id,
    session_id,
    user_id,
    page_url,
    event_type,
    order_id,
    product_id,
    created_at as event_created_at
from {{ ref('stg_events') }}
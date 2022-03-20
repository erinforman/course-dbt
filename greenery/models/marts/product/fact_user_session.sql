{{
  config(
    materialized='table'
  )
}}

with user_session as (
  select * from {{ ref('int_user_session') }}
)

select
  session_id, 
  user_id,
  first_event_created_at,
  last_event_created_at,
  last_event_created_at - first_event_created_at as session_length
from user_session
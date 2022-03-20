{{
  config(
    materialized='table'
  )
}}

  
with events as (
  select * from {{ ref('stg_events') }}
)

select 
  session_id, 
  user_id,
  min(created_at) as first_event_created_at,
  max(created_at) as last_event_created_at
from events
{{ dbt_utils.group_by(2) }}

{{
  config(
    materialized='table'
  )
}}

select 
  page_url, 
  count(event_id) as count_of_events,
  count(distinct user_id) as count_of_distinct_users,
  min(created_at) first_session_created_at,
  max(created_at) last_session_created_at,
  count(distinct event_type) as count_distinct_event_types,
  sum(case when event_type = 'add_to_cart' then 1 else 0 end) as count_add_to_cart_events,
  sum(case when event_type = 'checkout' then 1 else 0 end) as count_checkout_events,
  sum(case when event_type = 'page_view' then 1 else 0 end) as count_page_view_events,
  sum(case when event_type = 'package_shipped' then 1 else 0 end) as count_package_shipped_events
from {{ ref('stg_events') }}
group by 1

--todo: parse hash out of checkout and shipping urls to aggregate page stats across users
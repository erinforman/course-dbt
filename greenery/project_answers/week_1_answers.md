## Week 1 Short Answer Questions
[Link](https://corise.com/course/analytics-engineering-with-dbt/week/contentweek_ckzfv4i6t006g149c7ve5g0eh/module/module_ckzo7ykyh007m148r6cmhd0m0)
---
**Question 1:** How many users do we have?
```sql
select count(user_id)
from dbt_erin_f.stg_users
```
**Answer:** 130

---

**Question 2:** On average, how many orders do we receive per hour?
```sql
-- Start with an hourly breakdown of # hours created
with orders_per_hour as (
  select
    date_trunc('hour', created_at) AS created_at_date_hour,
    count(order_id) as cnt_orders
  from dbt_erin_f.stg_orders
  group by 1
)

select avg(cnt_orders) as avg_orders_per_hour
from orders_per_hour
```
**Answer:** 7.52

---

**Question 3:** On average, how long does an order take from being placed to being delivered?
```sql
with placed_to_delivery as (
  select 
    EXTRACT(EPOCH FROM (delivered_at - created_at)) AS difference
  from dbt_erin_f.stg_orders
  where delivered_at is not null
)
select avg(difference)/60/60 as avg_placed_to_delivery
from placed_to_delivery

```
**Answer:** 93.4 Hours

---

**Question 4:** How many users have only made one purchase? Two purchases? Three+ purchases?
```sql
with orders_per_user as (
  select user_id, count(order_id) as order_count
  from dbt_erin_f.stg_orders 
  group by 1
)

select 
 sum(case when order_count = 1 then 1 else 0 end) as count_one_purchase,
 sum(case when order_count = 2 then 1 else 0 end) as count_two_purchase,
 sum(case when order_count >= 3 then 1 else 0 end) as count_3plus_purchase
from orders_per_user

```
**Answer:**
one purchase: 25,
two purchases: 38,
three+ purchases: 71

---

**Question 5:** On average, how many unique sessions do we have per hour?
```sql
with unique_sessions_per_hour as (
  select date_trunc('hour', created_at) AS created_at_date_hour, count(distinct session_id) as sessions_per_hour
  from dbt_erin_f.stg_events 
  group by 1
)

select avg(sessions_per_hour) as avg_sessions_per_hour
from unique_sessions_per_hour
```
**Answer:** 16.33
## Week 2 Short Answer Questions
[Link](https://corise.com/course/analytics-engineering-with-dbt/week/contentweek_ckzmtktge010v147nf80ra029/module/module_ckzo7otb30074148r4kbe0y7q)
---
**Question 1:** What is our user repeat rate??


```sql
--Repeat Rate = Users who purchased 2 or more times / users who purchased

with orders_per_user as (
  select user_id, count(distinct order_id) as orders_per_user
  from dbt_erin_f.stg_orders 
  group by 1
)

select 
  count(user_id) FILTER (WHERE orders_per_user >= 2)::decimal / count(user_id)::decimal as repeat_rate
from orders_per_user
```
**Answer:** 79.84%

---

**Question 2:** What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question??

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.

**Answer:** 
Areas worth exploring:
* Promo codes: Are single over vs multi order users more or less likely to use promo codes? Does the timing of the promo code use matter (eg first order vs second+), i.e. is a user more "sticky" after they've made 2 orders vs 1, so the business should offer 2 sequential promo codes to new users to encourage multi-order users.
* Support tickets: Are users with issues related to shipping, product quality, etc less likely to order again? If a user has an issue, but they give the support agent high CSAT scores for the resolution, is the user likely to order again despite the issue?
* Product/User type: Do users who start with small, low maintenance, less expensive plants graduate to large, higher maintenance, more expensive plants? VS starting with the latter and having nowhere to "progress"?
* Customer education: Are users who receive email pro-tips on taking care of their first purchase more likely to make a second purchase?

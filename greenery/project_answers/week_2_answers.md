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

**Question 2:** What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.

**Answer:** 
Areas worth exploring:
* Promo codes: Are single over vs multi order users more or less likely to use promo codes? Does the timing of the promo code use matter (eg first order vs second+), i.e. is a user more "sticky" after they've made 2 orders vs 1, so the business should offer 2 sequential promo codes to new users to encourage multi-order users.
* Support tickets: Are users with issues related to shipping, product quality, etc less likely to order again? If a user has an issue, but they give the support agent high CSAT scores for the resolution, is the user likely to order again despite the issue?
* Product/User type: Do users who start with small, low maintenance, less expensive plants graduate to large, higher maintenance, more expensive plants? VS starting with the latter and having nowhere to "progress"?
* Customer education: Are users who receive email pro-tips on taking care of their first purchase more likely to make a second purchase?

---

**Question 3:** Explain the marts models you added. Why did you organize the models in the way you did?

**Answer:** 

* I created `fact_user_order` in the `marketing` mart with the idea that a marketing team could have 1 table to reference when strategizing and creating email campaigns.
first_name, last_name, and email would be helpful for merge variables. The last order date could be used in conjunction with order_status for drip compaigns (has enough time passed since a successful delivery for a follow up campaign?). I included product counts to add color to what constituted the order, so it's clear if the total cost was high because of a high value item or a bulk order, for example. 

* I created `fact_page` in the `product` mart as a page stats table. If the product team was A/B testing the performance of a page (page_id instead of page_url would be helpful here), one could query this table to get an idea of which verison was performing better by certain metrics.

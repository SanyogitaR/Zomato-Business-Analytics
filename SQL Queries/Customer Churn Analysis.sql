#Customer Churn Analysis
with last as (select max(order_timestamp) as last_txn_date
from zomato-analyst-project.zomato.Orders),

cust_last as(select customer_id, max(order_timestamp) as max_txn_date
from zomato-analyst-project.zomato.Orders
group by 1)

select count(*) as churned
from cust_last c cross join last b 
where DATE_DIFF(b.last_txn_date, c.max_txn_date, DAY) > 90


with last as (select max(order_timestamp) as last_txn_date
from zomato-analyst-project.zomato.Orders),

cust_last as(select customer_id, max(order_timestamp) as max_txn_date
from zomato-analyst-project.zomato.Orders
group by 1),

churn_tag as(select c.customer_id,case when DATE_DIFF(b.last_txn_date, c.max_txn_date, DAY) > 90 then 1 else 0 end as ischurn_tag
from cust_last c cross join last b )

SELECT
  SUM(CASE
        WHEN b.ischurn_tag = 1
        AND c.order_status = 'Delivered'
        THEN c.order_amount
        ELSE 0
      END) AS revenue_lost_due_to_churn
FROM `zomato-analyst-project.zomato.Orders` c
LEFT JOIN churn_tag b
  ON c.customer_id = b.customer_id;



WITH last AS (
  SELECT MAX(order_timestamp) AS last_txn_date
  FROM `zomato-analyst-project.zomato.Orders`
),

customer_data AS (
  SELECT
    customer_id,
    MAX(order_timestamp) AS max_txn_date,
    SUM(CASE
          WHEN order_status = 'Delivered'
          THEN order_amount
          ELSE 0
        END) AS total_revenue
  FROM `zomato-analyst-project.zomato.Orders`
  GROUP BY customer_id
),

churn_tag AS (
  SELECT
    c.customer_id,
    c.total_revenue,
    CASE
      WHEN DATE_DIFF(b.last_txn_date, c.max_txn_date, DAY) > 90
      THEN 1
      ELSE 0
    END AS ischurn_tag
  FROM customer_data c
  CROSS JOIN last b
)

SELECT
  customer_id,
  total_revenue
FROM churn_tag
WHERE ischurn_tag = 1
ORDER BY total_revenue DESC;




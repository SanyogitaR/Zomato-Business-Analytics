#customer analysis

WITH customer_revenue AS (
  SELECT
    customer_id,
    SUM(order_amount) AS total_revenue
  FROM `zomato-analyst-project.zomato.Orders`
  WHERE order_status = 'Delivered'
  GROUP BY customer_id
),


ranked_customers AS (
  SELECT
    customer_id,
    total_revenue,
    ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS customer_rank
  FROM customer_revenue
)


SELECT
  customer_id,
  total_revenue,
  customer_rank
FROM ranked_customers
WHERE customer_rank <= 20
ORDER BY customer_rank;


WITH customer_revenue AS (
  SELECT
    customer_id,
    SUM(order_amount) AS total_revenue
  FROM `zomato-analyst-project.zomato.Orders`
  WHERE order_status = 'Delivered'
  GROUP BY customer_id
),

ranked_customers AS (
  SELECT
    customer_id,
    total_revenue,
    ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS customer_rank
  FROM customer_revenue
),

-- SELECT
--   customer_id,
--   total_revenue,
--   customer_rank
-- FROM ranked_customers
-- WHERE customer_rank <= 20
-- ORDER BY customer_rank;


top as (SELECT
  customer_id,
  total_revenue,
  customer_rank
FROM ranked_customers
WHERE customer_rank <= 20
ORDER BY customer_rank
)

select sum(total_revenue)*100/(select sum(order_amount) from zomato-analyst-project.zomato.Orders where order_status='Delivered') as percentage
from top

select Acquisition_channel,count(distinct Customer_id ) as total_customers from zomato-analyst-project.zomato.Customer
group by 1
order by total_customers DESC

WITH first_order AS (
  SELECT
    customer_id,
    DATE_TRUNC(MIN(order_timestamp), MONTH) AS first_order_month
  FROM `zomato-analyst-project.zomato.Orders`
  WHERE order_status = 'Delivered'
  GROUP BY 1
)

SELECT
  COUNT(DISTINCT o.customer_id) AS repeat_customers
FROM `zomato-analyst-project.zomato.Orders` AS o
JOIN first_order AS f
  ON o.customer_id = f.customer_id
  AND DATE_TRUNC(o.order_timestamp, MONTH) > f.first_order_month
WHERE o.order_status = 'Delivered';

#Coupon Analysis
SELECT
  COUNTIF(discount_amount > 0) * 100 / COUNT(*) AS coupon_usage_percentage
FROM `zomato-analyst-project.zomato.Orders`
WHERE order_status = 'Delivered';

SELECT
  CASE
    WHEN discount_amount > 0 THEN 'Coupon Users'
    ELSE 'Non-Coupon Users'
  END AS customer_type,
  AVG(order_amount) AS avg_order_value,
  SUM(order_amount) AS total_spending,
  COUNT(order_id) AS total_orders
FROM `zomato-analyst-project.zomato.Orders`
WHERE order_status = 'Delivered'
GROUP BY 1;

SELECT
  c.city,
  COUNTIF(o.discount_amount > 0) AS coupon_orders
FROM `zomato-analyst-project.zomato.Orders` AS o
JOIN `zomato-analyst-project.zomato.Customer` AS c
  ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY 1
ORDER BY coupon_orders DESC;

SELECT
  c.city,
  COUNTIF(o.discount_amount > 0) AS coupon_orders,
  COUNT(o.order_id) AS total_orders,
  COUNTIF(o.discount_amount > 0) * 100 / COUNT(o.order_id)
    AS coupon_usage_percentage
FROM `zomato-analyst-project.zomato.Orders` AS o
JOIN `zomato-analyst-project.zomato.Customer` AS c
  ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY 1
ORDER BY coupon_usage_percentage DESC;
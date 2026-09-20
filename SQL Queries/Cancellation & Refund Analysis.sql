# Cancellation & Refund Analysis

select count(distinct case when order_status='Cancelled' then order_id end )/count(distinct order_id) as cancellation_rate
from  zomato-analyst-project.zomato.Orders

select count(distinct case when order_status='Refunded' then order_id end )/count(distinct order_id) as refund_rate
from  zomato-analyst-project.zomato.Orders

SELECT
  SUM(order_amount) AS cancelled_revenue
FROM `zomato-analyst-project.zomato.Orders`
WHERE order_status = 'Cancelled';

select restaurant_id, count(distinct case when order_status='Cancelled' then order_id end )/count(distinct order_id) as cancellation_rate
from  zomato-analyst-project.zomato.Orders
group by restaurant_id
order by cancellation_rate DESC
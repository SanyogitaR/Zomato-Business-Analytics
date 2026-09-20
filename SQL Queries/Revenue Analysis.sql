#Revenue Analysis

select sum(order_amount) as total_revenue from zomato-analyst-project.zomato.Orders
where order_status='Delivered'

select DATE_TRUNC(order_timestamp,month) as Month,sum(order_amount) as total_revenue from zomato-analyst-project.zomato.Orders
where order_status='Delivered'
group by 1
order by 1 ASC

select c.city, sum(o.order_amount) as total_revenue from zomato-analyst-project.zomato.Orders o join zomato-analyst-project.zomato.Customer c on o.customer_id =c.Customer_id 
where o.order_status='Delivered'
group by 1
order by sum(o.order_amount) DESC
LIMIT 1



select payment_mode, sum(order_amount) as total_revenue from zomato-analyst-project.zomato.Orders
where order_status='Delivered'
group by payment_mode
order by sum(order_amount) DESC
LIMIT 1

select sum(order_amount)/count(distinct order_id) as Avg_order_value from zomato-analyst-project.zomato.Orders
where order_status='Delivered'


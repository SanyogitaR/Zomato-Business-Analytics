#Restaurant Performance Analysis

select o.restaurant_id,r.restaurant_name, sum(o.order_amount) as total_revenue from zomato-analyst-project.zomato.Orders o left join zomato-analyst-project.zomato.Restaurants r on o.restaurant_id=r.restaurant_id
where O.order_status='Delivered'
group by O.restaurant_id,r.restaurant_name
order by sum(o.order_amount) DESC

SELECT 
  r.restaurant_name,
  SUM(o.order_amount) AS total_revenue
FROM `zomato-analyst-project.zomato.Orders` AS o
LEFT JOIN `zomato-analyst-project.zomato.Restaurants` AS r
  ON o.restaurant_id = r.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC;

select r.restaurant_name, count(o.order_id) as total_orders from zomato-analyst-project.zomato.Orders o left join zomato-analyst-project.zomato.Restaurants r on o.restaurant_id=r.restaurant_id
where O.order_status='Delivered'
group by r.restaurant_name
order by total_orders DESC


select r.cuisine , count(o.order_id) as total_orders from zomato-analyst-project.zomato.Orders o left join zomato-analyst-project.zomato.Restaurants r on o.restaurant_id=r.restaurant_id
where O.order_status='Delivered'
group by r.cuisine
order by total_orders DESC

select r.restaurant_name,r.avg_rating, sum(o.order_amount) as total_revenue from zomato-analyst-project.zomato.Orders o left join zomato-analyst-project.zomato.Restaurants r on o.restaurant_id=r.restaurant_id
where O.order_status='Delivered'
group by all
order by sum(o.order_amount) DESC

WITH restaurant_revenue AS (
    SELECT
        r.restaurant_name,
        SUM(o.order_amount) AS total_revenue
    FROM `zomato-analyst-project.zomato.Orders` AS o
    LEFT JOIN `zomato-analyst-project.zomato.Restaurants` AS r
        ON o.restaurant_id = r.restaurant_id
    WHERE o.order_status = 'Delivered'
    GROUP BY r.restaurant_name
),

ranked_restaurants AS (
    SELECT
        restaurant_name,
        total_revenue,
        RANK() OVER (ORDER BY total_revenue ASC) AS restaurant_rank
    FROM restaurant_revenue
)

SELECT
    restaurant_name,
    total_revenue
FROM ranked_restaurants
WHERE restaurant_rank <= 5
ORDER BY restaurant_rank;


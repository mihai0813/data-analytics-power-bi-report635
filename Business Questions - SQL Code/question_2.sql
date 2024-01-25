-- August is the month with the highest revenue in 2022 --
SELECT monthly_revenue
FROM
(SELECT SUM(product_quantity * sale_price) as monthly_revenue, 12 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-12-01' AND '2022-12-31'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 11 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-11-01' AND '2022-11-30'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 10 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-10-01' AND '2022-10-31'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 9 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-09-01' AND '2022-09-30'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 8 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-08-01' AND '2022-08-31'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 7 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-07-01' AND '2022-07-31'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 6 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-06-01' AND '2022-06-30'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 5 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-05-01' AND '2022-05-31'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 4 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-04-01' AND '2022-04-30'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 3 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-03-01' AND '2022-03-31'
UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 2 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-02-01' AND '2022-02-28'UNION
SELECT SUM(product_quantity * sale_price) as monthly_revenue, 1 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
WHERE order_date BETWEEN '2022-01-01' AND '2022-01-31') x
ORDER BY display_order;
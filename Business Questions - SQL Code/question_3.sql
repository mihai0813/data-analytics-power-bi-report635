--Local is the German store type with the highest revenue in 2022--
SELECT type_revenue
FROM
(SELECT SUM(product_quantity * dim_product.sale_price) as type_revenue, 1 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31' AND country IN ('Germany') AND store_type IN ('Super Store')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) as type_revenue, 2 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31' AND country IN ('Germany') AND store_type IN ('Local')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) as type_revenue, 3 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31' AND country IN ('Germany') AND store_type IN ('Outlet')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) as type_revenue, 4 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31' AND country IN ('Germany') AND store_type IN ('Mall Kiosk')) x
ORDER BY display_order;
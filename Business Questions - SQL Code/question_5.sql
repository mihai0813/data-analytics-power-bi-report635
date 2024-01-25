--Homeware generated the most profit for the Wiltshire, UK region in 2021--
SELECT category_profit
FROM
(SELECT SUM(product_quantity * dim_product.sale_price) - SUM(product_quantity * dim_product.cost_price) as category_profit, 1 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31' AND country_region IN ('Wiltshire') AND category IN ('diy')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) - SUM(product_quantity * dim_product.cost_price) as category_profit, 2 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31' AND country_region IN ('Wiltshire') AND category IN ('health-and-beauty')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) - SUM(product_quantity * dim_product.cost_price) as category_profit, 3 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31' AND country_region IN ('Wiltshire') AND category IN ('pets')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) - SUM(product_quantity * dim_product.cost_price) as category_profit, 4 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31' AND country_region IN ('Wiltshire') AND category IN ('food-and-drink')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) - SUM(product_quantity * dim_product.cost_price) as category_profit, 5 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31' AND country_region IN ('Wiltshire') AND category IN ('sports-and-leisure')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) - SUM(product_quantity * dim_product.cost_price) as category_profit, 6 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31' AND country_region IN ('Wiltshire') AND category IN ('toys-and-games')
UNION
SELECT SUM(product_quantity * dim_product.sale_price) - SUM(product_quantity * dim_product.cost_price) as category_profit, 7 as display_order
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31' AND country_region IN ('Wiltshire') AND category IN ('homeware')) x
ORDER BY display_order;
CREATE OR REPLACE VIEW store_type_sales_2 AS
SELECT DISTINCT(store_type), SUM(product_quantity * dim_product.sale_price) AS total_sales, 
(SUM(product_quantity * dim_product.sale_price) / (SELECT SUM(product_quantity * dim_product.sale_price) FROM orders INNER JOIN dim_product ON orders.product_code = dim_product.product_code)) * 100 AS percentage_of_sales, 
COUNT(order_date) AS number_of_orders
FROM orders
INNER JOIN dim_product ON orders.product_code = dim_product.product_code
INNER JOIN dim_store ON orders.store_code = dim_store.store_code
GROUP BY store_type;

SELECT *
FROM store_type_sales_2
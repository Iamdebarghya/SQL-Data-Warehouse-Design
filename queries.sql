-- Monthly revenue, cost and gross profit
SELECT d.year_num,d.month_num,d.month_name,SUM(f.sales_amount) revenue,SUM(f.cost_amount) cost,SUM(f.sales_amount-f.cost_amount) gross_profit FROM fact_sales f JOIN dim_date d ON d.date_key=f.date_key GROUP BY d.year_num,d.month_num,d.month_name ORDER BY d.year_num,d.month_num;
-- Regional revenue contribution
SELECT r.region_name,SUM(f.sales_amount) revenue,ROUND(100*SUM(f.sales_amount)/NULLIF((SELECT SUM(sales_amount) FROM fact_sales),0),2) revenue_share_pct FROM fact_sales f JOIN dim_region r ON r.region_key=f.region_key GROUP BY r.region_name ORDER BY revenue DESC;
-- Product performance
SELECT p.product_name,p.category,SUM(f.quantity) units,SUM(f.sales_amount) revenue,SUM(f.sales_amount-f.cost_amount) gross_profit FROM fact_sales f JOIN dim_product p ON p.product_key=f.product_key GROUP BY p.product_key,p.product_name,p.category ORDER BY revenue DESC LIMIT 10;
-- Customer segment performance
SELECT c.customer_segment,COUNT(DISTINCT f.order_id) orders,SUM(f.sales_amount) revenue,ROUND(SUM(f.sales_amount)/NULLIF(COUNT(DISTINCT f.order_id),0),2) avg_order_value FROM fact_sales f JOIN dim_customer c ON c.customer_key=f.customer_key GROUP BY c.customer_segment ORDER BY revenue DESC;
-- Month-over-month revenue using LAG (MySQL 8+)
WITH monthly AS(SELECT d.year_num,d.month_num,MIN(d.full_date) month_start,SUM(f.sales_amount) revenue FROM fact_sales f JOIN dim_date d ON d.date_key=f.date_key GROUP BY d.year_num,d.month_num),compared AS(SELECT *,LAG(revenue) OVER(ORDER BY month_start) previous_revenue FROM monthly) SELECT year_num,month_num,revenue,previous_revenue,ROUND(100*(revenue-previous_revenue)/NULLIF(previous_revenue,0),2) mom_growth_pct FROM compared ORDER BY month_start;
-- Discount and gross margin by category
SELECT p.category,SUM(f.discount_amount) discounts,SUM(f.sales_amount) revenue,ROUND(100*SUM(f.sales_amount-f.cost_amount)/NULLIF(SUM(f.sales_amount),0),2) gross_margin_pct FROM fact_sales f JOIN dim_product p ON p.product_key=f.product_key GROUP BY p.category ORDER BY revenue DESC;

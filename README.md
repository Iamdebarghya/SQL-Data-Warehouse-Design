# Sales Data Warehouse Design
A dimensional modelling project that organizes transactional sales data into a star schema for BI reporting and analytical SQL.

## Business objective
Create a consistent reporting layer for revenue, cost, gross profit, product performance, regional contribution and customer-segment analysis.

## Architecture
```text
Transactional sales -> staging / validation -> star schema -> BI / SQL reporting
                                      |-> fact_sales
                                      |-> dim_date
                                      |-> dim_product
                                      |-> dim_region
                                      |-> dim_customer
```

## Model design
- Fact table: one row per sales order line, including quantity, sales, discount and cost.
- Dimensions: date, product, region and customer segment.
- Surrogate dimension keys connect facts to descriptive attributes.
- Indexes support common date/region and product/date access patterns.

## Run locally
1. Use MySQL 8+.
2. Run `schema.sql` in a development environment. It creates and seeds `sales_warehouse`.
3. Run statements from `queries.sql`.
4. Reconcile totals to source transactions before using results in business decisions.

## Analytical questions
Monthly revenue/cost/profit, regional contribution, top products, customer-segment order value, month-over-month growth using `LAG()`, and discount/margin review.

## Assumptions and limitations
Seed data is synthetic and demonstrates the model only. Sales amount is treated as recognized line revenue; tax, returns and shipping treatment must be confirmed for a real source. Cost amount is line-level cost. This repository contains SQL DDL and queries, not a hosted production database or ETL orchestrator.

## Future work
Add staging transformations, source-to-target mappings, data-quality checks, incremental loads and slowly changing dimensions.

## Author
Debarghya Hajra | SQL, Data Modelling & Business Intelligence

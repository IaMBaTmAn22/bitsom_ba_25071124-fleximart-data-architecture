Section 1 

FACT TABLE: fact_sales
Grain: One row per product per order line item
Business Process: Sales transactions

Measures (Numeric Facts):
- quantity_sold: Number of units sold
- unit_price: Price per unit at time of sale
- discount_amount: Discount applied
- total_amount: Final amount (quantity × unit_price - discount)

Foreign Keys:
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer


DIMENSION TABLE: dim_date
Purpose: Date dimension for time-based analysis
Type: Conformed dimension
Attributes:
- date_key (PK): Surrogate key (integer, format: YYYYMMDD)
- full_date: Actual date
- day_of_week: Monday, Tuesday, etc.
- month: 1-12
- month_name: January, February, etc.
- quarter: Q1, Q2, Q3, Q4
- year: 2023, 2024, etc.
- is_weekend: Boolean



DIMENSION TABLE: dim_product  
Purpose: Stores product-related descriptive attributes  
Type: Conformed dimension

Attributes:
- product_key (PK): Surrogate key
- product_id: Original product identifier from source system
- product_name: Name of the product
- category: Product category (Electronics, Fashion, etc.)
- subcategory: Sub classification of product
- unit_price: Price of product at time of load



DIMENSION TABLE: dim_customer  
Purpose: Stores customer descriptive information  
Type: Conformed dimension

Attributes:
- customer_key (PK): Surrogate key
- customer_id: Original customer identifier from source system
- customer_name: Full name of the customer
- city: Customer city
- state: Customer state
- customer_segment: Segment such as Retail, Corporate, or Home Office





Section 2

The fact table is designed at the transaction line-item level, which means that each row represents the sale of one product in a particular order. 
This is the most detailed level of data and makes it easy to analyse sales in many different ways. For example, we can start with total yearly or monthly sales and then drill down to see which specific products or customers contributed to those numbers.

Surrogate keys are used instead of natural keys because they make joins faster and avoid dependency on IDs coming from the source systems. 
Natural keys like customer ID or product ID may change over time, but surrogate keys remain stable inside the data warehouse, which helps in maintaining consistency. Surrogate keys are used when there are no actual primary key candidates within the table

This star schema also supports roll-up and drill-down operations by connecting the fact table to the dimension tables. Using the date dimension, sales can be analysed by year, quarter, or month. Similarly, the product and customer dimensions allow product-wise and customer-wise analysis. 
Overall, this design makes reporting simple, flexible, and scalable.


Section 3:

fact_sales
{
  date_key: 20240115,
  product_key: 5,
  customer_key: 12,
  quantity_sold: 2,
  unit_price: 50000,
  total_amount: 100000
}


dim_date
{ date_key: 20240115, full_date: '2024-01-15', month: 1, quarter: 'Q1' }

dim_product
{ product_key: 5, product_name: 'Laptop', category: 'Electronics' }

dim_customer
{ customer_key: 12, customer_name: 'John Doe', city: 'Mumbai' }


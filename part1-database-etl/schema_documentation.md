ENTITY: customers
Purpose: Stores customer information
Attributes:
  - customer_id: Unique identifier (Primary Key)
  - first_name: Customer's first name
  - last_name: Customer's last name
  - email: Customers' unique email address
  - phone: Customer's contact number
  - city: Customer's residing city
  - registration_date – Date the customer registered

Relationships:
  - One customer can place MANY orders (1:M with orders table)


ENTITY: products
Purpose: Stores product details
Attributes:
  - product_id: Unique product indentfier (Primary Key)
  - product_name: Name of the Product
  - category: Product Category
  - price: Unit Price
  - stock_quantity: Units available in inventory

Relationships:
  - One product can appear in many order items (1:M with order_items)



ENTITY: orders
Purpose: Stores order-level transaction information.
Attributes:
  - order_id – Unique order identifier (Primary Key)
  - customer_id – Customer who placed the order (Foreign Key)
  - order_date – Date of order
  - ptotal_amount – Total amount for the order
  - status – Order status (Pending / Completed)

Relationships:
One order belongs to one customer (M:1)
One order can have many order items (1:M with order_items)




ENTITY: order_items
Purpose: SStores individual product line items per order.
Attributes:
  - order_item_id – Unique identifier (Primary Key)
  - order_id – Order reference (Foreign Key)
  - product_id – Product reference (Foreign Key)
  - unit_price – Price per unit
  - subtotal – quantity × unit_price

Relationships:




Normalization Explanation:

The database schema follows 3NF to eliminate repetation and redundancy and increase data integrity. Each table stores data related to a single entity, and all non-key attributes depends only on the primary key of the table

Customers table functional dependecies :
customer_id=first_name,last_name,registration_date,email,phone,city
Here each attribute is completly dependent on customer_id

Products table functional dependecies :
produt_id=product_name, category,price,stock_quantity
Product information is stored only once, avoiding duplication in sales records.

order table functional dependencies :
order_id=customer_id, order_date, total amount, status
Product information is stored only once, avoiding duplication in sales records.

order_items functional dependencies :
order_item_id=order_id, product_id, quantity, unit_price, subtotal
This ensures that individual product details within each order are normalized

Hence having noraml form avoids anomalies, update, insert, delete as updating a product price requires change only in one row in the products table and a new product can be added without requiring any order data and removing an order does not remove product or customer information. Hence the schema satisfies 3NF.


Sample Data Representation :

customers:
customer_id, first_name,  last_name,          email,                phone,         city,        registration_date
'83',         'Rahul',      'Sharma', 'rahul.sharma@gmail.com', '+91-9876543210', 'Bangalore', '2023-01-15'
'84',          'Priya',     'Patel',  'priya.patel@yahoo.com',  '+91-9988776655', 'Mumbai',    '2023-02-20'


products:
product_id,   product_name,         category,       price,    stock_quantity
'51',         'Reebok Trackpants', 'Fashion',      '1899.00',   '110'
'50',         'Boat Earbuds',      'Electronics',  '1499.00',   '250'


orders:
order_id,   customer_id,     order_date,     total_amount,    status
'11',       '83',            '2024-01-15',   '45999.00',      'Completed'
'12',       '84',            '2024-01-16',   '5998.00',       'Completed'


order_item_id, order_id, product_id, quantity, unit_price, subtotal
'10',         '11',      '35',       '1',      '45999.00', '45999.00'
'11',         '12',      '37',       '2',      '2999.00',  '5998.00'



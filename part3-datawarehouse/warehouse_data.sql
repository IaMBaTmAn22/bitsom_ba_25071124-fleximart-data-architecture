USE fleximart_dw;

-- ==========================
-- dim_date (30 rows)
-- ==========================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,0),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,0),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,0),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,0),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,0),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,1),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,1),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,0),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,0),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,0),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,0),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,0),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,1),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,1),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,0),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,0),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,0),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,1),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,1),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,0),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,0),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,0),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,0),
(20240209,'2024-02-09','Friday',9,2,'February','Q1',2024,0),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,1),
(20240211,'2024-02-11','Sunday',11,2,'February','Q1',2024,1),
(20240212,'2024-02-12','Monday',12,2,'February','Q1',2024,0),
(20240213,'2024-02-13','Tuesday',13,2,'February','Q1',2024,0),
(20240214,'2024-02-14','Wednesday',14,2,'February','Q1',2024,0),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,0);

-- ==========================
-- dim_product (15 rows)
-- ==========================
INSERT INTO dim_product (product_id,product_name,category,subcategory,unit_price) VALUES
('P001','iPhone 14','Electronics','Mobile',70000),
('P002','Samsung TV','Electronics','TV',45000),
('P003','MacBook Air','Electronics','Laptop',95000),
('P004','Nike Shoes','Fashion','Footwear',6000),
('P005','Adidas Jacket','Fashion','Clothing',4500),
('P006','Levis Jeans','Fashion','Clothing',3500),
('P007','Rice Bag','Groceries','Food',1200),
('P008','Wheat Flour','Groceries','Food',900),
('P009','Olive Oil','Groceries','Food',1500),
('P010','Bluetooth Speaker','Electronics','Audio',4000),
('P011','Smart Watch','Electronics','Wearable',8000),
('P012','Sunglasses','Fashion','Accessories',2500),
('P013','Sugar Pack','Groceries','Food',700),
('P014','Coffee Maker','Electronics','Kitchen',5500),
('P015','Backpack','Fashion','Bags',3000);

-- ==========================
-- dim_customer (12 rows)
-- ==========================
INSERT INTO dim_customer (customer_id,customer_name,city,state,customer_segment) VALUES
('C001','Rahul Sharma','Bangalore','Karnataka','Retail'),
('C002','Priya Patel','Mumbai','Maharashtra','Retail'),
('C003','Amit Kumar','Delhi','Delhi','Corporate'),
('C004','Sneha Reddy','Hyderabad','Telangana','Retail'),
('C005','Vikram Singh','Chennai','Tamil Nadu','Corporate'),
('C006','Arjun Rao','Bangalore','Karnataka','Retail'),
('C007','Neha Shah','Mumbai','Maharashtra','Retail'),
('C008','Ravi Verma','Delhi','Delhi','Corporate'),
('C009','Kavya Iyer','Chennai','Tamil Nadu','Retail'),
('C010','Anjali Mehta','Hyderabad','Telangana','Retail'),
('C011','Karthik Nair','Bangalore','Karnataka','Corporate'),
('C012','Suresh Patel','Mumbai','Maharashtra','Retail');

-- ==========================
-- fact_sales (40 rows)
-- ==========================
INSERT INTO fact_sales (date_key,product_key,customer_key,quantity_sold,unit_price,discount_amount,total_amount) VALUES
(20240106,1,1,1,70000,0,70000),(20240107,3,2,1,95000,5000,90000),
(20240113,4,3,2,6000,0,12000),(20240114,5,4,1,4500,0,4500),
(20240120,7,5,3,1200,0,3600),(20240121,8,6,2,900,0,1800),
(20240127,10,7,1,4000,0,4000),(20240128,11,8,1,8000,0,8000),
(20240203,12,9,2,2500,0,5000),(20240204,14,10,1,5500,500,5000),
(20240210,2,11,1,45000,0,45000),(20240211,6,12,2,3500,0,7000),
(20240106,9,1,1,1500,0,1500),(20240107,15,2,1,3000,0,3000),
(20240113,3,3,1,95000,0,95000),(20240114,1,4,1,70000,0,70000),
(20240120,4,5,2,6000,0,12000),(20240121,5,6,1,4500,0,4500),
(20240127,7,7,3,1200,0,3600),(20240128,8,8,2,900,0,1800),
(20240203,10,9,1,4000,0,4000),(20240204,11,10,1,8000,0,8000),
(20240210,12,11,1,2500,0,2500),(20240211,14,12,1,5500,0,5500),
(20240106,2,1,1,45000,0,45000),(20240107,6,2,1,3500,0,3500),
(20240113,9,3,1,1500,0,1500),(20240114,15,4,1,3000,0,3000),
(20240120,3,5,1,95000,0,95000),(20240121,1,6,1,70000,0,70000),
(20240127,4,7,2,6000,0,12000),(20240128,5,8,1,4500,0,4500),
(20240203,7,9,2,1200,0,2400),(20240204,8,10,2,900,0,1800),
(20240210,10,11,1,4000,0,4000),(20240211,11,12,1,8000,0,8000);
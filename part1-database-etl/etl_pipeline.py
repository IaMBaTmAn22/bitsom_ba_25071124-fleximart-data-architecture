import pandas as pd
import re
import mysql.connector
from dotenv import load_dotenv
import os
load_dotenv()

import os
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=os.getenv("DB_PASSWORD"),
    database="fleximart"
)

cursor = conn.cursor()

cursor.execute("DELETE FROM order_items")
cursor.execute("DELETE FROM orders")
cursor.execute("DELETE FROM products")
cursor.execute("DELETE FROM customers")
conn.commit()


customers = pd.read_csv("data/customers_raw.csv")
cust_before = len(customers)
customers = customers.drop_duplicates(subset=["customer_id"])
cust_after = len(customers)
cust_duplicates = cust_before - cust_after
cust_missing_emails = customers["email"].isna().sum()
customers["email"] = customers["email"].fillna(customers["customer_id"] + "@unknown.com")
def clean_phone(phone):
    phone = str(phone)
    digits = re.sub(r"\D", "", phone)
    if len(digits) >= 10:
        return "+91-" + digits[-10:]
    return None

customers["phone"] = customers["phone"].apply(clean_phone)
def clean_date(date_val):
    try:
        return pd.to_datetime(date_val, dayfirst=True)
    except:
        try:
            return pd.to_datetime(date_val, format="%m-%d-%Y")
        except:
            return None
customers["registration_date"] = customers["registration_date"].apply(clean_date)
customers["city"] = customers["city"].str.strip().str.title()
for _, row in customers.iterrows():
    cursor.execute("""
        INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s,%s,%s,%s,%s,%s)
    """, (row["first_name"], row["last_name"], row["email"],
          row["phone"], row["city"], row["registration_date"]))
conn.commit()

products = pd.read_csv("data/products_raw.csv")

clean_categories = []
for cat in products["category"]:
    cat = str(cat).strip().lower()
    if cat == "electronics":
        clean_categories.append("Electronics")
    elif cat == "fashion":
        clean_categories.append("Fashion")
    elif cat == "groceries":
        clean_categories.append("Groceries")
    else:
        clean_categories.append(cat.title())

products["category"] = clean_categories

prod_missing_stock = products["stock_quantity"].isna().sum()
products["stock_quantity"] = products["stock_quantity"].fillna(0)

prod_before = len(products)
products = products.dropna(subset=["price"])
prod_after = len(products)
prod_missing_price = prod_before - prod_after

for _, row in products.iterrows():
    cursor.execute("""
        INSERT INTO products (product_name, category, price, stock_quantity)
        VALUES (%s,%s,%s,%s)
    """, (row["product_name"], row["category"], row["price"], row["stock_quantity"]))
conn.commit()


sales = pd.read_csv("data/sales_raw.csv")
sales_before = len(sales)
sales = sales.drop_duplicates(subset=["transaction_id"])
sales_duplicates = sales_before - len(sales)
sales = sales.dropna(subset=["customer_id", "product_id"])
sales_missing_ids = sales_before - len(sales)
sales["transaction_date"] = sales["transaction_date"].apply(clean_date)


cursor.execute("SELECT customer_id, email FROM customers")
cust_map = {email: cid for cid, email in cursor.fetchall()}

cursor.execute("SELECT product_id, product_name FROM products")
prod_map = {name: pid for pid, name in cursor.fetchall()}

order_lookup = {}

for _, row in sales.iterrows():
    email = customers.loc[customers["customer_id"] == row["customer_id"], "email"].values[0]
    db_customer_id = cust_map[email]

    order_key = (db_customer_id, row["transaction_date"], row["status"])

    if order_key not in order_lookup:
        cursor.execute("""
            INSERT INTO orders (customer_id, order_date, total_amount, status)
            VALUES (%s,%s,0,%s)
        """, (db_customer_id, row["transaction_date"], row["status"]))
        conn.commit()
        order_lookup[order_key] = cursor.lastrowid

    order_id = order_lookup[order_key]

    product_rows = products.loc[products["product_id"] == row["product_id"]]
    if product_rows.empty:
        continue

    product_name = product_rows["product_name"].values[0]
    db_product_id = prod_map[product_name]

    subtotal = row["quantity"] * row["unit_price"]

    cursor.execute("""
        INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
        VALUES (%s,%s,%s,%s,%s)
    """, (order_id, db_product_id, row["quantity"], row["unit_price"], subtotal))

    cursor.execute("""
        UPDATE orders SET total_amount = total_amount + %s WHERE order_id = %s
    """, (subtotal, order_id))

conn.commit()


with open("data_quality_report.txt", "w") as f:
    f.write("DATA QUALITY REPORT\n")
    f.write("-------------------\n")
    f.write(f"Customers records processed: {cust_before}\n")
    f.write(f"Customers duplicates removed: {cust_duplicates}\n")
    f.write(f"Customers missing emails fixed: {cust_missing_emails}\n")
    f.write(f"Customers records loaded: {len(customers)}\n\n")
    f.write(f"Products records processed: {prod_before}\n")
    f.write(f"Products missing price removed: {prod_missing_price}\n")
    f.write(f"Products missing stock fixed: {prod_missing_stock}\n")
    f.write(f"Products records loaded: {len(products)}\n\n")
    f.write(f"Sales records processed: {sales_before}\n")
    f.write(f"Sales duplicate transactions removed: {sales_duplicates}\n")
    f.write(f"Sales records with missing IDs removed: {sales_missing_ids}\n")
    f.write(f"Sales records loaded: {len(sales)}\n")



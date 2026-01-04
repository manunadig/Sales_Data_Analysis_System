import pandas as pd
import sqlite3

df = pd.read_csv("data/raw_sales.csv")

df['order_date'] = pd.to_datetime(df['order_date'])

df['revenue'] = df['quantity'] * df['price']

conn = sqlite3.connect("database/sales.db")

df.to_sql("sales", conn, if_exists="replace", index=False)

query_total_sales = """
SELECT SUM(revenue) AS total_revenue FROM sales;
"""
query_category_sales = """
SELECT category, SUM(revenue) AS category_revenue
FROM sales
GROUP BY category;
"""
total_sales = pd.read_sql(query_total_sales, conn)
category_sales = pd.read_sql(query_category_sales, conn)

print("Total Sales Revenue:")
print(total_sales)

print("\nCategory-wise Sales:")
print(category_sales)


df.to_csv("data/cleaned_sales.csv", index=False)

conn.close()

print("\nData processing completed successfully.")

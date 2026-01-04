import sqlite3

conn = sqlite3.connect("sales.db")
cursor = conn.cursor()

cursor.execute("SELECT SUM(revenue) FROM sales")
print(cursor.fetchone())

conn.close()

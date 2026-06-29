import sqlite3
import pandas as pd

# Read cleaned dataset
df = pd.read_csv("data/processed/cleaned_telco.csv")

# Connect to SQLite
conn = sqlite3.connect("data/customer_churn.db")

# Create table
df.to_sql(
    "customer_churn",
    conn,
    if_exists="replace",
    index=False
)

print("Database created successfully!")

conn.close()
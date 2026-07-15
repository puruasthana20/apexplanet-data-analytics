import os
import sqlite3
import pandas as pd

# ----------------------------
# Paths
# ----------------------------

from pathlib import Path

# Project root
BASE_DIR = Path(__file__).resolve().parent.parent

# Paths
RAW_DATA = BASE_DIR / "data" / "raw" / "telco_churn.csv"
PROCESSED_DATA = BASE_DIR / "data" / "processed" / "cleaned_telco.csv"
DATABASE = BASE_DIR / "data" / "customer_churn.db"
OUTPUT = BASE_DIR / "reports" / "analytics_summary.txt"
# ----------------------------
# Load Dataset
# ----------------------------

print("=" * 50)
print("Loading Dataset...")

df = pd.read_csv(RAW_DATA)

print(f"Rows: {df.shape[0]}")
print(f"Columns: {df.shape[1]}")

# ----------------------------
# Data Cleaning
# ----------------------------

print("\nCleaning Dataset...")

df.columns = (
    df.columns
      .str.strip()
      .str.replace(" ", "_")
)

df.drop_duplicates(inplace=True)

df["Total_Charges"] = pd.to_numeric(
    df["Total_Charges"],
    errors="coerce"
)

df["Total_Charges"] = df["Total_Charges"].fillna(
    df["Total_Charges"].median()
)

# ----------------------------
# Save Processed Dataset
# ----------------------------

PROCESSED_DATA.parent.mkdir(parents=True, exist_ok=True)

df.to_csv(PROCESSED_DATA, index=False)

print("Processed dataset saved.")

# ----------------------------
# Create SQLite Database
# ----------------------------

print("\nUpdating Database...")

conn = sqlite3.connect(DATABASE)

df.to_sql(
    "customer_churn",
    conn,
    if_exists="replace",
    index=False
)

conn.close()

print("Database updated.")

# ----------------------------
# Generate KPIs
# ----------------------------

total_customers = len(df)

churn_rate = (
    (df["Churn_Label"] == "Yes").mean() * 100
)

avg_monthly = df["Monthly_Charges"].mean()

avg_tenure = df["Tenure_Months"].mean()

avg_cltv = df["CLTV"].mean()

# ----------------------------
# Save Summary Report
# ----------------------------

Path(OUTPUT).parent.mkdir(parents=True, exist_ok=True)

with open(OUTPUT, "w") as file:

    file.write("CUSTOMER CHURN ANALYTICS SUMMARY\n")
    file.write("=" * 50 + "\n\n")

    file.write(f"Total Customers : {total_customers}\n")
    file.write(f"Churn Rate      : {churn_rate:.2f}%\n")
    file.write(f"Average Charges : {avg_monthly:.2f}\n")
    file.write(f"Average Tenure  : {avg_tenure:.2f}\n")
    file.write(f"Average CLTV    : {avg_cltv:.2f}\n")

print("\nAnalytics summary generated.")

print("=" * 50)
print("Pipeline Completed Successfully.")
print("=" * 50)
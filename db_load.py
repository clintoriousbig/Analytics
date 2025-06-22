import duckdb
import os
import pandas as pd

# === Config ===
data_folder = "/Users/clintgilmore/Desktop/Analytics/DATA"
db_path = "analytics.db"

# === Connect to DuckDB ===
con = duckdb.connect(db_path)

# === Optional: Clear old tables ===
tables_to_clear = ["AUS_1d", "AUS_1h", "AUS_5m", "AUS_10m", "SPX_1d", "SPX_1h", "SPX_5m", "SPX_10m", "UK_1d", "XAU_1d", "BCO_1d", "AUD_1d"]
for table in tables_to_clear:
    try:
        con.execute(f"DROP TABLE IF EXISTS {table}")
    except Exception as e:
        print(f"Failed to drop {table}: {e}")

# === Load CSVs ===
for filename in os.listdir(data_folder):
    if not filename.endswith(".csv"):
        continue
    
    file_path = os.path.join(data_folder, filename)
    
    # e.g. AUS1d.csv → table name = AUS_1d
    base = os.path.splitext(filename)[0]
    table_name = base.replace("1d", "_1d").replace("1h", "_1h").replace("5m", "_5m").replace("10m", "_10m")

    print(f"Loading {file_path} into table {table_name}")

    con.execute(f"""
        CREATE TABLE {table_name} AS 
        SELECT * FROM read_csv_auto('{file_path}')
    """)

print("✅ All CSVs loaded into DuckDB.")

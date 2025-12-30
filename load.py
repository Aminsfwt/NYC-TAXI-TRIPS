import pyodbc
import pandas as pd
from sqlalchemy import create_engine

# --- Source Database Connection ---
source_conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=AMENSFWT\SQLEXPRESS;"
    "DATABASE=NYC_TAXI;"
    "Trusted_Connection=yes;"
    
   
      
)
source_conn = pyodbc.connect(source_conn_str)

# --- Target Database Connection ---
target_conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=TARGET_SERVER_NAME;"
    "DATABASE=NYC_TRYBS_DWH;"
    "Trusted_Connection=yes;""
)
engine = create_engine(
    "mssql+pyodbc://@AMENSFWT/SQLEXPRESS/NYC_TRYBS_DWH?driver=ODBC+Driver+18+for+SQL+Server&TrustServerCertificate=yes"
)

# --- Tables to copy ---
tables = ["Rates", "Vendors", "payments", "taxi_trips", "taxi_zones", "trip_types"]

for table in tables:
    print(f"Loading table: {table}")
    
    # Read from source
    query = f"SELECT * FROM dbo.{table}"
    df = pd.read_sql(query, source_conn)
    
    # Load into target schema raw_data
    df.to_sql(table, con=engine, schema='raw_data', if_exists='replace', index=False, chunksize=10000)
    
    print(f"Table {table} loaded successfully!")

# --- Close source connection ---
source_conn.close()

print("All tables transferred successfully!")

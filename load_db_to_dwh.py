import pandas as pd
from sqlalchemy import create_engine

# Make MS SQL Server Connection for the source database
source_engine = create_engine(
    "mssql+pyodbc://@AMENSFWT\\SQLEXPRESS/NYC_TAXI?"  #server name
    "driver=ODBC+Driver+17+for+SQL+Server&" #used driver
    "Trusted_Connection=yes&" #using windows authentication
    "TrustServerCertificate=yes"
)

# Make MS SQL Server Connection for the target database
target_engine = create_engine(
    "mssql+pyodbc://@AMENSFWT\\SQLEXPRESS/NYC_TAXI_DWH?"  
    "driver=ODBC+Driver+17+for+SQL+Server&"
    "Trusted_Connection=yes&"
    "TrustServerCertificate=yes",
    fast_executemany=True   #uses ODBC's optimized bulk insert (no 2100-parameter limit)
)

#tables that loaded from db
tables = ["Rates", "Vendors", "payments", "taxi_zones", "trip_types", "taxi_trips"]

for table in tables:
    print(f"Loading table: {table}")
    
    query = f"SELECT * FROM dbo.{table}"
    df = pd.read_sql(query, source_engine)
    
    print(f"   Read {len(df):,} rows, {len(df.columns)} columns")
    
    table_name = table.lower()
    
    #Drop table first for clean replace
    with target_engine.connect() as conn:
        conn.execute(text(f"DROP TABLE IF EXISTS raw_data.{table_name}"))
        conn.commit()
    
    df.to_sql(
        name=table_name,
        con=target_engine,
        schema='raw_data',
        if_exists='replace',
        index=False,
        chunksize=10000,
    )
    
    print(f"Table {table} loaded successfully!\n")

print("All tables transferred successfully!")
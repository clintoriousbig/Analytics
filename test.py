import duckdb

con = duckdb.connect("/Users/clintgilmore/Desktop/Analytics/analytics.db")

# See all tables/views created by dbt
print(con.execute("SHOW TABLES").fetchall())

# Query a specific model/table (e.g., 'my_model')
df = con.execute("SELECT * FROM test LIMIT 10").df()
print(df)

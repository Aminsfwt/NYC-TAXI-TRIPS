#!/bin/bash

"/e/ITI Data Visualization Track/Data Science/DBT/Codes/snowflake_wh/dbt-env/Scripts/python.exe" -m dbt clean
"/e/ITI Data Visualization Track/Data Science/DBT/Codes/snowflake_wh/dbt-env/Scripts/python.exe" -m dbt deps
"/e/ITI Data Visualization Track/Data Science/DBT/Codes/snowflake_wh/dbt-env/Scripts/python.exe" -m dbt compile
"/e/ITI Data Visualization Track/Data Science/DBT/Codes/snowflake_wh/dbt-env/Scripts/python.exe" -m dbt test

echo "All done!"
 
/*
{% macro create_warehouse_schema() %}

  {% set sql %}
    CREATE SCHEMA warehouse AUTHORIZATION dbo;
  {% endset %}

  {% do run_query(sql) %}
  {% do log("Schema 'warehouse' created (or already exists)", info=True) %}
{% endmacro %}*/
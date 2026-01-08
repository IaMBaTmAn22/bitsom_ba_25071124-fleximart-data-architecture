# FlexiMart Data Architecture Project
Student Name: Ganesh Bharadwaj
Student ID: BITSoM_BA_25071124
Email: ganeshb2208@gmail.com
Date: 08-01-2026

## Project Overview

This project is for building an ETL pipeline for FlexiMart. This build a complete analysis system starting from CSV files. ETL pipeline has been built using python, Relatioal Database in MySQL, NoSQL using MongoDB and Star schema data warehouse with OLAP queries.


## Repository Structure
├── part1-database-etl/
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   └── data_quality_report.txt
├── part2-nosql/
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
├── part3-datawarehouse/
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
└── README.md


## Technologies Used

- Python 3.x, pandas, mysql-connector-python
- MySQL 8.0
- MongoDB 6.0



## Setup Instructions

### Database Setup

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql


### MongoDB Setup

mongosh < part2-nosql/mongodb_operations.js

## Key Learnings

1. Data Cleaning and transformation using pandas in python.
2. Understood how relational database, NOSQL databases and data warehouse are different from each other and thier respective uses.
3. Learnt about star schema and OLAP queries

## Challenges Faced

1. Handling missing values and duplicate records during ETL was challenging, especially when enforcing database constraints.
2. Designing realistic warehouse data while maintaining foreign key consistency required careful planning.

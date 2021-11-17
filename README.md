Introducion
 Instacart, a grocery ordering and delivery app, has provided a dataset that can be worked with to create a datawarehouse model. The data that they have provided will be moved to S3. We will build an ETL pipeline that extracts their data from S3, stages them in Redshift, and transforms data into a set of dimensional tables for analytics. 

Project Datasets
The project data set can be downloaded from https://www.kaggle.com/c/instacart-market-basket-analysis/data. 

Aisle Dataset (134 rows): 
The first dataset from "aisle.csv", provides two columns "aisle_id" and "aisle" which are comma separated. 
aisle_id: aisle identifier
aisle: the name of the aisle

Department Dataset (21 rows): 
The Department dataset from "departments.csv" also provides two columns "department_id" and "department" which are comma separated. 
department_id: department identifier
department: the name of the department

Orders Dataset (3.4m rows, 206k users) 
The Orders dataset from "orders.csv" provides valueable information for each order. The file contains 
order_id: order identifier
user_id: customer identifier
eval_set: which evaluation set this order belongs in (see SET described below)
order_number: the order sequence number for this user (1 = first, n = nth)
order_dow: the day of the week the order was placed on
order_hour_of_day: the hour of the day the order was placed on
days_since_prior: days since the last order, capped at 30 (with NAs for order_number = 1)

Products Dataset (50k rows) 
The Products dataset from "products.csv" gives us four columns.
product_id: product identifier
product_name: name of the product
aisle_id: foreign key
department_id: foreign key

Order Products Prior Dataset  

order_products_PRIOR (~3.2m orders):
order_id: foreign key
product_id: foreign key
add_to_cart_order: order in which each product was added to cart
reordered: 1 if this product has been ordered by this user in the past, 0 otherwise
eval_set:  one of the four following evaluation sets (eval_set in orders):
          "prior": orders prior to that users most recent order 
          "train": training data supplied to participants (~131k orders)
          "test": test data reserved for machine learning competitions (~75k orders)

Schema for Instacart Basket Analysis
Using the above datasets, we'll  create a star schema optimized for queries. This includes the following tables.

Fact Table
1.fact_sales - records each user, user's orders, order's products, its department and aisles and their counts by time and date. 

USER_KEY, ORDER_KEY, PRODUCT_KEY, DEPARTMENT_KEY, AISLE_KEY, DATE_KEY, TIME_KEY

Dimension Tables
2.dim_user - users in the app
user_key, user_id, first_name, last_name, address, phone, state and city

3.dim_product - products listed
product_key, product_id, product_desc

4.dim_ - artists in music database

artist_id, name, location, latitude, longitude
5.time - timestamps of records in songplays broken down into specific units

start_time, hour, day, week, month, year, weekday
Project Template
In addition to the data files, the project workspace includes six files:

1.test.ipynb displays the first few rows of each table to let you check your database.
2.create_tables.py drops and creates fact and dimension tables for the star schema in Redshift.
3.etl.py load data from S3 into staging tables on Redshift and then process that data into your analytics tables on Redshift.
4.sql_queries.py contains SQL statements, which will be imported into the two other files above.
5.README.md provides discussion on your process and decisions for this ETL pipeline.

Project Steps
Create Table Schemas
1.Design schemas for your fact and dimension tables
2.Write a SQL CREATE statement for each of these tables in sql_queries.py
3.Complete the logic in create_tables.py to connect to the database and create these tables
4.Write SQL DROP statements to drop tables in the beginning of create_tables.py if the tables already exist. This way, you can run create_tables.py whenever you want to reset your database and test your ETL pipeline.
5.Launch a redshift cluster and create an IAM role that has read access to S3.
6.Add redshift database and IAM role info to dwh.cfg
7.Test by running create_tables.py and checking the table schemas in your redshift database. You can use Query Editor in the AWS Redshift console for this.

Build ETL Pipeline
1.Implement the logic in etl.py to load data from S3 to staging tables on Redshift.
2.Implement the logic in etl.py to load data from staging tables to analytics tables on Redshift.
3.Test by running etl.py after running create_tables.py and running the analytic queries on your Redshift database to compare your results with the expected results.
4.Delete your redshift cluster when finished.

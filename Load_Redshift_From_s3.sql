-- Load instacart data from s3 into redshift
COPY INSTACART.STG_DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_DESC)
FROM 's3://instacartmarketbasketanalysis/departments.csv' 
iam_role 'arn:aws:iam::411840229458:role/myRedshiftRole' 
csv
delimiter ',';

COPY INSTACART.STG_PRODUCT (PRODUCT_ID, PRODUCT_DESC,AISLE_ID,DEPARTMENT_ID)
FROM 's3://instacartmarketbasketanalysis/products.csv' 
iam_role 'arn:aws:iam::411840229458:role/myRedshiftRole' 
csv
delimiter ','
IGNOREHEADER 1;

COPY INSTACART.STG_AISLE (AISLE_ID, AISLE_DESC)
FROM 's3://instacartmarketbasketanalysis/aisles.csv' 
iam_role 'arn:aws:iam::411840229458:role/myRedshiftRole' 
csv
delimiter ',';

COPY INSTACART.STG_ORDER (ORDER_ID, USER_ID, EVAL_SET,ORDER_NUM, ORDER_DOW, ORDER_HR, DAYS_SINCE_LAST_ORDER)
FROM 's3://instacartmarketbasketanalysis/orders.csv' 
iam_role 'arn:aws:iam::411840229458:role/myRedshiftRole' 
csv
delimiter ','
ignoreheader 1;

COPY INSTACART.STG_ORDER_PRODUCTS (ORDER_ID, PRODUCT_ID, ADD_TO_CART_ORDER,REORDERED)
FROM 's3://instacartmarketbasketanalysis/order_products_prior.csv' 
iam_role 'arn:aws:iam::411840229458:role/myRedshiftRole' 
csv
delimiter ','
ignoreheader 1;
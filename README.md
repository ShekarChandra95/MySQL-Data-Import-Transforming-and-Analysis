# MySQL-Data-Import-Transforming-and-Analysis
This document serves as a comprehensive reference guide for importing Excel/CSV data into MySQL, cleaning and formatting data types, executing targeted data queries, and analyzing duplicate customer transactions.

## Table of Contents

1. Overview & Prerequisites

2. Table Structure & Column Management

3. Data Cleaning & Type Conversion

4. Data Retrieval & Formatting Queries

5. Duplicate Record Analysis

## Overview & Prerequisites

When importing dataset files (Excel/CSV) into MySQL Workbench, columns containing non-standard formatting (such as commas in numbers, currency symbols, custom date structures, or percentage signs) are frequently imported as VARCHAR (text) or trigger import errors.

### Resolving "Safe Update" Warnings

Before executing bulk update commands across columns without a primary key filter, temporarily disable Safe Update Mode:

```
-- Disable safe mode
SET SQL_SAFE_UPDATES = 0;

-- Re-enable safe mode (run after completing cleanup updates)
SET SQL_SAFE_UPDATES = 1;
```

## Table Structure & Column Management

Add Columns
```
-- Add a single column
ALTER TABLE customer_invoice 
ADD COLUMN column_name VARCHAR(50);

-- Add multiple columns simultaneously
ALTER TABLE customer_invoice 
ADD COLUMN first_name VARCHAR(50),
ADD COLUMN last_name VARCHAR(50),
ADD COLUMN hire_date DATE;
```
Remove Columns

```
ALTER TABLE customer_invoice 
DROP COLUMN idcustomer_data;
```

## Data Cleaning & Type Conversion

A. Fixing Date Values (```DD-MM-YYYY``` to ```DATE```)

If dates fail during import due to formatting, store them initially as text (```VARCHAR```) or clean existing text dates before converting to MySQL’s standard ```YYYY-MM-DD``` data type.

B. Cleaning Amount / Currency Columns (```VARCHAR``` to ```DECIMAL```)

Strips thousand-separator commas (```,```) and currency signs (```$```) from text columns, then alters the column data type to ```DECIMAL(10,2)``` for accurate financial calculation.

```
-- 1. Remove commas and currency signs
UPDATE your_table_name 
SET amount_column = REPLACE(REPLACE(amount_column, ',', ''), '$', ''),
    tax_column    = REPLACE(REPLACE(tax_column, ',', ''), '$', '');

-- 2. Convert column data types
ALTER TABLE your_table_name 
MODIFY COLUMN amount_column DECIMAL(10,2),
MODIFY COLUMN tax_column DECIMAL(10,2);
```

C. Converting Percentage Values

Strips ```%``` characters and converts the data type to store decimal percentages.

```
-- 1. Remove percentage signs
UPDATE customer_invoice 
SET GST_per = REPLACE(GST_per, '%', '');

-- 2. Modify data type (e.g., DECIMAL(5,2) for values up to 999.99%)
ALTER TABLE your_table_name 
MODIFY COLUMN percentage_column DECIMAL(5,2);
```

## Data Retrieval & Formatting Queries

Display Formatted Amounts and Dates

Format outputs for reporting without modifying underlying database values.
```
-- Retrieve records where invoice amount is less than 45,000
SELECT 
    DATE_FORMAT(cr_date, '%d-%m-%Y') AS formatted_date, 
    FORMAT(amount_column, 2) AS formatted_amount 
FROM your_table_name 
WHERE amount_column < 45000.00;
```

## Duplicate Record Analysis

A. List Duplicate Customers with Count
```
SELECT 
    Customer_Name, 
    COUNT(*) AS duplicate_count 
FROM customer_invoice 
GROUP BY Customer_Name 
HAVING COUNT(*) > 1;
```

B. Retrieve All Individual Transactions for Duplicate Customers
```
SELECT * 
FROM customer_invoice 
WHERE Customer_Name IN (
    SELECT customer_name_column 
    FROM customer_invoice 
    GROUP BY Customer_Name
    HAVING COUNT(*) > 1
)
ORDER BY Customer_Name;
```

C. Find Duplicate Customers with Amount > 45,000 & Get Maximum Amount

Filters transactions greater than 45,000, identifies customers appearing more than once in that filtered set, and displays their highest single transaction amount.

```
SELECT 
    Customer_Name, 
    COUNT(*) AS duplicate_count, 
    MAX(amount_column) AS max_amount
FROM customer_invoice
WHERE Invoice_Amount > 45000
GROUP BY Customer_Name
HAVING COUNT(*) > 1
ORDER BY max_amount DESC;
```

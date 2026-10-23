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
ALTER TABLE your_table_name 
ADD COLUMN column_name VARCHAR(50);

-- Add multiple columns simultaneously
ALTER TABLE your_table_name 
ADD COLUMN first_name VARCHAR(50),
ADD COLUMN last_name VARCHAR(50),
ADD COLUMN hire_date DATE;
```
Remove Columns

```
ALTER TABLE your_table_name 
DROP COLUMN column_name;
```

## Data Cleaning & Type Conversion

A. Fixing Date Values (DD-MM-YYYY to DATE)

If dates fail during import due to formatting, store them initially as text (```VARCHAR```) or clean existing text dates before converting to MySQL’s standard ```YYYY-MM-DD``` data type.

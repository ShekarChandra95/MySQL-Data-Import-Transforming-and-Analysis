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

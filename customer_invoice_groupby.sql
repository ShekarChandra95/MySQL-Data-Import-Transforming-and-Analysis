-- SELECT cr_date, Invoice_Amount, Customer_Name
-- FROM customer_invoice
-- WHERE Invoice_Amount > 45000;

SELECT Customer_Name,
	COUNT(*) AS DUPLICATE_COUNT,
    max(Invoice_Amount) as Max_Amount
FROM customer_invoice
WHERE Invoice_Amount > 45000
Group by Customer_Name
Having count(*) > 1;

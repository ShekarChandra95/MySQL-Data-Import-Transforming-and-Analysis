SET SQL_SAFE_UPDATES = 0;
UPDATE customer_invoice
SET cr_date = str_to_date(cr_date, '%d-%m-%Y'),
	Invoice_Amount = Replace(replace(Invoice_Amount, ',',''),'₹',''),
	Taxable_Value = Replace(replace(Taxable_Value, ',',''),'₹',''),
    GST_per = Replace(GST_per, '%',''),
	CGST = Replace(replace(CGST, ',',''),'₹',''),
	SGCT = Replace(replace(SGCT, ',',''),'₹',''),
	IGST = Replace(replace(IGST, ',',''),'₹',''),
	Grand_Total = Replace(replace(Grand_Total, ',',''),'₹','');

SET SQL_SAFE_UPDATES = 1;

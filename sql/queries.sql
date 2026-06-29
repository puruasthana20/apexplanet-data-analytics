SELECT *
FROM customer_churn;

SELECT CustomerID,
       Gender,
       Monthly_Charges
FROM customer_churn;

SELECT *
FROM customer_churn
WHERE Churn_Label='Yes';

SELECT *
FROM customer_churn
WHERE Monthly_Charges>80;

SELECT *
FROM customer_churn
ORDER BY Monthly_Charges DESC;

SELECT *
FROM customer_churn
LIMIT 10;

SELECT AVG(Monthly_Charges)
FROM customer_churn;

SELECT MAX(Total_Charges)
FROM customer_churn;

SELECT COUNT(*)
FROM customer_churn;

SELECT Churn_Label,
COUNT(*)
FROM customer_churn
GROUP BY Churn_Label;

SELECT Contract,
AVG(Monthly_Charges)
FROM customer_churn
GROUP BY Contract;

SELECT Contract,
AVG(Monthly_Charges)
FROM customer_churn
GROUP BY Contract;

SELECT CustomerID,
Total_Charges
FROM customer_churn
ORDER BY Total_Charges DESC
LIMIT 10;

SELECT Internet_Service,
AVG(Monthly_Charges)
FROM customer_churn
GROUP BY Internet_Service;

SELECT Payment_Method,
COUNT(*)
FROM customer_churn
WHERE Churn_Label='Yes'
GROUP BY Payment_Method;

SELECT AVG(Tenure_Months)
FROM customer_churn;

SELECT COUNT(*)
FROM customer_churn
WHERE Senior_Citizen=1
AND Churn_Label='Yes';

SELECT Internet_Service,
COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY Internet_Service;

SELECT Contract,
AVG(Total_Charges) AS Avg_Total_Charges
FROM customer_churn
GROUP BY Contract;

SELECT Contract,
COUNT(*) AS Churned_Customers
FROM customer_churn
WHERE Churn_Label='Yes'
GROUP BY Contract;

SELECT Contract,
COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY Contract
HAVING COUNT(*) > 1000;

SELECT CustomerID,
Monthly_Charges,
CASE
    WHEN Monthly_Charges < 40 THEN 'Low'
    WHEN Monthly_Charges BETWEEN 40 AND 80 THEN 'Medium'
    ELSE 'High'
END AS Charge_Category
FROM customer_churn;

SELECT City,
COUNT(*) AS Churned
FROM customer_churn
WHERE Churn_Label='Yes'
GROUP BY City
ORDER BY Churned DESC
LIMIT 5;

SELECT CustomerID,
Monthly_Charges
FROM customer_churn
WHERE Monthly_Charges >
(
    SELECT AVG(Monthly_Charges)
    FROM customer_churn
);

WITH AvgCharge AS
(
SELECT AVG(Monthly_Charges) AS AvgMonthly
FROM customer_churn
)

SELECT CustomerID,
Monthly_Charges
FROM customer_churn,
AvgCharge
WHERE Monthly_Charges > AvgMonthly;

SELECT CustomerID,
Total_Charges,
ROW_NUMBER() OVER
(
ORDER BY Total_Charges DESC
) AS Rank_No
FROM customer_churn;

SELECT CustomerID,
Total_Charges,
RANK() OVER
(
ORDER BY Total_Charges DESC
) AS Customer_Rank
FROM customer_churn;

SELECT CustomerID,
Total_Charges,
RANK() OVER
(
ORDER BY Total_Charges DESC
) AS Customer_Rank
FROM customer_churn;


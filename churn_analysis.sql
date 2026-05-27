use telecom_churn;

CREATE TABLE customers (
	customerID varchar(20),
	gender varchar(10),
	SeniorCitizen INT,
	Partner VARCHAR(5),
	Dependents VARCHAR(5),
	tenure INT,
	PhoneService VARCHAR(5),
	MultipleLines VARCHAR(20),
	InternetService VARCHAR(20),
	OnlineSecurity VARCHAR(20),
	OnlineBackup VARCHAR(20),
	DeviceProtection VARCHAR(20),
	TechSupport VARCHAR(20),
	StreamingTV VARCHAR(20),
	StreamingMovies VARCHAR(20),
	Contract VARCHAR(20),
	PaperlessBilling VARCHAR(5),
	PaymentMethod VARCHAR(30),
	MonthlyCharges DECIMAL(10, 2),
	TotalCharges VARCHAR(20),
	Churn VARCHAR(5)
);

SELECT 
    SUM(CASE WHEN customerID IS NULL THEN 1 ELSE 0 END) AS null_customerID,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS null_tenure,
    SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS null_monthly,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_total,
    SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS null_churn
FROM customers;


SELECT
	Churn,
	count(*) AS total,
	ROUND(count(*) * 100.0 / (SELECT Count(*) FROM customers),2) AS percentage
FROM
	customers
GROUP BY
	Churn
	
Select DISTINCT Contract From customers;
Select DISTINCT InternetService from customers;
Select Distinct PaymentMethod from customers;

update Customers
SET totalcharges = NULL
WHERE trim(totalcharges) = '';

Alter Table customers
modify column TotalCharges Decimal (10,2);

Select customerID, MonthlyCharges, TotalCharges
from customers
Limit 10;

Describe customers

CREATE TABLE customers_clean AS
SELECT 
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    Contract,
    InternetService,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn,
    CASE 
        WHEN tenure <= 12 THEN 'New (0-1 yr)'
        WHEN tenure <= 24 THEN 'Growing (1-2 yr)'
        WHEN tenure <= 48 THEN 'Mature (2-4 yr)'
        ELSE 'Loyal (4+ yr)'
    END AS tenure_group
FROM customers
WHERE customerID IS NOT NULL;


## table correction
DROP TABLE customers_clean;

CREATE TABLE customers_clean AS
SELECT 
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn,
    CASE 
        WHEN tenure <= 12 THEN 'New (0-1 yr)'
        WHEN tenure <= 24 THEN 'Growing (1-2 yr)'
        WHEN tenure <= 48 THEN 'Mature (2-4 yr)'
        ELSE 'Loyal (4+ yr)'
    END AS tenure_group
FROM customers
WHERE customerID IS NOT NULL;

SELECT customerID, tenure, tenure_group, Contract, Churn
FROM customers_clean
LIMIT 10;

#Q1

Select Gender,
	   Count(*) as Total,
	   Sum(Case when Churn = 'YES' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
From Customers_clean
group by Gender;

#Q2

Select CASE when Seniorcitizen = '1' then "senior" else "non-senior" end as senior_or_not,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by SeniorCitizen 

#Q3

Select Partner,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by Partner

#Q4

Select Dependents,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by Dependents

#Churn By services

#Q1

Select InternetService,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by InternetService

#Q2


Select PhoneService,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by PhoneService

DESCRIBE customers_clean;


#Q3


Select OnlineSecurity,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by OnlineSecurity

#Q4


Select StreamingTV,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by StreamingTV

#3 chrun By contract TYPE

#Q1

Select Contract,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by Contract

#Q2

Select PaymentMethod,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by PaymentMethod

#Q3
Select paperlessbilling,
	   Count(*) as Total,
	   Sum(Case when Churn = 'Yes' then 1 else 0 end) as churned,
	   Round(Sum(Case when Churn = 'Yes' then 1 else 0 end)*100.0/ Count(*), 2) as Churned_rate
from customers_clean
group by paperlessbilling

## Churn By tenure&charges

#Q1

Select tenure_group,Churn,
	   ROUND(AVG(MonthlyCharges), 2) AS avg_monthly,
       ROUND(AVG(TotalCharges), 2) AS avg_total
From customers_clean
group by tenure_group,Churn

#Q2
SELECT 
    Churn,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers_clean), 2) AS percentage
FROM customers_clean
GROUP BY Churn;
#Q3
Select Case 
		when MonthlyCharges < 30 then 'Low'
		when MonthlyCharges < 60 then 'Mid' 
		when MonthlyCharges < 90 then 'high'
		else 'Very high' end as Charge_bucket, 
	   count(*) as total,
	   ROUND(AVG(MonthlyCharges), 2) AS avg_monthly,
       ROUND(AVG(TotalCharges), 2) AS avg_total
From customers_clean
group by Charge_bucket

##cohort analysis

WITH cohort AS (
    SELECT 
        tenure_group,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
    FROM customers_clean
    GROUP BY tenure_group
)
SELECT 
    tenure_group,
    total_customers,
    churned_customers,
    ROUND(churned_customers * 100.0 / total_customers, 2) AS churn_rate
FROM cohort
ORDER BY churn_rate DESC;


SELECT 
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    tenure_group,
    Contract,
    InternetService,
    PaymentMethod,
    PaperlessBilling,
    OnlineSecurity,
    StreamingTV,
    MonthlyCharges,
    TotalCharges,
    Churn
FROM customers_clean;

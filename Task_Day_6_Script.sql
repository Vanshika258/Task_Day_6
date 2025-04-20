CREATE DATABASE online_sales_db;
USE online_sales_db;
CREATE TABLE sales_online (
    InvoiceNo INT,
    StockCode VARCHAR(50),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    Country VARCHAR(100),
    Discount DECIMAL(10,2),
    PaymentMethod VARCHAR(100),
    Category VARCHAR(100),
    SalesChannel VARCHAR(100),
    ReturnStatus VARCHAR(50),
    ShipmentProvider VARCHAR(100),
    OrderPriority VARCHAR(50)
);
LOAD DATA LOCAL INFILE 'C:/Users/chira/Desktop/Vanshika/5/cleaned_data_task_6.csv'
INTO TABLE sales_online
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
DESCRIBE sales_online;
SELECT * FROM sales_online;
-- Step 1: Monthly Revenue and Order Volume Trend
SELECT
    EXTRACT(YEAR FROM InvoiceDate) AS order_year,
    EXTRACT(MONTH FROM InvoiceDate) AS order_month,
    ROUND(SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS order_volume
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned' -- Exclude returns if applicable
GROUP BY
    EXTRACT(YEAR FROM InvoiceDate),
    EXTRACT(MONTH FROM InvoiceDate)
ORDER BY
    order_year,
    order_month;
-- Step 2: Top 10 Best-Selling Products by Revenue
SELECT
    Description,
    ROUND(SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS total_revenue
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned'
GROUP BY
    Description
ORDER BY
    total_revenue DESC
LIMIT 10;
-- Step 3: Monthly Revenue by Sales Channel
SELECT
    EXTRACT(YEAR FROM InvoiceDate) AS year,
    EXTRACT(MONTH FROM InvoiceDate) AS month,
    SalesChannel,
    ROUND(SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS revenue
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned'
GROUP BY
    year, month, SalesChannel
ORDER BY
    year, month;
-- Step 4: Revenue by Country
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS total_revenue
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned'
GROUP BY
    Country
ORDER BY
    total_revenue DESC;
-- Step 5: Monthly Order Count by Order Priority
SELECT
    EXTRACT(YEAR FROM InvoiceDate) AS year,
    EXTRACT(MONTH FROM InvoiceDate) AS month,
    OrderPriority,
    COUNT(DISTINCT InvoiceNo) AS order_count
FROM
    sales_online
GROUP BY
    year, month, OrderPriority
ORDER BY
    year, month, order_count DESC;
-- Step 6: Return Rate Over Time
SELECT
    EXTRACT(YEAR FROM InvoiceDate) AS year,
    EXTRACT(MONTH FROM InvoiceDate) AS month,
    COUNT(CASE WHEN ReturnStatus = 'Returned' THEN 1 END) AS returned_orders,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(CASE WHEN ReturnStatus = 'Returned' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS return_rate_percent
FROM
    sales_online
GROUP BY
    year, month
ORDER BY
    year, month;
-- Step 7: Average Discount per Category
SELECT
    Category,
    ROUND(AVG(Discount) * 100, 2) AS average_discount_percent,
    COUNT(*) AS total_items_sold
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned'
GROUP BY
    Category
ORDER BY
    average_discount_percent DESC;
-- Step 8: Sales by Shipment Provider
SELECT
    ShipmentProvider,
    ROUND(SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned'
GROUP BY
    ShipmentProvider
ORDER BY
    total_revenue DESC;
-- Step 9: Time of Day Trend
SELECT
    HOUR(InvoiceDate) AS hour_of_day,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    ROUND(SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS total_revenue
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned'
GROUP BY
    hour_of_day
ORDER BY
    hour_of_day;
-- Step 10: Profitability by Payment Method
SELECT
    PaymentMethod,
    ROUND(SUM((UnitPrice - (UnitPrice * 0.70)) * Quantity * (1 - Discount)), 2) AS total_profit,
    ROUND(SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS total_revenue,
    ROUND(100 * SUM((UnitPrice - (UnitPrice * 0.70)) * Quantity * (1 - Discount)) 
               / SUM(Quantity * UnitPrice * (1 - Discount)), 2) AS profit_margin_percent
FROM
    sales_online
WHERE
    ReturnStatus IS NULL OR ReturnStatus != 'Returned'
GROUP BY
    PaymentMethod
ORDER BY
    total_profit DESC;
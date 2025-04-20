# Task_Day_6
 Sales Trend Analysis Using Aggregations
# 📊 Online Sales Trend Analysis using MySQL

This project provides in-depth trend and performance analysis of an e-commerce dataset using SQL. The analysis was performed using MySQL on a cleaned dataset named `sales_online`.

---

## 📁 Files Included

- `sales_analysis.sql`: Contains 10 SQL queries that extract various insights from the dataset.
- `results/`: CSV files containing top 10 results for each query.
- `cleaned_data_task_6.csv`: (Optional) Cleaned dataset used in the analysis.
- `README.md`: Documentation of the project.

---

## 🧾 Dataset Schema

The `sales_online` table includes:

| Column Name       | Description                        |
|-------------------|------------------------------------|
| InvoiceNo         | Unique invoice/order number        |
| StockCode         | Product/Item code                  |
| Description       | Item description                   |
| Quantity          | Quantity purchased                 |
| InvoiceDate       | Date and time of order             |
| UnitPrice         | Price per unit                     |
| Country           | Country of sale                    |
| Discount          | Discount applied (0–1)             |
| PaymentMethod     | Payment type (e.g. Card, Cash)     |
| Category          | Product category                   |
| SalesChannel      | Online/Offline                     |
| ReturnStatus      | Returned/Not Returned              |
| ShipmentProvider  | Courier or logistics provider      |
| OrderPriority     | Low, Medium, High, Critical        |

---

## 📌 SQL Analyses Performed

### 1. **Monthly Revenue & Order Volume**
Shows revenue and number of unique orders month-wise.

### 2. **Top 10 Best-Selling Products**
Lists top products based on total revenue.

### 3. **Monthly Revenue by Sales Channel**
Breakdown of monthly sales across online/offline channels.

### 4. **Revenue by Country**
Which countries contributed most to revenue.

### 5. **Order Volume by Order Priority**
Monthly order count broken down by order urgency.

### 6. **Return Rate Over Time**
Return trends by month (returned vs total orders).

### 7. **Average Discount per Category**
Helps identify categories with frequent high discounts.

### 8. **Sales by Shipment Provider**
Shows which logistics providers handle most orders and revenue.

### 9. **Time of Day Trend**
Analyzes at what hour sales activity peaks.

### 10. **Profitability by Payment Method**
Estimates profit margin by payment type (assuming 70% cost of price).

---

## 🚀 How to Use

1. Load the cleaned CSV into MySQL.
2. Execute `sales_analysis.sql` in MySQL Workbench or similar.
3. Use the results for dashboards or reporting.
4. Each query result can be exported as `.csv` for sharing or analysis.

---

## ✨ Tools Used

- **MySQL** for querying and aggregation
- **Google Colab** for data cleaning
- **CSV** export for reporting

---

## 🙌 Author

Project by [Vanshika].  
Feel free to contribute or open an issue!


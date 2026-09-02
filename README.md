# SQL Server Customer & Order Analysis

> SQL Server project focused on analyzing customer and sales data using JOINs, aggregations, date functions, CASE statements, and CTEs.

---

## 📊 Dataset

| Table | Records | Description |
|---|---:|---|
| Customers | 100 | Customer details |
| Orders | 300 | Customer order details |
| **Total** | **400** | Combined records |

**Relationship:** `Customers.CustomerID = Orders.CustomerID`

---

## 🛠️ SQL Concepts Used

- `INNER JOIN`
- `LEFT JOIN`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `CASE`
- `SUM()`, `COUNT()`, `AVG()`, `MIN()`, `MAX()`
- `YEAR()`, `MONTH()`, `DAY()`
- `DATEPART()`, `DATENAME()`
- `DATEDIFF()`, `DATEADD()`
- `EOMONTH()`
- `COALESCE()`, `ISNULL()`
- Common Table Expressions (CTEs)

---

## 📈 Project Analysis

- Customer order analysis
- Total and average sales
- Sales by year, month, and quarter
- Orders by weekday
- Delivery time analysis
- Customer sales performance
- First and latest order analysis
- Customers with no orders
- Year-wise and month-wise sales analysis
- Delivery performance classification

---

## 💻 Tools Used

- **Microsoft SQL Server**
- **SQL Server Management Studio (SSMS)**

---

## 📂 Project Files

- `SQL_Joins_DateTime_400_Records.sql` — Database creation and sample data
- `SQL_50_Questions.sql` — SQL analysis queries

---

## 🎯 Objective

To analyze customer and sales data using SQL Server and demonstrate practical skills in data analysis, JOINs, aggregation, filtering, date analysis, NULL handling, and business logic.

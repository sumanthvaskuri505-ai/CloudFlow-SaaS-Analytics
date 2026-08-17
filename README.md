# ☁️ CloudFlow SaaS Customer Churn & Revenue Analytics

## 📌 Project Overview

CloudFlow is a simulated SaaS subscription company offering Basic, Professional, and Enterprise plans.

The objective of this project is to analyze customer subscriptions, revenue, churn, retention, and customer behavior using MySQL.

The analysis focuses on answering business questions such as:

- Which subscription plans generate the most revenue?
- Which customers are the highest-value customers?
- Which plans and customer segments have the highest churn?
- Which customers generate above-average revenue?
- How does revenue change month over month?
- Which customers upgraded their subscriptions?
- Which high-value customers have churned?

---

## 🎯 Business Objectives

The project aims to:

1. Analyze overall customer and subscription performance.
2. Identify major revenue-generating plans and customer segments.
3. Measure customer churn and retention.
4. Rank customers based on revenue contribution.
5. Analyze monthly revenue trends and growth.
6. Identify subscription upgrades.
7. Identify high-value churned customers.
8. Provide actionable business recommendations.

---

## 🗂️ Dataset

The project uses a simulated SaaS subscription dataset containing:

- 30 customers
- 3 subscription plans
- 30 subscriptions
- 100 payment records
- 20 subscription events

### Tables

| Table | Description |
|---|---|
| `customers` | Customer information and segmentation |
| `plans` | Subscription plans and monthly pricing |
| `subscriptions` | Customer subscription details |
| `payments` | Customer payment transactions |
| `subscription_events` | Upgrades, downgrades, renewals and cancellations |

---

## 🛠️ Technologies Used

- MySQL
- SQL
- MySQL Workbench
- Git
- GitHub

---

## 📊 Key Analysis

### Revenue Analysis

The project analyzes:

- Total revenue
- Revenue by subscription plan
- Revenue by customer segment
- Revenue per customer
- Top 10 customers by revenue

### Customer Analysis

The project analyzes:

- Active customers
- Churned customers
- Customer revenue ranking
- Above-average customers
- Customer segments

### Churn & Retention Analysis

The project analyzes:

- Overall churn rate
- Churn by subscription plan
- Churn by customer segment
- High-value churned customers
- Customer subscription behavior

### Time-Based Analysis

The project analyzes:

- Monthly revenue
- Running revenue totals
- Previous-month revenue
- Month-over-month revenue growth

### Subscription Behavior

The project analyzes:

- Customer upgrades
- Previous vs new subscription plans
- Additional monthly revenue from upgrades

---

## 🔥 Key Findings

### 1. Enterprise customers are the primary revenue driver

Enterprise customers represent approximately 30% of the customer base but generate approximately 70% of total revenue.

This makes Enterprise customers strategically important to the business.

### 2. Enterprise and Professional plans have higher churn

Both Enterprise and Professional plans have a churn rate of approximately 22.22%, compared with 16.67% for the Basic plan.

### 3. Enterprise customers have the highest revenue per customer

Enterprise customers generate significantly more revenue per customer than SMB and Mid-Market customers.

### 4. High-value churned customers require attention

Customers who generated significant lifetime revenue but subsequently cancelled represent important win-back opportunities.

### 5. Customer upgrades create additional revenue opportunities

Subscription upgrades can increase monthly recurring revenue and provide opportunities for targeted upselling.

---

## 💡 Business Recommendations

### 1. Prioritize Enterprise Customer Retention

Since Enterprise customers generate the majority of revenue, CloudFlow should prioritize retention programs for this segment.

Possible actions:

- Proactive account management
- Renewal incentives
- Customer health monitoring
- Early churn-risk identification

### 2. Target High-Value Churned Customers

Customers with high historical revenue should receive personalized win-back campaigns.

### 3. Improve Retention for High-Churn Plans

Professional and Enterprise plans should be investigated to understand why customers are cancelling at higher rates.

### 4. Expand Upselling Opportunities

Customers showing engagement and upgrade behavior can be targeted with personalized upgrade recommendations.

### 5. Monitor Revenue Trends

Monthly revenue and month-over-month growth should be monitored regularly to identify periods of revenue acceleration or decline.

---

## 🧠 SQL Concepts Demonstrated

This project demonstrates intermediate and advanced SQL techniques:

- SELECT
- WHERE
- GROUP BY
- HAVING
- Aggregate Functions
- INNER JOIN
- LEFT JOIN
- Multiple JOINs
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- `RANK()`
- `LAG()`
- Running Totals
- Date Functions
- Conditional Aggregation
- Revenue Analysis
- Churn Analysis

---

## 📁 Project Structure

```text
CloudFlow_SaaS_Analytics/
│
├── data/
│
├── sql/
│   └── cloudflow_analysis.sql
│
├── screenshots/
│
└── README.md
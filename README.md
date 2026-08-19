# ☁️ CloudFlow SaaS Customer Churn & Revenue Analytics

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-Analysis-00758F?style=for-the-badge)

## 📌 Project Overview

CloudFlow is a simulated SaaS subscription company offering **Basic, Professional, and Enterprise** subscription plans.

The objective of this project is to analyze customer subscriptions, revenue, customer behavior, and churn using **MySQL and Power BI**.

The analysis answers important business questions such as:

- Which subscription plans generate the most revenue?
- Which customer segments generate the most revenue?
- Who are the highest-value customers?
- What is the overall customer churn rate?
- Which subscription plans have the highest churn?
- How does revenue change over time?
- Which customers contribute the most revenue?

---

# 🎯 Business Objectives

The project focuses on five major areas:

### 1. Revenue Analysis
Analyze total revenue and identify the subscription plans and customer segments responsible for the highest revenue.

### 2. Customer Analysis
Understand the customer base by segment and identify high-value customers.

### 3. Churn Analysis
Calculate customer churn and compare churn rates across subscription plans.

### 4. Time-Based Analysis
Analyze monthly revenue trends to understand how revenue changes over time.

### 5. Business Recommendations
Convert the analysis into actionable recommendations for improving customer retention and revenue.

---

# 🗂️ Dataset & Data Model

The project uses a simulated SaaS dataset stored in MySQL.

The database contains five main tables:

```text
CloudFlow Database
│
├── customers
├── plans
├── subscriptions
├── subscription_events
└── payments
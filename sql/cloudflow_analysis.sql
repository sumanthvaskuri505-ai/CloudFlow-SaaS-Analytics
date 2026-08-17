-- ============================================================
-- CloudFlow SaaS Customer Churn & Revenue Analytics
-- SQL Business Analytics Project
-- ============================================================

USE cloudflow;


-- ============================================================
-- 1. EXECUTIVE BUSINESS KPIs
-- ============================================================

SELECT
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT CASE
        WHEN s.status = 'Active' THEN c.customer_id
    END) AS active_customers,
    COUNT(DISTINCT CASE
        WHEN s.status = 'Cancelled' THEN c.customer_id
    END) AS churned_customers,
    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN s.status = 'Cancelled' THEN c.customer_id
        END)
        / COUNT(DISTINCT c.customer_id),
        2
    ) AS churn_rate,
    SUM(
        CASE
            WHEN p.payment_status = 'Successful'
            THEN p.amount
            ELSE 0
        END
    ) AS total_revenue
FROM customers c
LEFT JOIN subscriptions s
    ON c.customer_id = s.customer_id
LEFT JOIN payments p
    ON c.customer_id = p.customer_id;


-- ============================================================
-- 2. TOP 10 CUSTOMERS BY REVENUE
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    SUM(p.amount) AS total_revenue
FROM customers c
JOIN payments p
    ON c.customer_id = p.customer_id
WHERE p.payment_status = 'Successful'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.customer_segment
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 3. REVENUE BY SUBSCRIPTION PLAN
-- ============================================================

SELECT
    pl.plan_name,
    COUNT(DISTINCT s.customer_id) AS customers,
    SUM(p.amount) AS total_revenue,
    ROUND(AVG(p.amount), 2) AS average_payment
FROM plans pl
JOIN subscriptions s
    ON pl.plan_id = s.plan_id
JOIN payments p
    ON s.subscription_id = p.subscription_id
WHERE p.payment_status = 'Successful'
GROUP BY
    pl.plan_id,
    pl.plan_name
ORDER BY total_revenue DESC;


-- ============================================================
-- 4. REVENUE BY CUSTOMER SEGMENT
-- ============================================================

SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS customers,
    SUM(p.amount) AS total_revenue,
    ROUND(
        SUM(p.amount) /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS revenue_per_customer
FROM customers c
JOIN payments p
    ON c.customer_id = p.customer_id
WHERE p.payment_status = 'Successful'
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;


-- ============================================================
-- 5. CHURN RATE BY PLAN
-- ============================================================

SELECT
    pl.plan_name,
    COUNT(*) AS total_customers,
    SUM(s.status = 'Cancelled') AS churned_customers,
    ROUND(
        100.0 * SUM(s.status = 'Cancelled') / COUNT(*),
        2
    ) AS churn_rate
FROM subscriptions s
JOIN plans pl
    ON s.plan_id = pl.plan_id
GROUP BY
    pl.plan_id,
    pl.plan_name
ORDER BY churn_rate DESC;


-- ============================================================
-- 6. CHURN RATE BY CUSTOMER SEGMENT
-- ============================================================

SELECT
    c.customer_segment,
    COUNT(*) AS total_customers,
    SUM(s.status = 'Cancelled') AS churned_customers,
    ROUND(
        100.0 * SUM(s.status = 'Cancelled') / COUNT(*),
        2
    ) AS churn_rate
FROM customers c
JOIN subscriptions s
    ON c.customer_id = s.customer_id
GROUP BY c.customer_segment
ORDER BY churn_rate DESC;


-- ============================================================
-- 7. CUSTOMER REVENUE RANKING
-- CTE + RANK()
-- ============================================================

WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(p.amount) AS total_revenue
    FROM customers c
    JOIN payments p
        ON c.customer_id = p.customer_id
    WHERE p.payment_status = 'Successful'
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM customer_revenue
ORDER BY revenue_rank;


-- ============================================================
-- 8. CUSTOMERS ABOVE AVERAGE REVENUE
-- CTE + Subquery
-- ============================================================

WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM payments
    WHERE payment_status = 'Successful'
    GROUP BY customer_id
),
average_revenue AS (
    SELECT
        AVG(total_revenue) AS avg_revenue
    FROM customer_revenue
)
SELECT
    c.customer_id,
    c.customer_name,
    cr.total_revenue
FROM customer_revenue cr
JOIN customers c
    ON cr.customer_id = c.customer_id
CROSS JOIN average_revenue ar
WHERE cr.total_revenue > ar.avg_revenue
ORDER BY cr.total_revenue DESC;


-- ============================================================
-- 9. MONTHLY REVENUE + RUNNING TOTAL
-- Window Function
-- ============================================================

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS month,
        SUM(amount) AS monthly_revenue
    FROM payments
    WHERE payment_status = 'Successful'
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
)
SELECT
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY month
    ) AS running_revenue
FROM monthly_revenue
ORDER BY month;


-- ============================================================
-- 10. MONTH-OVER-MONTH REVENUE GROWTH
-- LAG() Window Function
-- ============================================================

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS month,
        SUM(amount) AS monthly_revenue
    FROM payments
    WHERE payment_status = 'Successful'
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
),
revenue_comparison AS (
    SELECT
        month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    monthly_revenue,
    previous_month_revenue,
    ROUND(
        100.0 *
        (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_growth_percentage
FROM revenue_comparison
ORDER BY month;


-- ============================================================
-- 11. CUSTOMER UPGRADE ANALYSIS
-- Multiple JOINs
-- ============================================================

SELECT
    c.customer_name,
    old_p.plan_name AS old_plan,
    new_p.plan_name AS new_plan,
    old_p.monthly_price AS old_price,
    new_p.monthly_price AS new_price,
    new_p.monthly_price - old_p.monthly_price
        AS monthly_revenue_increase
FROM subscription_events e
JOIN customers c
    ON e.customer_id = c.customer_id
JOIN plans old_p
    ON e.old_plan_id = old_p.plan_id
JOIN plans new_p
    ON e.new_plan_id = new_p.plan_id
WHERE e.event_type = 'Upgrade'
ORDER BY monthly_revenue_increase DESC;


-- ============================================================
-- 12. HIGH-VALUE CHURNED CUSTOMERS
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    pl.plan_name,
    SUM(p.amount) AS lifetime_revenue,
    s.end_date
FROM customers c
JOIN subscriptions s
    ON c.customer_id = s.customer_id
JOIN plans pl
    ON s.plan_id = pl.plan_id
LEFT JOIN payments p
    ON s.subscription_id = p.subscription_id
    AND p.payment_status = 'Successful'
WHERE s.status = 'Cancelled'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    pl.plan_name,
    s.end_date
ORDER BY lifetime_revenue DESC;
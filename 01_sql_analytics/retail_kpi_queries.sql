-- ============================================================
-- PROJECT 1: Canadian Retail Sales Analytics
-- Target Role: Data Analyst | Business Analyst (Canada)
-- Tools: PostgreSQL, Advanced SQL
-- Skills: Window Functions, CTEs, Subqueries, Aggregations
-- Industry: Retail (Loblaw, Sobeys, Metro Inc. scenario)
-- ============================================================

-- ----------------------------------------------------------------
-- SCHEMA REFERENCE
-- Tables: sales, customers, products, stores, provinces
-- ----------------------------------------------------------------

-- ============================================================
-- QUERY 1: Revenue by Canadian Province (YTD)
-- Business Question: Which provinces drive the most revenue?
-- ============================================================
SELECT 
    p.province_code,
    p.province_name,
    COUNT(DISTINCT s.transaction_id) AS total_transactions,
    COUNT(DISTINCT s.customer_id) AS unique_customers,
    SUM(s.quantity * s.unit_price) AS gross_revenue,
    SUM(s.quantity * s.unit_price * (1 - s.discount_pct)) AS net_revenue,
    ROUND(AVG(s.quantity * s.unit_price), 2) AS avg_order_value,
    RANK() OVER (ORDER BY SUM(s.quantity * s.unit_price) DESC) AS revenue_rank
FROM sales s
JOIN stores st ON s.store_id = st.store_id
JOIN provinces p ON st.province_code = p.province_code
WHERE EXTRACT(YEAR FROM s.transaction_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY p.province_code, p.province_name
ORDER BY gross_revenue DESC;


-- ============================================================
-- QUERY 2: Year-over-Year Revenue Growth (LAG Window Function)
-- Business Question: How is monthly revenue trending vs last year?
-- ============================================================
WITH monthly_revenue AS (
      SELECT 
        DATE_TRUNC('month', transaction_date) AS month,
          SUM(quantity * unit_price) AS revenue
      FROM sales
      GROUP BY DATE_TRUNC('month', transaction_date)
  ),
yoy_comparison AS (
      SELECT 
        month,
          revenue AS current_revenue,
          LAG(revenue, 12) OVER (ORDER BY month) AS prior_year_revenue
      FROM monthly_revenue
  )
SELECT 
    TO_CHAR(month, 'YYYY-MM') AS month,
    ROUND(current_revenue, 2) AS current_revenue,
    ROUND(prior_year_revenue, 2) AS prior_year_revenue,
    ROUND(
          ((current_revenue - prior_year_revenue) / NULLIF(prior_year_revenue, 0)) * 100, 
        2
      ) AS yoy_growth_pct
FROM yoy_comparison
WHERE prior_year_revenue IS NOT NULL
ORDER BY month DESC;


-- ============================================================
-- QUERY 3: Customer Cohort Analysis (Monthly Retention)
-- Business Question: What % of customers return month over month?
-- ============================================================
WITH first_purchase AS (
      SELECT 
        customer_id,
          DATE_TRUNC('month', MIN(transaction_date)) AS cohort_month
      FROM sales
      GROUP BY customer_id
  ),
customer_activity AS (
      SELECT 
        s.customer_id,
          fp.cohort_month,
          DATE_TRUNC('month', s.transaction_date) AS activity_month,
          EXTRACT(EPOCH FROM (
              DATE_TRUNC('month', s.transaction_date) - fp.cohort_month
          )) / (30 * 24 * 3600) AS months_since_first_purchase
      FROM sales s
      JOIN first_purchase fp ON s.customer_id = fp.customer_id
  ),
cohort_size AS (
      SELECT cohort_month, COUNT(DISTINCT customer_id) AS cohort_customers
      FROM first_purchase
      GROUP BY cohort_month
  )
SELECT 
    TO_CHAR(ca.cohort_month, 'YYYY-MM') AS cohort,
    cs.cohort_customers AS cohort_size,
    ca.months_since_first_purchase::INT AS month_number,
    COUNT(DISTINCT ca.customer_id) AS active_customers,
    ROUND(
          COUNT(DISTINCT ca.customer_id) * 100.0 / cs.cohort_customers, 
        2
      ) AS retention_rate_pct
FROM customer_activity ca
JOIN cohort_size cs ON ca.cohort_month = cs.cohort_month
WHERE ca.months_since_first_purchase BETWEEN 0 AND 11
GROUP BY ca.cohort_month, cs.cohort_customers, ca.months_since_first_purchase
ORDER BY ca.cohort_month, ca.months_since_first_purchase;


-- ============================================================
-- QUERY 4: RFM Customer Segmentation
-- Business Question: Who are our best customers? (Canada-wide)
-- ============================================================
WITH rfm_base AS (
      SELECT 
        customer_id,
          MAX(transaction_date) AS last_purchase_date,
          COUNT(DISTINCT transaction_id) AS frequency,
          SUM(quantity * unit_price) AS monetary_value,
          CURRENT_DATE - MAX(transaction_date) AS recency_days
      FROM sales
      GROUP BY customer_id
  ),
rfm_scores AS (
      SELECT 
        customer_id,
          recency_days,
          frequency,
          ROUND(monetary_value, 2) AS monetary_value,
          NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,
          NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
          NTILE(5) OVER (ORDER BY monetary_value DESC) AS m_score
      FROM rfm_base
  )
SELECT 
    customer_id,
    recency_days,
    frequency,
    monetary_value,
    r_score,
    f_score,
    m_score,
    (r_score + f_score + m_score) AS rfm_total,
    CASE 
        WHEN (r_score + f_score + m_score) >= 13 THEN 'Champions'
        WHEN (r_score + f_score + m_score) >= 10 THEN 'Loyal Customers'
        WHEN (r_score + f_score + m_score) >= 7  THEN 'Potential Loyalists'
        WHEN r_score >= 4 AND (f_score + m_score) < 6 THEN 'New Customers'
        WHEN r_score <= 2 AND (f_score + m_score) >= 8 THEN 'At Risk'
        WHEN r_score = 1 AND f_score = 1 THEN 'Lost Customers'
        ELSE 'Needs Attention'
    END AS customer_segment
FROM rfm_scores
ORDER BY rfm_total DESC;


-- ============================================================
-- QUERY 5: Store Performance Ranking by Province
-- Business Question: Which stores are top/bottom performers?
-- ============================================================
WITH store_metrics AS (
      SELECT 
        st.store_id,
          st.store_name,
          st.city,
          p.province_name,
          SUM(s.quantity * s.unit_price) AS total_revenue,
          COUNT(DISTINCT s.transaction_id) AS total_orders,
          COUNT(DISTINCT s.customer_id) AS unique_customers,
          ROUND(AVG(s.quantity * s.unit_price), 2) AS avg_basket_size
      FROM sales s
      JOIN stores st ON s.store_id = st.store_id
      JOIN provinces p ON st.province_code = p.province_code
      GROUP BY st.store_id, st.store_name, st.city, p.province_name
  )
SELECT 
    store_id,
    store_name,
    city,
    province_name,
    total_revenue,
    total_orders,
    unique_customers,
    avg_basket_size,
    RANK() OVER (PARTITION BY province_name ORDER BY total_revenue DESC) AS rank_in_province,
    RANK() OVER (ORDER BY total_revenue DESC) AS national_rank,
    PERCENT_RANK() OVER (ORDER BY total_revenue DESC) AS percentile_rank
FROM store_metrics
ORDER BY province_name, rank_in_province;


-- ============================================================
-- QUERY 6: Product Category Performance & Margin Analysis
-- Business Question: Which categories drive margin, not just revenue?
-- ============================================================
SELECT 
    pr.category,
    pr.subcategory,
    SUM(s.quantity) AS units_sold,
    SUM(s.quantity * s.unit_price) AS gross_revenue,
    SUM(s.quantity * pr.cost_price) AS total_cost,
    SUM(s.quantity * s.unit_price) - SUM(s.quantity * pr.cost_price) AS gross_profit,
    ROUND(
          (SUM(s.quantity * s.unit_price) - SUM(s.quantity * pr.cost_price)) 
        / NULLIF(SUM(s.quantity * s.unit_price), 0) * 100, 
        2
      ) AS gross_margin_pct,
    RANK() OVER (ORDER BY 
        (SUM(s.quantity * s.unit_price) - SUM(s.quantity * pr.cost_price)) DESC
      ) AS margin_rank
FROM sales s
JOIN products pr ON s.product_id = pr.product_id
GROUP BY pr.category, pr.subcategory
ORDER BY gross_profit DESC;


-- ============================================================
-- QUERY 7: Moving Average Sales Trend (7-day rolling)
-- Business Question: Smoothed daily sales to identify trends
-- ============================================================
WITH daily_sales AS (
      SELECT 
        transaction_date::DATE AS sale_date,
          SUM(quantity * unit_price) AS daily_revenue,
          COUNT(DISTINCT transaction_id) AS daily_orders
      FROM sales
      GROUP BY transaction_date::DATE
  )
SELECT 
    sale_date,
    daily_revenue,
    daily_orders,
    ROUND(AVG(daily_revenue) OVER (
          ORDER BY sale_date 
          ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
      ), 2) AS rolling_7day_avg,
    ROUND(AVG(daily_revenue) OVER (
          ORDER BY sale_date 
          ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
      ), 2) AS rolling_30day_avg
FROM daily_sales
ORDER BY sale_date DESC;


-- ============================================================
-- QUERY 8: Customer Lifetime Value (CLV) Estimation
-- Business Question: What is the predicted lifetime value per segment?
-- ============================================================
WITH customer_stats AS (
      SELECT 
        customer_id,
          COUNT(DISTINCT transaction_id) AS purchase_count,
          SUM(quantity * unit_price) AS total_spend,
          MIN(transaction_date) AS first_purchase,
          MAX(transaction_date) AS last_purchase,
          EXTRACT(EPOCH FROM (MAX(transaction_date) - MIN(transaction_date))) 
            / (30 * 24 * 3600) AS customer_age_months
      FROM sales
      GROUP BY customer_id
      HAVING COUNT(DISTINCT transaction_id) > 1
  )
SELECT 
    customer_id,
    purchase_count,
    ROUND(total_spend, 2) AS total_spend,
    ROUND(total_spend / NULLIF(purchase_count, 0), 2) AS avg_order_value,
    ROUND(customer_age_months, 1) AS tenure_months,
    ROUND(purchase_count / NULLIF(customer_age_months, 0), 2) AS purchase_frequency_monthly,
    -- CLV = AOV * Purchase Frequency * Expected Lifetime (24 months)
    ROUND(
          (total_spend / NULLIF(purchase_count, 0)) * 
        (purchase_count / NULLIF(customer_age_months, 0)) * 24, 
        2
      ) AS estimated_clv_24mo
FROM customer_stats
ORDER BY estimated_clv_24mo DESC
LIMIT 100;


-- ============================================================
-- QUERY 9: Inventory Turnover & Stockout Risk Detection
-- Business Question: Which products need reordering?
-- ============================================================
WITH sales_velocity AS (
      SELECT 
        product_id,
          ROUND(SUM(quantity) / 90.0, 2) AS daily_avg_units_sold  -- last 90 days
      FROM sales
      WHERE transaction_date >= CURRENT_DATE - INTERVAL '90 days'
      GROUP BY product_id
  )
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.current_stock,
    sv.daily_avg_units_sold,
    ROUND(p.current_stock / NULLIF(sv.daily_avg_units_sold, 0), 0) AS days_of_stock_remaining,
    CASE 
        WHEN p.current_stock / NULLIF(sv.daily_avg_units_sold, 0) <= 7 THEN 'CRITICAL - Reorder Now'
        WHEN p.current_stock / NULLIF(sv.daily_avg_units_sold, 0) <= 14 THEN 'LOW - Plan Reorder'
        WHEN p.current_stock / NULLIF(sv.daily_avg_units_sold, 0) <= 30 THEN 'MEDIUM - Monitor'
        ELSE 'OK'
    END AS stock_status,
    ROUND(sv.daily_avg_units_sold * 30, 0) AS recommended_reorder_qty
FROM products p
LEFT JOIN sales_velocity sv ON p.product_id = sv.product_id
ORDER BY days_of_stock_remaining ASC NULLS LAST;


-- ============================================================
-- QUERY 10: Seasonal Sales Pattern Analysis (Canadian Holidays)
-- Business Question: How do Canadian holidays impact sales?
-- ============================================================
SELECT 
    EXTRACT(MONTH FROM transaction_date) AS month_num,
    TO_CHAR(transaction_date, 'Month') AS month_name,
    EXTRACT(DOW FROM transaction_date) AS day_of_week,  -- 0=Sunday, 6=Saturday
    CASE 
        WHEN EXTRACT(DOW FROM transaction_date) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(DISTINCT transaction_id) AS total_orders,
    SUM(quantity * unit_price) AS total_revenue,
    ROUND(AVG(quantity * unit_price), 2) AS avg_order_value
FROM sales
GROUP BY 
    EXTRACT(MONTH FROM transaction_date),
    TO_CHAR(transaction_date, 'Month'),
    EXTRACT(DOW FROM transaction_date)
ORDER BY month_num, day_of_week;

-- ============================================================
-- END OF FILE
-- Next file: cohort_analysis.sql, rfm_segmentation.sql
-- Portfolio: github.com/bhaviss/canadian-data-analyst-portfolio
-- ============================================================

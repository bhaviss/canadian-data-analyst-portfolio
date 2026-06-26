-- ============================================================
-- PROJECT 2: Canadian Healthcare Wait Times Analysis
-- Target Role: Data Analyst (Healthcare/Government)
-- Tools: PostgreSQL, CTEs, Window Functions
-- Dataset: Based on CIHI (Canadian Institute for Health Information)
-- Relevant Employers: Health Canada, PHAC, Provincial Health Authorities
-- ============================================================

-- ----------------------------------------------------------------
-- SCHEMA REFERENCE
-- Tables: wait_times, hospitals, provinces, procedure_types
-- Key benchmark: 90th percentile wait times by procedure
-- ----------------------------------------------------------------

-- ============================================================
-- QUERY 1: Provincial Wait Time Summary (Current Year)
-- Business Question: Which provinces meet national benchmarks?
-- ============================================================
WITH provincial_summary AS (
      SELECT 
        p.province_code,
          p.province_name,
          pt.procedure_category,
          COUNT(wt.patient_id) AS total_patients,
          ROUND(AVG(wt.wait_days), 1) AS avg_wait_days,
          ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY wt.wait_days), 1) AS median_wait_days,
          ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY wt.wait_days), 1) AS p90_wait_days,
          pt.benchmark_days AS national_benchmark,
          ROUND(SUM(CASE WHEN wt.wait_days <= pt.benchmark_days THEN 1 ELSE 0 END)::NUMERIC 
                / COUNT(wt.patient_id) * 100, 2) AS pct_meeting_benchmark
      FROM wait_times wt
      JOIN hospitals h ON wt.hospital_id = h.hospital_id
      JOIN provinces p ON h.province_code = p.province_code
      JOIN procedure_types pt ON wt.procedure_code = pt.procedure_code
      WHERE EXTRACT(YEAR FROM wt.referral_date) = 2024
      GROUP BY p.province_code, p.province_name, pt.procedure_category, pt.benchmark_days
  )
SELECT 
    province_code,
    province_name,
    procedure_category,
    total_patients,
    avg_wait_days,
    median_wait_days,
    p90_wait_days,
    national_benchmark,
    pct_meeting_benchmark,
    CASE 
        WHEN pct_meeting_benchmark >= 80 THEN 'Meeting Benchmark'
        WHEN pct_meeting_benchmark >= 60 THEN 'Needs Improvement'
        ELSE 'Critical - Not Meeting Benchmark'
    END AS performance_status,
    RANK() OVER (PARTITION BY procedure_category ORDER BY pct_meeting_benchmark DESC) AS province_rank
FROM provincial_summary
ORDER BY procedure_category, pct_meeting_benchmark DESC;


-- ============================================================
-- QUERY 2: 5-Year Wait Time Trend Analysis
-- Business Question: Are wait times improving over time?
-- ============================================================
WITH yearly_trends AS (
      SELECT 
        EXTRACT(YEAR FROM wt.referral_date) AS year,
          p.province_name,
          pt.procedure_category,
          COUNT(*) AS patient_volume,
          ROUND(AVG(wt.wait_days), 1) AS avg_wait_days,
          ROUND(PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY wt.wait_days), 1) AS p90_wait_days
      FROM wait_times wt
      JOIN hospitals h ON wt.hospital_id = h.hospital_id
      JOIN provinces p ON h.province_code = p.province_code
      JOIN procedure_types pt ON wt.procedure_code = pt.procedure_code
      WHERE EXTRACT(YEAR FROM wt.referral_date) BETWEEN 2019 AND 2024
      GROUP BY EXTRACT(YEAR FROM wt.referral_date), p.province_name, pt.procedure_category
  )
SELECT 
    year,
    province_name,
    procedure_category,
    patient_volume,
    avg_wait_days,
    p90_wait_days,
    LAG(p90_wait_days) OVER (PARTITION BY province_name, procedure_category ORDER BY year) AS prev_year_p90,
    ROUND(
          (p90_wait_days - LAG(p90_wait_days) OVER (PARTITION BY province_name, procedure_category ORDER BY year))
          / NULLIF(LAG(p90_wait_days) OVER (PARTITION BY province_name, procedure_category ORDER BY year), 0) * 100,
          2
      ) AS yoy_change_pct,
    ROUND(
          AVG(p90_wait_days) OVER (
              PARTITION BY province_name, procedure_category 
              ORDER BY year 
              ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
          ), 1
      ) AS rolling_3yr_avg_p90
FROM yearly_trends
ORDER BY province_name, procedure_category, year;


-- ============================================================
-- QUERY 3: COVID Impact on Wait Times
-- Business Question: How did COVID disrupt healthcare capacity?
-- ============================================================
WITH pre_covid AS (
      SELECT 
        h.province_code,
          pt.procedure_category,
          AVG(wt.wait_days) AS avg_wait_pre_covid,
          PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY wt.wait_days) AS p90_pre_covid,
          COUNT(*) AS volume_pre_covid
      FROM wait_times wt
      JOIN hospitals h ON wt.hospital_id = h.hospital_id
      JOIN procedure_types pt ON wt.procedure_code = pt.procedure_code
      WHERE wt.referral_date BETWEEN '2019-01-01' AND '2020-02-29'
      GROUP BY h.province_code, pt.procedure_category
  ),
post_covid AS (
      SELECT 
        h.province_code,
          pt.procedure_category,
          AVG(wt.wait_days) AS avg_wait_post_covid,
          PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY wt.wait_days) AS p90_post_covid,
          COUNT(*) AS volume_post_covid
      FROM wait_times wt
      JOIN hospitals h ON wt.hospital_id = h.hospital_id
      JOIN procedure_types pt ON wt.procedure_code = pt.procedure_code
      WHERE wt.referral_date BETWEEN '2021-01-01' AND '2022-12-31'
      GROUP BY h.province_code, pt.procedure_code
  )
SELECT 
    pre.province_code,
    pre.procedure_category,
    ROUND(pre.avg_wait_pre_covid, 1) AS avg_wait_pre,
    ROUND(post.avg_wait_post_covid, 1) AS avg_wait_post,
    ROUND(post.avg_wait_post_covid - pre.avg_wait_pre_covid, 1) AS wait_day_increase,
    ROUND((post.avg_wait_post_covid - pre.avg_wait_pre_covid) / pre.avg_wait_pre_covid * 100, 1) AS pct_increase,
    pre.volume_pre_covid,
    post.volume_post_covid,
    ROUND((post.volume_post_covid - pre.volume_pre_covid)::NUMERIC / pre.volume_pre_covid * 100, 1) AS volume_change_pct
FROM pre_covid pre
JOIN post_covid post ON pre.province_code = post.province_code 
    AND pre.procedure_category = post.procedure_category
ORDER BY pct_increase DESC;


-- ============================================================
-- QUERY 4: Hospital Performance Scorecard
-- Business Question: Which hospitals are top/bottom performers?
-- ============================================================
WITH hospital_metrics AS (
      SELECT 
        h.hospital_id,
          h.hospital_name,
          h.city,
          p.province_name,
          h.hospital_type,
          COUNT(wt.patient_id) AS total_patients_served,
          AVG(wt.wait_days) AS avg_wait_days,
          PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY wt.wait_days) AS p90_wait,
          SUM(CASE WHEN wt.wait_days <= pt.benchmark_days THEN 1 ELSE 0 END) * 100.0 
            / COUNT(wt.patient_id) AS benchmark_compliance_pct,
          COUNT(CASE WHEN wt.outcome = 'Cancelled' THEN 1 END) * 100.0 
            / COUNT(wt.patient_id) AS cancellation_rate_pct
      FROM wait_times wt
      JOIN hospitals h ON wt.hospital_id = h.hospital_id
      JOIN provinces p ON h.province_code = p.province_code
      JOIN procedure_types pt ON wt.procedure_code = pt.procedure_code
      WHERE EXTRACT(YEAR FROM wt.referral_date) = 2024
      GROUP BY h.hospital_id, h.hospital_name, h.city, p.province_name, h.hospital_type
  )
SELECT 
    hospital_id,
    hospital_name,
    city,
    province_name,
    hospital_type,
    total_patients_served,
    ROUND(avg_wait_days, 1) AS avg_wait_days,
    ROUND(p90_wait, 1) AS p90_wait_days,
    ROUND(benchmark_compliance_pct, 2) AS benchmark_compliance_pct,
    ROUND(cancellation_rate_pct, 2) AS cancellation_rate_pct,
    -- Composite performance score (higher = better)
    ROUND(
        (benchmark_compliance_pct * 0.6) + 
        ((100 - LEAST(cancellation_rate_pct * 5, 100)) * 0.4),
        2
    ) AS performance_score,
    NTILE(4) OVER (ORDER BY benchmark_compliance_pct DESC) AS performance_quartile,
    RANK() OVER (PARTITION BY province_name ORDER BY benchmark_compliance_pct DESC) AS provincial_rank
FROM hospital_metrics
ORDER BY performance_score DESC;


-- ============================================================
-- QUERY 5: Resource Utilization & Capacity Planning
-- Business Question: Where do we need more surgical capacity?
-- ============================================================
WITH quarterly_demand AS (
    SELECT 
        h.province_code,
        pt.procedure_category,
        DATE_TRUNC('quarter', wt.referral_date) AS quarter,
        COUNT(*) AS patient_volume,
        AVG(wt.wait_days) AS avg_wait
    FROM wait_times wt
    JOIN hospitals h ON wt.hospital_id = h.hospital_id
    JOIN procedure_types pt ON wt.procedure_code = pt.procedure_code
    GROUP BY h.province_code, pt.procedure_category, DATE_TRUNC('quarter', wt.referral_date)
),
demand_growth AS (
    SELECT 
        *,
        LAG(patient_volume, 4) OVER (PARTITION BY province_code, procedure_category ORDER BY quarter) AS volume_prior_year,
        ROUND(
            (patient_volume - LAG(patient_volume, 4) OVER (PARTITION BY province_code, procedure_category ORDER BY quarter))
            / NULLIF(LAG(patient_volume, 4) OVER (PARTITION BY province_code, procedure_category ORDER BY quarter), 0) * 100,
            2
        ) AS yoy_volume_growth_pct
    FROM quarterly_demand
)
SELECT 
    province_code,
    procedure_category,
    TO_CHAR(quarter, 'YYYY Q"Q"') AS quarter,
    patient_volume,
    volume_prior_year,
    yoy_volume_growth_pct,
    ROUND(avg_wait, 1) AS avg_wait_days,
    CASE 
        WHEN yoy_volume_growth_pct > 10 AND avg_wait > 100 THEN 'URGENT: Expand Capacity'
        WHEN yoy_volume_growth_pct > 5 AND avg_wait > 60 THEN 'Plan Capacity Increase'
        WHEN yoy_volume_growth_pct < -5 THEN 'Reducing Demand - Monitor'
        ELSE 'Stable'
    END AS capacity_recommendation
FROM demand_growth
WHERE quarter >= '2023-01-01'
ORDER BY province_code, procedure_category, quarter;

-- ============================================================
-- END OF FILE
-- Portfolio: github.com/bhaviss/canadian-data-analyst-portfolio
-- ============================================================

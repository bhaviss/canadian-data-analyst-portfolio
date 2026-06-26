# Bhavithra SS — Data Analytics Portfolio

**M.Sc. Information Technology | Research Assistant @ Concordia University Edmonton**
**Ex-Data Analyst @ Besant Technologies | ML Engineer | Edmonton, Alberta 🇨🇦**

📧 bhavithrass@gmail.com &nbsp;|&nbsp; 💼 [LinkedIn](https://www.linkedin.com/in/bhavithra-ss-/) &nbsp;|&nbsp; 📊 [Kaggle](https://www.kaggle.com/bhavi05) &nbsp;|&nbsp; 🌐 [bhaviss.com](https://www.bhaviss.com)

---

## Who I Am

I'm Bhavithra — a data person who genuinely enjoys the full stack of a data problem, from messy raw data to a dashboard someone actually uses, or a model that actually ships. 

Right now I'm a Research Assistant at Concordia University Edmonton completing my M.Sc. in Information Technology (GPA 3.92/4), where my research focuses on multimodal AI for space debris detection — tracking orbital objects in real time using YOLO, MobileNetV2, and SORT trajectory prediction. Before grad school I spent 2+ years as a Data Analyst at Besant Technologies, where I built Power BI and Tableau dashboards used by actual business teams, automated ETL pipelines, and worked with datasets at the 1M+ record scale.

This portfolio documents the data work I've built to target Canadian roles across analytics, data science, data engineering, and ML. The projects here are grounded in Canadian datasets (Statistics Canada, CMHC, CIHI), Canadian industry contexts (Big 5 banks, telecom, retail, healthcare), and the tools that actually show up in Canadian job postings.

---

## My Actual Stack

**Languages:** Python (primary), SQL (advanced), R (familiar)
**ML/AI:** scikit-learn, XGBoost, LightGBM, PyTorch, SHAP/XAI, MLflow, SMOTE
**Data & Viz:** Pandas, NumPy, Matplotlib, Seaborn, Plotly
**BI Tools:** Power BI (DAX, Power Query, RLS), Tableau (LOD, Story Points), Excel (Advanced)
**Data Engineering:** PostgreSQL, dbt, Apache Airflow, SQLAlchemy, Docker
**Cloud:** Azure (ADF, Data Lake, Databricks), AWS (basics), GCP (basics)
**Research:** Computer Vision (YOLO, MobileNetV2), NLP, Reinforcement Learning, Explainable AI

---

## Kaggle Notebooks (Public)

These are real, runnable notebooks — not just descriptions. Each one goes through the full data science lifecycle.

### 1. Heart Disease Risk Prediction with Explainable ML
**→ [View on Kaggle](https://www.kaggle.com/code/bhavi05/01-heart-disease-risk-prediction-explainable-ml)**

Binary classification on the Heart Failure Prediction dataset. Built five models — Logistic Regression, Decision Tree, Random Forest, Gradient Boosting, XGBoost — then applied SHAP to show which clinical features actually drive predictions. The XAI piece matters here: in healthcare you can't just hand over a black-box model, you need to explain why it flagged a patient as high risk.

**Tools:** Python, scikit-learn, XGBoost, SHAP, Matplotlib | **Dataset:** Heart Failure Prediction (Kaggle)

---

### 2. Credit Card Fraud Detection with Imbalanced ML
**→ [View on Kaggle](https://www.kaggle.com/code/bhavi05/03-credit-card-fraud-detection-imbalanced-ml)**

This one tackles the class imbalance problem head-on. The MLG-ULB dataset has 284,807 transactions with only 492 frauds (0.17%) — a 500:1 ratio. Standard accuracy metrics are useless here. Used SMOTE, class weighting, and threshold adjustment, evaluated with Precision-Recall AUC and F1 rather than vanilla accuracy. Runtime: 4m 10s, Version 3.

**Tools:** Python, scikit-learn, imbalanced-learn, SMOTE | **Dataset:** MLG-ULB Credit Card Fraud

---

### 3. Customer Churn Prediction with Explainable ML
**→ [View on Kaggle](https://www.kaggle.com/code/bhavi05/06-customer-churn-prediction-explainable-ml)**

Churn prediction on the IBM Telco dataset (7,043 customers, 21 features). Beyond just predicting who churns, used SHAP to surface the strongest churn signals — contract type, tenure, and monthly charges consistently come out on top. Built with actionable business output in mind: the point isn't AUC, it's telling the retention team who to call first.

**Tools:** Python, scikit-learn, XGBoost, SHAP | **Dataset:** IBM Telco Customer Churn

---

### Other Kaggle Work (Private — making public soon)
- `09_product_review_sentiment` — NLP sentiment analysis on product reviews
- - `08_movie_recommendation_engine` — Collaborative filtering recommendation system
  - - `Flowers_recognition` — CNN image classifier (transfer learning)
   
    - ---

    ## Portfolio Projects (This Repo)

    These projects were built specifically to address gaps between my existing experience and what Canadian employers in each data role want to see.

    ---

    ### SQL Analytics (→ `01_sql_analytics/`)

    **Why I built these:** My DA background is real, but most of my prior SQL work was in BI tool query builders, not raw PostgreSQL with window functions. These demonstrate I can write the kind of analytical SQL that shows up in Canadian DA take-home tests.

    **`retail_kpi_queries.sql`** — 10 queries covering a full Canadian grocery retail scenario: revenue by province (BC/ON/QC/AB), YoY growth with LAG(), monthly customer cohort retention, RFM segmentation with NTILE(), store performance ranking with RANK()/DENSE_RANK(), product margin analysis, 7/30-day rolling averages, CLV estimation, inventory stockout detection, and seasonal holiday pattern analysis.

    **`healthcare_wait_times.sql`** — 5 queries modeled on CIHI data: provincial benchmark compliance rates, 5-year trend analysis with LAG() and rolling averages, pre/post COVID wait time comparison, hospital performance scorecards with composite scoring, and quarterly capacity planning analysis. Relevant for Health Canada, provincial health authorities, and consulting firms like Deloitte or KPMG Canada.

    ---

    ### Excel Projects (→ `03_excel_projects/`)

    **Why I built these:** Power BI is my comfort zone for dashboards, but a lot of Canadian SME, finance, and government roles still run on Excel. The guide documents three high-level builds.

    **Financial Dashboard for Canadian SME** — Power Query for automated refresh, dynamic pivot tables with province/product/month slicers, XLOOKUP/INDEX-MATCH/SUMPRODUCT formulas, KPI cards with conditional formatting, waterfall chart P&L, map chart by province.

    **HR Analytics Dashboard** — Attrition by department and tenure using COUNTIFS, headcount forecasting with FORECAST.ETS(), salary equity analysis, time-to-hire tracking.

    **Supply Chain Dashboard** — EOQ calculation with Solver, reorder point alerts, supplier scorecard, demand forecasting with moving average, Scenario Manager for holiday season vs. disruption scenarios.

    ---

    ### Power BI Dashboards (→ `04_powerbi_dashboards/`)

    **Why I built these:** I have real Power BI experience from Besant Technologies, but I wanted to document advanced DAX patterns that come up in Canadian financial services interviews specifically.

    **`dax_measures.md`** — Full DAX library covering: revenue/margin KPIs, time intelligence (MTD, YTD, LY, MoM %, YoY %, rolling 30/60/90-day), customer analytics (new vs returning, CLV, churn rate), Canadian province segmentation, product performance, forecasting measures, and Row-Level Security patterns for branch-level banking dashboards.

    Three dashboard concepts documented: Canadian e-commerce (Shopify-type), Big 5 bank branch performance (with RLS for branch managers), and Public Health surveillance (PHAC-style COVID/respiratory tracking).

    ---

    ### Tableau Projects (→ `05_tableau_projects/`)

    **`tableau_calculated_fields.md`** — Canadian Real Estate dashboard spec: FIXED/INCLUDE/EXCLUDE LOD expressions for national vs. provincial vs. city aggregations, table calculations (running total, 3-month moving average, RANK(), % of total), parameter controls for city selection and top-N filtering, dashboard actions (filter on click, highlight on hover), and a 5-chapter Story Points narrative structure.

    ---

    ### Data Engineering (→ `06_data_engineering/`)

    **Why I built this:** My ETL experience is real (automated pipelines at Besant), but I hadn't yet worked with dbt formally. This is me learning it properly and documenting it.

    **`dbt_models/README.md`** — Full dbt project structure: staging models (stg_sales.sql, stg_customers.sql with Canadian postal code regex validation), intermediate models (int_customer_orders.sql with RFM components and CLV estimation), and finance/customer marts. Includes incremental materialization pattern, SCD Type 2 for customer dimension, and schema.yml tests (unique, not_null, accepted Canadian province codes, value range checks). Also covers dbt CLI workflow.

    ---

    ### Data Science / ML (→ `08_data_science_projects/`)

    **`demand_forecasting/forecasting_model.py`** — Retail demand forecasting with a properly built Canadian holiday calendar (Victoria Day, Thanksgiving on 2nd Monday October, Boxing Day, Labour Day). Generates 5 SKUs with realistic trend + seasonality + COVID structural break, engineers lag features and rolling stats, compares naive baseline vs. LightGBM. The holiday calendar piece is something I added specifically because it matters for Canadian retail and it's usually missing from generic tutorials.

    ---

    ## What I'm Currently Working On

    - **Research:** Multimodal space debris detection — CNNs + YOLO + SORT trajectory prediction at Concordia
    - - **Making public on Kaggle:** Product review NLP notebook and movie recommendation engine
      - - **Targeting:** Data Analyst and junior Data Scientist / ML Engineer roles in Edmonton/Calgary/remote Canada
        - - **Learning:** dbt certification, Azure Data Engineer Associate (DP-203)
         
          - ---

          ## What Makes Me Different

          I bridge research and applied analytics. Most of my ML work has been in applied research contexts (XAI, computer vision) which means I'm comfortable reading papers and translating them into code — not just running sklearn pipelines from tutorials. At the same time, my time at Besant taught me that dashboards only matter if stakeholders actually use them, which shapes how I communicate analytical findings.

          I also genuinely understand the Canadian context — I live here, I follow the Canadian data community, I know CIHI vs CIBC vs CRTC vs Statistics Canada are completely different types of organizations that happen to share initials. That specificity shows up in the projects.

          ---

          ## Let's Connect

          I'm actively looking for data roles in Canada. If something here looks relevant to what your team needs, I'd love to talk.

          📧 **bhavithrass@gmail.com**
          💼 **[linkedin.com/in/bhavithra-ss-/](https://www.linkedin.com/in/bhavithra-ss-/)**
          📊 **[kaggle.com/bhavi05](https://www.kaggle.com/bhavi05)**
          🔗 **[github.com/bhaviss](https://github.com/bhaviss)**
          📍 **Edmonton, Alberta — open to remote, hybrid, or onsite across Canada**

          ---

          *Last updated June 2026*

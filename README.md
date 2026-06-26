# Bhavithra SS

📧 bhavithrass@gmail.com &nbsp;|&nbsp; [LinkedIn](https://www.linkedin.com/in/bhavithra-ss-/) &nbsp;|&nbsp; [Kaggle](https://www.kaggle.com/bhavi05) &nbsp;|&nbsp; [bhaviss.com](https://www.bhaviss.com) &nbsp;|&nbsp; Edmonton, AB

---

M.Sc. Information Technology at Concordia University Edmonton (GPA 3.92/4). My research is on multimodal AI for space debris detection — real-time tracking using YOLO, MobileNetV2, and SORT. Before this, I spent 2+ years as a Data Analyst at Besant Technologies building Power BI and Tableau dashboards, running ETL pipelines, and working with datasets at the million-record scale.

I built this repo to have a place where my data work actually lives — SQL, Python, BI, ML, data engineering — not just bullet points on a resume.

---

## Kaggle

Three public notebooks so far. More coming.

**[Heart Disease Risk Prediction with Explainable ML](https://www.kaggle.com/code/bhavi05/01-heart-disease-risk-prediction-explainable-ml)**
Binary classification on the Heart Failure Prediction dataset. Trained five models (Logistic Regression, Decision Tree, Random Forest, Gradient Boosting, XGBoost), then used SHAP to surface which clinical features actually drive each prediction. The explainability piece is the real point — in healthcare, a black-box answer isn't enough.

**[Credit Card Fraud Detection with Imbalanced ML](https://www.kaggle.com/code/bhavi05/03-credit-card-fraud-detection-imbalanced-ml)**
284,807 transactions, 492 frauds. That's a 500:1 class ratio, which breaks standard accuracy completely. Built a pipeline around SMOTE, class weighting, and threshold adjustment, and evaluated with Precision-Recall AUC instead of accuracy. Runtime 4m 10s — it actually runs the full training loop.

**[Customer Churn Prediction with Explainable ML](https://www.kaggle.com/code/bhavi05/06-customer-churn-prediction-explainable-ml)**
IBM Telco dataset, 7,043 customers, 21 features. Churn prediction with SHAP on top — contract type, tenure, and monthly charges consistently come out as the biggest drivers. Built it so the output is actually useful to whoever would act on it, not just a model score.

Also have private notebooks in progress: product review sentiment (NLP), movie recommendation engine (collaborative filtering), flower recognition (CNN transfer learning). Making them public soon.

---

## SQL

**`01_sql_analytics/retail_kpi_queries.sql`**
Ten queries on a grocery retail scenario — revenue by province, YoY growth with LAG(), monthly cohort retention, RFM segmentation with NTILE(), store ranking with RANK()/DENSE_RANK(), product margin analysis, rolling averages, CLV estimation, inventory stockout detection, seasonal patterns. The kind of queries that show up in DA take-home tests.

**`01_sql_analytics/healthcare_wait_times.sql`**
Five queries modeled on CIHI data structure — provincial benchmark compliance, 5-year trend analysis, pre/post COVID wait time comparisons, hospital performance scorecards with composite scoring, quarterly capacity planning. Wrote this because healthcare analytics is a real hiring vertical here and SQL for it looks different from retail.

---

## Power BI

**`04_powerbi_dashboards/dax_measures.md`**
A full DAX library I actually use and reference — revenue/margin KPIs, time intelligence (MTD, YTD, prior year, MoM/YoY %, rolling windows), customer metrics (new vs returning, CLV, churn rate), province-level segmentation, product performance, and Row-Level Security patterns. Documented because DAX is the part of Power BI interviews where most people trip up.

---

## Tableau

**`05_tableau_projects/tableau_calculated_fields.md`**
Calculated fields, LOD expressions (FIXED, INCLUDE, EXCLUDE), table calculations, parameter controls, dashboard actions, and a Story Points structure — all written against a real estate dashboard scenario. LODs are the Tableau equivalent of window functions and most people avoid them. I don't.

---

## Excel

**`03_excel_projects/excel_dashboard_guide.md`**
Three dashboard builds: a financial P&L dashboard with Power Query, dynamic pivots, XLOOKUP, and waterfall charts. An HR analytics tracker with FORECAST.ETS() and salary equity formulas. A supply chain dashboard with Solver-based EOQ, reorder alerts, and Scenario Manager. Excel still runs most Canadian SME finance teams and I'm not too cool for it.

---

## Data Engineering

**`06_data_engineering/dbt_models/README.md`**
A dbt project with staging → intermediate → mart model layers. Covers incremental materialization, SCD Type 2 for a customer dimension, schema.yml data quality tests (unique, not_null, accepted values for province codes, value range checks), and the full dbt CLI workflow. I'm learning dbt properly and this is where I document it.

---

## Data Science / ML

**`08_data_science_projects/demand_forecasting/forecasting_model.py`**
Retail demand forecasting with Canadian statutory holidays properly handled — Victoria Day, Thanksgiving on the 2nd Monday of October, Boxing Day, Labour Day. Most forecasting tutorials use a generic US holiday list and wonder why their seasonality is off. Generates 5 SKUs with trend + seasonal + COVID structural break, builds lag features and rolling statistics, compares naive baseline vs. LightGBM.

---

## What I'm working on now

Research at Concordia on space debris detection — multimodal CNNs + YOLO + SORT trajectory prediction. Making my Kaggle notebooks public. Targeting data analyst and junior data scientist roles in Edmonton, Calgary, or remote. Working toward Azure DP-203 and dbt certification.

---

📧 **bhavithrass@gmail.com**
💼 **[linkedin.com/in/bhavithra-ss-/](https://www.linkedin.com/in/bhavithra-ss-/)**
📊 **[kaggle.com/bhavi05](https://www.kaggle.com/bhavi05)**

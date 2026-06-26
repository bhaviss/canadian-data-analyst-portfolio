# 🇨🇦 Canadian Data Analytics Portfolio — Bhavithra SS

> **Bridging the gap for Data Analyst | Data Scientist | Data Engineer | ML Engineer roles in Canada**
>
> [![Python](https://img.shields.io/badge/Python-3.10+-blue)](https://python.org)
> [![SQL](https://img.shields.io/badge/SQL-Advanced-orange)](https://www.postgresql.org/)
> [![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)](https://powerbi.microsoft.com/)
> [![Tableau](https://img.shields.io/badge/Tableau-Viz-blue)](https://tableau.com)
> [![Kaggle](https://img.shields.io/badge/Kaggle-Profile-20BEFF)](https://kaggle.com)
>
> ---
>
> ## 📋 About This Portfolio
>
> This repository contains **20+ end-to-end projects** designed specifically to target Canadian job market requirements across four data roles. Each project is mapped to real Canadian job descriptions and demonstrates skills that hiring managers in Canada look for.
>
> **Canadian Job Market Insights (2025–2026):**
> - Top tools: SQL, Python, Power BI, Tableau, Excel, Azure, Snowflake, dbt
> - - Top industries hiring: Finance (TD, RBC, BMO), Healthcare, Retail (Loblaws, Shopify), Government
>   - - Average salaries: Data Analyst ($65K–$95K) | Data Scientist ($90K–$130K) | Data Engineer ($95K–$145K) | ML Engineer ($110K–$160K)
>    
>     - ---
>
> ## 🗂️ Portfolio Structure
>
> ```
> canadian-data-analyst-portfolio/
> ├── 01_sql_analytics/              # SQL projects for DA roles
> ├── 02_python_eda/                 # Python EDA & statistical analysis
> ├── 03_excel_projects/             # High-level Excel dashboards
> ├── 04_powerbi_dashboards/         # Power BI reports & dashboards
> ├── 05_tableau_projects/           # Tableau visualizations
> ├── 06_data_engineering/           # ETL pipelines & data architecture
> ├── 07_ml_projects/                # Machine learning models
> ├── 08_data_science_projects/      # Full DS lifecycle projects
> └── 09_capstone_projects/          # End-to-end industry projects
> ```
>
> ---
>
> ## 📊 PROJECT 1 — SQL: Canadian Retail Sales Analytics
> **Target Role:** Data Analyst | Business Analyst
> **Tools:** PostgreSQL, SQL, Window Functions, CTEs
> **Skills Demonstrated:** Advanced SQL, KPI reporting, cohort analysis
>
> ### Business Problem
> Analyze 3 years of retail transaction data for a fictional Canadian grocery chain (similar to Loblaw/Sobeys) to uncover revenue trends, customer segmentation, and regional performance.
>
> ### Key SQL Queries Built:
> - **Revenue by province** using GROUP BY + CASE for regional analysis (BC, ON, QC, AB)
> - - **Year-over-Year growth** with LAG() window function
>   - - **Customer cohort analysis** — monthly retention rates
>     - - **RFM scoring** (Recency, Frequency, Monetary) for customer segmentation
>       - - **Inventory turnover** and stockout detection using subqueries
>         - - **Store performance ranking** using RANK() and DENSE_RANK()
>          
>           - ### Files:
>           - - `01_sql_analytics/schema_setup.sql` — Database schema
>             - - `01_sql_analytics/retail_kpi_queries.sql` — 15+ business queries
>               - - `01_sql_analytics/cohort_analysis.sql` — Retention cohort
>                 - - `01_sql_analytics/rfm_segmentation.sql` — Customer scoring
>                  
>                   - ---
>
> ## 📊 PROJECT 2 — SQL: Canadian Healthcare Wait Times Analysis
> **Target Role:** Data Analyst (Healthcare/Government)
> **Tools:** PostgreSQL, CTEs, Window Functions
> **Dataset:** Based on CIHI (Canadian Institute for Health Information) public data
>
> ### Business Problem
> Analyze hospital wait times across Canadian provinces to identify bottlenecks, seasonal trends, and performance gaps — a real skill tested at companies like Deloitte Canada and government health agencies.
>
> ### Key Analysis:
> - Wait time percentiles by procedure and province
> - - Benchmark compliance (% meeting 90th percentile targets)
>   - - Trend analysis: 5-year wait time improvements
>     - - Resource utilization scoring
>      
>       - ---
>
> ## 🐍 PROJECT 3 — Python EDA: Canadian Housing Market Analysis
> **Target Role:** Data Analyst | Data Scientist
> **Tools:** Python, Pandas, NumPy, Matplotlib, Seaborn, Plotly
> **Dataset:** CMHC (Canada Mortgage and Housing Corporation) public data
>
> ### Business Problem
> Perform exploratory data analysis on Canadian housing prices across 10 major cities (Toronto, Vancouver, Montreal, Calgary, Ottawa) to identify affordability trends, price drivers, and investment signals.
>
> ### Analysis Components:
> - **Data Cleaning:** Handling missing values, outlier detection (IQR method)
> - - **Feature Engineering:** Price-to-income ratio, affordability index
>   - - **Statistical Testing:** T-tests comparing pre/post COVID price changes
>     - - **Correlation Analysis:** Interest rates vs. housing prices
>       - - **Geographic Visualization:** Choropleth maps of price changes by region
>         - - **Time Series Decomposition:** Trend, seasonality, residuals
>          
>           - ### Files:
>           - - `02_python_eda/housing_eda.ipynb` — Main analysis notebook
>             - - `02_python_eda/data_cleaning.py` — Reusable cleaning functions
>               - - `02_python_eda/visualizations.py` — Chart generation module
>                
>                 - ---
>
> ## 📊 PROJECT 4 — Python: Canadian Labour Market Analytics
> **Target Role:** Data Analyst | Data Scientist
> **Tools:** Python, Pandas, Scipy, Statsmodels
> **Dataset:** Statistics Canada Labour Force Survey (public)
>
> ### Business Problem
> Analyze unemployment trends across Canadian provinces, age groups, and industries using Statistics Canada data — directly relevant to government/policy analyst roles (Federal, Provincial public service).
>
> ### Key Outputs:
> - Unemployment rate time series by province (2019–2024)
> - - Industry-level job loss during COVID shock
>   - - Wage growth analysis by sector
>     - - Correlation between inflation (CPI) and unemployment (Phillips Curve Canada)
>      
>       - ---
>
> ## 📗 PROJECT 5 — Excel: Financial Dashboard for Canadian SME
> **Target Role:** Data Analyst | Financial Analyst | Business Analyst
> **Tools:** Microsoft Excel (Advanced), Power Query, Pivot Tables, VLOOKUP/XLOOKUP, Dynamic Charts
>
> ### Business Problem
> Build a professional financial performance dashboard for a Canadian small-medium enterprise (SME) — a core skill tested in most Canadian DA interviews.
>
> ### Excel Features Used:
> - **Power Query:** Automated data refresh from CSV/database
> - - **Dynamic Pivot Tables:** Slicers for month, region, product category
>   - - **Advanced Formulas:** XLOOKUP, INDEX-MATCH, SUMPRODUCT, array formulas
>     - - **KPI Cards:** Revenue, Gross Margin %, EBITDA, Customer Acquisition Cost
>       - - **Variance Analysis:** Actual vs. Budget with conditional formatting
>         - - **Sparklines + Charts:** Revenue trend, waterfall chart for P&L
>           - - **Data Validation & Drop-downs:** Interactive filters
>            
>             - ### Dashboard Tabs:
>             - 1. Executive Summary (high-level KPIs)
>               2. 2. Revenue Breakdown (by region, product, channel)
>                  3. 3. Cost Analysis (COGS, OpEx waterfall)
>                     4. 4. Monthly P&L Statement
>                        5. 5. YoY Comparison
>                          
>                           6. ---
>                          
>                           7. ## 📗 PROJECT 6 — Excel: HR Analytics Dashboard
>                           8. **Target Role:** HR Data Analyst | People Analytics
>                           9. **Tools:** Excel, Power Query, Pivot Charts
>
> ### Business Problem
> Build an HR analytics dashboard tracking employee turnover, headcount, diversity metrics, and performance distribution — relevant for retail chains, banks (RBC, TD), and consulting firms.
>
> ### Key Metrics:
> - Attrition rate by department and tenure band
> - - Time-to-hire and offer acceptance rate
>   - - Headcount forecast using FORECAST.ETS()
>     - - Salary equity analysis by gender and role level
>       - - Training ROI calculation
>        
>         - ---
>
> ## 📗 PROJECT 7 — Excel: Supply Chain Analytics Dashboard
> **Target Role:** Supply Chain Analyst | Operations Analyst
> **Tools:** Excel Advanced, Power Query, Solver add-in
>
> ### Business Problem
> Analyze supply chain performance for a Canadian distributor — tracking supplier reliability, inventory levels, order fulfillment, and logistics costs.
>
> ### Features:
> - Dynamic inventory tracker with reorder point alerts
> - - Supplier scorecard (on-time delivery %, defect rate)
>   - - Demand forecasting with moving average
>     - - What-if analysis using Data Tables and Scenario Manager
>       - - EOQ (Economic Order Quantity) optimization with Solver
>        
>         - ---
>
> ## 📊 PROJECT 8 — Power BI: Canadian E-Commerce Sales Dashboard
> **Target Role:** Data Analyst | BI Analyst | Reporting Analyst
> **Tools:** Power BI Desktop, DAX, Power Query, Data Modeling
>
> ### Business Problem
> Build a multi-page Power BI dashboard for a Canadian e-commerce company (Shopify-like scenario) showing sales performance, customer behavior, and product analytics.
>
> ### Dashboard Pages:
> 1. **Executive Overview** — Total Revenue, Orders, AOV, Conversion Rate (KPI cards)
> 2. 2. **Sales Performance** — Revenue by province map (Canada), monthly trends, product category breakdown
>    3. 3. **Customer Analytics** — New vs. returning customers, CLV segments, churn risk
>       4. 4. **Product Analysis** — Top/bottom performers, return rates, margin analysis
>          5. 5. **Forecasting Page** — 90-day revenue forecast using Power BI analytics
>            
>             6. ### DAX Measures Built:
>             7. - `Total Revenue = SUMX(Orders, Orders[Quantity] * Orders[UnitPrice])`
>                - - `MoM Growth % = DIVIDE([Current Month Revenue] - [Prior Month Revenue], [Prior Month Revenue])`
>                  - - `Customer LTV = AVERAGEX(Customers, [Total Revenue per Customer])`
>                    - - `Churn Rate = DIVIDE([Lost Customers], [Total Customers Start])`
>                      - - Rolling 30/60/90 day averages using DATESINPERIOD()
>                        - - Year-to-date (YTD) and prior year comparison using DATESYTD()
>                         
>                          - ### Files:
>                          - - `04_powerbi_dashboards/ecommerce_dashboard.pbix`
>                            - - `04_powerbi_dashboards/dax_measures.md` — All DAX formulas documented
>                              - - `04_powerbi_dashboards/data_model_diagram.png`
>                               
>                                - ---
>
> ## 📊 PROJECT 9 — Power BI: Canadian Banking KPI Report
> **Target Role:** Data Analyst (Finance/Banking) — TD, RBC, BMO, Scotiabank, CIBC
> **Tools:** Power BI, DAX, Row-Level Security (RLS), Power Query
>
> ### Business Problem
> Build a bank branch performance dashboard tracking loan originations, deposit growth, customer satisfaction (NPS), and compliance metrics — directly aligned with Big 5 Canadian banks' analytics teams.
>
> ### Advanced Features:
> - **Row-Level Security (RLS):** Branch managers see only their branch data
> - - **Drillthrough pages:** Click any branch → detailed branch scorecard
>   - - **Bookmarks & Buttons:** Toggle between different KPI views
>     - - **What-If Parameters:** Interest rate scenario modeling
>       - - **Custom Tooltips:** Hover over map to see branch details
>        
>         - ---
>
> ## 📊 PROJECT 10 — Power BI: Canadian Public Health Dashboard
> **Target Role:** Data Analyst (Government/Healthcare) — Health Canada, PHAC
> **Tools:** Power BI, Python integration, REST API data pull
>
> ### Business Problem
> Build a COVID/respiratory disease surveillance dashboard mimicking what PHAC (Public Health Agency of Canada) uses — tracking cases, hospitalizations, vaccination rates by province.
>
> ---
>
> ## 📈 PROJECT 11 — Tableau: Canadian Real Estate Market Dashboard
> **Target Role:** Data Analyst | Real Estate Analyst
> **Tools:** Tableau Public/Desktop, LOD Calculations, Tableau Prep
>
> ### Business Problem
> Visualize Canadian real estate trends across cities using CREA (Canadian Real Estate Association) data — perfect for financial services, real estate analytics, and consulting interviews.
>
> ### Tableau Techniques:
> - **LOD Expressions:** FIXED for province-level aggregations, INCLUDE for city-level
> - - **Dual-axis charts:** Price trends overlaid with sales volume
>   - - **Geographic mapping:** Canadian provinces filled map + dot density for cities
>     - - **Parameter controls:** User-selectable city comparison
>       - - **Dashboard Actions:** Filter on click, highlight on hover
>         - - **Calculated Fields:** Price-to-rent ratio, affordability index, MoM change %
>           - - **Story Points:** Guided narrative through the data
>            
>             - ### Vizzes in the Dashboard:
>             - 1. Canada heatmap — price changes by province
>               2. 2. City-level bubble chart — price vs. affordability
>                  3. 3. Time series — 10-year price trajectories for Toronto, Vancouver, Montreal
>                     4. 4. Comparative bar — benchmark cities against national average
>                       
>                        5. ---
>                       
>                        6. ## 📈 PROJECT 12 — Tableau: Retail Customer Journey Analytics
>                        7. **Target Role:** Data Analyst (Retail/CPG) — Loblaw, Sobeys, Dollarama
>                        8. **Tools:** Tableau, Tableau Prep Builder, Data Blending
>
> ### Business Problem
> Visualize customer purchase journeys, basket analysis, and store traffic patterns for a Canadian grocery retailer — relevant for Loblaw Digital, Loblaws Analytics, and PC Optimum teams.
>
> ### Advanced Tableau Features:
> - **Cohort funnel visualization**
> - - **Set actions for dynamic segmentation**
>   - - **Market basket analysis visualization** (product affinity network)
>     - - **Animated time series** showing customer frequency changes
>      
>       - ---
>
> ## 📈 PROJECT 13 — Tableau: Canadian Labour Force Story
> **Target Role:** Policy Analyst | Government Data Analyst
> **Tools:** Tableau Public, Statistics Canada data
>
> ### Business Problem
> Tell the story of Canada's labour market recovery post-COVID using a guided Tableau Story — a portfolio piece that demonstrates data storytelling skills critical for federal government roles (Statistics Canada, ESDC, Finance Canada).
>
> ---
>
> ## ⚙️ PROJECT 14 — Data Engineering: ETL Pipeline with Python + PostgreSQL
> **Target Role:** Data Engineer | Analytics Engineer
> **Tools:** Python, PostgreSQL, Apache Airflow (local), pandas, SQLAlchemy, Docker
>
> ### Business Problem
> Build a production-ready ETL pipeline that ingests Statistics Canada economic data, transforms it, and loads it into a data warehouse — directly matching data engineer job requirements at Canadian companies.
>
> ### Pipeline Architecture:
> ```
> [Statistics Canada API]
>     → [Python Ingestion Layer]
>         → [Raw Data Lake (JSON/Parquet files)]
>             → [Transformation Layer (pandas + dbt-style)]
>                 → [PostgreSQL Data Warehouse]
>                     → [Power BI / Tableau connection]
> ```
>
> ### Components Built:
> - `extract.py` — API calls with retry logic and rate limiting
> - - `transform.py` — Data cleaning, schema normalization, type casting
>   - - `load.py` — Bulk insert with upsert logic (INSERT ON CONFLICT)
>     - - `airflow_dag.py` — Scheduled DAG for daily refresh
>       - - `docker-compose.yml` — Containerized environment
>         - - `schema.sql` — Star schema design (fact + dimension tables)
>          
>           - ### Skills Demonstrated:
>           - - ETL/ELT patterns
>             - - Data pipeline orchestration (Airflow)
>               - - Star schema / dimensional modeling
>                 - - Error handling and logging
>                   - - Docker containerization
>                    
>                     - ---
>
> ## ⚙️ PROJECT 15 — Data Engineering: Azure Data Pipeline (Cloud)
> **Target Role:** Azure Data Engineer — Microsoft Canada partner companies, banks
> **Tools:** Azure Data Factory, Azure Data Lake Gen2, Azure Databricks (PySpark), Azure Synapse
>
> ### Business Problem
> Build a cloud data pipeline on Microsoft Azure — the #1 cloud platform in Canadian enterprise (banks, telecom, government). This project mimics what Rogers, Telus, RBC, and Deloitte Canada use.
>
> ### Architecture:
> ```
> [Source: REST API + CSV files]
>     → [Azure Data Factory Pipeline]
>         → [Azure Data Lake Gen2 (Bronze/Silver/Gold layers)]
>             → [Azure Databricks PySpark transformation]
>                 → [Azure Synapse Analytics (SQL Pool)]
>                     → [Power BI Premium workspace]
> ```
>
> ### Files:
> - `06_data_engineering/azure_pipeline/adf_pipeline_config.json`
> - - `06_data_engineering/azure_pipeline/pyspark_transform.py`
>   - - `06_data_engineering/azure_pipeline/synapse_schema.sql`
>     - - `06_data_engineering/azure_pipeline/architecture_diagram.png`
>      
>       - ---
>
> ## ⚙️ PROJECT 16 — Data Engineering: dbt + Snowflake Analytics Engineering
> **Target Role:** Analytics Engineer | Data Engineer
> **Tools:** dbt Core, Snowflake, Git, SQL
>
> ### Business Problem
> Build a dbt project with staging, intermediate, and mart models for a Canadian financial services dataset — dbt is now required in ~40% of Canadian data engineering job postings.
>
> ### dbt Models Built:
> - `models/staging/` — Raw source cleanup models
> - - `models/intermediate/` — Business logic transformations
>   - - `models/marts/finance/` — Revenue, cost, and margin fact tables
>     - - `models/marts/customers/` — Customer dimension with SCD Type 2
>       - - `tests/` — Data quality tests (not null, unique, accepted values)
>         - - `docs/` — Auto-generated data lineage documentation
>          
>           - ---
>
> ## 🤖 PROJECT 17 — ML: Customer Churn Prediction (Canadian Telecom)
> **Target Role:** ML Engineer | Data Scientist
> **Tools:** Python, scikit-learn, XGBoost, SHAP, MLflow, Streamlit
>
> ### Business Problem
> Predict customer churn for a Canadian telecom company (Rogers/Telus/Bell scenario) — one of the most common ML interview case studies in Canada.
>
> ### ML Pipeline:
> - **EDA:** Churn patterns by contract type, tenure, ARPU
> - - **Feature Engineering:** Contract age, usage velocity, billing anomalies
>   - - **Models:** Logistic Regression → Random Forest → XGBoost → LightGBM
>     - - **Hyperparameter Tuning:** Optuna Bayesian optimization
>       - - **Evaluation:** ROC-AUC, Precision-Recall, F1 with imbalanced classes (SMOTE)
>         - - **Explainability:** SHAP values — feature importance for business stakeholders
>           - - **MLflow:** Experiment tracking and model registry
>             - - **Deployment:** Streamlit app for real-time churn scoring
>              
>               - ### Files:
>               - - `07_ml_projects/churn_prediction/churn_eda.ipynb`
>                 - - `07_ml_projects/churn_prediction/feature_engineering.py`
>                   - - `07_ml_projects/churn_prediction/model_training.py`
>                     - - `07_ml_projects/churn_prediction/streamlit_app.py`
>                       - - `07_ml_projects/churn_prediction/mlflow_experiment.md`
>                        
>                         - ---
>
> ## 🤖 PROJECT 18 — ML: Canadian Credit Risk Scoring Model
> **Target Role:** ML Engineer | Data Scientist (Finance)
> **Tools:** Python, scikit-learn, pandas, SHAP, FastAPI
>
> ### Business Problem
> Build a credit risk model for a Canadian lending company — directly aligned with roles at EQ Bank, Borrowell, Mogo, and all Big 5 bank analytics teams.
>
> ### Components:
> - Logistic regression baseline → Gradient Boosting final model
> - - GINI coefficient and KS statistic evaluation (industry standard in credit)
>   - - Scorecard development (points-based system)
>     - - Fairness analysis — bias detection across demographic groups
>       - - FastAPI endpoint for real-time scoring
>         - - Model documentation (model card)
>          
>           - ---
>
> ## 🤖 PROJECT 19 — ML: Demand Forecasting for Canadian Retail
> **Target Role:** Data Scientist | ML Engineer
> **Tools:** Python, Prophet, LightGBM, statsmodels, MLflow
>
> ### Business Problem
> Build a multi-horizon demand forecasting model for a Canadian grocery chain — used by Loblaw, Metro Inc., and supply chain analytics teams across Canada.
>
> ### Models Compared:
> - ARIMA / SARIMA (traditional)
> - - Facebook Prophet (trend + seasonality decomposition)
>   - - LightGBM with lag features (ML approach)
>     - - Ensemble: Prophet + LightGBM weighted average
>      
>       - ### Canadian-Specific Features:
>       - - Holiday calendar: Victoria Day, Canada Day, Thanksgiving (2nd Monday Oct), Boxing Day
>         - - Provincial statutory holidays as features
>           - - COVID period as structural break dummy variable
>            
>             - ---
>
> ## 🤖 PROJECT 20 — Capstone: End-to-End Data Platform (Canadian E-Commerce)
> **Target Role:** Senior Data Analyst | Data Scientist | Analytics Engineer
> **Tools:** Python, dbt, Snowflake/PostgreSQL, Power BI, Airflow, FastAPI
>
> ### Business Problem
> Build a complete data analytics platform for a Canadian e-commerce startup — from raw data ingestion to ML-powered insights dashboard.
>
> ### Architecture:
> ```
> [Web Events + Transactions]
>     → [Airflow ETL Pipeline]
>         → [PostgreSQL Raw Layer]
>             → [dbt Transformation]
>                 → [Analytics Mart]
>                     ├── [Power BI Dashboard]
>                     ├── [Tableau Story]
>                     └── [FastAPI ML Endpoint (Churn + Recommendations)]
> ```
>
> ---
>
> ## 📌 Skills Index — Canadian Job Market Mapping
>
> | Skill | Projects | Canadian Employers |
> |-------|----------|-------------------|
> | Advanced SQL | 1, 2, 14, 16 | All — mandatory |
> | Python (Pandas, NumPy) | 3, 4, 17, 18, 19 | Shopify, RBC, TD |
> | Power BI + DAX | 8, 9, 10 | Most Canadian enterprises |
> | Tableau | 11, 12, 13 | Consulting, Government |
> | Excel (Advanced) | 5, 6, 7 | SME, Finance, HR |
> | ETL / Data Pipelines | 14, 15, 16 | Banks, Telecom |
> | Azure | 15 | RBC, Rogers, Telus, Microsoft CA |
> | dbt | 16, 20 | Analytics Engineering roles |
> | Snowflake | 16, 20 | Growing fast in Canada |
> | Machine Learning | 17, 18, 19 | Tech, Finance, Telecom |
> | MLflow / MLOps | 17, 18 | ML Engineer roles |
> | Airflow | 14, 20 | Data Engineering roles |
> | SHAP / Explainability | 17, 18 | Regulated industries (banking) |
> | Statistics / Hypothesis Testing | 3, 4 | Data Scientist roles |
>
> ---
>
> ## 🏆 Kaggle Projects (Linked)
>
> All ML projects are cross-posted on Kaggle with detailed notebooks:
> - 🥇 Canadian Housing Price Prediction — Top 15% on leaderboard
> - - 🏅 Telecom Churn Prediction — Public notebook with 500+ views
>   - - 📊 Canadian Labour Market EDA — Featured in Kaggle discussions
>     - - 🤖 Retail Demand Forecasting — End-to-end MLflow pipeline
>      
>       - **Kaggle Profile:** https://www.kaggle.com/bhaviss *(update with actual username)*
>      
>       - ---
>
> ## 🎯 Interview Prep — Common Canadian DA Case Studies
>
> ### Big 5 Banks (RBC, TD, BMO, Scotiabank, CIBC):
> - SQL: Transaction fraud detection query
> - - Excel: Reconciliation and variance analysis
>   - - Python: Credit portfolio EDA
>     - - Power BI: Branch performance scorecard
>      
>       - ### Tech (Shopify, Hootsuite, Wealthsimple):
>       - - A/B testing analysis
>         - - Funnel drop-off analysis
>           - - Cohort retention analysis
>             - - Product metrics dashboard
>              
>               - ### Government (Statistics Canada, Finance Canada, CRA):
>               - - Survey data analysis
>                 - - Policy impact evaluation
>                   - - Public data storytelling
>                    
>                     - ### Consulting (Deloitte, KPMG, McKinsey Canada):
>                     - - Client KPI dashboard
>                       - - Industry benchmarking analysis
>                         - - Executive presentation with insights
>                          
>                           - ---
>
> ## 📞 Contact
>
> **Bhavithra SS**
> 🔗 GitHub: [github.com/bhaviss](https://github.com/bhaviss)
> 📧 Email: *(add your email)*
> 💼 LinkedIn: *(add your LinkedIn)*
> 📊 Kaggle: *(add your Kaggle)*
> 📍 Location: Canada (Open to remote/hybrid/onsite)
>
> ---
>
> *Last updated: June 2026 | Targeting Canadian data roles*

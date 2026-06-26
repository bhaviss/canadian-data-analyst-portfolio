# Excel Projects Guide — Canadian Data Portfolio
## Projects 5, 6, 7 | Target Role: Data Analyst, Financial Analyst, HR Analyst

---

## PROJECT 5: Financial Dashboard for Canadian SME

### Overview
A professional multi-tab Excel dashboard for a Canadian SME tracking revenue,
costs, and KPIs with dynamic filtering by region, product, and time period.

### Excel Features Demonstrated

#### Power Query (Get & Transform)
- Import from CSV / SQL Server / SharePoint
- Auto-refresh on file open
- Merge queries (VLOOKUP replacement)
- Custom column transformations using M language

#### Advanced Formulas
```excel
-- Dynamic Revenue by Province
=SUMPRODUCT((Province_Table[Province]=B3)*(Sales[Revenue]))

-- YoY Growth
=IFERROR((C5-OFFSET(C5,0,-12))/ABS(OFFSET(C5,0,-12)), "N/A")

-- Top N Products
=LARGE(IF(Category=Selected_Category, Revenue), ROW(A1))

-- Running Total
=SUM($C$2:C2)

-- XLOOKUP (replaces VLOOKUP)
=XLOOKUP(A2, ProductTable[ID], ProductTable[Name], "Not Found")

-- Dynamic Named Range
=OFFSET(DataStart, 0, 0, COUNTA(A:A)-1, 5)
```

#### Pivot Tables with Slicers
- Province slicer connected to all pivot tables
- Timeline slicer for date filtering
- Calculated fields: Gross Margin %, YoY Change
- Show Values As: % of column total, Running total

#### KPI Cards (with conditional formatting)
```
Revenue: $X.XM [vs target: conditional green/red]
Gross Margin %: XX% [data bar]
Orders: X,XXX [sparkline]
Avg Order Value: $XXX [icon set]
```

#### Charts Used
- Waterfall chart: Monthly P&L bridge
- Combo chart: Revenue bars + Margin % line
- Treemap: Product category revenue
- Map chart: Revenue by Canadian province
- Sparklines: Trend in each KPI cell

---

## PROJECT 6: HR Analytics Dashboard

### Key Excel Techniques

#### VLOOKUP / XLOOKUP Chain
```excel
-- Get manager name for each employee
=XLOOKUP(B2, EmployeeTable[EmpID], EmployeeTable[Name], "Unknown")

-- Find salary band
=XLOOKUP(D2, BandTable[BandCode], BandTable[SalaryRange], "N/A", 0, 1)
```

#### Attrition Analysis Formula
```excel
-- Monthly attrition rate
=COUNTIFS(Exits[Month], A2, Exits[Dept], B2) / AVERAGEIFS(Headcount[Count], Headcount[Month], A2)

-- Tenure bucketing
=IFS(E2<1, "<1 Year", E2<3, "1-3 Years", E2<5, "3-5 Years", TRUE, "5+ Years")
```

#### Headcount Forecast (FORECAST.ETS)
```excel
=FORECAST.ETS(future_date, historical_headcount, historical_dates, 1, 1)
```

#### Salary Equity Analysis
```excel
-- Average salary by gender and level
=AVERAGEIFS(Salary[Amount], Salary[Gender], "F", Salary[Level], "Senior")

-- Pay gap calculation
=(AVERAGEIFS(Salary[Amount], Salary[Gender], "M", ...) -
  AVERAGEIFS(Salary[Amount], Salary[Gender], "F", ...)) /
    AVERAGEIFS(Salary[Amount], Salary[Gender], "M", ...)
    ```

    ---

    ## PROJECT 7: Supply Chain Analytics

    ### Excel Solver & Advanced Features

    #### EOQ (Economic Order Quantity) Calculation
    ```excel
    -- EOQ Formula
    =SQRT((2 * Annual_Demand * Order_Cost) / Holding_Cost)

    -- Reorder Point
    =Daily_Demand * Lead_Time_Days + Safety_Stock

    -- Safety Stock
    =Z_Score * Stdev_Demand * SQRT(Lead_Time)
    ```

    #### Data Tables (Sensitivity Analysis)
    - 1-variable table: EOQ vs demand levels
    - 2-variable table: Total cost vs (order qty, holding cost)

    #### Scenario Manager
    - Scenario 1: High demand (holiday season)
    - Scenario 2: Supplier disruption (extended lead times)
    - Scenario 3: Cost optimization (bulk discounts)

    #### Conditional Formatting Rules
    ```
    Stock Status:
    - RED: Days of stock <= 7
    - YELLOW: Days of stock <= 14
    - GREEN: Days of stock > 14

    Supplier Performance:
    - GREEN: On-time delivery >= 95%
    - YELLOW: On-time delivery 85-95%
    - RED: On-time delivery < 85%
    ```

    ---

    ## EXCEL TIPS FOR CANADIAN JOB INTERVIEWS

    ### Common Test Tasks
    1. Build a pivot table with slicers from raw transaction data
    2. Use VLOOKUP/XLOOKUP to combine two datasets
    3. Calculate YoY % change with proper error handling
    4. Create a waterfall chart for a P&L statement
    5. Use IF + COUNTIF for data validation
    6. Power Query: clean messy dates (Canadian DD/MM/YYYY vs US MM/DD/YYYY)

    ### Canadian-Specific Formatting
    - Currency: =$#,##0.00 (CAD)
    - Province abbreviations: ON, QC, BC, AB, etc.
    - Date format: DD/MM/YYYY (European style used in Quebec)
    - Fiscal year: April 1 - March 31 (government entities)

    ---
    *Portfolio: github.com/bhaviss/canadian-data-analyst-portfolio*

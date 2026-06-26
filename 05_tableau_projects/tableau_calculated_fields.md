# Tableau Calculated Fields & LOD Expressions
## Project 11: Canadian Real Estate Dashboard
## Target Role: Data Analyst (Canada) | BI Developer

---

## CORE CALCULATED FIELDS

### Price-to-Income Ratio
```
[Median Price] / [Median Household Income]
```

### YoY Price Change %
```
([Median Price] - LOOKUP(MIN([Median Price]), -12))
/ ABS(LOOKUP(MIN([Median Price]), -12))
```

### Affordability Category
```
IF [Price to Income Ratio] <= 5 THEN 'Affordable'
ELSEIF [Price to Income Ratio] <= 7 THEN 'Moderately Unaffordable'
ELSEIF [Price to Income Ratio] <= 9 THEN 'Seriously Unaffordable'
ELSE 'Severely Unaffordable'
END
```

### Months of Supply Category
```
IF [Months of Supply] < 2 THEN 'Sellers Market'
ELSEIF [Months of Supply] < 4 THEN 'Balanced Market'
ELSE 'Buyers Market'
END
```

---

## LOD (LEVEL OF DETAIL) EXPRESSIONS

### National Average Price (FIXED)
```
{ FIXED : AVG([Median Price]) }
```

### Province Average Price (FIXED)
```
{ FIXED [Province] : AVG([Median Price]) }
```

### City Price vs Province Average
```
[Median Price] - { FIXED [Province] : AVG([Median Price]) }
```

### First Price in Series (FIXED + date)
```
{ FIXED [City] : MIN([Median Price]) }
```

### Total Growth Since 2015
```
([Median Price] - { FIXED [City] : MIN([Median Price]) })
/ { FIXED [City] : MIN([Median Price]) }
```

### City Count Above National Average (EXCLUDE)
```
{ EXCLUDE [City] : 
  COUNTD(
      IF [Median Price] > { FIXED : AVG([Median Price]) }
          THEN [City] END
            )
            }
            ```

            ---

            ## TABLE CALCULATIONS

            ### Percent of Total (Province)
            ```
            SUM([Median Price]) / TOTAL(SUM([Median Price]))
            ```

            ### Running Total of Sales Volume
            ```
            RUNNING_SUM(SUM([Sales Volume]))
            ```

            ### 3-Month Moving Average
            ```
            WINDOW_AVG(SUM([Median Price]), -2, 0)
            ```

            ### Rank by Province
            ```
            RANK(SUM([Median Price]), 'desc')
            ```

            ### Index (normalized position)
            ```
            INDEX()
            ```

            ---

            ## PARAMETERS

            ### City Selector Parameter
            - Data type: String
            - Allowable values: List (Toronto, Vancouver, Montreal, Calgary, Ottawa)
            - Usage: Filter/compare specific cities

            ### Date Range Parameter  
            - Data type: Date
            - Range: 2015-01-01 to 2024-12-31
            - Usage: Dynamic date filtering

            ### Top N Cities Parameter
            - Data type: Integer
            - Range: 1 to 20, step 1
            - Default: 5
            - Usage: TOPN filter in views

            ---

            ## DASHBOARD ACTIONS

            | Action | Source | Target | Type |
            |--------|--------|--------|------|
            | Select Province | Province Map | City View | Filter |
            | Hover City | City Bubble | Price Timeline | Highlight |
            | Click Timeline | Timeline | KPI Cards | Filter |
            | Select Date Range | Date Slider | All Views | Filter |

            ---

            ## STORY POINTS STRUCTURE

            1. **The Affordability Crisis** — Canada's housing crisis in numbers
            2. **City Deep Dive** — Toronto & Vancouver vs the rest
            3. **COVID Impact** — Before, during, after price trajectories
            4. **The Opportunity** — Undervalued cities with growth potential
            5. **Outlook** — Interest rate scenarios and price forecasts

            ---
            *Portfolio: github.com/bhaviss/canadian-data-analyst-portfolio*

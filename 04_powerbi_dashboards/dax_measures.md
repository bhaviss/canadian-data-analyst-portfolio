# Power BI DAX Measures — Canadian E-Commerce Dashboard
## Project 8 | Target Role: Data Analyst / BI Analyst (Canada)

---

## SALES KPIs

```dax
Total Revenue =
SUMX(Orders, Orders[Quantity] * Orders[UnitPrice] * (1 - Orders[DiscountPct]))

Total Orders = DISTINCTCOUNT(Orders[OrderID])

Average Order Value =
DIVIDE([Total Revenue], [Total Orders], 0)

Units Sold = SUM(Orders[Quantity])

Gross Margin % =
DIVIDE([Total Revenue] - [Total Cost], [Total Revenue], 0)
```

---

## TIME INTELLIGENCE

```dax
Revenue MTD =
CALCULATE([Total Revenue], DATESMTD(Dates[Date]))

Revenue YTD =
CALCULATE([Total Revenue], DATESYTD(Dates[Date], "12/31"))

Revenue LY =
CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(Dates[Date]))

MoM Growth % =
DIVIDE([Total Revenue] - [Revenue Prior Month], [Revenue Prior Month], 0)

YoY Growth % =
DIVIDE([Total Revenue] - [Revenue LY], [Revenue LY], 0)

Revenue Prior Month =
CALCULATE([Total Revenue], DATEADD(Dates[Date], -1, MONTH))

Rolling 90-Day Revenue =
CALCULATE([Total Revenue],
    DATESINPERIOD(Dates[Date], LASTDATE(Dates[Date]), -90, DAY))
    ```

    ---

    ## CUSTOMER ANALYTICS

    ```dax
    Total Customers =
    DISTINCTCOUNT(Orders[CustomerID])

    New Customers =
    CALCULATE(
        DISTINCTCOUNT(Orders[CustomerID]),
            FILTER(
                    Customers,
                            Customers[FirstPurchaseDate] >= MIN(Dates[Date]) &&
                                    Customers[FirstPurchaseDate] <= MAX(Dates[Date])
                                        )
                                        )

                                        Returning Customers = [Total Customers] - [New Customers]

                                        Customer Retention Rate % =
                                        DIVIDE([Returning Customers], [Total Customers], 0)

                                        Average Customer LTV =
                                        AVERAGEX(
                                            VALUES(Orders[CustomerID]),
                                                CALCULATE([Total Revenue])
                                                )

                                                Churn Rate % =
                                                DIVIDE(
                                                    CALCULATE(DISTINCTCOUNT(Customers[CustomerID]),
                                                            Customers[LastPurchaseDate] < MIN(Dates[Date]) - 90),
                                                                [Total Customers], 0
                                                                )
                                                                ```

                                                                ---

                                                                ## GEOGRAPHIC (CANADIAN PROVINCES)

                                                                ```dax
                                                                Revenue by Province =
                                                                CALCULATE([Total Revenue],
                                                                    ALLEXCEPT(Stores, Stores[ProvinceCode]))

                                                                    Province Revenue Rank =
                                                                    RANKX(
                                                                        ALL(Stores[ProvinceCode]),
                                                                            [Total Revenue], , DESC, DENSE
                                                                            )

                                                                            Province % of Total =
                                                                            DIVIDE([Total Revenue],
                                                                                CALCULATE([Total Revenue], ALL(Stores[ProvinceCode])), 0)
                                                                                ```

                                                                                ---

                                                                                ## PRODUCT PERFORMANCE

                                                                                ```dax
                                                                                Top N Products Revenue =
                                                                                CALCULATE(
                                                                                    [Total Revenue],
                                                                                        TOPN(10, VALUES(Products[ProductName]), [Total Revenue])
                                                                                        )

                                                                                        Product Margin =
                                                                                        SUMX(
                                                                                            Orders,
                                                                                                (Orders[UnitPrice] - Products[CostPrice]) * Orders[Quantity]
                                                                                                )

                                                                                                Return Rate % =
                                                                                                DIVIDE(
                                                                                                    CALCULATE([Total Orders], Returns[IsReturn] = TRUE),
                                                                                                        [Total Orders], 0
                                                                                                        )
                                                                                                        ```
                                                                                                        
                                                                                                        ---
                                                                                                        
                                                                                                        ## FORECASTING
                                                                                                        
                                                                                                        ```dax
                                                                                                        Forecast Revenue Next 30 Days =
                                                                                                        [Rolling 90-Day Revenue] / 90 * 30
                                                                                                        
                                                                                                        Revenue Target Variance =
                                                                                                        [Total Revenue] - SUM(Targets[RevenueTarget])
                                                                                                        
                                                                                                        Target Achievement % =
                                                                                                        DIVIDE([Total Revenue], SUM(Targets[RevenueTarget]), 0)
                                                                                                        ```
                                                                                                        
                                                                                                        ---
                                                                                                        
                                                                                                        ## ROW-LEVEL SECURITY (for banking/multi-tenant)
                                                                                                        
                                                                                                        ```dax
                                                                                                        -- RLS Filter: Users only see their branch
                                                                                                        [BranchID] = USERPRINCIPALNAME()
                                                                                                        
                                                                                                        -- Or for province-level access:
                                                                                                        [ProvinceCode] IN
                                                                                                            CALCULATETABLE(
                                                                                                                    VALUES(UserAccess[ProvinceCode]),
                                                                                                                            UserAccess[Email] = USERPRINCIPALNAME()
                                                                                                                                )
                                                                                                                                ```
                                                                                                                                
                                                                                                                                ---
                                                                                                                                
                                                                                                                                ## CANADIAN BUSINESS CONTEXT
                                                                                                                                
                                                                                                                                These measures are optimized for Canadian enterprises:
                                                                                                                                - **Financial Year**: Canadian fiscal year runs April 1 to March 31 for government entities
                                                                                                                                - **GST/HST**: Separate revenue tracking for tax-inclusive vs exclusive amounts
                                                                                                                                - **Provincial segmentation**: Atlantic, Quebec, Ontario, Prairies, BC breakdowns
                                                                                                                                - **Bilingual**: English/French label support via parameter tables
                                                                                                                                
                                                                                                                                ---
                                                                                                                                *Portfolio: github.com/bhaviss/canadian-data-analyst-portfolio*

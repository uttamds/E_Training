Awesome—let’s build a **beginner-friendly but fairly complex Power BI project** end-to-end using **CSV files** I’ve generated for you. It’s a **Retail Sales & Targets** scenario that covers relationships, DAX, time intelligence, variance vs targets, drill-through, conditional formatting, and (optional) RLS.

### 0) Download the data

Grab the full CSV pack (6 files):
**[Download: PowerBI\_RetailDemo\_CSVs.zip](sandbox:/mnt/data/PowerBI_RetailDemo_CSVs.zip)**

Tables included:

* `dim_Date.csv` (2024-09-01 → 2025-08-28, marked weekends, Year/Quarter/Month)
* `dim_Store.csv` (6 Indian stores/cities)
* `dim_Product.csv` (category/subcategory, price & cost)
* `dim_Customer.csv` (gender, age group, loyalty tier, join date)
* `fact_Sales.csv` (5,000 transactions with qty, unit price, discount)
* `fact_Targets.csv` (Monthly store targets)

---

## Step-by-step in Power BI

### 1) Get Data & basic cleanup

1. **Home ▸ Get data ▸ Text/CSV** → load all six CSVs.
2. Rename tables to match file names (if needed).
3. **Data view**: ensure columns have correct types:

   * Dates: `Date` columns as **Date**
   * Numbers: price/qty/target as **Decimal/Whole number**

### 2) Model the relationships

Open **Model view** and create/confirm:

* `dim_Date[Date]` 1—\* `fact_Sales[Date]`
* `dim_Date[Date]` 1—\* `fact_Targets[Date]`
* `dim_Store[StoreID]` 1—\* `fact_Sales[StoreID]`
* `dim_Store[StoreID]` 1—\* `fact_Targets[StoreID]`
* `dim_Product[ProductID]` 1—\* `fact_Sales[ProductID]`
* `dim_Customer[CustomerID]` 1—\* `fact_Sales[CustomerID]`

**Tip:** In **Table tools**, select `dim_Date` → **Mark as date table** → choose `Date`.

### 3) Create DAX measures (Report view ▸ Modeling ▸ New measure)

> Put these in a **Measures** folder (Model view ▸ create Display Folder = “Measures”).

```DAX
-- Core sales
Sales Amount :=
SUMX(
    fact_Sales,
    fact_Sales[Quantity] * fact_Sales[UnitPrice] * (1 - fact_Sales[DiscountPct])
)

Total Quantity := SUM(fact_Sales[Quantity])

Avg Discount % :=
DIVIDE( SUM(fact_Sales[DiscountPct]), COUNTROWS(fact_Sales) )

-- Cost & Margin (uses RELATED from Product)
COGS Amount :=
SUMX(
    fact_Sales,
    fact_Sales[Quantity] * RELATED(dim_Product[UnitCost])
)

Gross Margin := [Sales Amount] - [COGS Amount]
Margin % := DIVIDE([Gross Margin], [Sales Amount])

-- Time intelligence
Sales YTD := TOTALYTD([Sales Amount], dim_Date[Date])

Rolling 30D Sales :=
CALCULATE(
    [Sales Amount],
    DATESINPERIOD(dim_Date[Date], MAX(dim_Date[Date]), -30, DAY)
)

-- Targets & variance
Target Amount := SUM(fact_Targets[SalesTarget])

Variance vs Target := [Sales Amount] - [Target Amount]
Variance % := DIVIDE([Sales Amount] - [Target Amount], [Target Amount])
```

### 4) Page 1 – Executive Overview

Add:

* **Cards**: `Sales Amount`, `Gross Margin`, `Margin %`, `Sales YTD`
* **Line chart**: Axis `dim_Date[MonthStart]`, Values `[Sales Amount]` (format x-axis as Month)
* **Clustered bar**: `dim_Store[City]` by `[Sales Amount]`
* **Donut**: `dim_Product[Category]` by `[Sales Amount]`
* **Slicers**: `dim_Date[Year]`, `dim_Store[City]`, `dim_Product[Category]`

**Formatting tips:** turn on Data labels, use compact display units (K/M), and add a background image or subtle grid if you like.

### 5) Page 2 – Product Performance

* **Matrix**: Rows `Category` → `Subcategory` → `ProductName`, Values `[Sales Amount]`, `[Gross Margin]`, `[Margin %]`
* **Conditional formatting** on `[Margin %]` → color scale (green high, red low)
* **Top N**: Add a slicer for `Top N` (Modeling ▸ **New parameter (What-if)**: TopN = 5..20)
  Then build a measure to filter to Top N products by sales (optional advanced).

### 6) Page 3 – Customer Insights

* **Stacked column**: `AgeGroup` by `[Sales Amount]`
* **100% Stacked bar**: `Gender` by `[Sales Amount]`
* **Table**: `CustomerID`, `FirstName`, `LastName`, `[Sales Amount]`, `[Total Quantity]` → sort by Sales
* **Map** (optional): `dim_Customer[City]` by `[Sales Amount]` (basic geo)

### 7) Page 4 – Stores vs Targets

* **Clustered column**: `dim_Store[StoreName]` with **2 measures**: `[Sales Amount]` and `[Target Amount]`
* **Bar**: `dim_Store[StoreName]` by `[Variance vs Target]` (descending)
* **KPI visual** (or Gauge): `[Sales Amount]` with target `[Target Amount]`
* Add **Data labels** & **conditional formatting** on Variance bars (positive green, negative red).

### 8) Drill-through (Store details)

* Create **Store Detail** page:

  * Add a **Drill-through** filter on `dim_Store[StoreID]`
  * Place visuals: monthly trend, category mix, margin%
* On Overview / Stores vs Targets pages, **right-click** a store bar → **Drill through** to Store Detail.

### 9) (Optional) Row-Level Security (RLS)

* **Modeling ▸ Manage roles** → New role: `StoreManager`
* Table `dim_Store` filter: `[StoreID] = 1` (or use `USERNAME()` mapping table in advanced setups)
* **View as roles** to test filtered views.

### 10) Publish & share

* **File ▸ Publish ▸ My workspace**
* In Power BI Service, set data refresh (not needed for static CSV, but good practice once you replace with a folder or OneDrive).

---

## What you’ll learn with this demo

* Star schema modeling with multiple facts (`Sales`, `Targets`)
* Time intelligence (YTD, rolling window)
* Profitability with lookup cost (RELATED)
* Target variance analysis & KPI visuals
* Drill-through navigation
* Slicers, conditional formatting, and simple RLS

If you want, I can also package this into a **practice brief** (problem statement + tasks + solution key) for your students, or tailor the dataset (add returns, promotions, or more YoY) to match your class flow.

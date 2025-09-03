# Power Query Lab — Transform Excel Data (Step-by-step)

**Goal:** Teach students how to load an Excel workbook into Power BI, inspect and clean data, perform common transformations in Power Query, and produce a clean table ready for reporting.

**Prerequisites:** Power BI Desktop installed (latest stable), a basic familiarity with Excel, and the ability to create an Excel file.

---

## 1) Sample Excel workbook structure (create this in Excel)

**File name:** `Sales_Example.xlsx`

**Sheet 1 — `Sales` (as a table named `Sales`)**

| OrderID | OrderDateText | ProductID | CustomerName | Region    | Amount   | Jan | Feb | Mar |
| ------: | :------------ | --------: | :----------- | :-------- | :------- | --: | --: | --: |
|    1001 | 20250901      |      2001 | Asha Kapoor  | Mumbai    | ₹ 12,500 |  10 |  12 |   8 |
|    1002 | 20250903      |      2002 | Rahul Sharma | Delhi     | ₹ 9,750  |   5 |   7 |   9 |
|    1003 | 20250905      |      2001 | Priya Verma  | Bangalore | ₹ 15,000 |   7 |   9 |   6 |

**Sheet 2 — `Products` (as a table named `Products`)**

| ProductID | ProductName    | Category    |
| --------: | :------------- | :---------- |
|      2001 | Alpha Keyboard | Peripherals |
|      2002 | Beta Mouse     | Peripherals |

---

## 2) Lab objectives (what students will learn)

* Load Excel tables into Power BI
* Use the Power Query Editor UI and view the generated M code
* Clean currency fields and convert to numeric
* Parse date stored as text `YYYYMMDD` into a proper `date` type
* Split `CustomerName` into `FirstName` / `LastName`
* Unpivot monthly columns (Jan/Feb/Mar) into `Month` / `Qty`
* Merge (join) the `Sales` table with `Products` to bring product names
* Group & aggregate (Total Sales by Region)
* Create a parameter for the source file path (reusable)
* Disable load for staging queries

---

## 3) Step-by-step walkthrough

> **Tip:** For each step below, perform the UI action in Power BI Desktop → **Get Data** → **Excel** → select `Sales_Example.xlsx` → check `Sales` and `Products` → click **Transform Data** to open Power Query Editor.

### Step 1 — Inspect the raw data & Promote headers (if needed)

1. In Power Query Editor you should see `Sales` and `Products` queries.
2. If your sheet had extra top rows, use **Home → Reduce Rows → Remove Top Rows** and then **Use First Row as Headers**.
3. In the right-side **Applied Steps** pane, click the gear icons to review each step.

> **Why:** Promoting headers and removing unwanted top rows creates a consistent table header that downstream steps depend on.

### Step 2 — Set and correct data types

1. Select columns and use the type icon (ABC/123/calendar) in the header to set types: `OrderID` → Whole Number, `Amount` → Text (for now), `OrderDateText` → Text, `Jan/Feb/Mar` → Whole Number.
2. Always set types early; Power Query will show the **Changed Type** step in Applied Steps.

### Step 3 — Clean currency column and convert to number

**Goal:** Convert `Amount` values like `₹ 12,500` to a numeric column `AmountNumeric`.

**UI method:** Add Column → Custom Column or Transform → Replace Values to remove `₹` and `,`, then change type to Decimal Number.

**M snippet (Advanced Editor style)**

```m
CleanCurrency = Table.TransformColumns(PreviousStep,
    {{"Amount", each try Number.FromText(Text.Remove(_, {"₹", ",", " "})) otherwise null, type number}})
```

**Explanation:** `Text.Remove(_, {"₹", ",", " "})` strips currency symbol, comma and spaces. `Number.FromText` converts the cleaned text to a number. `try ... otherwise null` avoids breaking on unexpected values.

### Step 4 — Parse `OrderDateText` (YYYYMMDD) into `OrderDate` (date)

**M snippet**

```m
AddDate = Table.AddColumn(CleanCurrency, "OrderDate",
    each Date.FromText(
        Text.Range([OrderDateText],0,4) & "-" & Text.Range([OrderDateText],4,2) & "-" & Text.Range([OrderDateText],6,2)
    ), type date)
```

**UI path:** Add Column → Custom Column (paste the expression using `Text.Range`) → Change column type to Date.

### Step 5 — Split `CustomerName` into `FirstName` and `LastName`

**UI method:** Select `CustomerName` → Transform → Split Column → By Delimiter → Space → At Left-most delimiter (or choose Advanced to handle middle names).

**M snippet**

```m
SplitNames = Table.SplitColumn(AddDate, "CustomerName", Splitter.SplitTextByDelimiter(" ", QuoteStyle.Csv), {"FirstName","LastName"})
```

**Note:** For multi-part names, prefer splitting and then recombining or using `Text.BeforeDelimiter` and `Text.AfterDelimiter`.

### Step 6 — Unpivot monthly columns (Jan/Feb/Mar -> Month, Qty)

**UI:** Select the non-month columns (OrderID, OrderDate, ProductID, FirstName, LastName, Region, AmountNumeric) → Transform → Unpivot Columns → Unpivot Other Columns.

**M snippet**

```m
Unpivoted = Table.UnpivotOtherColumns(SplitNames, {"OrderID","OrderDate","ProductID","FirstName","LastName","Region","AmountNumeric"}, "Month", "Qty")
```

**Result:** You will have rows per month per order with `Month` = "Jan"/"Feb" etc and `Qty` showing values.

### Step 7 — Merge `Sales` with `Products` to bring product details

**UI:** Home → Merge Queries → select `Sales` (left), `Products` (right), join on `ProductID`, choose **Left Outer**, then expand `ProductName`, `Category`.

**M snippet**

```m
Merged = Table.NestedJoin(Unpivoted, {"ProductID"}, Products, {"ProductID"}, "Products", JoinKind.LeftOuter),
Expanded = Table.ExpandTableColumn(Merged, "Products", {"ProductName","Category"}, {"ProductName","Category"})
```

### Step 8 — Add calculated column (e.g., `SalesValue` = `AmountNumeric` \* `Qty`)

**UI:** Add Column → Custom Column

**M snippet**

```m
WithSalesValue = Table.AddColumn(Expanded, "SalesValue", each [AmountNumeric] * Number.From([Qty]), type number)
```

### Step 9 — Group & Aggregate (Total Sales by Region)

**UI:** Home → Group By → Group by `Region` → New column `TotalSales` → Sum of `SalesValue`.

**M snippet**

```m
Grouped = Table.Group(WithSalesValue, {"Region"}, {{"TotalSales", each List.Sum([SalesValue]), type number}, {"Orders", each Table.RowCount(_), Int64.Type}})
```

### Step 10 — Add Index column (optional staging key)

**UI:** Add Column → Index Column → From 1

**M snippet**

```m
Indexed = Table.AddIndexColumn(Grouped, "Index", 1, 1, Int64.Type)
```

### Step 11 — Error handling & replacing nulls

* Use **Transform → Detect Data Type** and then **Replace Errors** or use `try ... otherwise` in a custom column.

**Example M**

```m
SafeAmount = Table.TransformColumns(PreviousStep, {{"AmountNumeric", each try _ otherwise null, type nullable number}})
```

### Step 12 — Create a parameter for the Excel file path (reusability)

1. In Power Query Editor: Home → Manage Parameters → New Parameter

   * Name: `DataFilePath`
   * Type: Text
   * Current Value: `C:\Users\you\Documents\Sales_Example.xlsx`
2. Edit the `Source` step of the `Sales` query to use the parameter, e.g. `Excel.Workbook(File.Contents(DataFilePath), true)`

**M example for Source**

```m
Source = Excel.Workbook(File.Contents(DataFilePath), null, true)
```

### Step 13 — Disable load for staging queries (best practice)

* If you created intermediate queries (e.g., `CleanCurrency` or `Unpivoted`) and only want the final result to load into the model, right-click the intermediate query → uncheck **Enable Load** (or right-click → Disable Load).

### Step 14 — Close & Apply

* When finished, click **Home → Close & Apply**. Power BI will apply the query transformations and load the cleaned tables into the data model.

---

## 4) Full example — compact M for the `Sales` final query

```m
let
    Source = Excel.Workbook(File.Contents(DataFilePath), true),
    Sales = Source{[Name="Sales"]}[Content],
    Promoted = Table.PromoteHeaders(Sales, [PromoteAllScalars=true]),
    ChangedTypes = Table.TransformColumnTypes(Promoted, {{"OrderID", Int64.Type}, {"OrderDateText", type text}, {"ProductID", Int64.Type}, {"CustomerName", type text}, {"Region", type text}, {"Amount", type text}, {"Jan", Int64.Type}, {"Feb", Int64.Type}, {"Mar", Int64.Type}}),
    CleanCurrency = Table.TransformColumns(ChangedTypes, {{"Amount", each try Number.FromText(Text.Remove(_, {"₹", ",", " "})) otherwise null, type number}}),
    AddDate = Table.AddColumn(CleanCurrency, "OrderDate", each Date.FromText(Text.Range([OrderDateText],0,4) & "-" & Text.Range([OrderDateText],4,2) & "-" & Text.Range([OrderDateText],6,2)), type date),
    SplitNames = Table.SplitColumn(AddDate, "CustomerName", Splitter.SplitTextByDelimiter(" ", QuoteStyle.Csv), {"FirstName","LastName"}),
    Unpivoted = Table.UnpivotOtherColumns(SplitNames, {"OrderID","OrderDate","ProductID","FirstName","LastName","Region","Amount"}, "Month", "Qty"),
    // Assume Products query exists in the workbook and is loaded as Products
    Merged = Table.NestedJoin(Unpivoted, {"ProductID"}, Products, {"ProductID"}, "Products", JoinKind.LeftOuter),
    Expanded = Table.ExpandTableColumn(Merged, "Products", {"ProductName","Category"}, {"ProductName","Category"}),
    WithSalesValue = Table.AddColumn(Expanded, "SalesValue", each [Amount] * Number.From([Qty]), type number),
    Result = Table.Group(WithSalesValue, {"Region"}, {{"TotalSales", each List.Sum([SalesValue]), type number}, {"Orders", each Table.RowCount(_), Int64.Type}})
in
    Result
```

---

## 5) Practice exercises (for students)

1. **Combine sheets:** Suppose the workbook has sheets `Jan`, `Feb`, `Mar` (same structure) — create a query that combines all months into one table automatically. *(Hint: use `Excel.Workbook` and filter by sheet name prefix, then `Table.Combine`.)*

2. **Remove duplicates:** Remove duplicate `OrderID` keeping the latest `OrderDate`.

3. **API call (stretch):** Instead of `File.Contents`, change the source to a Web API that returns JSON. Parse and expand JSON to a table.

4. **Parameter switch:** Create 2 parameters — `Env` (Dev/Prod) and `DataFilePath_Dev`, `DataFilePath_Prod`. Use `Env` to pick the correct path.

## 6) Quick checks & validation (how to verify your results)

* Check row counts before/after unpivot — rows should increase when unpivoting months.
* Check data types in the Applied Steps: any `Error` icons indicate bad conversions.
* Verify `TotalSales` sums against a quick Excel pivot of the same data.
* Use **View → Column Quality / Column Distribution** to spot nulls/outliers.

---

## 7) Common pitfalls & tips

* **Locale issues:** Date parsing may fail if system locale isn't `YYYY-MM-DD` friendly — use `Date.FromText` with constructed `YYYY-MM-DD` string to be safe.
* **Query folding:** Transformations that break folding (like `Table.AddIndexColumn`, `List operations`, `functions using try/otherwise`) can push processing to local engine — keep heavy aggregations on the source side when possible.
* **Performance:** Remove unnecessary columns early, filter rows early, and avoid too many steps that create large intermediate tables.
* **Naming:** Use descriptive step names (right-click step → Rename) — it helps when reading Advanced Editor.

---

## 8) Bonus: Export this lab as a printable handout

If you want, I can convert this lab into a printable PDF or create the `Sales_Example.xlsx` and provide CSV versions of the sheets so students can immediately practice. Tell me which format you prefer (PDF handout, downloadable Excel, or both) and I will prepare it.

---

**End of lab**

If you'd like, I can also generate a shorter 1-page cheat-sheet of the most-used M formulas from this lab (ready to print).



# **Power BI Lab – Retail Sales Dashboard**

**Objective:**
Students will learn how to:

* Import data into Power BI
* Model relationships (joins)
* Create DAX measures
* Use a slicer to filter visuals
* Build an interactive dashboard

---

## **Step 1: Create Sample Data**

We'll use **three CSV files**:

### **1. Customers.csv**

| CustomerID | CustomerName | City      |
| ---------- | ------------ | --------- |
| C001       | Ramesh       | Mumbai    |
| C002       | Priya        | Pune      |
| C003       | Anil         | Delhi     |
| C004       | Meena        | Bangalore |
| C005       | Arjun        | Chennai   |

---

### **2. Products.csv**

| ProductID | ProductName | Category    | UnitPrice |
| --------- | ----------- | ----------- | --------- |
| P001      | Laptop      | Electronics | 55000     |
| P002      | Mobile      | Electronics | 30000     |
| P003      | Chair       | Furniture   | 4500      |
| P004      | Table       | Furniture   | 7000      |
| P005      | Pen         | Stationery  | 20        |

---

### **3. Sales.csv**

| SalesID | CustomerID | ProductID | Quantity | Discount |
| ------- | ---------- | --------- | -------- | -------- |
| S001    | C001       | P001      | 1        | 5%       |
| S002    | C002       | P002      | 2        | 0%       |
| S003    | C003       | P003      | 4        | 10%      |
| S004    | C001       | P005      | 10       | 0%       |
| S005    | C004       | P004      | 1        | 5%       |
| S006    | C002       | P001      | 1        | 0%       |

> Save these as **Customers.csv**, **Products.csv**, and **Sales.csv**.

---

## **Step 2: Import Data into Power BI**

1. Open **Power BI Desktop**
2. Click **Home → Get Data → Text/CSV**
3. Load **Customers.csv**, **Products.csv**, and **Sales.csv**
4. Check data preview → Click **Load**

---

## **Step 3: Model the Data**

1. Go to **Model View** (left panel icon).
2. Power BI may auto-detect relationships. If not, create them manually:

   * Drag **Sales\[CustomerID]** → **Customers\[CustomerID]**
   * Drag **Sales\[ProductID]** → **Products\[ProductID]**
3. Both relationships should be **Many-to-One**.

---

## **Step 4: Create DAX Measures**

Go to **Modeling → New Measure** and create these:

### **1. Total Sales Amount**

```DAX
Total Sales =
SUMX(
    Sales,
    Sales[Quantity] * RELATED(Products[UnitPrice]) * (1 - Sales[Discount])
)
```

### **2. Total Quantity Sold**

```DAX
Total Quantity = SUM(Sales[Quantity])
```

### **3. Average Discount**

```DAX
Avg Discount = AVERAGE(Sales[Discount])
```

---

## **Step 5: Build the Report**

Go to **Report View** → Add visuals:

### **1. Table Visual**

* Add: **CustomerName**, **ProductName**, **Quantity**, **UnitPrice**, **Total Sales**.

### **2. Clustered Column Chart**

* Axis → **ProductName**
* Values → **Total Sales**

### **3. Pie Chart**

* Legend → **Category**
* Values → **Total Sales**

### **4. KPI Cards**

* **Total Sales**
* **Total Quantity**
* **Avg Discount**

---

## **Step 6: Add a Slicer**

1. Go to **Insert → Slicer**
2. Drag **Customers\[City]** into the slicer field
3. Select **List** style
4. Now students can **filter the dashboard by city**.

---

## **Step 7: Exercise for Students**

### **Task 1:**

Show **Total Sales by City** in a bar chart.

### **Task 2:**

Create a slicer for **Category** instead of City.

### **Task 3:**

Add a card showing **Top-Selling Product**:

```DAX
Top Product =
FIRSTNONBLANK(
    Products[ProductName],
    CALCULATE(SUM(Sales[Quantity]))
)
```

---

## **Step 8: Expected Dashboard Layout**

* **Top Left:** Table visual (Customer → Product → Sales)
* **Top Right:** Column chart (Product vs Sales)
* **Bottom Left:** Pie chart (Sales by Category)
* **Bottom Right:** KPI cards
* **Right Panel:** Slicer by City

---



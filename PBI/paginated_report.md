Let’s create a **simple, classroom-ready lab** on **Paginated Reports in Power BI**.
I’ll design it so students can **create a basic paginated report** using **Power BI Report Builder** with step-by-step instructions, screenshots placeholders, and a simple dataset.

---

# **Power BI Lab – Paginated Reports**

### **Objective**

Students will learn how to **create, format, and export** a **paginated report** using **Power BI Report Builder**.

---

## **1. Prerequisites**

* **Power BI Report Builder** installed ([Download Here](https://learn.microsoft.com/power-bi/paginated-reports/report-builder-power-bi))
* **Power BI Desktop** installed.
* A simple **Sales dataset** (`SalesData.xlsx`).

---

## **2. Dataset**

**File Name:** `SalesData.xlsx`

| OrderID | Date       | Region | Product    | Category    | Sales | Quantity | Profit |
| ------- | ---------- | ------ | ---------- | ----------- | ----- | -------- | ------ |
| 1001    | 05-01-2023 | South  | Mobile     | Electronics | 35000 | 3        | 7000   |
| 1002    | 06-01-2023 | North  | Laptop     | Electronics | 55000 | 2        | 9000   |
| 1003    | 07-01-2023 | East   | Chair      | Furniture   | 5000  | 4        | 1000   |
| 1004    | 08-01-2023 | West   | Table      | Furniture   | 8000  | 1        | 2000   |
| 1005    | 09-01-2023 | South  | Headphones | Electronics | 3000  | 5        | 800    |

---

## **3. Lab Objectives**

By the end of this lab, students should be able to:

* Connect to a dataset.
* Create a **paginated table report**.
* Apply **sorting, grouping, and formatting**.
* Add headers, footers, and page numbers.
* Export the report to **PDF** and **Excel**.

---

## **4. Lab Steps**

### **Step 1 — Open Power BI Report Builder**

* Launch **Power BI Report Builder**.
* Go to **File → New → Paginated Report**.
* Choose **Table Wizard**.

---

### **Step 2 — Connect to Data**

1. In the **Table Wizard**, click **Create a Dataset**.
2. Select **Data Source Type → Microsoft Excel**.
3. Browse and select `SalesData.xlsx`.
4. Click **Next**.

---

### **Step 3 — Select Data Fields**

1. In the **Dataset Wizard**:

   * Drag the following fields into the table:

     * **Region**
     * **Product**
     * **Sales**
     * **Profit**
2. Click **Next**.

---

### **Step 4 — Arrange Table Layout**

1. Choose **Tabular Layout**.
2. Check **Add subtotal** → by **Region**.
3. Choose **Stepped Layout** → for better readability.
4. Click **Finish**.

---

### **Step 5 — Add Report Header & Footer**

1. Right-click on the canvas → **Insert → Header**.
2. Add **Text Box** → Set title as:
   **“Sales Report – Paginated”**
3. Right-click → **Insert → Footer**.
4. Insert:

   * **Page Number** → `="Page " & Globals!PageNumber`
   * **Date** → `=Today()`

---

### **Step 6 — Apply Formatting**

* Format the **Sales** and **Profit** columns:

  * Right-click column → **Text Box Properties → Number → Currency**.
* Change **table header background** to **light blue**.
* Bold the **Region subtotal** rows.

---

### **Step 7 — Add Sorting & Grouping**

1. Select the **Region** column.
2. Go to **Group Properties** → **Sort By → Region (A-Z)**.
3. Add a **secondary sort** → **Sales** (Highest to Lowest).

---

### **Step 8 — Preview the Report**

* Click **Run** (top menu).
* Check:

  * Correct grouping by Region.
  * Subtotals displayed properly.
  * Page numbers and date visible.

---

### **Step 9 — Export the Report**

1. Go to **File → Export**.
2. Export as:

   * **PDF** → For sharing.
   * **Excel** → For further analysis.

---

## **5. Expected Output**

**Page 1 Example:**

**Sales Report – Paginated**
*(Header)*

| Region               | Product    | Sales   | Profit |
| -------------------- | ---------- | ------- | ------ |
| South                | Mobile     | ₹35,000 | ₹7,000 |
| South                | Headphones | ₹3,000  | ₹800   |
| **Subtotal (South)** |            | ₹38,000 | ₹7,800 |

*(Footer → Page 1 of N, Date)*

---

## **6. Extension Activity (Optional)**

Ask students to enhance the report by:

* Adding **parameters** (e.g., select Region to filter).
* Adding **charts** (e.g., Sales by Region).
* Embedding the report into **Power BI Service**.

---

## **7. Student Deliverables**

* `.rdl` file of the paginated report.
* PDF export of the report.
* Screenshot of the preview.

---


Alright 🙂
I’ll prepare a **step-by-step Power BI Desktop demo** using a **small sample dataset** to explain the **SWITCH()** DAX function in a **beginner-friendly** way.
This will include:

* **Dataset**
* **Steps in Power BI**
* **DAX Formula**
* **Visualization Setup**
* **Expected Output**

---

## **Step 1: Sample Dataset**

Create a simple CSV file named **`SalesData.csv`** with the following data:

| ProductID | ProductName  | ProductCategory | Rating | SalesAmount |
| --------- | ------------ | --------------- | ------ | ----------- |
| 1         | iPhone 14    | Mobiles         | 5      | 80000       |
| 2         | Dell XPS     | Laptops         | 4      | 95000       |
| 3         | T-Shirt      | Shirts          | 3      | 1500        |
| 4         | Jeans        | Jeans           | 2      | 2500        |
| 5         | Samsung S23  | Mobiles         | 5      | 75000       |
| 6         | MacBook Air  | Laptops         | 5      | 120000      |
| 7         | Jacket       | Shirts          | 3      | 3000        |
| 8         | Oppo Reno    | Mobiles         | 4      | 30000       |
| 9         | Levi's Jeans | Jeans           | 1      | 3500        |
| 10        | Sony TV      | Others          | 4      | 65000       |

---

## **Step 2: Load Data into Power BI Desktop**

1. Open **Power BI Desktop**.
2. Go to **Home → Get Data → Text/CSV**.
3. Select **`SalesData.csv`** and click **Load**.

---

## **Step 3: Create a Calculated Column using SWITCH()**

We’ll create two **calculated columns** to demonstrate different SWITCH() use cases.

---

### **A) Categorizing Product Groups**

```DAX
Product Category Group = 
SWITCH(
    TRUE(),
    'SalesData'[ProductCategory] = "Mobiles", "Electronics",
    'SalesData'[ProductCategory] = "Laptops", "Electronics",
    'SalesData'[ProductCategory] = "Shirts", "Clothing",
    'SalesData'[ProductCategory] = "Jeans", "Clothing",
    "Others"
)
```

**Explanation:**

* If category = Mobiles or Laptops → **Electronics**
* If category = Shirts or Jeans → **Clothing**
* Else → **Others**

---

### **B) Converting Ratings into Labels**

```DAX
Rating Label = 
SWITCH(
    'SalesData'[Rating],
    5, "Excellent",
    4, "Good",
    3, "Average",
    2, "Poor",
    1, "Very Poor",
    "Not Rated"
)
```

**Explanation:**

* Maps rating numbers to text labels for easier reporting.

---

## **Step 4: Create a Visualization**

1. Go to **Report View** in Power BI Desktop.
2. Insert a **Table visual**.
3. Drag the following fields into the table:

   * **ProductName**
   * **ProductCategory**
   * **Product Category Group** (calculated column)
   * **Rating**
   * **Rating Label** (calculated column)
   * **SalesAmount**
4. Resize the table to see all columns clearly.

---

## **Step 5: Expected Output in Table Visual**

| ProductName  | ProductCategory | Product Category Group | Rating | Rating Label | SalesAmount |
| ------------ | --------------- | ---------------------- | ------ | ------------ | ----------- |
| iPhone 14    | Mobiles         | Electronics            | 5      | Excellent    | 80000       |
| Dell XPS     | Laptops         | Electronics            | 4      | Good         | 95000       |
| T-Shirt      | Shirts          | Clothing               | 3      | Average      | 1500        |
| Jeans        | Jeans           | Clothing               | 2      | Poor         | 2500        |
| Samsung S23  | Mobiles         | Electronics            | 5      | Excellent    | 75000       |
| MacBook Air  | Laptops         | Electronics            | 5      | Excellent    | 120000      |
| Jacket       | Shirts          | Clothing               | 3      | Average      | 3000        |
| Oppo Reno    | Mobiles         | Electronics            | 4      | Good         | 30000       |
| Levi's Jeans | Jeans           | Clothing               | 1      | Very Poor    | 3500        |
| Sony TV      | Others          | Others                 | 4      | Good         | 65000       |

---

## **Step 6: What Students Learn from This Demo**

✅ How to use **SWITCH()** with **fixed values**
✅ How to use **SWITCH(TRUE())** for multiple logical conditions
✅ How to create **calculated columns**
✅ How to visualize calculated results in a report

---

If you want, I can also prepare a **Power BI PBIX file** with:

* Sample dataset loaded
* Both SWITCH() columns created
* Pre-designed table visual

Would you like me to make that PBIX file for you? It’ll save time in training.

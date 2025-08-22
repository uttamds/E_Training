Alright, Uttam 🙂
I’ll create a **complex stored procedure** in **MS SQL Server** that demonstrates the **usage of views** and **joins** step by step.
We'll create a **small example** using a sample database and tables.

---

## **Scenario**

We have three tables:

1. **Customers** – Stores customer details.
2. **Orders** – Stores orders placed by customers.
3. **Products** – Stores product information.

We will:

* Create a **view** combining `Orders` and `Products`.
* Use a **stored procedure** that joins the **view** with `Customers`.
* Add **filtering**, **aggregation**, and **sorting** inside the SP.

---

## **Step 1 — Create Sample Tables**

```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    City NVARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

---

## **Step 2 — Insert Sample Data**

```sql
INSERT INTO Customers VALUES
(1, 'Ravi Sharma', 'Pune'),
(2, 'Priya Mehta', 'Mumbai'),
(3, 'Amit Verma', 'Delhi');

INSERT INTO Products VALUES
(101, 'Laptop', 55000),
(102, 'Mobile', 20000),
(103, 'Headphones', 2500);

INSERT INTO Orders VALUES
(1001, 1, 101, 2, '2025-08-01'),
(1002, 2, 102, 1, '2025-08-05'),
(1003, 1, 103, 3, '2025-08-10'),
(1004, 3, 101, 1, '2025-08-12');
```

---

## **Step 3 — Create a View**

Let's create a **view** to simplify order-product details.

```sql
CREATE VIEW vw_OrderDetails
AS
SELECT 
    O.OrderID,
    O.CustomerID,
    P.ProductName,
    P.Price,
    O.Quantity,
    (P.Price * O.Quantity) AS TotalAmount,
    O.OrderDate
FROM Orders O
INNER JOIN Products P ON O.ProductID = P.ProductID;
```

**What this view does:**

* Joins **Orders** + **Products**
* Adds a computed column **TotalAmount**

---

## **Step 4 — Create the Complex Stored Procedure**

Now we create a stored procedure that:

* Accepts `@City` and `@MinAmount` as input parameters.
* Uses the **view** `vw_OrderDetails`.
* Joins with **Customers**.
* Returns aggregated results with sorting.

```sql
CREATE PROCEDURE sp_GetCustomerOrderSummary
    @City NVARCHAR(50) = NULL,
    @MinAmount DECIMAL(10,2) = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        C.FullName,
        C.City,
        OD.ProductName,
        OD.Quantity,
        OD.Price,
        OD.TotalAmount,
        OD.OrderDate
    FROM vw_OrderDetails OD
    INNER JOIN Customers C ON OD.CustomerID = C.CustomerID
    WHERE OD.TotalAmount >= @MinAmount
      AND (@City IS NULL OR C.City = @City)
    ORDER BY OD.TotalAmount DESC, OD.OrderDate DESC;
END;
```

---

## **Step 5 — Execute the Procedure**

### **Case 1: Get all orders above ₹20,000**

```sql
EXEC sp_GetCustomerOrderSummary @MinAmount = 20000;
```

### **Case 2: Get only Mumbai orders above ₹10,000**

```sql
EXEC sp_GetCustomerOrderSummary @City = 'Mumbai', @MinAmount = 10000;
```

---

## **How This Demonstrates Views & Joins**

✅ **View Usage** → `vw_OrderDetails` combines `Orders` and `Products`.
✅ **Join Usage** → Stored procedure joins `vw_OrderDetails` with `Customers`.
✅ **Dynamic Filtering** → Parameters make the SP reusable.
✅ **Sorting & Aggregation** → Uses computed column `TotalAmount` for calculations.

---

If you want, I can make this even **more complex** by adding:

* **Another view** combining **Customers** + **vw\_OrderDetails**
* A **CTE** inside the SP
* **Grouping** to show **total amount spent per customer**

Do you want me to enhance it further with **CTEs + multiple views**?
It’ll make the example look like a **real-time enterprise SP**. Should I?

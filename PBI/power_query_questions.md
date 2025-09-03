
## **Power Query Interview Questions**

### **A. Basic-Level Questions** *(For Freshers & Beginners)*

1. What is **Power Query** in Power BI, and how is it different from Power BI Desktop visuals?
2. What is the role of the **Power Query Editor** in Power BI?
3. Can you explain the difference between **Power Query** and **DAX**?
4. What are the different **data sources** you can connect to using Power Query?
5. What is the **M language** in Power Query? Do you need to know it to work with Power Query?
6. What are **applied steps** in Power Query, and how are they useful?
7. How do you **remove duplicates** in Power Query?
8. How can you **rename columns** or **change data types** in Power Query?
9. What is the difference between **Remove Rows** and **Keep Rows** in Power Query?
10. How do you **split a column** based on a delimiter in Power Query?

---

### **B. Intermediate-Level Questions** *(For Developers & Analysts)*

11. What is the difference between **Append Queries** and **Merge Queries**? Give an example.
12. How do you perform **inner join**, **left join**, and **full outer join** using Power Query?
13. How do you **group data** and perform aggregations in Power Query?
14. How can you **unpivot columns** and why would you do it?
15. What are **Parameters** in Power Query, and where would you use them?
16. How do you **filter rows dynamically** based on user input or parameter values?
17. How can you create a **custom column** in Power Query?
18. How do you handle **null values** and **blank data** in Power Query?
19. What is the difference between **Power Query transformations** and **calculated columns** in DAX?
20. How do you **detect and handle errors** in Power Query?

---

### **C. Advanced-Level Questions** *(For Experienced Candidates)*

21. What is the difference between **Power Query** and **Dataflows** in Power BI Service?
22. How does **query folding** work in Power Query, and why is it important for performance?
23. How can you **optimize performance** in Power Query transformations?
24. When should you **disable load** in Power Query, and why?
25. How do you deal with **slow Power Query refreshes**?
26. How can you **merge queries** based on multiple columns?
27. How do you create a **conditional column** using M code instead of GUI options?
28. How do you **reference queries** vs. **duplicate queries**? Which one is better and why?
29. How do you connect Power Query to a **web API** and handle pagination?
30. What are **custom functions** in Power Query, and when do you use them?

---

### **D. Scenario-Based / Hands-On Questions**

31. You have **Sales** and **Product** tables. How would you merge them to bring the product name into the sales table?
32. You have a column with values like `"INR 12,000"` — how would you clean and convert this into a numeric column?
33. You receive a dataset where dates are stored as `20250903`. How would you transform it into `03-Sep-2025`?
34. Your data source is an Excel file where **each month’s data is on a separate sheet**. How would you combine them dynamically?
35. You have a **nested JSON file**. How would you flatten it in Power Query?
36. You need to **filter out weekends** from a date column. How would you achieve this in Power Query?
37. You have a column containing **full names**; split it into **first name** and **last name** dynamically.
38. You have two tables: **Customers** and **Transactions**. Show only customers **who have not made any transactions**.
39. A CSV file has **dynamic column names** that change every month. How would you make the query **dynamic**?
40. You need to create a parameterized query to switch between **Dev** and **Prod** databases automatically. How would you set this up?

---

### **E. Quick Theory-Based Questions** *(Often Asked Rapid-Fire)*

* What is the default language behind Power Query? *(Answer: M Language)*
* Can you schedule refreshes in Power Query? *(Answer: No, but you can in Power BI Service)*
* What is **query folding**, and when does it break?
* What are **staging queries** in Power Query?
* What’s the difference between **"Close & Load"** and **"Close & Apply"**?
* When would you prefer using **Power Query** instead of writing **SQL queries**?
* Can Power Query handle **incremental refresh**? *(Answer: Only via Power BI Service)*
* What are the different **join kinds** in Power Query? *(Inner, Left, Right, Full, Anti-Join)*

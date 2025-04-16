# 🍕 DeliPizza Web Application

**ASP.NET Web Application for Online Restaurant Ordering System**

---

## 📌 Project Overview

DeliPizza is a web-based ordering system developed using **ASP.NET** and **C#**, designed to simulate a real-world restaurant ordering experience. Built as a final group project for the **Web Application Development (ISB42403)** course at **Universiti Kuala Lumpur**, this platform allows:

- Customers to register, browse menus, place orders, and make payments
- Admins to view and manage sales data and user accounts

---

## 🧩 Features

### 👤 User Functions
- 🔐 User registration and login  
- 🛒 Browse food categories and items (with images)  
- ➕ Add items to cart and specify quantity  
- 💰 Automatic price calculation with 6% service tax and rounding  
- 🧾 Sales receipt and transaction confirmation  

### 🛠️ Admin Functions
- 👥 Admin login with page authorization  
- 📈 View detailed and summarized sales reports  
- 🧑‍🔧 Manage user accounts  

---

## 🛠️ Technologies Used
- **ASP.NET Web Forms (C#)**
- **SQL Server**
- **HTML, CSS & Bootstrap**
- **Stored Procedures** for transactional operations

---

## 🧮 Database Schema

### Tables
- `FoodCategories`: Item categories  
- `Items`: Menu items  
- `Sales`: Transaction records  
- `UserAccounts`: Authentication system  

### Key Stored Procedures
- `spSalesAddItem`, `spSalesConfirm`, `spSalesGetTotalAmount`  
- `spGetMonthlySalesSummary`, `spGetSalesByProduct`  

---



## 🚀 How to Run
1. Clone this repo
2. Open the solution in **Visual Studio**
3. Set up your local SQL Server database using the provided schema
4. Update the connection string in `Web.config`
5. Run the application on your local server

---





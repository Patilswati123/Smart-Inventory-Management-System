# Smart Inventory Management System 📦

A traditional, production-ready Java Web Application built using the **MVC (Model-View-Controller)** architectural pattern with **Java Servlets, JSP, JDBC, MySQL, Apache Tomcat, and Bootstrap 5**.

---

## 🚀 Key Features

1. **User Authentication:** Secure Login and Logout system using `HttpSession` and `AuthFilter`.
2. **Dashboard:** Real-time inventory metrics (Total Products, Units in Stock, Low Stock Warnings) and recent activity logs.
3. **Product Management:** Complete CRUD operations (Add, View, Update, Delete) with validation.
4. **Live Product Search:** Filter products dynamically by product code, name, or category.
5. **Stock In:** Restock inventory from suppliers with audit remarks.
6. **Stock Out:** Dispatch inventory to customers with real-time stock availability guards (prevents negative balances).
7. **Stock Transaction History:** Full audit log tracking every inventory movement with timestamp and quantity.
8. **Low Stock Alerts:** Dedicated watchlist for items reaching or falling below safety thresholds.

---

## 🛠️ Technology Stack

* **Backend:** Java (JDK 11+ / 18)
* **Web Layer:** Java Servlets (`javax.servlet`), JavaServer Pages (JSP)
* **Database:** MySQL 8.0
* **Data Access:** Pure JDBC (`Connection`, `PreparedStatement`, `ResultSet`)
* **Server:** Apache Tomcat 9
* **Frontend:** HTML5, CSS3, JavaScript, Bootstrap 5.3, Bootstrap Icons
* **Build Tool:** Maven (standard webapp structure)

---

## 📂 Project Architecture (MVC)

```text
SmartInventorySystem/
├── src/main/java/com/inventory/
│   ├── model/         # [M] JavaBeans/POJOs (Product, User, StockTransaction)
│   ├── dao/           # Data Access Objects executing JDBC queries
│   ├── util/          # DBConnection factory
│   ├── filter/        # AuthFilter for route protection
│   └── controller/    # [C] Servlets handling HTTP requests
├── src/main/resources/
│   └── database.sql   # MySQL Schema & seed data
└── src/main/webapp/   # [V] Presentation Layer
    ├── assets/        # CSS & JavaScript
    ├── WEB-INF/views/ # Protected JSP view templates
    └── index.jsp      # Application entry point
```

---

## ⚙️ Setup & Installation

### 1. Database Setup
1. Open **MySQL Workbench** or MySQL CLI.
2. Execute the script located at `src/main/resources/database.sql`.
3. Verify or configure your database credentials in `com.inventory.util.DBConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/smart_inventory_db";
   private static final String USERNAME = "root";
   private static final String PASSWORD = "root";
   ```

### 2. Run with Eclipse / Tomcat 9
1. Open Eclipse IDE.
2. Go to **File ➔ Import ➔ Maven ➔ Existing Maven Projects** and select this directory.
3. Add **Tomcat v9.0 Server** in the Servers tab.
4. Right-click the project ➔ **Run As ➔ Run on Server**.
5. Access the app in your browser:
   ```text
   http://localhost:8081/SmartInventorySystem/
   ```

### 3. Default Credentials
* **Administrator:** `admin` / `admin123`
* **Staff Member:** `staff` / `staff123`

---

## 📄 License
This project is licensed under the MIT License.

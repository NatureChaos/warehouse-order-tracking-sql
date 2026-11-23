# Warehouse Order & Inventory Tracking (SQLite)

I built this SQLite project to practice designing a relational database from scratch and writing practical SQL queries for everyday warehouse operations—like tracking inventory across different cities, generating pick-lists for workers, and checking if shipping carriers are actually delivering on time.

## How the Database is Structured
Instead of cramming everything into one giant table, I split the data into 7 focused tables linked by primary and foreign keys. I also added `CHECK` and `UNIQUE` constraints so the database automatically blocks bad data (like inventory dropping below zero or duplicate tracking numbers):

* **`Warehouses`**: The storage facilities, their cities, and max unit capacities.
* **`Products`**: The product catalog with SKUs, prices, and reorder thresholds.
* **`Inventory`**: Tracks exact stock counts and aisle/bin locations for each product at each warehouse.
* **`Customers`**: Customer names, emails, and shipping addresses.
* **`Orders`**: Tracks who placed an order, which warehouse is fulfilling it, and its current status (`Pending`, `Picking`, `Packed`, `Shipped`, `Delivered`, or `Cancelled`).
* **`Order_Items`**: Connects orders to specific products, quantities, and the price at the time of purchase.
* **`Shipments`**: Carrier info, tracking numbers, and estimated vs. actual delivery dates.

## What the Queries Do (`queries.sql`)
I included four main queries to answer real operational questions:
1. **Warehouse Pick-Lists:** Joins orders, products, and inventory locations so warehouse staff get a clean list of what to pull, sorted by aisle and bin.
2. **Low-Stock Alerts:** Flags any item where current stock has dropped to or below its `reorder_level`.
3. **Carrier On-Time Delivery Rate:** Compares `actual_delivery` against `estimated_delivery` using `CASE` statements to see each carrier's on-time percentage.
4. **Top-Selling Products per Warehouse:** Uses a CTE and `RANK()` window function to find the top 3 revenue-generating items inside each individual warehouse.

## Try It Out
1. Download `warehouse_tracking.db` (or run `schema.sql` followed by `seed_data.sql` to build it fresh).
2. Open it in **DB Browser for SQLite**, **DBeaver**, or any SQLite editor.
3. Run the queries in `queries.sql` to see the reports.

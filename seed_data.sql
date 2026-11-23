PRAGMA foreign_keys = ON;

-- 1. Add Warehouses
INSERT INTO Warehouses (warehouse_name, location_city, capacity_units) VALUES 
('Midwest Hub', 'Chicago', 50000),
('East Coast Center', 'Newark', 75000),
('West Coast Depot', 'Los Angeles', 60000);

-- 2. Add Products
INSERT INTO Products (sku, product_name, category, unit_price, reorder_level) VALUES 
('LAP-01', 'Pro Laptop', 'Electronics', 1200.00, 15),
('MOU-05', 'Wireless Mouse', 'Accessories', 25.00, 50),
('KEY-09', 'Mechanical Keyboard', 'Accessories', 85.00, 20),
('MON-24', '24-Inch 4K Monitor', 'Electronics', 350.00, 10),
('CAB-02', 'USB-C Braided Cable', 'Accessories', 15.00, 100);

-- 3. Add Inventory (Notice Laptop in Chicago is at 10, which is below reorder_level 15!)
INSERT INTO Inventory (warehouse_id, product_id, aisle_bin, quantity_on_hand) VALUES 
(1, 1, 'A1-B04', 10),
(1, 2, 'C3-B12', 120),
(1, 5, 'D1-B01', 250),
(2, 3, 'B2-B08', 45),
(2, 4, 'A4-B02', 8),
(3, 1, 'A1-B01', 35);

-- 4. Add Customers
INSERT INTO Customers (customer_name, email, shipping_address) VALUES 
('Alice Smith', 'alice@example.com', '123 Maple St, Detroit, MI'),
('Bob Jones', 'bob@example.com', '456 Oak Ave, Boston, MA'),
('Carlos Rivera', 'carlos@example.com', '789 Pine Rd, Austin, TX'),
('Diana Prince', 'diana@example.com', '321 Elm Blvd, Seattle, WA');

-- 5. Add Orders
INSERT INTO Orders (customer_id, warehouse_id, order_status) VALUES 
(1, 1, 'Pending'),
(2, 2, 'Delivered'),
(3, 1, 'Picking'),
(4, 3, 'Shipped');

-- 6. Add Order Line Items
INSERT INTO Order_Items (order_id, product_id, quantity_ordered, unit_price_at_purchase) VALUES 
(1, 1, 2, 1200.00), -- Alice: 2 Laptops
(1, 2, 3, 25.00),   -- Alice: 3 Mice
(2, 3, 1, 85.00),   -- Bob: 1 Keyboard
(2, 4, 2, 350.00),  -- Bob: 2 Monitors
(3, 5, 10, 15.00),  -- Carlos: 10 Cables
(4, 1, 1, 1200.00); -- Diana: 1 Laptop

-- 7. Add Shipments (Bob arrived early; Diana is currently in transit)
INSERT INTO Shipments (order_id, carrier, tracking_number, shipped_date, estimated_delivery, actual_delivery) VALUES 
(2, 'UPS', '1Z999AA10123456784', '2026-11-18 10:00:00', '2026-11-21', '2026-11-20 14:30:00'),
(4, 'FedEx', '794644790138', '2026-11-22 09:15:00', '2026-11-25', NULL);
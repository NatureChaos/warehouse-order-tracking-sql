-- QUERY 1: Warehouse Pick-List for Active Orders
SELECT 
    o.order_id,
    w.warehouse_name,
    i.aisle_bin,
    p.sku,
    p.product_name,
    oi.quantity_ordered,
    i.quantity_on_hand
FROM Orders o
JOIN Warehouses w ON o.warehouse_id = w.warehouse_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
JOIN Inventory i ON p.product_id = i.product_id AND w.warehouse_id = i.warehouse_id
WHERE o.order_status IN ('Pending', 'Picking')
ORDER BY o.order_id, i.aisle_bin ASC;

-- QUERY 2: Low-Stock Restock Alert
SELECT 
    w.warehouse_name,
    p.sku,
    p.product_name,
    i.quantity_on_hand,
    p.reorder_level
FROM Inventory i
JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
JOIN Products p ON i.product_id = p.product_id
WHERE i.quantity_on_hand <= p.reorder_level;

-- QUERY 3: Carrier On-Time Delivery Rate
SELECT 
    carrier,
    COUNT(shipment_id) AS total_delivered,
    SUM(CASE WHEN DATE(actual_delivery) <= DATE(estimated_delivery) THEN 1 ELSE 0 END) AS on_time_deliveries,
    ROUND(
        100.0 * SUM(CASE WHEN DATE(actual_delivery) <= DATE(estimated_delivery) THEN 1 ELSE 0 END) / COUNT(shipment_id), 
        2
    ) AS on_time_percentage
FROM Shipments
WHERE actual_delivery IS NOT NULL
GROUP BY carrier;

-- QUERY 4: Top Revenue-Generating Products per Warehouse (Window Function)
WITH WarehouseProductSales AS (
    SELECT 
        w.warehouse_name,
        p.product_name,
        SUM(oi.quantity_ordered * oi.unit_price_at_purchase) AS total_revenue,
        RANK() OVER (
            PARTITION BY w.warehouse_name 
            ORDER BY SUM(oi.quantity_ordered * oi.unit_price_at_purchase) DESC
        ) AS sales_rank
    FROM Orders o
    JOIN Warehouses w ON o.warehouse_id = w.warehouse_id
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    WHERE o.order_status != 'Cancelled'
    GROUP BY w.warehouse_name, p.product_name
)
SELECT * 
FROM WarehouseProductSales
WHERE sales_rank <= 3;
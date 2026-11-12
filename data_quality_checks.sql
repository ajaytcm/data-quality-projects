-- ============================================================
-- Data Quality Checks — sample_customer_orders
-- Purpose: find defective rows in a small customer-orders table
--          so they can be reviewed, corrected, or rejected.
-- Dialect: standard SQL (runs on SQLite / SQL Server / MySQL
--          with only minor syntax changes).
-- Table:   orders(order_id, customer_id, customer_email,
--                 order_date, status, quantity, unit_price)
--          customers(customer_id, customer_name)
-- ============================================================

-- ------------------------------------------------------------
-- CHECK 1: Duplicate order IDs
-- Catches: the same order loaded twice (double-load / retry).
-- ------------------------------------------------------------
SELECT order_id, COUNT(*) AS row_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- ------------------------------------------------------------
-- CHECK 2: Near-duplicate orders
-- Same customer, same date, same total amount — likely the
-- same order keyed twice under different IDs.
-- ------------------------------------------------------------
SELECT customer_id, order_date,
       SUM(quantity * unit_price) AS order_total,
       COUNT(*) AS row_count
FROM orders
GROUP BY customer_id, order_date, quantity, unit_price
HAVING COUNT(*) > 1;

-- ------------------------------------------------------------
-- CHECK 3: Missing values in required fields
-- Required: customer_id, customer_email, order_date, status.
-- ------------------------------------------------------------
SELECT *
FROM orders
WHERE customer_id IS NULL
   OR customer_email IS NULL OR customer_email = ''
   OR order_date IS NULL
   OR status IS NULL OR status = '';

-- ------------------------------------------------------------
-- CHECK 4: Invalid email format
-- Simple pattern check: must contain '@' with text on both
-- sides and a '.' after the '@'.
-- ------------------------------------------------------------
SELECT order_id, customer_email
FROM orders
WHERE customer_email NOT LIKE '%_@_%._%';

-- ------------------------------------------------------------
-- CHECK 5: Status values outside the allowed list
-- Allowed: PLACED, PAID, SHIPPED, DELIVERED, CANCELLED
-- ------------------------------------------------------------
SELECT DISTINCT status
FROM orders
WHERE status NOT IN ('PLACED', 'PAID', 'SHIPPED', 'DELIVERED', 'CANCELLED');

-- ------------------------------------------------------------
-- CHECK 6: Orphan orders — customer_id with no customer record
-- ------------------------------------------------------------
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- ------------------------------------------------------------
-- CHECK 7: Impossible values
-- Negative or zero quantity, negative price, future order date.
-- ------------------------------------------------------------
SELECT *
FROM orders
WHERE quantity <= 0
   OR unit_price < 0
   OR order_date > CURRENT_DATE;

-- ------------------------------------------------------------
-- CHECK 8: Completeness summary (for the DQ report)
-- Percentage of rows passing each rule, one line per rule.
-- ------------------------------------------------------------
SELECT
  COUNT(*)                                            AS total_rows,
  SUM(CASE WHEN customer_email LIKE '%_@_%._%'
           THEN 1 ELSE 0 END) * 100.0 / COUNT(*)      AS pct_valid_email,
  SUM(CASE WHEN status IN ('PLACED','PAID','SHIPPED',
           'DELIVERED','CANCELLED')
           THEN 1 ELSE 0 END) * 100.0 / COUNT(*)      AS pct_valid_status,
  SUM(CASE WHEN quantity > 0 AND unit_price >= 0
           THEN 1 ELSE 0 END) * 100.0 / COUNT(*)      AS pct_valid_amounts
FROM orders;

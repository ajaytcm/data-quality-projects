# Data Quality Findings Report — Sample Customer Orders

**Dataset:** `sample_customer_orders.csv` (15 order rows) joined to `sample_customers.csv` (12 customers)
**Checks run:** the 8 queries in `data_quality_checks.sql` (executed in SQLite, 2026-11-12)
**Note:** all data is synthetic sample data created for this project.

## Results by check

| # | Check | Result | Rows affected |
|---|-------|--------|---------------|
| 1 | Duplicate order IDs | 1 duplicate ID | Order **1003** appears twice (exact duplicate row) |
| 2 | Near-duplicate orders | 2 groups | **C002 / 2026-10-03** — orders 1002 and 1012, same date, quantity and price under different IDs (likely double-keyed); C003 group is the Check 1 duplicate |
| 3 | Missing required values | 2 rows | **1004** — customer email missing; **1010** — order date missing |
| 4 | Invalid email format | 1 row | **1005** — `david.kim@example` has no domain suffix |
| 5 | Status outside allowed list | 2 bad values | **1006** — `DELIVERD` (typo for DELIVERED); **1014** — `pending` (lowercase, not in the allowed list) |
| 6 | Orphan orders | 1 row | **1008** — customer_id `C999` has no record in the customers table |
| 7 | Impossible values | 3 rows | **1007** — quantity −1; **1009** — order date 2026-12-24 is in the future; **1011** — quantity 0 on a CANCELLED order |
| 8 | Completeness summary | 15 rows total | Valid email 86.7% · Valid status 86.7% · Valid amounts 86.7% |

## What I would do with these findings

1. **Exact duplicate (1003):** delete one copy after confirming with the source system; add a uniqueness constraint on `order_id`.
2. **Near-duplicate (1002/1012):** raise with the order-entry team — same customer, date and amount usually means the order was keyed twice; verify before deleting so a real second order is not lost.
3. **Missing email/date (1004, 1010):** send back to source for completion; make both fields mandatory at entry.
4. **Invalid email (1005):** correct from the customer record; add a format validation rule at entry.
5. **Status typos (1006, 1014):** standardise to the allowed list (`DELIVERD` → `DELIVERED`, `pending` → `PLACED` after confirmation); replace free-text status with a dropdown.
6. **Orphan order (1008):** quarantine — do not process fulfilment or billing until the customer record exists.
7. **Impossible values (1007, 1009, 1011):** quantity −1 looks like a returns entry keyed as an order — confirm and reclassify; future date is a keying error to correct; quantity 0 on a cancelled order is acceptable but should be confirmed as the cancellation convention.

## Summary

11 of the 15 sample rows carry at least one defect. The pattern is typical of manual order entry with no validation at the point of entry: duplicates, free-text typos, and missing fields. The checks in `data_quality_checks.sql` are written to be re-run after cleanup so the same report can prove the fixes worked.

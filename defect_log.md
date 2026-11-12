# Defect Log — Customer Portal (Sample)

Application: Customer Portal v2.4 · Related documents: `test_plan.md`, `test_cases.md`
All entries are illustrative examples written for this sample project.

| Defect ID | Summary | Found in | Severity | Priority | Status |
|-----------|---------|----------|----------|----------|--------|
| DEF-001 | Order History shows another customer's order after switching accounts without closing the browser | TC-05 | Critical | High | Fixed — retested, closed |
| DEF-002 | Checkout tax calculated on the discounted total instead of the subtotal for coupon orders | TC-08 | High | High | Fixed — retested, closed |
| DEF-003 | "Delivered" status displays as "DELIVERD" for orders imported from the legacy system | TC-06 | Medium | Medium | Open — data fix in progress |
| DEF-004 | Password reset link expires after 15 minutes instead of the specified 60 minutes | TC-04 | Medium | Medium | Assigned |
| DEF-005 | Declined card leaves a "Pending" order in Order History | TC-11 | High | High | Fixed — regression in progress |

## Example defect report (DEF-002)

- **Summary:** Checkout tax calculated on the discounted total instead of the subtotal for coupon orders
- **Environment:** QA, Customer Portal v2.4 build 118
- **Steps to reproduce:**
  1. Log in as the seeded customer
  2. Add an item priced $100.00 to the cart
  3. Apply coupon SAVE10 (10% off)
  4. Proceed to checkout and view the tax line
- **Expected:** Tax (8%) calculated on the $100.00 subtotal = $8.00; total $98.00
- **Actual:** Tax calculated on the discounted $90.00 = $7.20; total $97.20
- **Severity / Priority:** High / High — incorrect customer charge on every coupon order
- **Status history:** New → Assigned → Fixed (build 121) → Retest passed → Closed

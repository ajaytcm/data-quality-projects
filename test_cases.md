# Test Cases — Customer Portal (Sample)

Application: Customer Portal v2.4 · Related plan: `test_plan.md`

| ID | Area | Test case | Steps | Expected result | Priority |
|----|------|-----------|-------|-----------------|----------|
| TC-01 | Login | Valid login | Enter valid email + password → Sign in | User lands on dashboard; name shown | High |
| TC-02 | Login | Invalid password | Enter valid email + wrong password → Sign in | Error "Invalid email or password"; no login | High |
| TC-03 | Login | Account lockout | Fail login 5 times in a row | Account locked message; correct password also rejected until unlock | High |
| TC-04 | Login | Password reset | Click "Forgot password" → open email link → set new password | Login succeeds with new password; old password rejected | Medium |
| TC-05 | Order History | List accuracy | Log in as seeded customer with 5 orders | Exactly the customer's 5 orders shown, newest first, matching database | High |
| TC-06 | Order History | Status display | View orders in each status (Placed / Shipped / Delivered / Cancelled) | Status label on screen matches database status for every order | High |
| TC-07 | Order History | Empty history | Log in as new customer with no orders | "No orders yet" message; no errors | Low |
| TC-08 | Checkout | Total calculation | Add items $49.99 × 2 and $19.95 × 1 → checkout | Subtotal $119.93; tax and grand total calculated correctly | High |
| TC-09 | Checkout | Quantity boundary | Set quantity to 0, then to max allowed (99) | 0 rejected with message; 99 accepted | Medium |
| TC-10 | Checkout | Payment confirmation | Pay with sandbox card → confirm order | Order confirmation page + confirmation email; order appears in Order History as Paid | High |
| TC-11 | Checkout | Declined card | Pay with sandbox decline card | Clear decline message; no order created; cart retained | High |
| TC-12 | Regression | Profile update | Change display name → save → log out / in | New name persists and shows on dashboard | Medium |

**Execution notes:** each case is run on the QA environment with the seeded
test data described in the test plan. Failures are logged as defects
(see `defect_log.md`) and retested after the fix, with the surrounding
regression cases re-run.

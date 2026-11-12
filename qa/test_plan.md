# Test Plan — Customer Portal (Sample)

**Application:** Customer Portal v2.4 (fictional sample application)
**Features in scope:** Login, Order History, Checkout
**Prepared by:** A. Vasamsetti — QA
**Version:** 1.0

## 1. Objective

Verify that the Customer Portal release works as specified before it reaches
customers: users can sign in securely, view accurate order history, and
complete checkout with correct totals.

## 2. Scope

**In scope**
- Login (valid / invalid credentials, locked account, password reset)
- Order History (list accuracy against the orders database, status display)
- Checkout (cart totals, tax calculation, payment confirmation, order email)

**Out of scope**
- Admin console (tested under a separate plan)
- Performance testing (separate non-functional plan)

## 3. Test approach

- **Test design:** requirements-based test cases (see `test_cases.md`),
  equivalence partitioning and boundary values for quantity / price fields.
- **Test types:** system testing, integration testing (portal ↔ orders
  database ↔ payment gateway stub), regression testing of unchanged features,
  and user acceptance support with the business team.
- **Defect management:** all defects logged with severity / priority and
  tracked to closure (see `defect_log.md`); retest + regression after fixes.

## 4. Test environment

- QA environment mirroring production configuration
- Test data: seeded customers and orders (including cancelled and returned
  orders), payment gateway in sandbox mode

## 5. Entry / exit criteria

**Entry:** requirements signed off, QA environment deployed and smoke-tested,
test data loaded.
**Exit:** all high-priority test cases executed and passing; no open
Critical / High defects; regression suite green; UAT sign-off received.

## 6. Risks

| Risk | Mitigation |
|---|---|
| Payment gateway sandbox downtime | Schedule checkout testing early; keep stub fallback |
| Late requirements change to tax rules | Boundary-value cases for tax; confirm rules with business before execution |

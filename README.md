# Data Quality & QA Projects

Sample projects that show how I work: checking data for defects, and planning and documenting software testing. All data here is synthetic sample data created for practice — no employer or client data.

## Contents

### 1. SQL data-quality checks — `sql/`
Small, deliberately messy sample datasets (`sample_customer_orders.csv`, `sample_customers.csv`) and a set of SQL checks (`data_quality_checks.sql`) that find the problems in them:

- Duplicate records (exact and near-duplicate business keys)
- Missing / null values in required fields
- Invalid formats (email pattern, order status values outside the allowed list)
- Referential problems (orders with no matching customer)
- Value-range problems (negative quantities, order dates in the future)

Each check is written to return the offending rows so they can be reviewed and corrected, with a short note on what the check catches and how I would report it.

### 2. QA artifacts — `qa/`
A worked example of the documents I produce in a QA role, written for a fictional "Customer Portal" application:

- `test_plan.md` — scope, approach, test types, entry / exit criteria
- `test_cases.md` — functional test cases with steps and expected results
- `defect_log.md` — example defect reports with severity, priority, and lifecycle status

## Skills demonstrated

SQL (SELECT, WHERE, GROUP BY, HAVING, JOINs) · data profiling & validation · test planning & case design · defect reporting & tracking · documentation

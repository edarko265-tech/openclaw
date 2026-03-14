# Domain Model v0.1

## Core Bounded Contexts

- Tenant and Identity
- Workforce and Scheduling
- Job Execution and Proof of Work
- Billing and Payroll
- Analytics and Reporting

## Primary Entities

### Tenant and Identity
- Tenant
- User
- Role
- Permission
- SubscriptionPlan

### Workforce and Scheduling
- Employee
- AvailabilityWindow
- Shift
- Assignment

### Job Execution and Proof
- Client
- ServiceLocation
- JobTemplate
- Job
- ChecklistTemplate
- ChecklistSubmission
- ProofAsset
- Signature

### Billing and Payroll
- Invoice
- InvoiceLine
- Payment
- PayrollPeriod
- PayrollEntry

## Aggregate Ownership

- Tenant owns users, employees, clients, jobs, invoices, payroll periods.
- Job owns checklist submissions and proof assets.
- Payroll period owns payroll entries.

## Key Invariants

- Cross-tenant access is never allowed.
- Job cannot move to approved without checklist completion.
- Invoice cannot be marked paid without payment event confirmation.
- Payroll entry must map to validated attendance intervals.

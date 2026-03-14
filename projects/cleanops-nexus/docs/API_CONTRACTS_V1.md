# CleanOps Nexus API Contracts v1

## 1. Auth and Tenant

### POST /api/v1/auth/register-company
Creates tenant and company-admin account.

### POST /api/v1/auth/login
Authenticates user and returns session tokens.

### GET /api/v1/tenant/me
Returns tenant metadata, plan, and feature flags.

## 2. Employees

### GET /api/v1/employees
Lists employees for current tenant.

### POST /api/v1/employees
Creates employee profile and role assignment.

### PATCH /api/v1/employees/:employeeId
Updates employee profile, status, or role.

## 3. Clients

### GET /api/v1/clients
Lists clients for current tenant.

### POST /api/v1/clients
Creates client profile with service addresses.

## 4. Jobs

### GET /api/v1/jobs
Lists jobs with filters (date, status, assignee).

### POST /api/v1/jobs
Creates a job or recurring schedule.

### PATCH /api/v1/jobs/:jobId/assign
Assigns cleaner and supervisor.

### PATCH /api/v1/jobs/:jobId/status
Transitions job state (scheduled, in_progress, completed, approved).

## 5. Attendance

### POST /api/v1/attendance/clock-in
Records clock-in with timestamp and GPS point.

### POST /api/v1/attendance/clock-out
Records clock-out and computes payable duration.

## 6. Proof of Work

### POST /api/v1/proof/upload-url
Returns signed media upload URL.

### POST /api/v1/proof/checklist/submit
Submits checklist values and optional signature.

## 7. Invoicing and Payments

### POST /api/v1/invoices
Generates invoice from completed jobs.

### GET /api/v1/invoices
Lists invoice status and payment states.

### POST /api/v1/payments/stripe/webhook
Receives Stripe events and updates payment state.

## 8. Payroll

### GET /api/v1/payroll/periods/:periodId/summary
Returns payroll summary for selected period.

### GET /api/v1/payroll/periods/:periodId/export
Exports payroll data in CSV format.

## 9. Error Contract

All errors return:
- code
- message
- request_id
- details (optional)

## 10. Cross-Cutting Rules

- Every request is tenant-scoped.
- Role checks run before domain actions.
- All write operations create audit records.

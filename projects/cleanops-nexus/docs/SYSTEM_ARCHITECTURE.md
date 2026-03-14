# CleanOps Nexus System Architecture (v1)

## 1. Topology

- Mobile App (React Native)
- Web Admin App (Next.js)
- API Gateway (NestJS)
- Core Domain Services (tenant, auth, staff, jobs, clients, payroll, invoices)
- Async Workers (notifications, report exports, billing jobs)
- PostgreSQL (primary data store)
- Redis (queues, cache, distributed locks)
- Object Storage (proof-of-work photos and documents)

## 2. Multi-Tenant Isolation

- Every business record carries tenant_id.
- Tenant context resolved from signed session token and subdomain metadata.
- Service layer enforces tenant scoping before repository access.
- Query layer uses tenant predicates on all read and write operations.
- Audit tables include tenant_id, actor_id, action, and timestamp.

## 3. Role Model

- Platform Owner: manages tenants, subscriptions, plans, system health.
- Company Admin: manages staff, clients, schedules, payroll config.
- Supervisor: monitors jobs, validates attendance and proof-of-work.
- Cleaner: executes assigned jobs and checklists.

## 4. Domain Modules

- identity: authentication, authorization, sessions, email verification
- tenant: tenant onboarding, plan assignment, feature flags
- workforce: employees, role assignment, availability and schedules
- clients: client records, addresses, recurring service templates
- jobs: creation, assignment, recurrence, status lifecycle
- attendance: clock-in/out, GPS validation, overtime calculations
- proof: checklist templates, media uploads, signatures
- invoicing: invoice lifecycle, payment status, Stripe events
- payroll: rates, overtime multipliers, period summaries, exports
- analytics: operational and financial KPIs
- notifications: push, email, in-app alerts

## 5. Event-Driven Flows

- JobAssigned -> push notification to cleaner
- JobStarted -> attendance validation and supervisor visibility update
- JobCompleted -> checklist/proof verification workflow
- InvoiceGenerated -> payment follow-up workflows
- PaymentCaptured -> ledger update and revenue metrics refresh

## 6. Security Controls

- JWT access tokens with short TTL and rotating refresh tokens
- Password hashing with strong work factor
- Signed upload URLs with short expiration
- PII field protection and least-privilege service accounts
- Request and action audit logging for sensitive operations

## 7. Observability

- Structured logs with tenant_id and request_id
- Metrics: API latency, job throughput, payment processing success
- Alerts: queue backlogs, failed webhooks, authentication anomalies

## 8. Deployment Model

- Dockerized services
- Environment tiers: dev, staging, production
- CI gates: lint, type-check, unit tests, integration tests
- CD with migration safety checks and rollback plan

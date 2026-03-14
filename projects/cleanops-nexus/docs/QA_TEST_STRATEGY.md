# CleanOps Nexus QA Test Strategy (Wave 01)

## 1. Test Pyramid

- Unit tests: domain services, validators, utility functions
- Integration tests: API endpoints, database interactions, queue workflows
- End-to-end tests: core user journeys across API and clients

## 2. Critical User Journeys

- Tenant registration and admin login
- Employee creation and role assignment
- Client creation and recurring job setup
- Cleaner clock-in, checklist completion, proof upload, clock-out
- Invoice generation and payment status update
- Payroll summary export

## 3. Security Test Coverage

- Tenant boundary tests for all data endpoints
- RBAC authorization matrix tests
- Input validation and payload sanitization tests
- Auth token lifecycle and refresh flow tests
- Signed upload URL expiry and misuse tests

## 4. Performance and Reliability

- Load tests for job listing and schedule APIs
- Queue retry behavior for notification and billing workflows
- Failover tests for object storage and webhook retries

## 5. CI Gates

- Lint and static checks
- Type checks
- Unit test suite
- Integration test suite
- E2E smoke suite

## 6. Release Exit Criteria

- No blocker or critical defects open
- All mandatory gates pass
- Security checks pass for changed modules
- Rollback plan documented

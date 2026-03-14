# Wave 2 Test Matrix

## Backend

- Unit: tenant context resolver, auth token validator
- Integration: health endpoint, auth login contract, tenant context endpoint
- Contract: OpenAPI lint and endpoint drift checks

## Mobile

- Unit: route registration map
- Component: job list placeholder render contract
- E2E placeholder: sign-in to jobs list navigation smoke path

## Cross-Cutting

- Tenant isolation rule checks
- RBAC gate checks
- Media proof upload policy checks

## Exit Criteria

- No blocker defects in core flows
- All selected checks green on PR
- Findings documented with owners

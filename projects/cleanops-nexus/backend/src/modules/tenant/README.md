# Tenant Module Skeleton

## Responsibility

Tenant lifecycle, plan assignment, and tenant-scoped policy resolution.

## First Build Targets

- Tenant bootstrap service
- Tenant context resolver middleware
- Feature flag lookup service
- Audit hooks for tenant-level mutations

## Contracts

- Input: authenticated identity and tenant reference
- Output: validated tenant context with plan and feature toggles

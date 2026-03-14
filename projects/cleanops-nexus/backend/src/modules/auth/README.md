# Auth Module Skeleton

## Responsibility

User authentication, role claims, session token issuance, and verification.

## First Build Targets

- Company admin registration endpoint
- Login endpoint with credential validation
- Access token + refresh token issuance
- Role claim extraction middleware

## Security Baseline

- Password hashing with strong cost factor
- Short-lived access tokens
- Rotating refresh tokens
- Tenant-aware authorization checks

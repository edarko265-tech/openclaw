# Project Brief: CleanOps Nexus

Prepared On: 2026-03-14
Prepared For: SaaS Product Development
Prepared By: William Saah Nkansah Odoom (source scope) and OpenClaw kickoff team

## 1. Project Overview

CleanOps Nexus is a multi-tenant cloud platform to help cleaning companies run staff operations, scheduling, payroll, client management, proof of work, and finance workflows through a mobile app and an owner web dashboard.

## 2. Product Components

- Mobile Application for cleaning company staff and supervisors
- Web Application for SaaS owner administration

## 3. Core Modules

- Authentication and multi-tenant system
- Employee management
- Time tracking and attendance
- Client management
- Job scheduling and recurrence
- Service checklist and proof of work
- Payments and invoicing
- Dashboard and analytics
- Payroll module
- GPS and live job tracking
- Notification system
- Reports and data export

## 4. Cleaner Mobile App Features

- View assigned jobs
- Start and stop job timer
- Upload before and after photos
- Complete job checklist
- View payroll summary
- Receive push notifications

## 5. SaaS Owner Web Admin Features

- Tenant management
- Subscription and billing management
- Revenue and growth analytics
- Feature toggle and plan control
- Support and helpdesk management
- System monitoring and audit logs

## 6. Non-Functional Requirements

- Secure multi-tenant data isolation
- Cloud-scale architecture
- Role-based access control
- Backup and disaster recovery strategy
- GDPR compliance
- Mobile-first responsive design

## 7. Recommended Stack

- Backend: NestJS (TypeScript) with PostgreSQL
- Mobile: React Native (TypeScript)
- Web Admin: Next.js with Tailwind CSS
- Infrastructure: Docker, CI/CD, object storage
- Payments: Stripe

## 8. Phase Plan

- Phase 1: Product design and architecture
- Phase 2: Core backend development
- Phase 3: Mobile application development
- Phase 4: Payments and payroll integration
- Phase 5: SaaS admin dashboard development
- Phase 6: Testing, security, and deployment

## 9. Monetization

- Subscription pricing tiers: Starter, Growth, Enterprise
- Optional invoice commission add-on

## 10. Future Enhancements

- AI scheduling optimization
- Automated assignment engine
- White-label mode
- Marketplace mode
- Advanced predictive analytics

## 11. Success Criteria for Wave 01

- Canonical domain model and architecture approved
- Initial backend, mobile, and web admin foundations created
- CI quality gates defined
- Branch and PR workflow active with clear ownership

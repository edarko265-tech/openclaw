# USER_FLOWS.md

## Overview
This document details the user flows for the CleanOps Nexus Mobile project, focusing on the cleaner job lifecycle and proof-of-work UX.

### Cleaner Job Lifecycle
1. **Authentication**
   - Cleaner logs in or signs up.
   - Dashboard displays current assignments and tasks.

2. **Job Assignment**
   - Cleaner receives a notification for a new job.
   - Views job details, location, and time estimates.

3. **Acceptance**
   - Cleaner accepts the job.
   - Job moves to the 'Active' state in the dashboard.

4. **Execution**
   - On arriving at the location, cleaner marks "Start Job."
   - App tracks time and possibly geolocation.
   - Cleaner logs proof-of-work: photos, task checklists, notes.

5. **Completion**
   - Marks "Complete Job."
   - System validates proof-of-work.
   - Client approval queue begins.

6. **Payroll**
   - Job completion adds to cleaner's payout account.
   - Payment summary available in "Earnings" screen.

### Proof-of-Work UX
- **Photos:** Upload images of completed tasks or problematic areas.
- **Checklist:** Check off standard job tasks for automated QA.
- **Notes:** Optional text field to describe situation (e.g., locked room, extra work).
- **Time Tracking:** Auto-start when "Begin Job" is pressed; requires manual "End Job."

This structure ensures clarity, transparency, and efficiency for both cleaners and clients.
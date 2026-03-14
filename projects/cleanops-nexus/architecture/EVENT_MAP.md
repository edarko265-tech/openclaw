# Event Map v0.1

## Scheduling Events

- JobCreated
- JobAssigned
- JobRescheduled
- JobCancelled

## Execution Events

- JobStarted
- ChecklistSubmitted
- ProofUploaded
- JobCompleted
- JobApproved

## Attendance Events

- ClockInRecorded
- ClockOutRecorded
- OvertimeCalculated

## Billing and Payroll Events

- InvoiceGenerated
- InvoiceSent
- PaymentReceived
- PayrollPeriodClosed
- PayrollExportGenerated

## Event Consumers

- Notification worker consumes JobAssigned, JobRescheduled, JobCompleted.
- Billing worker consumes JobApproved and PaymentReceived.
- Analytics pipeline consumes all domain events for KPI projections.

## Reliability Rules

- Events are immutable after publish.
- Consumer handlers are idempotent.
- Failed handlers retry with backoff and dead-letter routing.

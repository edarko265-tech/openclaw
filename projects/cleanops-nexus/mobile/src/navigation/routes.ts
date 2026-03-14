export type AppRoute =
  | "SignIn"
  | "JobList"
  | "JobDetails"
  | "Checklist"
  | "ProofUpload"
  | "PayrollSummary";

export const coreRoutes: AppRoute[] = [
  "SignIn",
  "JobList",
  "JobDetails",
  "Checklist",
  "ProofUpload",
  "PayrollSummary",
];

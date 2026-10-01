import type { Category } from "./types";

export const CATEGORY_LABELS: Record<Category, string> = {
  verify: "Verify first",
  collect: "Collection follow-up",
  billing: "Billing review",
  monitor: "Not yet due",
  settled: "Paid in export",
};

export const NEXT_STEP: Record<Category, string> = {
  collect: "Customer communication",
  billing: "Internal billing review",
  verify: "Finance verification before any customer contact",
  monitor: "No action until the due date",
  settled: "No collection action",
};

export const CATEGORY_TONE: Record<Category, { bar: string; soft: string }> = {
  collect: { bar: "border-l-red-500", soft: "border-red-200 bg-red-50 text-red-800" },
  verify: { bar: "border-l-violet-500", soft: "border-violet-200 bg-violet-50 text-violet-800" },
  billing: { bar: "border-l-amber-500", soft: "border-amber-200 bg-amber-50 text-amber-800" },
  monitor: { bar: "border-l-sky-400", soft: "border-sky-200 bg-sky-50 text-sky-800" },
  settled: { bar: "border-l-emerald-500", soft: "border-emerald-200 bg-emerald-50 text-emerald-800" },
};

import { CATEGORY_LABELS, CATEGORY_TONE } from "../categories";
import { money } from "../format";
import { cn } from "../lib/utils";
import type { InvoicePosition } from "../types";
import { Badge } from "./ui/badge";
import { Card } from "./ui/card";
import { Tabs, TabsList, TabsTrigger } from "./ui/tabs";

export type Filter = "collect" | "billing" | "verify" | "all";

const FILTERS: { value: Filter; label: string }[] = [
  { value: "collect", label: "Collections" },
  { value: "billing", label: "Billing review" },
  { value: "verify", label: "Verify first" },
  { value: "all", label: "All" },
];

type Props = {
  invoices: InvoicePosition[];
  filter: Filter;
  search: string;
  selectedId: string | null;
  onFilterChange: (filter: Filter) => void;
  onSearchChange: (search: string) => void;
  onSelect: (id: string) => void;
};

export function matches(invoice: InvoicePosition, filter: Filter, search: string): boolean {
  if (filter !== "all" && invoice.category !== filter) return false;
  const term = search.trim().toLowerCase();
  if (!term) return true;
  return [invoice.invoice_number, invoice.customer_name, invoice.job_name, invoice.job_number].some((field) =>
    field?.toLowerCase().includes(term),
  );
}

export default function ReceivablesQueue({
  invoices,
  filter,
  search,
  selectedId,
  onFilterChange,
  onSearchChange,
  onSelect,
}: Props) {
  const visible = invoices.filter((invoice) => matches(invoice, filter, search));
  const count = (value: Filter) =>
    value === "all" ? invoices.length : invoices.filter((invoice) => invoice.category === value).length;

  return (
    <Card className="p-3" role="region" aria-label="Worklist">
      <Tabs value={filter} onValueChange={(value) => onFilterChange(value as Filter)}>
        <TabsList>
          {FILTERS.map(({ value, label }) => (
            <TabsTrigger key={value} value={value} className="px-2 text-xs">
              {label}
              <span className="text-xs text-muted-foreground">{count(value)}</span>
            </TabsTrigger>
          ))}
        </TabsList>
      </Tabs>
      <input
        type="search"
        className="my-3 h-9 w-full rounded-md border bg-card px-3 outline-none focus:border-primary focus:ring-2 focus:ring-ring"
        placeholder="Search invoice, customer, or job"
        aria-label="Search invoices"
        value={search}
        onChange={(event) => onSearchChange(event.target.value)}
      />
      {visible.length === 0 ? (
        <p className="py-8 text-center text-muted-foreground">No invoices match.</p>
      ) : (
        <ul className="space-y-1">
          {visible.map((invoice) => {
            const selected = invoice.id === selectedId;
            return (
              <li key={invoice.id}>
                <button
                  className={cn(
                    "flex w-full flex-col gap-0.5 rounded-lg border border-l-4 border-transparent px-3 py-2.5 text-left transition-colors hover:bg-muted",
                    CATEGORY_TONE[invoice.category].bar,
                    selected && "bg-blue-50 ring-1 ring-primary/30 hover:bg-blue-50",
                  )}
                  aria-current={selected}
                  onClick={() => onSelect(invoice.id)}
                >
                  <span className="flex justify-between gap-2">
                    <span className="font-semibold">{invoice.invoice_number}</span>
                    <span className="font-medium tabular-nums">
                      {money(invoice.category === "billing" ? invoice.total : invoice.remaining_balance)}
                    </span>
                  </span>
                  <span>{invoice.customer_name ?? "Unknown customer"}</span>
                  <span className="flex items-center gap-1.5 text-xs text-muted-foreground">
                    {filter === "all" && (
                      <Badge variant="outline" className={CATEGORY_TONE[invoice.category].soft}>
                        {CATEGORY_LABELS[invoice.category]}
                      </Badge>
                    )}
                    {invoice.reason}
                  </span>
                </button>
              </li>
            );
          })}
        </ul>
      )}
    </Card>
  );
}

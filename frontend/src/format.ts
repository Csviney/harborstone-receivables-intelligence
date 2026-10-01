const currency = new Intl.NumberFormat("en-US", { style: "currency", currency: "USD" });

export function money(value: string | null): string {
  return value === null ? "Unknown" : currency.format(Number(value));
}

// Format in UTC so the date doesn't shift back a day in US time zones.
export function day(isoDate: string | null, month: "short" | "long" = "short"): string {
  if (!isoDate) return "—";
  const [year, m, d] = isoDate.split("-").map(Number);
  return new Date(Date.UTC(year, m - 1, d)).toLocaleDateString("en-US", {
    timeZone: "UTC",
    year: "numeric",
    month,
    day: "numeric",
  });
}

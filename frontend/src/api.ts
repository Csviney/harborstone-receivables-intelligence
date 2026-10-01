import type { InvoiceDetail, Receivables } from "./types";

export class ApiError extends Error {
  constructor(
    readonly status: number,
    message: string,
  ) {
    super(message);
  }
}

async function getJson<T>(path: string, signal?: AbortSignal): Promise<T> {
  const response = await fetch(`/api${path}`, { headers: { Accept: "application/json" }, signal });
  if (!response.ok) {
    const body = await response.json().catch(() => null);
    throw new ApiError(response.status, body?.detail?.message ?? `Request failed (${response.status})`);
  }
  return (await response.json()) as T;
}

export const fetchReceivables = () => getJson<Receivables>("/receivables");

export const fetchInvoice = (id: string, signal?: AbortSignal) =>
  getJson<InvoiceDetail>(`/invoices/${encodeURIComponent(id)}`, signal);

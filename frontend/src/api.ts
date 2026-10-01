import type { ARTrend, InvestigationResult, InvoiceDetail, Receivables } from "./types";

export class ApiError extends Error {
  constructor(
    readonly status: number,
    message: string,
  ) {
    super(message);
  }
}

async function request<T>(path: string, init: RequestInit = {}): Promise<T> {
  const response = await fetch(`/api${path}`, {
    ...init,
    headers: { Accept: "application/json", "Content-Type": "application/json" },
  });
  if (!response.ok) {
    const body = await response.json().catch(() => null);
    throw new ApiError(response.status, body?.detail?.message ?? `Request failed (${response.status})`);
  }
  return (await response.json()) as T;
}

export const fetchReceivables = () => request<Receivables>("/receivables");

export const fetchTrend = () => request<ARTrend>("/receivables/trend");

export const fetchInvoice = (id: string, signal?: AbortSignal) =>
  request<InvoiceDetail>(`/invoices/${encodeURIComponent(id)}`, { signal });

export const assessInvoice = (id: string, refresh: boolean) =>
  request<InvestigationResult>(`/invoices/${encodeURIComponent(id)}/investigations`, {
    method: "POST",
    body: JSON.stringify({ refresh }),
  });

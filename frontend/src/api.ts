import type { Health } from "./types";

export class ApiError extends Error {
  constructor(
    readonly status: number,
    message: string,
  ) {
    super(message);
  }
}

async function getJson<T>(path: string, acceptStatuses: number[] = []): Promise<T> {
  const response = await fetch(`/api${path}`, { headers: { Accept: "application/json" } });
  if (!response.ok && !acceptStatuses.includes(response.status)) {
    throw new ApiError(response.status, `Request failed (${response.status})`);
  }
  return (await response.json()) as T;
}

// /health returns a body with its 503.
export const fetchHealth = () => getJson<Health>("/health", [503]);

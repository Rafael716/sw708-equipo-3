export const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3001";

export async function apiRequest<T>(
  path: string,
  options?: RequestInit,
): Promise<T> {
  const res = await fetch(`${API_URL}${path}`, options);
  if (!res.ok) {
    let message = `Error ${res.status}`;
    try {
      const data = await res.json();
      message = data.message || data.error || message;
    } catch {
      // ignore parse errors
    }
    throw new Error(message);
  }
  return res.json();
}
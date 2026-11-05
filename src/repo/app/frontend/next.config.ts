import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // output standalone solo para Docker (self-host).
  // Vercel buildea con su propio output (sin esta variable).
  ...(process.env.NEXT_OUTPUT_STANDALONE === "true"
    ? { output: "standalone" as const }
    : {}),
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "lh3.googleusercontent.com",
      },
    ],
  },
};

export default nextConfig;
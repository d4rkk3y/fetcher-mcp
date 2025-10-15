import type { TransportConfig } from "../transports/types.js";
import { isDebugMode, parseTransportConfig } from "./args.js";

/**
 * Get application configuration
 */
export function getConfig(): {
  transport: TransportConfig;
  debug: boolean;
} {
  return {
    transport: parseTransportConfig(),
    debug: isDebugMode(),
  };
}

export { isDebugMode };

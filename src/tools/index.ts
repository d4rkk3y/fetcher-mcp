import { browserInstall, browserInstallTool } from "./browserInstall.js";
import { fetchUrl, fetchUrlTool } from "./fetchUrl.js";
import { fetchUrls, fetchUrlsTool } from "./fetchUrls.js";

// Export tool definitions
export const tools = [fetchUrlTool, fetchUrlsTool, browserInstallTool];

// Export tool implementations
export const toolHandlers = {
  [fetchUrlTool.name]: fetchUrl,
  [fetchUrlsTool.name]: fetchUrls,
  [browserInstallTool.name]: browserInstall,
};

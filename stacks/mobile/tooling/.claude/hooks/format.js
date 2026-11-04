// PostToolUse hook: format the file Claude just edited with Prettier.
// Never blocks Claude. Formatting failures are ignored.
const { spawnSync } = require("node:child_process");

let input = "";
process.stdin.on("data", (chunk) => (input += chunk));
process.stdin.on("end", () => {
  try {
    const file = JSON.parse(input).tool_input?.file_path;
    if (file) {
      spawnSync("npx", ["--no-install", "prettier", "--write", "--ignore-unknown", file], {
        stdio: "ignore",
        shell: true,
      });
    }
  } catch {
    // Ignore malformed input.
  }
});

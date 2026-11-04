"""PostToolUse hook: format the Python file Claude just edited with ruff.

Never blocks Claude. Formatting failures are ignored.
"""
import json
import subprocess
import sys

try:
    file_path = json.load(sys.stdin).get("tool_input", {}).get("file_path", "")
    if file_path.endswith(".py"):
        subprocess.run(["ruff", "format", file_path], capture_output=True, check=False)
except Exception:
    pass

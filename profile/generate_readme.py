#!/usr/bin/env python3
"""Generate profile/README.md from org.yaml + README.md.j2.

Usage:
    python3 profile/generate_readme.py
"""
from __future__ import annotations

import sys
from datetime import datetime, timezone
from pathlib import Path

try:
    import yaml
    from jinja2 import Environment, FileSystemLoader
except ImportError:
    print("Missing deps. Run: pip install pyyaml jinja2", file=sys.stderr)
    sys.exit(1)

profile_dir = Path(__file__).parent

data = yaml.safe_load((profile_dir / "org.yaml").read_text())
data["generated_at"] = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")

env = Environment(
    loader=FileSystemLoader(profile_dir),
    keep_trailing_newline=True,
    trim_blocks=True,
    lstrip_blocks=True,
)
template = env.get_template("README.md.j2")
output = template.render(**data)

out_path = profile_dir / "README.md"
out_path.write_text(output)
print(f"Written: {out_path}")

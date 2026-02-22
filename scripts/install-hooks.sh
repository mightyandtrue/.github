#!/usr/bin/env bash
# Install org-context git hooks into the current repo.
# Run from the root of any mightyandtrue project repo.
#
# One-liner (no local clone of .github needed):
#   bash <(gh api repos/mightyandtrue/.github/contents/scripts/install-hooks.sh \
#     --jq '.content' \
#     | python3 -c "import sys,base64; sys.stdout.write(base64.b64decode(sys.stdin.read().replace('\n','').strip()).decode())")

set -e

if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Error: not in a git repo. Run this from the project repo root." >&2
  exit 1
fi

HOOKS_DIR="$(git rev-parse --git-dir)/hooks"
REPO_ROOT="$(git rev-parse --show-toplevel)"

echo "Installing org-context git hooks into: $HOOKS_DIR"

# ---------------------------------------------------------------------------
# post-merge: runs after git pull / git merge
# ---------------------------------------------------------------------------
cat > "$HOOKS_DIR/post-merge" << 'HOOK'
#!/usr/bin/env bash
# Fetch org README into .context/org.md after git pull
CONTEXT_DIR="$(git rev-parse --show-toplevel)/.context"
OUT_FILE="$CONTEXT_DIR/org.md"
mkdir -p "$CONTEXT_DIR"
if gh api repos/mightyandtrue/.github/contents/profile/README.md \
     --jq '.content' 2>/dev/null \
   | python3 -c "import sys,base64; sys.stdout.write(base64.b64decode(sys.stdin.read().replace('\n','').strip()).decode())" \
   > "$OUT_FILE" 2>/dev/null; then
  echo "[org-context] Updated .context/org.md"
else
  echo "[org-context] Warning: could not fetch org README. Cached version retained." >&2
fi
HOOK
chmod +x "$HOOKS_DIR/post-merge"

# ---------------------------------------------------------------------------
# post-checkout: runs after git checkout / git switch / git clone
# Only fires on branch checkouts (arg $3 = 1), not file checkouts
# ---------------------------------------------------------------------------
cat > "$HOOKS_DIR/post-checkout" << 'HOOK'
#!/usr/bin/env bash
# Fetch org README into .context/org.md after branch checkout
[ "${3:-0}" = "1" ] || exit 0
CONTEXT_DIR="$(git rev-parse --show-toplevel)/.context"
OUT_FILE="$CONTEXT_DIR/org.md"
mkdir -p "$CONTEXT_DIR"
if gh api repos/mightyandtrue/.github/contents/profile/README.md \
     --jq '.content' 2>/dev/null \
   | python3 -c "import sys,base64; sys.stdout.write(base64.b64decode(sys.stdin.read().replace('\n','').strip()).decode())" \
   > "$OUT_FILE" 2>/dev/null; then
  echo "[org-context] Updated .context/org.md"
else
  echo "[org-context] Warning: could not fetch org README. Cached version retained." >&2
fi
HOOK
chmod +x "$HOOKS_DIR/post-checkout"

# ---------------------------------------------------------------------------
# Update .gitignore
# ---------------------------------------------------------------------------
GITIGNORE="$REPO_ROOT/.gitignore"
if ! grep -q "^\.context/" "$GITIGNORE" 2>/dev/null; then
  printf '\n# Org context (auto-fetched on git pull, not committed)\n.context/\n' >> "$GITIGNORE"
  echo "[org-context] Added .context/ to .gitignore"
fi

# ---------------------------------------------------------------------------
# Fetch immediately so .context/org.md exists right now
# ---------------------------------------------------------------------------
echo "[org-context] Fetching org context now..."
bash "$HOOKS_DIR/post-merge"

echo ""
echo "Done. Hooks installed."
echo "  post-merge:    $HOOKS_DIR/post-merge"
echo "  post-checkout: $HOOKS_DIR/post-checkout"
echo "  Org README at: $REPO_ROOT/.context/org.md"
echo ""
echo "Next: add this line to the TOP of your CLAUDE.md:"
echo ""
echo "  @.context/org.md"
echo ""

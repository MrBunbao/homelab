#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/Users/admad/homelab"
DOCS_DIR="$REPO_DIR/docs"
PRIVATE_DIR="$REPO_DIR/docs-private"

mkdir -p "$PRIVATE_DIR"

# Known sensitive files (relative to docs/)
declare -a SENSITIVE=(
  "CONFIGS/EpicGames/README.md"
  "CONFIGS/Tabby Web/Github OAuth.md"
  "CONFIGS/Nextcloud/commands-scripts.md"
  "CONFIGS/Nextcloud/Cloudflare API Token.md"
)

sanitize_content() {
  # Redact common secret-like patterns but keep surrounding context
  perl -pe '
    s/(?i)\b(password|pass|secret|token|api[-_ ]?key|smtp.*pass(word)?|client[-_ ]?secret)\b([^\n]*)/\1: [REDACTED]/g;
    s/(?i)\b(authorization:\s*bearer)\s+[A-Za-z0-9\.\-_]+/\1 [REDACTED]/g;
    s/(?i)(cloudflare.*token)([^\n]*)/\1: [REDACTED]/g;
  '
}

for rel in "${SENSITIVE[@]}"; do
  src="$DOCS_DIR/$rel"
  if [[ -f "$src" ]]; then
    dst_priv="$PRIVATE_DIR/$rel"
    dst_pub="$DOCS_DIR/$rel"
    mkdir -p "$(dirname "$dst_priv")" "$(dirname "$dst_pub")"
    # Move original to private if not already moved
    if [[ ! -f "$dst_priv" ]]; then
      mv "$src" "$dst_priv"
    fi
    # Create sanitized public copy
    {
      echo "<!-- Public copy with sensitive values redacted. Full original is in docs-private/$rel (untracked). -->"
      echo
      cat "$dst_priv" | sanitize_content
    } > "$dst_pub"
    echo "Sanitized: $rel"
  fi
done

# Extra safety pass: redact likely secrets anywhere else in docs/ (excluding private and build output)
grep -RIl --exclude-dir=.git --exclude-dir=site --exclude-dir=docs-private "$DOCS_DIR" | while read -r file; do
  tmp="${file}.tmp"
  perl -pe '
    s/(?i)\b(password|pass|secret|token|api[-_ ]?key|client[-_ ]?secret|smtp.*pass(word)?)\s*[:=]\s*[^\s'"'"'"]+/\1: [REDACTED]/g;
    s/(?i)\b(authorization:\s*bearer)\s+[A-Za-z0-9\.\-_]+/\1 [REDACTED]/g;
  ' "$file" > "$tmp" && mv "$tmp" "$file"
done

echo "Sanitization complete."

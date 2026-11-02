#!/usr/bin/env bash
set -euo pipefail

for tool in nix just actionlint; do
  command -v "$tool" >/dev/null
done

actionlint
just check

if [[ -f hosts/mochi/default.nix ]]; then
  nix eval --raw .#nixosConfigurations.mochi.config.system.build.toplevel.drvPath
  printf '\n'
else
  printf '::warning::hosts/mochi is absent; only the generic workstation and dev shells were evaluated.\n'
  if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
    printf 'Generic workstation and dev shells checked. **mochi was not checked: hosts/mochi is absent.**\n' >> "$GITHUB_STEP_SUMMARY"
  fi
fi

git diff --exit-code -- flake.lock

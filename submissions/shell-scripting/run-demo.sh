#!/usr/bin/env bash
# Non-interactive demo: feeds answers to the read -p prompts through a
# pseudo-terminal (script -qec ...), so the prompts are actually displayed.
# Used to produce the screenshot.
set -u
WORK="$(mktemp -d)"
cd "$WORK"
HERE="$(cd "$(dirname "$0")" && pwd)"
printf 'Samarth\nsysinfo-demo\n' | script -qec "bash $HERE/system-info.sh" /dev/null
echo
echo "(demo workdir: $WORK)"

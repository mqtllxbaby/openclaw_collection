# openclawdocs

**Version:** 2026.03.13
**License:** MIT

`openclawdocs` is a reusable OpenClaw documentation skill for answering setup, configuration, migration, troubleshooting, and version-specific questions.

its version should match openclaw version and update for every openclaw release

## What it helps with

- finding the right OpenClaw doc page quickly
- answering version-sensitive config and CLI questions
- explaining migrations and breaking changes
- troubleshooting cases where runtime behavior does not match docs
- providing concise, copyable config examples

## Included files

- `README.md` — this file to explain about this project
- `SKILL.md` — main workflow and triggering guidance
- `CHANGELOG.md` — record change of the different verion of this package
- `HISTORY.md` — record change of the different verion of openclaw
- `scripts/` — helper utilities for version checks and doc lookup

## Helper scripts

| Script | Purpose |
|---|---|
| `scripts/check-version.sh` | Detect installed version; optional latest-version comparison |
| `scripts/sitemap.sh` | Browse docs paths from `llms.txt` |
| `scripts/search.sh` | Search doc paths by keyword |
| `scripts/fetch-doc.sh <path>` | Fetch a specific doc page |
| `scripts/track-changes.sh` | Track docs snapshots over time |

## Design goals

This version is prepared for future publishing/sharing:
- no personal chat IDs in examples
- fewer machine-specific assumptions
- stronger trigger description
- clearer distinction between documented vs source-observed behavior
- generic snippets that other users can adapt safely

## Notes

- Prefer local docs first when they exist.
- Use the public docs mirror when local docs are unavailable.
- Inspect installed source when docs are incomplete or contradicted by runtime behavior.

## Thanks

- inspired and borrowed from https://clawhub.ai/NicholasSpisak/clawddocs

## Public references

- Docs: <https://docs.openclaw.ai>
- Index: <https://docs.openclaw.ai/llms.txt>
- Source: <https://github.com/openclaw/openclaw>
- ClawHub: <https://clawhub.com>

# openclawdocs

**Version:** 2026.3.24
**License:** MIT
**GitHub location:** <https://github.com/mqtllxbaby/openclaw_collection/tree/main/skills/openclawdocs>

`openclawdocs` is a reusable OpenClaw documentation skill for answering setup, configuration, migration, troubleshooting, and version-specific questions.

Its version should match the installed OpenClaw release and be refreshed for each meaningful OpenClaw version change.

Current local target: OpenClaw 2026.3.24.

## What it helps with

- finding the right OpenClaw doc page quickly
- answering version-sensitive config and CLI questions
- explaining migrations and breaking changes
- troubleshooting cases where runtime behavior does not match docs
- providing concise, copyable config examples

## Included files

- `README.md` — this file to explain about this project
- `SKILL.md` — main workflow and triggering guidance
- `CHANGELOG.md` — record changes across released versions of this skill
- `HISTORY.md` — record the OpenClaw release-family changes this skill should track
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
- refreshed guidance for OpenClaw 2026.3.22 release-family changes, especially browser attach, built-in image generation, and plugin-SDK migration

## Notes

- Prefer local docs first when they exist.
- Use the public docs mirror when local docs are unavailable.
- Inspect installed source when docs are incomplete or contradicted by runtime behavior.

## Thanks

- inspired and borrowed from https://clawhub.ai/NicholasSpisak/clawddocs

## Public references

- This skill on GitHub: <https://github.com/mqtllxbaby/openclaw_collection/tree/main/skills/openclawdocs>
- OpenClaw docs: <https://docs.openclaw.ai>
- OpenClaw docs index: <https://docs.openclaw.ai/llms.txt>
- OpenClaw source: <https://github.com/openclaw/openclaw>
- ClawHub: <https://clawhub.com>

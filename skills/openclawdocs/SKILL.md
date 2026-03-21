---
name: openclawdocs
description: OpenClaw documentation expert matching latest version to help LLM know it better. Use whenever the user asks how OpenClaw works, how to configure or fix it, what changed between versions, which doc page applies, or when runtime behavior seems to disagree with the docs.
---

# OpenClaw Docs

Use this skill for OpenClaw questions that benefit from documentation lookup, version awareness, config examples, or source-of-truth verification.

## What this skill is for

Use it when the user asks about:
- installation, updates, deployment, or platform support
- gateway config, agents, sessions, memory, tools, plugins, channels, cron, browser, nodes, or web UI
- CLI commands, config structure, schema paths, migrations, or breaking changes
- troubleshooting, doc lookup, “where is this documented?”, or “why does reality not match the docs?”

This skill should win over generic browsing when the topic is specifically OpenClaw.

## Core workflow

1. Detect the user’s installed OpenClaw version when possible.
2. Prefer local OpenClaw docs first when they are available.
3. Use the public docs mirror if local docs are missing or insufficient.
4. If docs are unclear, stale, contradictory, or incomplete, inspect the installed OpenClaw source code before answering confidently.
5. Give the answer with version notes, concrete commands, and a doc/source citation.

## Version-aware workflow

When the user is asking about config, commands, or behavior that may vary by version:

1. Detect the installed version with one of:
   - `openclaw --version`
   - `./scripts/check-version.sh --auto`
2. Treat the installed version as the primary applicability signal.
3. Note the installed version in the response when it matters.
4. If the docs appear to target a different version, say so plainly.
5. Call out breaking changes instead of silently mixing old and new syntax.

### Common version pitfalls

- Older installs may use legacy config structures or older command names.
- Modern installs use `channels/` rather than older `providers/` guidance.
- Some automation, plugin, and tool behaviors changed across 2026.x releases.
- If you are unsure whether a behavior is documented or source-observed, label it clearly.

## Preferred lookup order

Installed openclaw source is always the source of truth. 
local docs and public docs are useful and but can be outdated.
Tell user clearly if there is any conflict between them.

Treat the helper scripts in `scripts/` as convenience fallbacks, not the primary source of truth.

### 1) Local docs

Check the installed docs tree first when present. Typical locations:
- package docs directory adjacent to the OpenClaw install
- local repo docs if working from source


### 2) Public docs

Use:
- `https://docs.openclaw.ai`
- `https://docs.openclaw.ai/llms.txt`
- `https://github.com/openclaw/openclaw`

### 3) Installed openclaw source 

Inspect installed source when:
- docs and runtime behavior disagree
- loader/search path behavior is in question
- a config field seems undocumented
- plugin/tool wiring is unclear
- generated output or watcher/reload behavior matters

When you inspect source, distinguish:
- **documented behavior**
- **source-observed behavior**
- **runtime-observed behavior**

## Search and navigation workflow

If the exact page is unknown:
1. Run `./scripts/search.sh <keyword>` for path-level discovery.
2. Run `./scripts/sitemap.sh` to browse categories.
3. Run `./scripts/fetch-doc.sh <doc-path>` to retrieve a candidate page.
4. If needed, consult `llms.txt` directly for broader discovery.

## Response style

For documentation answers, prefer this shape:

```text
Installed version: <version if known>
Applicability: <matches docs / older than docs / newer than docs / unknown>
Answer: <direct answer>
Commands or config: <copyable snippet>
Notes: <migration caveats / breaking changes / source-observed notes>
Source: <URL or local docs path>
```

## Config guidance rules

- Prefer minimal working examples over giant configs.
- Match syntax to the user’s version when known.
- Prefer JSON5-shaped config examples when mirroring local docs, since OpenClaw config commonly uses JSON5 syntax.
- If suggesting config edits, verify exact schema paths before claiming field names.
- For update guidance, prefer `openclaw update` when the docs/version support it; mention package-manager fallback only when relevant.
- If a restart or config change is required, say so explicitly.
- Do not invent CLI subcommands.

## Troubleshooting workflow

When a user says something is broken:
1. Identify whether the issue is docs, config, auth, environment, or version mismatch.
2. Find the closest official doc page.
3. If the doc is vague, inspect source or local runtime evidence.
4. Give a shortest-path fix first.
5. Then give the reason it happened.

## Bundled helpers

### Scripts
- `scripts/check-version.sh --auto` — output OpenClaw version directly
- `scripts/check-version.sh` — Check user's OpenClaw version vs latest
- `scripts/sitemap.sh` — browse docs paths
- `scripts/search.sh` — keyword/path search over `llms.txt`
- `scripts/fetch-doc.sh` — fetch a doc page with light caching
- `scripts/track-changes.sh` — snapshot docs changes over time

## Examples of when to use this skill

- “How do I set up Telegram in OpenClaw?”
- “Why is my bot not responding in groups?”
- “What changed between my OpenClaw version and the latest docs?”
- “How do I configure cron jobs / skills / browser / gateway auth?”
- “The docs say one thing but my local install behaves differently.”
- “Which page documents this config field?”

## Resources

- Official docs: `https://docs.openclaw.ai`
- Full index: `https://docs.openclaw.ai/llms.txt`
- Source: `https://github.com/openclaw/openclaw`

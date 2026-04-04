---
name: openclawdocs
description: OpenClaw documentation expert for setup, configuration, troubleshooting, migrations, CLI usage, automation, channels, tools, skills, and version-specific behavior. Use whenever the user asks how OpenClaw works, how to configure or fix it, what changed between versions, which doc page applies, or when runtime behavior seems to disagree with the docs.
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
- OpenClaw 2026.3.22 shifted several workflows that are easy to answer incorrectly from stale memory:
  - browser attach guidance now prefers the existing-session / `profile=user` path over older legacy extension-relay guidance
  - built-in image generation is centered on the core `image_generate` tool and `agents.defaults.imageGenerationModel`, not the old bundled `nano-banana-pro` wrapper
  - plugin SDK guidance should point at `openclaw/plugin-sdk/*`, not the removed legacy SDK surface
- OpenClaw 2026.3.24 added or sharpened a few areas worth calling out explicitly when relevant:
  - the gateway/OpenAI-compatible surface now includes `/v1/models` and `/v1/embeddings`
  - explicit model override forwarding through `/v1/chat/completions` and `/v1/responses` is broader
  - `/tools` and the Control UI are better at showing what the current agent can actually use right now
  - restart-sentinel wake behavior and outbound local-media handling improved, which matters for restart-heavy and media-heavy workflows
- OpenClaw 2026.3.31 changed a few areas that are easy to answer incorrectly from stale memory:
  - detached/background work is more unified across cron, subagents, ACP, and background CLI execution, so task/flow behavior may differ from older release families
  - per-agent `tools.exec` defaults are now actually honored when no inline override is present, which can surface new approval prompts or different exec routing after upgrade
  - dangerous skill/plugin install paths fail closed by default unless the operator explicitly opts into unsafe install behavior
  - gateway auth and node command exposure are stricter, so older advice that assumes looser trusted-proxy or pairing behavior may now be wrong
  - `/btw` reliability improved on the affected reasoning path, so old workaround guidance may no longer apply
- OpenClaw 2026.4.1 added and fixed a few areas that are easy to miss if you only remember 2026.3.x:
  - `/tasks` is now a first-class chat-native task board, so background-work answers should consider it alongside `/status`
  - `agents.defaults.params` exists, so provider-default parameter tuning may now belong there instead of ad hoc per-model advice
  - cron supports per-job tool allowlists, which can be a safer answer than broad agent/global tool-policy changes
  - exec approval/security behavior was tightened and fixed again in several places, so approvals, allowlists, and cron execution issues should be checked against current runtime/config rather than blamed on old regressions
  - config reload/task-registry/Telegram approval-threading fixes landed, so some older restart or channel-workaround advice may now be stale
- OpenClaw 2026.4.2 changed a few areas that are easy to answer incorrectly from stale memory:
  - old xAI `tools.web.x_search.*` and Firecrawl `tools.web.fetch.firecrawl.*` paths are now legacy; current guidance should use the plugin-owned config paths and mention `openclaw doctor --fix` for migration when relevant
  - Task Flow is now a more explicit first-class substrate with durable flow state and `openclaw flows`, so detached-work answers may need to mention flows rather than only tasks/sessions/cron
  - gateway/node host exec defaults and approval/config normalization changed again, so current answers should verify the live effective exec policy instead of assuming 2026.4.1 behavior
  - approval routing, loopback exec pairing, and provider transport/routing fixes landed, so some post-2026.3.31 regressions now have newer documented fixes
- If you are unsure whether a behavior is documented or source-observed, label it clearly.

## Preferred lookup order

Installed OpenClaw source is the final source of truth.
Local docs are the first place to look for practical answers.
Public docs are useful, but they can lag or lead the installed build.
Tell the user clearly when local docs, public docs, and installed source disagree.

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
- For update guidance, prefer `openclaw update` and `openclaw update status` when the docs/version support them; mention raw package-manager version checks only as fallback context when relevant.
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

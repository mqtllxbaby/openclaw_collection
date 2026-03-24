### Version: 2026.3.23

**Key Changes in 2026.3.23:**
- **Auth/OpenAI tokens:** Fixed live gateway auth-profile writes reverting freshly saved credentials to stale in-memory values; models auth paste-token now writes to resolved agent store, fixing expired OpenAI token refresh issues (refresh_token_reused).
- **Plugin runtimes:** Bundled plugin runtime sidecars (WhatsApp, Matrix, etc.) now included in npm package, fixing global install failures.
- **CLI/channel auth:** Auto-select single configured login-capable channel, harden channel IDs against prototype-chain/control-character abuse, improved on-demand channel installs.
- **Qwen (Alibaba Cloud Model Studio):** Added standard DashScope endpoints for China/global API keys alongside existing Coding Plan endpoints.
- **UI/CSP:** Improved inline script CSP handling, consolidated button primitives, refined Knot theme with WCAG 2.1 AA contrast.

**Practical note for this skill:** This release fixes the OAuth token refresh bug that caused authentication failures in 2026.3.22.

---

### Version: 2026.3.22

**Key Changes in 2026.3.22:**
- **Browser / Chrome MCP:** legacy Chrome extension relay guidance is no longer the preferred path; current docs center on existing-session attach and `profile=user`.
- **Image generation:** built-in image creation/editing is centered on the core `image_generate` tool and `agents.defaults.imageGenerationModel`; the old bundled `nano-banana-pro` wrapper/docs are gone.
- **Plugin SDK:** plugin guidance should use `openclaw/plugin-sdk/*`; the older monolithic SDK surface was removed.
- **ClawHub:** native OpenClaw flows now cover skill search / install / update, and plugin installs can resolve through ClawHub-backed paths.
- **Providers / tools:** new bundled or improved provider/tool coverage includes Exa, Tavily, Firecrawl, Anthropic Vertex, Chutes, and newer OpenAI/GitHub Copilot forward-compat paths.
- **Agents / UX:** per-agent thinking defaults, `/btw`, and multiple control-UI / usage refinements landed across this release family.
- **Config migration reminders:** removed/stale plugin references should be cleaned after upgrade, and older sample image-generation config should be migrated to the native image-generation config path.

**Practical note for this skill:** answers should prefer local docs/source for 2026.3.22 and should avoid old relay-era browser advice or old nano-banana skill-era image-generation advice unless explicitly discussing legacy installs.

---

### Version: 2026.3.13

**Key Changes in 2026.3.13:**
- **fix(compaction):** Use full-session token count for post-compaction sanity check
- **fix(telegram):** Thread media transport policy into SSRF (fixes media delivery in threads)
- **fix(session):** Preserve lastAccountId and lastThreadId on session reset
- **Default model:** Updated from `openai-codex/gpt-5.3-codex` → `openai-codex/gpt-5.4`
- **fix(agents):** Drop Anthropic thinking blocks on replay; avoid double memory injection on case-insensitive mounts
- **fix(cron):** Prevent isolated cron nested lane deadlocks
- **Docker:** Added `OPENCLAW_TZ` timezone support
- **Security:** Prevent gateway token leak in Docker build context
- **UI:** Mobile navigation drawer refinements, chat rendering improvements

**Recovery note:** GitHub tag is `v2026.3.13-1` (immutable release recovery), but npm version remains `2026.3.13`.

---

### Version: 2026.3.12
- Pi is only coding agent (legacy paths removed)
- `channels/` not `providers/` in config
- SecretRef support for 64+ config targets
- PDF tool available for document analysis
- Enhanced cron with isolated sessions + webhook delivery
- **New in 2026.3.9-2026.3.11:**
  - Cron exponential retry backoff (30s → 1m → 5m → 15m → 60m) after consecutive errors
  - Cron `--light-context` / `lightContext: true` for lightweight bootstrap (keeps bootstrap empty, does NOT suppress skillsSnapshot)
  - Cron run-log pruning: `cron.runLog.maxBytes` + `cron.runLog.keepLines`
  - Cron session retention: `cron.sessionRetention` (default `24h`) prunes completed isolated run sessions
  - `openclaw cron run` returns immediately when queued (use `cron runs --id <jobId>` to follow)
  - One-shot (`at`) jobs delete after success by default (use `--keep-after-run` to keep)
  - `openclaw doctor --fix` now explicitly normalizes legacy cron fields/store formats during upgrades
  - ACP bridge improvements (session controls, usage updates, tool streaming)
- `openclaw update` is the documented safe updater for source checkouts/channels; npm installs should still use the package-manager update flow from the Updating docs
- ACP bridge is still partial, not fully ACP-native: `loadSession` is partial, per-session MCP servers are unsupported, and session controls currently expose only a focused subset (thought level, tool verbosity, reasoning, usage detail, elevated actions)

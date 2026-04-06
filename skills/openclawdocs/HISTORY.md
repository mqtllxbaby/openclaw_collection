### Version: 2026.4.5

**Key Changes in 2026.4.5:**
- **Config alias cleanup:** several old public config aliases are now explicitly legacy, so config answers should prefer canonical public paths and mention `openclaw doctor --fix` when helping older installs migrate.
- **Built-in media generation:** `music_generate` and `video_generate` are now first-class built-in tools, and local ComfyUI / Comfy Cloud workflow-backed media generation is part of the answer space for image, music, and video questions.
- **Provider/catalog changes:** bundled provider coverage expanded again, including Qwen, Fireworks AI, StepFun, Bedrock Mantle improvements, and more search / TTS routes, so provider-availability answers should be checked against current local docs instead of older 2026.4.x assumptions.
- **Claude CLI migration:** bundled Claude CLI backend guidance changed materially, with legacy configured profiles kept runnable but new onboarding moving away from that path; answers should distinguish legacy working setups from current recommended setup.
- **Memory / dreaming:** dreaming and memory-promotion surfaces are now much broader, with `/dreaming`, Dreams UI, configurable aging, REM tooling, and `dreams.md`, so memory answers should not stop at only `MEMORY.md` + daily notes when the feature is enabled.
- **Prompt/cache/runtime stability:** prompt caching, tool inventory, streaming, and progress-reporting behavior changed substantially again, so stale advice about partial replies, cache reuse, or tool-prompt duplication may now be wrong.

**Practical note for this skill:** for 2026.4.5 answers, check first whether the user’s question is really about new built-in media tools, provider/catalog changes, config alias migration, Claude CLI migration, or dreaming/memory promotion before reusing 2026.4.2-era guidance.

---

### Version: 2026.4.2

**Key Changes in 2026.4.2:**
- **Config migrations:** legacy xAI `tools.web.x_search.*` and Firecrawl `tools.web.fetch.firecrawl.*` paths moved under plugin-owned config, so config answers should warn about those migrations and point users at `openclaw doctor --fix` when upgrading older setups.
- **Task Flow:** the core Task Flow substrate was restored/expanded with durable flow state, `openclaw flows` inspection/recovery, and managed child-task spawning, so answers about background orchestration should now consider flows more explicitly.
- **Exec defaults / approvals:** gateway/node host exec defaults shifted again toward no-prompt YOLO-style defaults in the documented runtime behavior, and approval/config normalization got additional fixes; answers should verify the live effective exec policy rather than assuming older 2026.4.1 semantics.
- **Exec/channel routing:** DM-first native approvals and host-policy handling were tightened further, so approval behavior may now differ from earlier 2026.4.x guidance.
- **Transport/routing fixes:** multiple provider routing, auth/header normalization, loopback exec pairing, and media HTTP fixes landed; when users report odd provider or local-exec regressions after 2026.3.31, 2026.4.2 is now part of the likely explanation space.
- **Other notable additions/fixes:** plugin `before_agent_reply`, Android assistant entrypoints, Matrix mention/threading improvements, Feishu comment-thread improvements, WhatsApp presence/media fixes, and Slack formatting fixes.

**Practical note for this skill:** for 2026.4.2 answers, check first whether the user’s issue is really an update-status/config-migration/task-flow/exec-policy question before reusing 2026.4.1-era advice.

---

### Version: 2026.4.1

**Key Changes in 2026.4.1:**
- **Tasks / task board:** `/tasks` is now a chat-native background task board for the current session, so answers about detached work should mention it when users want task visibility instead of only `/status` or session lists.
- **Agents / provider defaults:** `agents.defaults.params` now exists for global provider parameter defaults, so config answers should not assume model selection is the only agent-wide tuning surface.
- **Cron / tool scoping:** cron now supports per-job tool allowlists (`openclaw cron --tools`), so safer cron guidance can recommend narrower tool access instead of only broad agent/global policy changes.
- **Exec / approvals / cron:** approval/default behavior around exec is more consistent again, with fixes for approval persistence, cron no-route dead-ends, and host-policy interactions; old advice that assumes approvals are merely UI glitches may now be wrong.
- **Gateway / reload / tasks:** 2026.4.1 fixed config-reload restart loops and task-registry stalls/hangs, so post-upgrade task-board or gateway-hang issues may map to this release family.
- **Channel / delivery fixes:** Telegram error suppression/retry behavior and topic-aware exec approval routing improved, so older workaround advice for repeated Telegram failures or wrong-thread approvals may be stale.
- **Other notable additions:** bundled SearXNG web search provider, Bedrock Guardrails support, Voice Wake on macOS, Feishu Drive comment flows, more Z.AI models, and QMD collection-pattern fixes.

**Practical note for this skill:** for 2026.4.1 answers, explicitly check whether the user is dealing with task-board/task-ledger behavior, cron tool allowlists, or exec-approval/security defaults before reusing older 2026.3.x guidance.

---

### Version: 2026.3.31

**Key Changes in 2026.3.31:**
- **Background tasks / flows:** detached work is now much more unified across ACP, subagents, cron, and background CLI execution, with a shared task ledger and new flow visibility surfaces.
- **Agents / exec defaults:** per-agent `tools.exec` defaults are now honored more reliably; this can change real runtime behavior for `host`, `security`, `ask`, and `node` in ways older installs did not enforce consistently.
- **/btw reliability:** `/btw` side questions now explicitly disable provider reasoning on the affected path, fixing the no-response failure mode seen in some sessions.
- **Security hardening:** dangerous installs fail closed by default, trusted-proxy auth got stricter, and node commands/events are kept behind stronger pairing/approval boundaries.
- **Browser / MCP / CDP adjacent changes:** broader MCP/remote-server and transport work landed, but answers should still distinguish documented browser flows from source-observed transport details.
- **Other notable additions:** QQ Bot channel plugin, Slack exec approvals, WhatsApp reactions, Matrix proxy/history/thread controls, QMD extra collections, and OpenAI Responses verbosity forwarding.

**Practical note for this skill:** for 2026.3.31 answers, explicitly call out when behavior changed because detached/background runs are now more unified or because per-agent exec defaults are finally being enforced. Also warn when stricter security defaults may explain why an old workflow now asks for approval or fails closed.

---

### Version: 2026.3.24

**Key Changes in 2026.3.24:**
- **Gateway/OpenAI compatibility:** added `/v1/models` and `/v1/embeddings`, and improved forwarding of explicit model overrides through `/v1/chat/completions` and `/v1/responses`.
- **Tool visibility:** `/tools` and the Control UI now better reflect what the current agent can actually use right now.
- **Restart continuity:** restart-sentinel wake behavior improved, which matters for interrupted sessions after updates/restarts.
- **Outbound media / local files:** outbound media handling is more robust under the configured fs policy.
- **Runtime compatibility:** Node 22 floor lowered to 22.14+, reducing self-update/version-floor surprises on Node 22 installs.
- **Channel fixes:** multiple Telegram/Discord/Slack fixes landed, but the most relevant local impact remains improved delivery and routing behavior rather than a config migration.

**Practical note for this skill:** for 2026.3.24 answers, call out the new OpenAI-compatible gateway API surface, the stronger tool-availability visibility, and the improved restart/media behavior when those topics are relevant.

---

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

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

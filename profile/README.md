# Mighty & True

> AI-powered strategy and content systems for B2B marketers

We build AI-powered tools, content automation, and marketing infrastructure for B2B technology companies — from messaging frameworks to newsletter pipelines to podcast publishing systems.

---

## Active Projects

| Project | Status | Description |
|---------|--------|-------------|
| n8n-automations | `live` | n8n workflow automations — drag-and-drop newsletter pipeline (WF1–WF4), LaunchPod podcast publishing, LinkedIn posts, and client Slack bots. |
| [site-analyzer](https://site-analyzer.mightyandtrue.com) | `live` | SEO/AEO audit tool producing client-ready PDF reports with CWV data and radar charts. |
| [solutions-messaging-os](https://messaging.mightyandtrue.com) | `live` | AI-powered Solutions Messaging Framework builder for M&T strategists with competitive analysis. |
| marketing-intel | `local-only` | Messaging quality analysis + buyer voice matching via review mining (Trustpilot, Reddit, Serper). |
| automated-event-outbound | `in-progress` | Reusable AI-powered event/conference outbound system. First campaign — B2BMX 2026. |

---

## Getting Started (New Developers)

1. Accept the GitHub org invite and enable 2FA on your account
2. Clone the repo(s) you're working on — access is via the `developers` team
3. Copy `.env.example` to `.env` and fill in values (get secrets from Kevin)
4. Each repo has a `CLAUDE.md` — read it before touching code

**Branch workflow:**
```
git checkout -b your-name/feature-description
# make changes
git push origin your-name/feature-description
# open a PR against main — 1 approval required to merge
```

Never push directly to `main`. Branch protection is enforced on all repos.

---

## Infrastructure

| Resource | Details |
|----------|---------|
| n8n | [https://n8n.mightyandtrue.com](https://n8n.mightyandtrue.com) |
| Database | Supabase PostgreSQL (shared instance, project-prefixed tables) |
| Hosting | DigitalOcean (Python web apps via systemd + Caddy) |
| Default AI model | `claude-sonnet-4-6` |

Deploy instructions and server details are in each project's `CLAUDE.md`.

---

## AI Development Conventions

**Model selection**
- **Haiku** (`claude-haiku-4-5-20251001`): structured extraction, classification, scoring, JSON tasks
- **Sonnet** (`claude-sonnet-4-6`): analysis, narrative, reasoning, generation, debugging
- **Extended thinking**: expensive — keep togglable via env var, off by default

**Prompt engineering**
- Separate system prompts (role + constraints) from user prompts (data + task)
- Always specify output format explicitly — JSON schema, field names, types
- For JSON extraction: instruct the model to return only valid JSON, no prose wrapping
- Version your prompts — treat prompt changes like code changes

**Cost & reliability**
- Cache aggressively: Supabase `*_cache` tables or in-memory dict
- Log token usage in production to catch regressions
- Never trust LLM output structure blindly — parse with try/except, fall back gracefully
- Always set explicit timeouts on Anthropic API calls
- Stream AI responses via SSE — never make users wait on a blank screen

---

## Project Conventions

**Environment variables**
- Prefix with project identifier: `SA_`, `SMO_`, `MI_`
- Always maintain `.env.example` with every variable documented
- Production `.env` on the server only — never in the repo

**Database**
- Table names prefixed by project (e.g. `smo_projects`, `curated_items`)
- Always include `created_at TIMESTAMPTZ DEFAULT NOW()` on all tables
- Enable Supabase RLS before any table is exposed to a web-facing app
- Migrations as numbered SQL files in `migrations/`

**n8n gotchas**
- Nodes returning 0 items silently stop the chain — add `alwaysOutputData: true` on read nodes
- `pairedItem` tracking breaks through Google Drive download nodes — use `$('Node').all()[$itemIndex]`
- n8n API `PUT` requires `settings` field in payload or it returns 400

**Security**
- Web apps bind to `127.0.0.1` — Caddy handles SSL termination + reverse proxy
- RLS enabled on all Supabase tables used by web-facing apps
- Never commit secrets — use `.env` files (gitignored)

**CLAUDE.md files**
Every repo includes a `CLAUDE.md` with: purpose, current phase, stack, key file locations, active constraints, and known gotchas.

---

## Supabase Tables

| Project | Tables |
|---------|--------|
| Newsletter | `curated_items`, `editions`, `cta_rotation`, `takes` |
| SMO | `smo_projects`, `smo_intake_materials`, `smo_competitors`, `smo_frameworks`, `smo_competitive_matrix`, `smo_manifestos`, `smo_edit_history` |
| Marketing Intel | `mi_analyses`, `mi_cache` |

---

*Auto-generated from `profile/org.yaml`. Edit that file — not this one.*
*Last updated: 2026-02-27*

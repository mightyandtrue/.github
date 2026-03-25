# Mighty & True

> AI-powered strategy and content systems for B2B marketers

We build AI-powered tools, content automation, and marketing infrastructure for B2B technology companies — from messaging frameworks to newsletter pipelines to podcast publishing systems.

---

## Infrastructure

| Resource | Value |
|----------|-------|
| n8n | [https://n8n.mightyandtrue.com](https://n8n.mightyandtrue.com) |
| Droplet | `` (DigitalOcean) |
| Database | Supabase PostgreSQL (shared instance, project-prefixed tables) |
| Database -- Front-End | Vercel |
| Domain Hosting | godaddy |
| Default AI model | `claude-sonnet-4-6` |

**Deploy pattern (Python web apps):**
```bash
ssh  "cd /opt/apps/<project> && git pull origin main && chown -R www-data:www-data /opt/apps/<project> && systemctl restart <service>"
```

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
- Production `.env` on the droplet only — never in the repo

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
- Web apps bind to `127.0.0.1` — nginx handles SSL termination + reverse proxy
- RLS enabled on all Supabase tables used by web-facing apps
- All web apps behind Basic Auth before sharing with clients

**CLAUDE.md files**
Every repo includes a `CLAUDE.md` with: purpose, current phase, stack, key file locations, active constraints, and known gotchas. This gives AI coding tools persistent context across sessions without re-explaining architecture.
---

*Auto-generated from `profile/org.yaml`. Edit that file — not this one.*
*Last updated: 2026-03-21 16:24 UTC*

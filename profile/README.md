# Mighty & True

> AI-powered strategy and content systems for B2B marketers

We build AI-powered tools, content automation, and marketing infrastructure for B2B technology companies — from messaging frameworks to newsletter pipelines to podcast publishing systems.


---

## Active Projects

| Project | Status | Description |
|---------|--------|-------------|
| mt-chief-of-staff | `live` | Personal AI assistant hub-and-spoke on n8n — calendar, tasks, meetings, email, and strategy spokes. |
| mt-proofs | `live` | Creative proofing platform — client-facing review and approval for M&T deliverables. |
| mt-n8n-automations | `live` | n8n workflow automations — drag-and-drop newsletter pipeline (WF1–WF4), LaunchPod podcast publishing, LinkedIn posts, and client Slack bots. |
| [mt-site-analyzer](https://site-analyzer.mightyandtrue.com) | `live` | SEO/AEO audit tool producing client-ready PDF reports with CWV data and radar charts. |
| [solutions-messaging-os](https://messaging.mightyandtrue.com) | `live` | AI-powered Solutions Messaging Framework builder for M&T strategists with competitive analysis. |
| brandsentry-ai | `in-progress` | AI-powered brand compliance and QA engine. |
| flowos-api | `in-progress` | Mighty & True platform APIs — backbone for the FlowOS customer dashboard. |
| marketing-intel | `local-only` | Messaging quality analysis + buyer voice matching via review mining (Trustpilot, Reddit, Serper). |
| automated-event-outbound | `in-progress` | Reusable AI-powered event/conference outbound system. First campaign — B2BMX 2026. |

---

## Developer Workflow

New repo: run `/start` in Claude Code — scaffolds from `mt-template`, sets naming conventions, creates a feature branch.
Ship work: run `/ship` — commits, pushes, and opens a PR.

Every repo includes a `CLAUDE.md` with project context so AI tools have persistent state across sessions.

**Full guide:** [mt-engineering-handbook](https://github.com/mightyandtrue/mt-engineering-handbook) — naming conventions, repo setup, CI workflows, security standards.

---

## Infrastructure

| Resource | Value |
|----------|-------|
| n8n | [https://n8n.mightyandtrue.com](https://n8n.mightyandtrue.com) |
| Database | Supabase PostgreSQL (shared instance, project-prefixed tables) |
| Hosting | DigitalOcean droplet + Vercel (frontend) |
| Domain | GoDaddy |
| Default AI model | `claude-sonnet-4-6` |

---

## AI Model Reference

| Model | Use for |
|-------|---------|
| Haiku (`claude-haiku-4-5-20251001`) | Extraction, classification, scoring, JSON tasks |
| Sonnet (`claude-sonnet-4-6`) | Analysis, reasoning, generation, debugging |

Extended thinking is expensive — keep togglable via env var, off by default.

---

*Auto-generated from `profile/org.yaml`. Edit that file — not this one.*
*Last updated: 2026-03-25 14:25 UTC*

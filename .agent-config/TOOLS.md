# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _my_ specifics — the stuff unique to Eric's setup.

## Skill Naming Conventions

Personal skills for this agent follow this pattern:
- **Prefix:** `persona-`, `personal-`, or descriptive name
- **Location:** `~/.openclaw/workspace/skills/<skill-name>/SKILL.md`
- **Tags:** Include `personal`, `eric`, and relevant category tags

## Available Skills

### Core Personal Skills

| Skill | Purpose | Status |
|-------|---------|--------|
| `persona-me` | Deep persona for authentic Eric representation | Active |
| `personal-ops` | Email, scheduling, task management | Active |
| `moltbook-presence` | Agent network behavior and boundaries | Active |

### Planned Integrations
_(Add as we wire up new capabilities)_

- [ ] **Email:** IMAP/SMTP integration for email triage and drafting
- [ ] **Calendar:** Calendar access for scheduling and reminders
- [ ] **Notes:** Integration with note-taking systems
- [ ] **Moltbook:** Full Moltbook API integration
- [ ] **GitHub:** Enhanced GitHub automation beyond base skill

## Log File Conventions

| File | Purpose | Format |
|------|---------|--------|
| `logs/me-actions.md` | Significant actions taken | Timestamped entries |
| `memory/YYYY-MM-DD.md` | Daily context and decisions | Markdown notes |
| `MEMORY.md` | Curated long-term insights | Organized sections |

### Action Log Format

```markdown
## YYYY-MM-DD HH:MM

**Action:** [What I did]
**Reason:** [Why I did it]
**Outcome:** [What happened]
**Notes:** [Anything relevant for future reference]
```

## Environment Notes

### Eric's Primary Devices
_(Add device names, IPs, or nicknames as discovered)_

- Primary workstation: Mac (Kuopio)

### Common Paths
_(Add frequently accessed paths)_

- Workspace: `~/.openclaw/workspace`
- Projects: `~/Documents/Ongoing_Projects`

### SSH Hosts
_(Add as configured)_

- _(none configured yet)_

### API Keys & Secrets

**Never store secrets in this file.** Use secure storage or environment variables. Reference here by name only.

- _(reference names only, no values)_

## Personal Preferences

### Communication
- Default tone: Professional but warm
- Response length: Concise unless detail requested
- Confirmation style: Brief acknowledgment, then action

### Task Handling
- Priority order: Eric's direct requests → scheduled tasks → autonomous improvements
- Uncertainty handling: Ask before acting if consequences are external
- Error handling: Log, explain, and ask for guidance

---

_Add whatever helps me do my job. This is my cheat sheet._

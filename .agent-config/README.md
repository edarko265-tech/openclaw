# Agent Configuration Files

This directory contains the bootstrap files for your OpenClaw agent. These files define the agent's personality, identity, and behavior.

## Files

- **AGENTS.md** - Repository guidelines and project-specific instructions
- **SOUL.md** - Agent personality, communication style, and core behavior
- **TOOLS.md** - Tool usage guidelines and preferences
- **IDENTITY.md** - Agent identity and role definition
- **USER.md** - User preferences and interaction style
- **MEMORY.md** - Long-term memory and context retention rules
- **HEARTBEAT.md** - Periodic task reminders and scheduled actions

## Usage

### On New Installation

After cloning the repo and installing OpenClaw, copy these files to your workspace:

```bash
# Copy all bootstrap files to the workspace
cp .agent-config/*.md ~/.openclaw/workspace/

# Or during onboarding, the system will detect and use these files
```

### On Raspberry Pi

After cloning to your Pi:

```bash
# Ensure workspace directory exists
mkdir -p ~/.openclaw/workspace/

# Copy configuration files
cp .agent-config/*.md ~/.openclaw/workspace/

# Then proceed with building and running OpenClaw
```

## Important Notes

- These files are **loaded into the agent's system prompt** at runtime
- Modifications here will affect the agent's behavior globally
- Keep sensitive information out of these files (use `.env` for secrets)
- The actual workspace files are in `~/.openclaw/workspace/` (gitignored)
- This directory is a **template/backup** for bootstrapping new installations

## Customization

Edit these files to customize your agent's:
- Personality and tone
- Tool preferences
- Memory retention strategies
- Project-specific guidelines
- User interaction patterns

After editing, copy to `~/.openclaw/workspace/` and restart the gateway.

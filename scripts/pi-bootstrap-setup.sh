#!/bin/bash
# OpenClaw Pi Bootstrap Setup Script
# This script sets up the agent configuration after cloning the repo

set -e

echo "🚀 OpenClaw Pi Bootstrap Setup"
echo "================================"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Ensure workspace directory exists
echo -e "${BLUE}📁 Creating workspace directory...${NC}"
mkdir -p ~/.openclaw/workspace/

# Copy agent configuration files
echo -e "${BLUE}📋 Copying agent configuration files...${NC}"
if [ -d ".agent-config" ]; then
    cp .agent-config/*.md ~/.openclaw/workspace/ 2>/dev/null || true
    echo -e "${GREEN}✓ Agent configuration files copied${NC}"
else
    echo -e "${YELLOW}⚠️  .agent-config directory not found. Agent will use defaults.${NC}"
fi

# List what was copied
echo ""
echo -e "${BLUE}📄 Bootstrap files in workspace:${NC}"
ls -1 ~/.openclaw/workspace/*.md 2>/dev/null || echo "No .md files found"

echo ""
echo -e "${GREEN}✅ Bootstrap setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Copy your .env file to the project root (if not already done)"
echo "2. Install dependencies: pnpm install"
echo "3. Build the project: pnpm build"
echo "4. Run onboarding: openclaw onboard --install-daemon"
echo ""
echo "The agent will now have your personality and configuration! 🎉"

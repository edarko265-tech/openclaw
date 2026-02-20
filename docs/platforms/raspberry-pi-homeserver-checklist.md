---
title: "Pi 5 Homeserver Setup Checklist"
summary: "Quick reference checklist for Raspberry Pi 5 homeserver setup"
---

# Raspberry Pi 5 Homeserver Setup Checklist

## Pre-Setup
- [ ] Raspberry Pi 5 (8GB recommended)
- [ ] 32GB+ MicroSD card or USB SSD
- [ ] Power supply and cables
- [ ] Network connection (Ethernet recommended)
- [ ] Desktop or laptop for SSH/VNC connections
- [ ] ~45 minutes of time

## Phase 1: OS Installation (5 min)
- [ ] Download Raspberry Pi Imager
- [ ] Select "Raspberry Pi OS (64-bit)" with desktop
- [ ] Set hostname: `gateway-host`
- [ ] Enable SSH ✅
- [ ] Set username/password
- [ ] Configure WiFi (if needed)
- [ ] Set timezone
- [ ] Flash to SD card/USB SSD
- [ ] Insert and boot Pi

## Phase 2: SSH Access & System Setup (10 min)
- [ ] SSH into Pi: `ssh username@gateway-host`
- [ ] Run: `sudo apt update && sudo apt upgrade -y`
- [ ] Run: `sudo apt install -y git curl build-essential`
- [ ] Install VNC: `sudo apt install -y realvnc-vnc-server`
- [ ] Enable VNC: `sudo systemctl enable vncserver-x11-serviced`
- [ ] Start VNC: `sudo systemctl start vncserver-x11-serviced`
- [ ] Set timezone: `sudo timedatectl set-timezone America/Chicago`

## Phase 3: VNC Configuration (5 min)
- [ ] Test VNC from laptop: `vnc://username@gateway-host:5900`
- [ ] Or use SSH tunnel: `ssh -L 5900:localhost:5900 username@gateway-host`
- [ ] Connect from VNC viewer to `localhost:5900`
- [ ] Verify desktop displays

## Phase 4: System Optimization (5 min)
- [ ] Add swap: Follow Step 8 in full guide
- [ ] Or quick setup: `sudo fallocate -l 4G /swapfile && sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile`
- [ ] Make permanent: `echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab`

## Phase 5: Node.js Installation (5 min)
- [ ] Run: `curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -`
- [ ] Run: `sudo apt install -y nodejs`
- [ ] Verify: `node --version` (should be v22.x.x)

## Phase 6: OpenClaw Installation (5 min)
- [ ] Run: `curl -fsSL https://openclaw.ai/install.sh | bash`
- [ ] OR dev install: `git clone https://github.com/openclaw/openclaw.git && cd openclaw && npm install && npm run build`

## Phase 7: OpenClaw Daemon Setup (5 min)
- [ ] Run: `openclaw onboard --install-daemon`
- [ ] Choose: `local` for gateway mode
- [ ] Choose: API keys for auth
- [ ] Add your channels (Telegram, Discord, etc.)
- [ ] Choose: `Yes` to install as daemon

## Phase 8: Verify Auto-Start (5 min)
- [ ] Check: `sudo systemctl status openclaw` (should be active/running)
- [ ] Check: `sudo systemctl is-enabled openclaw` (should be enabled)
- [ ] View logs: `journalctl -u openclaw -f`
- [ ] Test dashboard: `http://gateway-host:18789` or SSH tunnel to `http://localhost:18789`

## Phase 9: Power Loss Recovery Test (5 min)
- [ ] Manually stop service: `sudo systemctl stop openclaw`
- [ ] Verify it's stopped: `sudo systemctl status openclaw`
- [ ] Start it: `sudo systemctl start openclaw`
- [ ] Verify it's running: `sudo systemctl status openclaw`
- [ ] Optional: Physically unplug/replug Pi, wait 30 seconds, verify service starts

## Post-Setup Verification
- [ ] SSH works: `ssh username@gateway-host`
- [ ] VNC works: Can connect and see desktop
- [ ] Dashboard accessible: `http://gateway-host:18789`
- [ ] Service is enabled: `sudo systemctl is-enabled openclaw`
- [ ] Service auto-restarts on crash
- [ ] Service starts on boot after power loss

## Optional: Advanced Setup
- [ ] Enable Tailscale for remote access (see full guide)
- [ ] Set up UFW firewall
- [ ] Configure SSH key authentication
- [ ] Set up cron jobs for backups
- [ ] Switch to USB SSD for better performance
- [ ] Set up log rotation/monitoring

## Daily Operations
- [ ] Check status: `openclaw status`
- [ ] View logs: `sudo journalctl -u openclaw -n 20`
- [ ] Restart service: `sudo systemctl restart openclaw`
- [ ] Access VNC or SSH as needed

## Troubleshooting Commands

### Gateway Issues
```bash
journalctl -u openclaw -n 50        # View last 50 log lines
journalctl -u openclaw -f           # Follow logs in real-time
sudo systemctl restart openclaw     # Restart service
openclaw doctor                     # Run diagnostics
sudo systemctl status openclaw      # Check service status
```

### VNC Issues
```bash
sudo systemctl restart vncserver-x11-serviced  # Restart VNC
sudo systemctl status vncserver-x11-serviced   # Check VNC status
sudo ss -tlnp | grep 5900                      # Verify port listening
```

### SSH Issues
```bash
sudo systemctl restart ssh                     # Restart SSH
sudo systemctl status ssh                      # Check SSH status
ssh -vvv username@gateway-host                 # Verbose SSH debug
```

### Memory Issues
```bash
free -h                                        # Check memory
swapon --show                                  # Check swap
ps aux | grep openclaw                         # Check service memory
vcgencmd measure_temp                          # Check CPU temp
```

---

See the [full Raspberry Pi 5 Homeserver Setup Guide](/platforms/raspberry-pi-homeserver-setup) for detailed instructions.

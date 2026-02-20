---
summary: "Complete setup guide for Raspberry Pi 5 homeserver with VNC, SSH, and auto-start"
read_when:
  - Setting up Raspberry Pi 5 as a homeserver
  - Wanting VNC and SSH access to your Pi
  - Need auto-start on boot and power loss recovery
title: "Raspberry Pi 5 Homeserver Setup (VNC + SSH + Auto-Start)"
---

# Raspberry Pi 5 Homeserver Setup

Complete guide to set up your Raspberry Pi 5 as a homeserver running OpenClaw with both VNC and SSH access, plus automatic startup on boot and power recovery.

## Prerequisites

- Raspberry Pi 5 (8GB recommended)
- MicroSD card (32GB+ recommended) or USB SSD (preferred for better performance)
- Ethernet connection or WiFi
- ~45 minutes setup time

## 1) Flash Raspberry Pi OS with Desktop

Unlike the headless server setup, you'll want a desktop environment for VNC access:

1. Download [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Choose OS: **Raspberry Pi OS (64-bit)** (Full desktop version, not Lite)
3. Click the gear icon (⚙️) to pre-configure:
   - **Hostname:** `gateway-host` (or your preferred name)
   - **Enable SSH:** ✅ Check this
   - **Set username and password:** Create your user account
   - **Configure WiFi:** If using WiFi, set SSID and password
   - **Set timezone:** Your local timezone
4. Flash to your SD card / USB drive
5. Insert and boot the Pi

## 2) Initial SSH Connection

```bash
# From your laptop/desktop, SSH into the Pi
ssh username@gateway-host
# or use the IP address if hostname doesn't resolve
ssh username@192.168.x.x
```

## 3) System Update and Essential Packages

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y git curl build-essential

# Install VNC server (RealVNC is pre-installed but let's verify)
sudo apt install -y realvnc-vnc-server realvnc-vnc-viewer

# Verify timezone is set correctly
sudo timedatectl set-timezone America/Chicago  # Change to your timezone
timedatectl
```

## 4) Enable VNC Server

```bash
# Enable VNC at boot
sudo raspi-config

# OR use command line:
sudo systemctl enable vncserver-x11-serviced
sudo systemctl start vncserver-x11-serviced

# Verify it's running
sudo systemctl status vncserver-x11-serviced
```

If using `raspi-config`, navigate to:
- **Interfacing Options** → **VNC** → **Enable**

## 5) Configure VNC Resolution (Optional but Recommended)

By default, VNC uses the display resolution. For headless or optimal viewing:

```bash
# Edit the VNC config
sudo nano /etc/vnc/config.d/common.custom

# Add these lines to set a default resolution:
geometry=1920x1080

# Save (Ctrl+X, Y, Enter)
```

Alternatively, through raspi-config:
- **Display Options** → **Resolution** → Choose a resolution

Restart VNC:

```bash
sudo systemctl restart vncserver-x11-serviced
```

## 6) Connect via VNC

### From macOS (using built-in Screen Sharing):

```bash
# Open Finder → Go → Connect to Server
# Enter: vnc://username@gateway-host:5900
# Or use the IP: vnc://192.168.x.x:5900
```

### From Linux/Windows or via CLI:

```bash
# If you have a VNC viewer installed
# macOS
open "vnc://username@gateway-host:5900"

# Linux
vncviewer username@gateway-host:5900

# Windows
# Use RealVNC Viewer or similar (download from realvnc.com)
```

### Alternative: SSH Tunnel (if VNC port blocked by firewall)

```bash
# From your laptop
ssh -L 5900:localhost:5900 username@gateway-host

# Then connect to localhost:5900 in your VNC viewer
open "vnc://localhost:5900"
```

## 7) Install Node.js 22 (ARM64)

```bash
# Add NodeSource repository
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

# Install Node.js
sudo apt install -y nodejs

# Verify installation
node --version   # Should show v22.x.x
npm --version
```

## 8) Add Swap (Critical for Pi 5 Stability)

Even with 8GB, swap helps prevent OOM kills:

```bash
# Create 4GB swap file (adjust size as needed)
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Optimize swappiness (reduce reliance on swap)
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Verify
free -h
```

## 9) Install OpenClaw

### Recommended: Standard Install

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

### Alternative: Development Install (for tinkering)

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
npm install
npm run build
sudo npm link  # Make it globally available
```

## 10) Run Onboarding with Daemon Setup

```bash
openclaw onboard --install-daemon
```

Follow the wizard:

1. **Gateway mode:** Select `local` (runs on this Pi)
2. **Auth:** API keys recommended (OAuth can be finicky on Pi)
3. **Channels:** Add your channels (Telegram, Discord, etc.)
4. **Daemon:** When prompted to install as daemon, select **Yes** (systemd)

This will:
- Create your configuration
- Set up authentication
- Install a systemd service that starts on boot
- Start the OpenClaw gateway immediately

## 11) Verify Daemon Installation

```bash
# Check if the service exists
sudo systemctl status openclaw

# Check if it's enabled to start on boot
sudo systemctl is-enabled openclaw

# If not enabled, enable it
sudo systemctl enable openclaw

# View the service logs
journalctl -u openclaw -f

# Stop/start/restart the service manually
sudo systemctl restart openclaw
```

## 12) Access the Dashboard

### Option A: SSH Tunnel (Recommended for security)

```bash
# From your laptop
ssh -L 18789:localhost:18789 username@gateway-host

# Open in browser
open http://localhost:18789
```

### Option B: Direct (if on same network)

Find the Pi's IP and open:
```
http://gateway-host:18789
```
or
```
http://192.168.x.x:18789
```

### Option C: Tailscale (Always-on, secure remote access)

```bash
# Install Tailscale on Pi
curl -fsSL https://tailscale.com/install.sh | sh

# Authenticate
sudo tailscale up

# Configure OpenClaw to bind to Tailscale
openclaw config set gateway.bind tailnet

# Restart the service
sudo systemctl restart openclaw

# Find your Tailscale IP
sudo tailscale ip -4

# Access from anywhere
open http://<tailscale-ip>:18789
```

---

## Auto-Start Configuration

### What's Automatic

The onboarding wizard with `--install-daemon` flag sets everything up automatically:

- **systemd service created:** `/etc/systemd/system/openclaw.service`
- **Starts on boot:** Service is enabled
- **Auto-restart on crash:** Service is set to restart on failure
- **Runs as user:** Not root (safer)

### Verify Auto-Start Works

```bash
# Check if service is enabled
sudo systemctl is-enabled openclaw
# Should output: enabled

# If not enabled, enable it
sudo systemctl enable openclaw

# Simulate a reboot scenario
sudo systemctl stop openclaw
sudo systemctl start openclaw

# Check status
sudo systemctl status openclaw
```

### Manual Service Check

```bash
# View the actual service file
sudo systemctl cat openclaw

# Manually restart
sudo systemctl restart openclaw

# View live logs (watch logs as service starts)
sudo journalctl -u openclaw -f
```

### Power Loss Recovery

The systemd service will automatically:

1. **Start on boot** (after Pi powers back on)
2. **Auto-restart on crash** (if the service fails)
3. **Preserve state** (session data is saved to disk)

Your gateway will be fully operational within ~10 seconds after the Pi boots.

---

## Performance Optimization

### Use USB SSD (Huge Speed Boost)

SD cards are slow and wear out. Switch to a USB 3.0 SSD for dramatic improvements:

```bash
# Check current boot device
lsblk

# See Raspberry Pi USB boot guide:
# https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#usb-mass-storage-boot
```

### Reduce Memory Pressure

```bash
# Disable GPU memory allocation (if headless use only)
# Edit /boot/config.txt
sudo nano /boot/config.txt

# Add if not present:
gpu_mem=128  # or higher if you need it

# Disable Bluetooth if not needed
sudo systemctl disable bluetooth
sudo systemctl stop bluetooth

# Disable unnecessary services
sudo systemctl disable avahi-daemon cups
```

### Monitor Resources

```bash
# Check memory usage
free -h

# Check CPU temperature
vcgencmd measure_temp

# Live monitoring
sudo apt install -y htop
htop

# Check disk usage
df -h

# View service resource usage
systemctl status openclaw
```

---

## Troubleshooting

### Gateway Won't Start

```bash
# Check logs
journalctl -u openclaw -n 50  # Last 50 lines
journalctl -u openclaw -f     # Follow logs in real-time

# Check if port 18789 is in use
sudo lsof -i :18789

# Try manual restart
sudo systemctl restart openclaw
```

### VNC Connection Issues

```bash
# Verify VNC is running
sudo systemctl status vncserver-x11-serviced

# Restart VNC
sudo systemctl restart vncserver-x11-serviced

# Check if VNC is listening on port 5900
sudo netstat -tlnp | grep 5900
# or
sudo ss -tlnp | grep 5900

# If port not listening, restart the service
sudo systemctl restart vncserver-x11-serviced
```

### Out of Memory (OOM) Errors

```bash
# Check memory
free -h

# Check swap
swapon --show

# If no swap or low on space, add more:
# See Step 8 above

# View OpenClaw memory usage
ps aux | grep openclaw
```

### SSH Won't Connect

```bash
# Verify SSH is running
sudo systemctl status ssh

# Restart SSH
sudo systemctl restart ssh

# Check SSH logs
sudo journalctl -u ssh -f
```

### After Power Loss, Gateway Doesn't Start

```bash
# Check systemd logs
sudo journalctl -u openclaw --since "5 minutes ago"

# Verify service is enabled
sudo systemctl is-enabled openclaw

# Try manual start
sudo systemctl start openclaw

# Check status
sudo systemctl status openclaw
```

---

## Recommended Configuration

For optimal Pi homeserver performance:

### models.json

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-sonnet-4-20250514",
        "fallbacks": ["openai/gpt-4o-mini", "openai/gpt-4o"]
      }
    }
  }
}
```

**Don't run local LLMs** — they're too slow on Pi. Let Claude/GPT handle the computation; the Pi just needs network access.

### Cron Jobs (Optional)

You can set up automated tasks to run on your Pi:

```bash
# Edit crontab
crontab -e

# Example: Restart gateway daily at 2 AM
0 2 * * * sudo systemctl restart openclaw

# Example: Backup credentials weekly
0 3 * * 0 tar -czf ~/backups/openclaw-creds-$(date +\%Y\%m\%d).tar.gz ~/.openclaw/credentials/
```

See [Cron Jobs Guide](/automation/cron-jobs) for more details.

---

## Daily Operations

### Check Status

```bash
# Quick status check
openclaw status

# Full system check
openclaw doctor

# View daemon logs
sudo journalctl -u openclaw -n 20
```

### Remote Management

**SSH:** Full command-line access for configuration and debugging

**VNC:** Desktop GUI access for visual debugging and system administration

**Web Dashboard:** OpenClaw UI accessible at `http://gateway-host:18789`

### Adding New Channels

All configuration changes through `openclaw config` or the web dashboard will persist. Just restart the service:

```bash
sudo systemctl restart openclaw
```

---

## Security Considerations

1. **SSH Key Authentication** (Recommended over password)
   ```bash
   ssh-copy-id -i ~/.ssh/id_rsa username@gateway-host
   ```

2. **Disable Root SSH**
   ```bash
   sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
   sudo systemctl restart ssh
   ```

3. **Use Tailscale** instead of exposing ports to the internet

4. **Regular Updates**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

5. **Firewall (ufw)**
   ```bash
   sudo apt install -y ufw
   sudo ufw default deny incoming
   sudo ufw default allow outgoing
   sudo ufw allow ssh
   sudo ufw allow 18789/tcp  # OpenClaw dashboard
   sudo ufw enable
   ```

---

## Next Steps

1. ✅ Flash OS → SSH → Setup done
2. ✅ Enable VNC and test connection
3. ✅ Install OpenClaw and run onboarding with `--install-daemon`
4. ✅ Verify systemd service and auto-start
5. ✅ Test power cycle (unplug/replug) to verify recovery
6. 📱 Start using: Send messages to your channels
7. 🔧 Configure: Add more channels, customize settings
8. 🎯 Automate: Set up cron jobs for backups/restarts

---

## References

- [Raspberry Pi Official Docs](https://www.raspberrypi.com/documentation/)
- [Raspberry Pi VNC Setup](https://www.raspberrypi.com/documentation/computers/remote-access.html#vnc)
- [OpenClaw Pi Guide](/platforms/raspberry-pi)
- [OpenClaw Gateway Configuration](/gateway/configuration)
- [Cron Jobs Setup](/automation/cron-jobs)
- [Tailscale for Remote Access](/gateway/tailscale)

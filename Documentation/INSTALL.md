# Installation Guide

Complete installation instructions for grubvix on all supported Linux distributions.

---

## 🚀 Quick Install (All Distributions)

```bash
# 1. Clone the repository
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix

# 2. Make the script executable
chmod +x grubvix.sh

# 3. Run it!
sudo ./grubvix.sh -h
```

That's it! grubvix is ready to use.

---

## 📦 Distribution-Specific Instructions

### Ubuntu / Debian / Linux Mint / Pop!_OS

```bash
# Install dependencies (if needed)
sudo apt update
sudo apt install grub2 fonts-dejavu-core

# Clone grubvix
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix
chmod +x grubvix.sh

# Test it
sudo ./grubvix.sh -l
```

### Arch Linux / Manjaro / EndeavourOS

```bash
# Install dependencies (if needed)
sudo pacman -S grub ttf-dejavu

# Clone grubvix
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix
chmod +x grubvix.sh

# Test it
sudo ./grubvix.sh -l
```

### Fedora / RHEL / CentOS / Rocky Linux / AlmaLinux

```bash
# Install dependencies (if needed)
sudo dnf install grub2-tools liberation-fonts

# Clone grubvix
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix
chmod +x grubvix.sh

# Test it
sudo ./grubvix.sh -l
```

### openSUSE (Leap / Tumbleweed)

```bash
# Install dependencies (if needed)
sudo zypper install grub2 dejavu-fonts

# Clone grubvix
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix
chmod +x grubvix.sh

# Test it
sudo ./grubvix.sh -l
```

### Gentoo

```bash
# Install dependencies (if needed)
sudo emerge grub media-fonts/dejavu

# Clone grubvix
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix
chmod +x grubvix.sh

# Test it
sudo ./grubvix.sh -l
```

---

## 🔧 Optional: System-Wide Installation

To make grubvix available system-wide:

### Method 1: Symbolic Link (Recommended)

```bash
# Create symlink in /usr/local/bin
sudo ln -s $(pwd)/grubvix.sh /usr/local/bin/grubvix

# Now you can run from anywhere:
sudo grubvix -l
```

### Method 2: Copy to PATH

```bash
# Copy to system directory
sudo cp grubvix.sh /usr/local/bin/grubvix
sudo chmod +x /usr/local/bin/grubvix

# Run from anywhere:
sudo grubvix -l
```

### Method 3: Add to PATH

```bash
# Add grubvix directory to PATH
echo 'export PATH="$PATH:$HOME/grubvix"' >> ~/.bashrc
source ~/.bashrc

# Run from anywhere:
sudo ./grubvix.sh -l
```

---

## ✅ Verify Installation

### Test 1: Check Help Menu

```bash
./grubvix.sh -h
```

**Expected:** Colorful help menu with ASCII art

### Test 2: List Themes

```bash
./grubvix.sh -l
```

**Expected:** List of built-in themes (or message if none)

### Test 3: Check Dependencies

```bash
sudo ./grubvix.sh -b
```

**Expected:** System check passes, backup created

---

## 🐛 Troubleshooting

### "Permission denied"

```bash
# Solution: Make script executable
chmod +x grubvix.sh
```

### "Must be run as root"

```bash
# Solution: Use sudo
sudo ./grubvix.sh -t mytheme
```

### "Could not find update-grub"

```bash
# Solution: Install GRUB tools

# Ubuntu/Debian:
sudo apt install grub2

# Arch:
sudo pacman -S grub

# Fedora:
sudo dnf install grub2-tools
```

### "Git command not found"

```bash
# Solution: Install git

# Ubuntu/Debian:
sudo apt install git

# Arch:
sudo pacman -S git

# Fedora:
sudo dnf install git
```

### "Font not found"

```bash
# Solution: Install fonts

# Ubuntu/Debian:
sudo apt install fonts-dejavu-core

# Arch:
sudo pacman -S ttf-dejavu

# Fedora:
sudo dnf install liberation-fonts
```

### Script runs but themes don't apply

```bash
# Check GRUB is installed:
which grub-mkconfig || which grub2-mkconfig || which update-grub

# Check GRUB config exists:
ls /boot/grub/grub.cfg || ls /boot/grub2/grub.cfg

# Manually update GRUB:
sudo update-grub
# or
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 🔄 Updating grubvix

### Method 1: Git Pull (If cloned)

```bash
cd grubvix
git pull origin main
```

### Method 2: Re-download

```bash
# Backup your custom themes
cp -r grubvix/Themes ~/grubvix-themes-backup

# Remove old version
rm -rf grubvix

# Clone new version
git https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix
chmod +x grubvix.sh

# Restore custom themes
cp -r ~/grubvix-themes-backup/* Themes/
```

---

## 🗑️ Uninstalling

### Remove grubvix script

```bash
# If installed system-wide
sudo rm /usr/local/bin/grubvix

# Remove repository
cd ~
rm -rf grubvix
```

### Restore default GRUB

```bash
# Before uninstalling, restore default theme
sudo ./grubvix.sh -d

# Or manually:
sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub
sudo update-grub
```

### Remove backups (optional)

```bash
sudo rm -rf /var/backups/grubvix
```

---

## 🔐 Security Considerations

### Script Permissions

grubvix requires root access because it:
- Modifies `/etc/default/grub`
- Copies files to `/boot/grub/themes/`
- Runs `update-grub` or `grub-mkconfig`

**Always review scripts before running with sudo!**

### Verify Source

```bash
# Download from official repository only
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git

# Verify script integrity (optional)
sha256sum grubvix.sh
```

### Check Script Contents

```bash
# Review the script before first use
less grubvix.sh

# Or open in your editor
nano grubvix.sh
```

---

## 💡 Post-Installation Tips

### Add Custom Themes

```bash
# Create a new theme directory
mkdir -p Themes/my-custom-theme

# Add your theme files
cp /path/to/theme.txt Themes/my-custom-theme/
cp /path/to/background.png Themes/my-custom-theme/

# Apply it
sudo ./grubvix.sh -t my-custom-theme
```

### Backup Your Configuration

```bash
# Create manual backup
sudo ./grubvix.sh -b

# Backups are stored in:
ls /var/backups/grubvix/
```

### Test Themes Safely

```bash
# Apply theme
sudo ./grubvix.sh -t test-theme

# Reboot and check

# If you don't like it:
sudo ./grubvix.sh -d  # Restore default
```

---

## 📚 Next Steps

After installation:

1. **Read the documentation**
   ```bash
   cat README.md
   ```

2. **Explore examples**
   ```bash
   cat USAGE_EXAMPLES.md
   ```

3. **List available themes**
   ```bash
   ./grubvix.sh -l
   ```

4. **Apply your first theme**
   ```bash
   sudo ./grubvix.sh -t mytheme
   ```

5. **Customize resolution/font**
   ```bash
   sudo ./grubvix.sh -r 1920x1080 -f 24
   ```

---

## 🆘 Getting Help

- **GitHub Issues**: Report bugs or ask questions
- **Documentation**: Check README.md and other docs
- **Examples**: See USAGE_EXAMPLES.md
- **Compatibility**: Check COMPATIBILITY.md for your distro

---

**Enjoy your beautiful GRUB bootloader!** 🎨

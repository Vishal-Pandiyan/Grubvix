# Grubvix - GRUB Theme Manager CLI

A professional, production-ready command-line utility for managing GRUB bootloader themes on Linux systems with a stunning modern terminal UI.

![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)
![Bash](https://img.shields.io/badge/bash-5.0%2B-green.svg)
![Platform](https://img.shields.io/badge/platform-linux-lightgrey.svg)

## Features

✨ **Built-in Theme Collection**
- Curated GRUB themes bundled with grubvix
- Ready to use out of the box

🛡️ **Safety First**
- Automatic backups before any changes
- Comprehensive validation
- Clear error messages
- Rollback capability

⚙️ **Advanced Configuration**
- Custom resolution settings
- Font size management
- Theme restoration
- Professional CLI interface

🎨 **Unique Terminal UI**
- 256-color support with electric blue branding
- Animated spinners and progress bars
- Unicode box drawing characters
- Real-time visual feedback

## 🌐 Installation 

1. Clone the repository:
```bash
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix
```

2. Make the script executable:
```bash
chmod +x grubvix.sh
```

3. (Optional) Create a symlink for system-wide access:
```bash
sudo ln -s $(pwd)/grubvix.sh /usr/local/bin/grubvix
```

## Usage

### Basic Commands

**Apply a built-in theme:**
```bash
sudo ./grubvix.sh -t mytheme
```

**List available built-in themes:**
```bash
sudo ./grubvix.sh -l
```

**Restore default GRUB theme:**
```bash
sudo ./grubvix.sh -d
```

**Show help:**
```bash
./grubvix.sh -h
```

### Advanced Usage

**Apply theme from local path:**
```bash
sudo ./grubvix.sh -t mytheme -p /path/to/theme/folder
```

**Set GRUB resolution:**
```bash
sudo ./grubvix.sh -r 1920x1080
```

**Set GRUB font size:**
```bash
sudo ./grubvix.sh -f 24
```

**Apply theme with custom resolution and font:**
```bash
sudo ./grubvix.sh -t mytheme -r 2560x1440 -f 32
```

**Create backup manually:**
```bash
sudo ./grubvix.sh -b
```

The `theme.txt` file is mandatory and contains GRUB theme specifications.

## 🔖Command Reference

| Flag | Description | Example |
|------|-------------|---------|
| `-t NAME` | Apply theme | `-t mytheme` |
| `-p PATH` | Use local path | `-p /home/user/themes/custom` |
| `-l` | List built-in themes | `-l` |
| `-d` | Restore default theme | `-d` |
| `-r WxH` | Set resolution | `-r 1920x1080` |
| `-f SIZE` | Set font size | `-f 24` |
| `-b` | Create backup | `-b` |
| `-h` | Show help | `-h` |

## Requirements

- **Operating System**: Linux (any distribution with GRUB/GRUB2)
- **Privileges**: Root/sudo access required
- **Dependencies**:
  - `grub-mkconfig`, `grub2-mkconfig`, or `update-grub`
  - `grub-mkfont` or `grub2-mkfont` (for font size changes)

### ✅ Supported Distributions

grubvix works on **99% of Linux distributions** including:

**Debian-based:** Ubuntu, Debian, Linux Mint, Pop!_OS, Elementary OS, Kali Linux  
**Arch-based:** Arch Linux, Manjaro, EndeavourOS, Garuda Linux  
**RHEL-based:** Fedora, RHEL, CentOS, Rocky Linux, AlmaLinux  
**Others:** openSUSE, Gentoo, Void Linux, Solus, NixOS

The script automatically detects your distribution and uses the appropriate GRUB commands.

Read the [System Compatibility](Documentation/COMPATIBILITY.md) for detailed guidelines

## 🗃️ Backup and Recovery

### Automatic Backups

grubvix automatically creates backups before making any changes:
- Location: `/var/backups/grubvix/`
- Format: `grub_YYYYMMDD_HHMMSS.bak`

### Manual Restore

To manually restore a backup:
```bash
sudo cp /var/backups/grubvix/grub_20240101_120000.bak /etc/default/grub
sudo update-grub
```

## Supported Resolutions

Common GRUB resolutions:
- `1920x1080` (Full HD)
- `2560x1440` (2K)
- `3840x2160` (4K)
- `1366x768` (HD)
- `1280x720` (HD)

## ⚙️ Troubleshooting

**Theme doesn't appear after reboot:**
- Ensure theme files are valid
- Check `/boot/grub/themes/` for installed theme
- Verify `/etc/default/grub` contains `GRUB_THEME` entry
- Run `sudo update-grub` manually

**Font size not changing:**
- Ensure DejaVu or Liberation fonts are installed
- Check `/boot/grub/fonts/` for generated font file
- Verify GRUB supports custom fonts

**Permission denied errors:**
- Always run with `sudo`
- Check file permissions on theme directories

## 📦 Bundled Themes

grubvix includes curated GRUB themes. See `Themes/README.md` for:
- List of bundled themes
- Theme credits and licenses
- How to add your own themes

**All bundled themes are GPL-3.0 licensed** (or compatible licenses).

## 👥 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Read the [Contributing Guide](CONTRIBUTING.md) for detailed guidelines.

## Useful Links 📌
- 📦 [Installation Guide](Documentation/INSTALL.md) – Step-by-step setup instructions   
- 💡 [Usage Examples](Documentation/USAGE_EXAMPLES.md) – Real command examples for common tasks
- 🖥️ [System Compatibility](Documentation/COMPATIBILITY.md) – Supported distros, GRUB versions, and requirements
- 🙌 [Credits & Attributions](Themes/CREDITS.md) – Theme authors and third-party resources  
- 📝 [Changelog](CHANGELOG.md) – Version history and updates


## ⚖️ License 

This project is licensed under the **GNU General Public License v3.0** - see the [LICENSE](LICENSE) file for details.

### What This Means:

✅ **You can:**
- Use grubvix freely
- Modify the source code
- Distribute copies
- Use commercially

⚠️ **You must:**
- Keep the GPL-3.0 license
- Provide source code when distributing
- State changes made to the code
- Use GPL-3.0 for derivative works

### 📦 Bundled Themes

All themes in the `Themes/` directory are GPL-3.0 licensed (or compatible open-source licenses). See `Themes/CREDITS.md` for attribution to original theme creators.

## ✨ Acknowledgments

- GRUB development team
- Linux community
- Theme creators (see `Themes/CREDITS.md`)
- Contributors to grubvix

## 🏷️ Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check existing issues for solutions
- Read the documentation

---

**Note 📝**: Always backup important data before modifying bootloader configuration. While grubvix includes safety features, bootloader modifications should be performed with caution.

**Made with ♥ for Linux**
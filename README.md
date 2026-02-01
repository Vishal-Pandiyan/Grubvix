# Grubvix - GRUB Theme Manager CLI

A professional, production-ready command-line utility for managing GRUB bootloader themes on Linux systems.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Bash](https://img.shields.io/badge/bash-5.0%2B-green.svg)
![Platform](https://img.shields.io/badge/platform-linux-lightgrey.svg)

## Features

✨ **Multiple Theme Sources**
- Built-in themes from repository
- Local filesystem paths
- Remote Git repositories

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

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Vishal-Pandiyan/Grubvix.git
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
sudo ./grubvix.sh -t theme-name
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
sudo ./grubvix.sh -t theme-name -p /path/to/theme/folder
```

**Apply theme from Git repository:**
```bash
sudo ./grubvix.sh -t them-ename -g [Git url]
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
sudo ./grubvix.sh -t theme-name -r 2560x1440 -f 32
```

**Create backup manually:**
```bash
sudo ./grubvix.sh -b
```

## Theme Structure

Each theme must follow this structure:

```
theme-name/
├── theme.txt           # Required: GRUB theme configuration
├── background.png      # Optional: Background image
├── icons/              # Optional: Icon directory
└── fonts/              # Optional: Custom fonts
```

The `theme.txt` file is mandatory and contains GRUB theme specifications.

## Command Reference

| Flag | Description | Example |
|------|-------------|---------|
| `-t NAME` | Apply theme | `-t theme-name` |
| `-p PATH` | Use local path | `-p /home/user/themes/custom` |
| `-g URL` | Use Git repository | `-g https://github.com/user/theme.git` |
| `-l` | List built-in themes | `-l` |
| `-d` | Restore default theme | `-d` |
| `-r WxH` | Set resolution | `-r 1920x1080` |
| `-f SIZE` | Set font size | `-f 24` |
| `-b` | Create backup | `-b` |
| `-h` | Show help | `-h` |

## Requirements

- **Operating System**: Linux (any distribution with GRUB)
- **Privileges**: Root/sudo access required
- **Dependencies**:
  - `grub-mkconfig` or `update-grub`
  - `grub-mkfont` (for font size changes)
  - `git` (for Git repository theme installation)

## Backup and Recovery

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

## Troubleshooting

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

**Git clone fails:**
- Verify Git is installed: `sudo apt install git`
- Check internet connection
- Verify repository URL is correct

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- GRUB development team
- Linux community
- Theme creators

## Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check existing issues for solutions
- Read the documentation

---

**Note**: Always backup important data before modifying bootloader configuration. While grubvix includes safety features, bootloader modifications should be performed with caution.

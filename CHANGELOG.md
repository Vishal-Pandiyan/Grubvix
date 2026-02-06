# Changelog

All notable changes to grubvix will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Version [2.0.0] Updated on 2026-02-06

### ⚖️ LICENSE CHANGE: MIT → GPL-3.0

**IMPORTANT:** grubvix has changed from MIT to GPL-3.0 license.

**Reason:** To legally bundle GPL-3.0 licensed GRUB themes in the repository for user convenience.

**What this means:**
- ✅ You can still use, modify, and distribute grubvix
- ✅ Bundled themes are now included (no separate downloads needed)
- ⚠️ Derivatives must also be GPL-3.0 (copyleft requirement)

See LICENSE file for full GPL-3.0 text.

### Added

- **GPL-3.0 License** - Changed from MIT to GPL-3.0
- **GPL headers** - Added to all source files
- **Bundled themes** - Curated GPL-3.0 themes included in repository
- **Themes/CREDITS.md** - Attribution to original theme creators
- **Enhanced distro support** - Auto-detection for 40+ distributions
- **Cross-distro compatibility** - Support for Debian, Arch, RHEL, openSUSE families
- **Modern terminal UI** - 256-color support with electric blue branding
- **Animated feedback** - Spinners and progress bars during operations
- **Unicode box drawing** - Professional terminal interface
- **Automatic backups** - Before every configuration change
- **Multi-path GRUB detection** - Finds GRUB config across different distros
- **Font tool detection** - Supports grub-mkfont and grub2-mkfont

### Changed

- **License**: MIT → GPL-3.0
- **UI design** - Completely redesigned terminal interface
- **Color scheme** - Professional 256-color palette
- **Error messages** - Enhanced with box drawing and color coding
- **Success feedback** - Visual confirmation with symbols
- **Help menu** - Improved formatting and examples
- **Footer messages** - Now includes license information

### Removed

- **Git repository theme installation** - Removed -g flag (avoids invalid theme structures)
- **Network dependencies** - No longer requires internet for themes
- **Git dependency** - No longer needs git installed

### Fixed

- **GRUB config path detection** - Better support for UEFI systems
- **Font path resolution** - Handles grub vs grub2 directories
- **Resolution validation** - Stricter format checking
- **Error handling** - More comprehensive error messages
- **Cleanup on exit** - Guaranteed temporary file removal

### Improved

- **Cross-platform compatibility** - Tested on Ubuntu, Arch, Fedora
- **Documentation** - Comprehensive guides for all features
- **Code quality** - Modular, well-commented code
- **User experience** - Beautiful terminal UI with real-time feedback

## [1.0.0] - 2024-XX-XX (Hypothetical Previous Version)

### Added

- Initial release
- Basic theme management
- MIT License
- Simple CLI interface

---

## Migration Guide: 1.x → 2.0

### For Users:

**Nothing changes in usage!** Commands remain the same:
```bash
sudo grubvix.sh -t mytheme
sudo grubvix.sh -l
sudo grubvix.sh -d
```

**Benefits:**
- ✅ Themes now bundled (easier to use)
- ✅ Better UI (nicer to look at)
- ✅ More reliable (better error handling)

### For Contributors:

**License change:**
- All contributions must be GPL-3.0
- Add GPL header to new files
- Cannot use MIT-only code

**See:** CONTRIBUTING.md for updated guidelines

---

## License History

| Version | License | Reason |
|---------|---------|--------|
| 2.0.0+  | GPL-3.0 | Bundle GPL themes legally |
| 1.x     | MIT     | Maximum permissiveness |

---

## Upgrade Instructions

### From 1.x to 2.0:

```bash
# Backup your current version (optional)
cp grubvix.sh grubvix-1.x-backup.sh

# Pull latest changes
git pull origin main

# Make executable
chmod +x grubvix.sh

# Test
./grubvix.sh -h
```

**Note:** Your existing GRUB configuration and backups are unaffected.

---

## Future Roadmap

### Planned for 2.1.0

- [ ] More bundled themes
- [ ] Theme preview feature
- [ ] Interactive theme selector
- [ ] Configuration wizard
- [ ] Multi-language support
- [ ] Theme marketplace integration

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute to grubvix.

All contributions will be licensed under GPL-3.0.

---

**Made with ♥ for Linux**

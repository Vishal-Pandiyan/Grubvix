# Contributing to grubvix

Thank you for your interest in contributing to grubvix! We welcome contributions from the community.

## Code of Conduct

This project follows the standard open-source code of conduct. Be respectful, inclusive, and professional.

## 🤝 How to Contribute

### Reporting Bugs

If you find a bug:

1. **Check existing issues** to avoid duplicates
2. **Create a new issue** with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - Your system information (distro, GRUB version)
   - grubvix version

### Suggesting Features

For feature requests:

1. **Check existing issues** first
2. **Create a new issue** explaining:
   - What problem it solves
   - How it should work
   - Why it's useful

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/my-feature`
3. **Make your changes**
4. **Test thoroughly** on your system
5. **Commit with clear messages**: `git commit -m 'Add feature X'`
6. **Push to your fork**: `git push origin feature/my-feature`
7. **Create a Pull Request**

## 📝 Development Guidelines

### Code Style

- **Bash version**: Compatible with Bash 4.0+
- **Indentation**: 4 spaces (no tabs)
- **Line length**: Max 100 characters where practical
- **Functions**: Descriptive names with comments
- **Variables**: Use `readonly` for constants, `local` in functions
- **Error handling**: Always check command exit codes

### Code Structure

```bash
# Good: Clear function with error handling
install_theme() {
    local source_path="$1"
    local theme_name="$2"
    
    if [[ ! -d "${source_path}" ]]; then
        error_exit "Theme directory not found"
    fi
    
    # Implementation...
}

# Bad: No error handling, unclear names
inst() {
    cp -r $1 $2
}
```

### 💬 Comments

- **File headers**: Include GPL-3.0 header
- **Function comments**: Explain purpose and parameters
- **Inline comments**: Clarify complex logic
- **Section dividers**: Use clear separators

Example:
```bash
# ============================================================================
# THEME MANAGEMENT FUNCTIONS
# ============================================================================

# Install theme to GRUB themes directory
# Args:
#   $1 - Source theme path
#   $2 - Theme name
install_theme() {
    # Implementation
}
```

### 🧪 Testing

Before submitting a PR:

1. **Test on your distribution**
2. **Test all command-line options**
3. **Test error handling** (try invalid inputs)
4. **Verify backup creation**
5. **Test theme installation**
6. **Check GRUB config updates**

### 🐛Commit Messages

Follow this format:

```
Short summary (50 chars or less)

Detailed explanation of what changed and why.
- Bullet points for multiple changes
- Reference issues: Fixes #123

Signed-off-by: Your Name <your.email@example.com>
```

Examples:
```
Add support for UEFI systems

- Detect UEFI boot mode
- Use appropriate GRUB config path
- Update documentation

Fixes #45
```

## 📜 License Compliance

### GPL-3.0 Requirements

grubvix is licensed under GPL-3.0. When contributing:

✅ **You must:**
- Agree to license your contributions under GPL-3.0
- Include the GPL-3.0 header in new files
- Maintain existing license headers

❌ **You cannot:**
- Contribute code with incompatible licenses
- Remove or modify license headers
- Claim others' work as your own

### 📚 File Headers

All new `.sh` files must include:

```bash
#!/usr/bin/env bash

################################################################################
# grubvix - GRUB Theme Manager CLI
# Copyright (C) 2024-2026 grubvix contributors
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
################################################################################
```

### 🎨 Contributing Themes

If contributing themes to the `Themes/` directory:

1. **Ensure theme is GPL-3.0** or compatible license
2. **Include original LICENSE** file with theme
3. **Add attribution** to `Themes/CREDITS.md`
4. **Verify theme.txt** exists and is valid
5. **Test theme** works with GRUB

Format for `Themes/CREDITS.md`:
```markdown
## Theme Name
- **Author:** Original Author Name
- **Source:** https://github.com/author/theme
- **License:** GPL-3.0
- **Description:** Brief description
```

##  📁 Project Structure

Understanding the codebase:

```
grubvix/
├── grubvix.sh          # Main script (850+ lines)
│   ├── Global config
│   ├── UI functions
│   ├── Utility functions
│   ├── Backup functions
│   ├── Theme management
│   ├── GRUB configuration
│   ├── Help & argument parsing
│   └── Main execution
│
├── Themes/             # Bundled themes
│   ├── README.md
│   └── CREDITS.md
│
└── docs/               # Documentation
    ├── README.md
    ├── USAGE_EXAMPLES.md
    ├── COMPATIBILITY.md
    └── ...
```

## 🎯 Areas for Contribution

### High Priority

- [ ] More theme bundles (GPL-3.0 compatible)
- [ ] Additional distribution support
- [ ] Bug fixes
- [ ] Documentation improvements
- [ ] Test coverage

### Medium Priority

- [ ] Theme preview feature
- [ ] Interactive theme selector
- [ ] Configuration wizard
- [ ] Multi-language support

### Low Priority

- [ ] GUI frontend
- [ ] Web-based theme gallery
- [ ] Theme creation tools

## 🔍 Review Process

1. **Automated checks**: Code style, file headers
2. **Manual review**: Code quality, functionality
3. **Testing**: Contributor and maintainer testing
4. **Discussion**: Changes may be requested
5. **Merge**: Once approved

## Getting Help

Need help contributing?

- **Issues**: Ask questions in issues
- **Discussions**: Use GitHub Discussions
- **Examples**: Check existing code

## Recognition

Contributors will be:
- Listed in `CONTRIBUTORS.md` 
- Credited in release notes
- Mentioned in CHANGELOG.md

## 🌍 Development Setup

```bash
# Clone your fork
git clone https://github.com/Vishal-Pandiyan/Grub-vix.git
cd grubvix

# Add upstream remote
git remote add upstream https://github.com/Vishal-Pandiyan/Grub-vix.git

# Create feature branch
git checkout -b feature/my-feature

# Make changes
nano grubvix.sh

# Test
sudo ./grubvix.sh -l

# Commit
git add .
git commit -m "Add my feature"

# Push
git push origin feature/my-feature

# Create PR on GitHub
```

## ❓ Questions?

- Open an issue for questions
- Check existing documentation
- Read the GPL-3.0 license

---

**Thank you for contributing to grubvix! 🚀**

By contributing, you agree that your contributions will be licensed under the GPL-3.0 license.

**Made with ♥ for Linux**
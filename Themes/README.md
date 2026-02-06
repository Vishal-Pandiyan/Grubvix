# 🎨 Bundled GRUB Themes

## 📂 About This Directory

This directory contains **curated GRUB themes** bundled with grubvix for your convenience.

**All themes are GPL-3.0 licensed** (or compatible open-source licenses).

---

## ✅ **Bundled Themes**

grubvix includes the following themes:



---

## 🚀 **Quick Start**

### **List Available Themes:**
```bash
./grubvix.sh -l
```

### **Apply a Theme:**
```bash
sudo ./grubvix.sh -t theme-name
```

### **Apply with Custom Resolution:**
```bash
sudo ./grubvix.sh -t theme-name -r 1920x1080
```

---

## 📋 **Theme Structure**

Each theme in this directory follows this structure:

```
theme-name/
├── theme.txt          ← Required: GRUB configuration
├── background.png     ← Optional: Background image
├── icons/             ← Optional: OS icons
│   ├── arch.png
│   ├── ubuntu.png
│   ├── windows.png
│   └── ...
├── fonts/             ← Optional: Custom fonts
│   └── font.pf2
└── LICENSE            ← GPL-3.0 (from original)
```

**Critical:** Every theme MUST have `theme.txt` to be recognized by grubvix!

---

## ⚖️ **License Compliance**

### **All Bundled Themes are GPL-3.0**

When using bundled themes, you should know:

✅ **You can:**
- Use any bundled theme freely
- Modify themes for personal use
- Share grubvix with bundled themes
- Create derivative themes

⚠️ **You must:**
- Keep the GPL-3.0 license
- Provide attribution to original creators
- Keep LICENSE files with themes
- If you modify and distribute themes, keep them GPL-3.0

❌ **You cannot:**
- Remove license/copyright notices
- Claim themes as your own work
- Relicense bundled themes to non-GPL licenses

### **Why GPL-3.0?**

Most GRUB themes use GPL-3.0, so we adopted it for grubvix to:
- Bundle themes legally
- Provide convenience to users
- Maintain open-source spirit
- Respect original creators

---

## 🎨 **Adding Your Own Themes**

Want to add custom themes to your local grubvix?

### **Method 1: Use Built-in Themes Directory**

```bash
# Download or create your theme
cd grubvix/Themes

# Add your theme directory
mkdir my-custom-theme
cd my-custom-theme

# Create theme.txt (REQUIRED)
nano theme.txt

# Add background and icons
cp /path/to/background.png ./
mkdir icons
cp /path/to/icons/* icons/

# Test
cd ../..
./grubvix.sh -l  # Should list your theme
sudo ./grubvix.sh -t my-custom-theme
```

### **Method 2: Use Local Path**

```bash
# Apply theme from anywhere on your system
sudo ./grubvix.sh -t mytheme -p /path/to/theme/folder
```

---

## 🔍 **Theme Validation**

Before applying, verify your theme:

```bash
# Check theme structure
ls -la Themes/mytheme/

# Verify theme.txt exists (REQUIRED!)
cat Themes/mytheme/theme.txt

# Check for background
ls Themes/mytheme/background.png

# List all valid themes
./grubvix.sh -l
```

**If theme doesn't appear in list:**
- Check if `theme.txt` exists in theme directory
- Verify permissions (should be readable)
- Check for syntax errors in `theme.txt`

---

## 🆘 **Troubleshooting**

### **Theme not appearing in list:**

```bash
# Check if theme.txt exists
ls Themes/mytheme/theme.txt

# If missing, theme won't be recognized
```

### **Theme looks broken after applying:**

```bash
# Try setting proper resolution
sudo ./grubvix.sh -t mytheme -r 1920x1080

# Check theme files are complete
ls -la Themes/mytheme/

# Verify background image exists
file Themes/mytheme/background.png
```

### **Icons not showing:**

**Common causes:**
- Icons directory missing
- Icon files not PNG format
- Icon names don't match OS

**Solution:**
```bash
# Check icons directory
ls Themes/mytheme/icons/

# Icons must be named:
# arch.png, ubuntu.png, debian.png, windows.png, etc.
```

---

## 📝 **Contributing Themes**

Want to add your theme to grubvix?

### **Requirements:**

1. **GPL-3.0 License** (or compatible open-source license)
2. **Valid theme.txt** with proper GRUB syntax
3. **High quality** - tested and working
4. **Attribution** - credit original creators if based on existing work

### **Submission Process:**

1. Fork grubvix repository
2. Add your theme to `Themes/` directory
3. Update `Themes/CREDITS.md` with attribution
4. Test theme works with grubvix
5. Submit Pull Request


---

## 📚 **More Theme Sources**

### **GitHub:**
- https://github.com/topics/grub-theme
- https://github.com/topics/grub2-theme

### **Theme Galleries:**
- https://www.gnome-look.org/browse?cat=109
- https://www.pling.com/browse?cat=109

### **Reddit:**
- r/unixporn (custom GRUB themes)
- r/linux (theme showcases)

---

## ⚡ **Quick Command Reference**

```bash
# List bundled themes
./grubvix.sh -l

# Apply bundled theme
sudo ./grubvix.sh -t themename

# Apply with resolution
sudo ./grubvix.sh -t themename -r 1920x1080

# Apply local theme
sudo ./grubvix.sh -t themename -p /path/to/theme

# Restore default
sudo ./grubvix.sh -d

# Create backup
sudo ./grubvix.sh -b
```

---

## 🎉 **Enjoy Beautiful GRUB!**

**Remember:**
- ✅ All bundled themes are GPL-3.0
- ✅ Attribution to creators in CREDITS.md
- ✅ Free to use and modify
- ✅ Contributions welcome!

**Questions?** See [CREDITS.md](CREDITS.md) for theme-specific information.

---

**Made with ♥ for Linux | GPL-3.0 License**

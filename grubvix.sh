#!/usr/bin/env bash

################################################################################
#  ██████  ██████  ██    ██ ██████  ██    ██ ██ ██   ██
# ██       ██   ██ ██    ██ ██   ██ ██    ██ ██  ██ ██ 
# ██   ███ ██████  ██    ██ ██████  ██    ██ ██   ███  
# ██    ██ ██   ██ ██    ██ ██   ██  ██  ██  ██  ██ ██ 
#  ██████  ██   ██  ██████  ██████    ████   ██ ██   ██
#
# GRUB Theme Manager CLI - Next Generation
# Version: 1.0.0 | License: MIT
################################################################################

set -euo pipefail

# ============================================================================
# GLOBAL CONFIGURATION
# ============================================================================

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly THEMES_DIR="${SCRIPT_DIR}/Themes"
readonly GRUB_CONFIG="/etc/default/grub"
readonly GRUB_THEMES_DIR="/boot/grub/themes"
readonly BACKUP_DIR="/var/backups/grubvix"
readonly TMP_DIR="/tmp/grubvix-$$"
readonly VERSION="1.0.0"

# ============================================================================
# ADVANCED COLOR PALETTE & STYLES
# ============================================================================

# Color codes with 256-color support
readonly C_RESET='\033[0m'
readonly C_BOLD='\033[1m'
readonly C_DIM='\033[2m'
readonly C_ITALIC='\033[3m'
readonly C_UNDERLINE='\033[4m'

# Foreground colors
readonly C_BLACK='\033[30m'
readonly C_RED='\033[31m'
readonly C_GREEN='\033[32m'
readonly C_YELLOW='\033[33m'
readonly C_BLUE='\033[34m'
readonly C_MAGENTA='\033[35m'
readonly C_CYAN='\033[36m'
readonly C_WHITE='\033[37m'

# Bright/vivid colors
readonly C_BRIGHT_RED='\033[91m'
readonly C_BRIGHT_GREEN='\033[92m'
readonly C_BRIGHT_YELLOW='\033[93m'
readonly C_BRIGHT_BLUE='\033[94m'
readonly C_BRIGHT_MAGENTA='\033[95m'
readonly C_BRIGHT_CYAN='\033[96m'
readonly C_BRIGHT_WHITE='\033[97m'

# Background colors
readonly C_BG_BLACK='\033[40m'
readonly C_BG_RED='\033[41m'
readonly C_BG_GREEN='\033[42m'
readonly C_BG_YELLOW='\033[43m'
readonly C_BG_BLUE='\033[44m'
readonly C_BG_MAGENTA='\033[45m'
readonly C_BG_CYAN='\033[46m'
readonly C_BG_WHITE='\033[47m'

# Custom brand colors (256-color mode)
readonly C_BRAND='\033[38;5;39m'      # Electric blue
readonly C_SUCCESS='\033[38;5;46m'    # Neon green
readonly C_ERROR='\033[38;5;196m'     # Bright red
readonly C_WARNING='\033[38;5;214m'   # Orange
readonly C_INFO='\033[38;5;51m'       # Cyan
readonly C_ACCENT='\033[38;5;207m'    # Pink/magenta

# Box drawing characters
readonly BOX_TL='╔'  # Top left
readonly BOX_TR='╗'  # Top right
readonly BOX_BL='╚'  # Bottom left
readonly BOX_BR='╝'  # Bottom right
readonly BOX_H='═'   # Horizontal
readonly BOX_V='║'   # Vertical
readonly BOX_VR='╠'  # Vertical right
readonly BOX_VL='╣'  # Vertical left
readonly BOX_HU='╩'  # Horizontal up
readonly BOX_HD='╦'  # Horizontal down
readonly BOX_PLUS='╬' # Cross

# Special symbols
readonly SYM_CHECK='✓'
readonly SYM_CROSS='✗'
readonly SYM_ARROW='➜'
readonly SYM_STAR='★'
readonly SYM_CIRCLE='●'
readonly SYM_SQUARE='■'
readonly SYM_TRIANGLE='▶'
readonly SYM_WARN='⚠'
readonly SYM_INFO='ℹ'
readonly SYM_ROCKET='🚀'
readonly SYM_GEAR='⚙'
readonly SYM_PACKAGE='📦'
readonly SYM_FIRE='🔥'

# Operation flags
THEME_NAME=""
LOCAL_PATH=""
GIT_URL=""
RESOLUTION=""
FONT_SIZE=""
MODE=""
TERMINAL_WIDTH=$(tput cols 2>/dev/null || echo 80)

# ============================================================================
# ADVANCED UI FUNCTIONS
# ============================================================================

# Get terminal width dynamically
get_terminal_width() {
    TERMINAL_WIDTH=$(tput cols 2>/dev/null || echo 80)
}

# Print centered text
print_center() {
    local text="$1"
    local color="${2:-$C_RESET}"
    # Remove ANSI color codes for length calculation
    local plain_text=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    local text_length=${#plain_text}
    local padding=$(( (TERMINAL_WIDTH - text_length) / 2 ))
    
    printf "%*s" $padding ""
    echo -e "${color}${text}${C_RESET}"
}

# Print horizontal line
print_line() {
    local char="${1:-═}"
    local color="${2:-$C_BRAND}"
    printf "${color}"
    printf '%*s\n' "$TERMINAL_WIDTH" '' | tr ' ' "$char"
    printf "${C_RESET}"
}

# Print fancy header box
print_header_box() {
    local title="$1"
    local subtitle="${2:-}"
    
    get_terminal_width
    
    echo ""
    print_line "═" "$C_BRAND"
    print_center "╔════════════════════════════════════════════════════════════╗" "$C_BRAND"
    print_center "║                                                            ║" "$C_BRAND"
    print_center "║  ${C_BOLD}${C_BRIGHT_CYAN}GRUBVIX${C_RESET}${C_BRAND} - GRUB Theme Manager CLI                ║" "$C_BRAND"
    print_center "║                                                            ║" "$C_BRAND"
    print_center "╚════════════════════════════════════════════════════════════╝" "$C_BRAND"
    print_line "═" "$C_BRAND"
    
    if [[ -n "$title" ]]; then
        echo ""
        print_center "${C_BOLD}${C_BRIGHT_YELLOW}${SYM_TRIANGLE} ${title}${C_RESET}"
        if [[ -n "$subtitle" ]]; then
            print_center "${C_DIM}${subtitle}${C_RESET}"
        fi
        echo ""
    fi
}

# Print section header
print_section() {
    local title="$1"
    local icon="${2:-$SYM_SQUARE}"
    
    echo ""
    echo -e "${C_BRAND}${BOX_VR}${BOX_H}${BOX_H}${BOX_H} ${C_BOLD}${C_BRIGHT_CYAN}${icon} ${title}${C_RESET}"
    echo -e "${C_BRAND}${BOX_V}${C_RESET}"
}

# Print success message with animation effect
print_success() {
    local message="$1"
    echo -e "${C_BRAND}${BOX_V}${C_RESET} ${C_SUCCESS}${SYM_CHECK}${C_RESET} ${C_BRIGHT_GREEN}${message}${C_RESET}"
}

# Print error message with styling
print_error() {
    local message="$1"
    echo ""
    echo -e "${C_ERROR}${BOX_TL}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_TR}${C_RESET}"
    echo -e "${C_ERROR}${BOX_V}${C_RESET} ${C_BRIGHT_RED}${C_BOLD}${SYM_CROSS} ERROR${C_RESET}              ${C_ERROR}${BOX_V}${C_RESET}"
    echo -e "${C_ERROR}${BOX_VR}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_VL}${C_RESET}"
    echo -e "${C_ERROR}${BOX_V}${C_RESET} ${C_BRIGHT_RED}${message}${C_RESET}"
    echo -e "${C_ERROR}${BOX_BL}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_H}${BOX_BR}${C_RESET}"
    echo ""
}

# Print warning message
print_warning() {
    local message="$1"
    echo -e "${C_BRAND}${BOX_V}${C_RESET} ${C_WARNING}${SYM_WARN}${C_RESET} ${C_BRIGHT_YELLOW}${message}${C_RESET}"
}

# Print info message
print_info() {
    local message="$1"
    echo -e "${C_BRAND}${BOX_V}${C_RESET} ${C_INFO}${SYM_INFO}${C_RESET} ${C_BRIGHT_CYAN}${message}${C_RESET}"
}

# Print step with number
print_step() {
    local step_num="$1"
    local message="$2"
    echo -e "${C_BRAND}${BOX_V}${C_RESET} ${C_ACCENT}[${step_num}]${C_RESET} ${message}"
}

# Print progress bar
print_progress() {
    local current=$1
    local total=$2
    local description="$3"
    
    local percentage=$((current * 100 / total))
    local filled=$((percentage / 5))
    local empty=$((20 - filled))
    
    local bar=""
    for ((i=0; i<filled; i++)); do
        bar="${bar}█"
    done
    for ((i=0; i<empty; i++)); do
        bar="${bar}░"
    done
    
    echo -ne "\r${C_BRAND}${BOX_V}${C_RESET} ${C_BRIGHT_CYAN}${bar}${C_RESET} ${percentage}% ${C_DIM}${description}${C_RESET}"
    
    if [[ $current -eq $total ]]; then
        echo ""
    fi
}

# Animated spinner
show_spinner() {
    local pid=$1
    local message=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %10 ))
        echo -ne "\r${C_BRAND}${BOX_V}${C_RESET} ${C_BRIGHT_CYAN}${spin:$i:1}${C_RESET} ${message}..."
        sleep 0.1
    done
    echo -ne "\r${C_BRAND}${BOX_V}${C_RESET} ${C_SUCCESS}${SYM_CHECK}${C_RESET} ${message}... ${C_BRIGHT_GREEN}Done${C_RESET}\n"
}

# Print footer
print_footer() {
    local status="$1"
    
    echo -e "${C_BRAND}${BOX_V}${C_RESET}"
    print_line "═" "$C_BRAND"
    
    if [[ "$status" == "success" ]]; then
        print_center "${C_SUCCESS}${SYM_ROCKET} ${C_BOLD}${C_BRIGHT_GREEN}Operation completed successfully!${C_RESET}"
    elif [[ "$status" == "info" ]]; then
        print_center "${C_INFO}${SYM_INFO} ${C_BRIGHT_CYAN}Operation completed${C_RESET}"
    fi
    
    print_center "${C_DIM}grubvix v${VERSION} | Made with ${C_RED}♥${C_RESET}${C_DIM} for Linux${C_RESET}"
    print_line "═" "$C_BRAND"
    echo ""
}

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

error_exit() {
    print_error "$1"
    cleanup
    print_footer "error"
    exit 1
}

cleanup() {
    if [[ -d "${TMP_DIR}" ]]; then
        rm -rf "${TMP_DIR}" 2>/dev/null || true
    fi
}

trap cleanup EXIT

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error_exit "This script must be run as root. Please use sudo."
    fi
}

check_dependencies() {
    local deps=("grub-mkconfig" "grub-mkfont")
    local missing=()
    
    print_section "System Check" "$SYM_GEAR"
    
    for cmd in "${deps[@]}"; do
        if command -v "$cmd" &> /dev/null; then
            print_success "Found: ${cmd}"
        else
            print_error "Missing: ${cmd}"
            missing+=("$cmd")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        error_exit "Missing required commands: ${missing[*]}"
    fi
}

# ============================================================================
# BACKUP FUNCTIONS
# ============================================================================

backup_grub_config() {
    print_section "Backup Creation" "$SYM_PACKAGE"
    
    mkdir -p "${BACKUP_DIR}"
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="${BACKUP_DIR}/grub_${timestamp}.bak"
    
    print_info "Creating timestamped backup..."
    
    if cp "${GRUB_CONFIG}" "${backup_file}"; then
        print_success "Backup saved: ${C_DIM}${backup_file}${C_RESET}"
    else
        error_exit "Failed to create backup"
    fi
}

# ============================================================================
# THEME MANAGEMENT FUNCTIONS
# ============================================================================

validate_theme() {
    local theme_path="$1"
    
    print_step "1" "Validating theme structure..."
    
    if [[ ! -d "${theme_path}" ]]; then
        error_exit "Theme directory not found: ${theme_path}"
    fi
    print_success "Theme directory exists"
    
    if [[ ! -f "${theme_path}/theme.txt" ]]; then
        error_exit "theme.txt not found in: ${theme_path}"
    fi
    print_success "theme.txt found"
}

install_theme() {
    local source_path="$1"
    local theme_name="$2"
    local dest_path="${GRUB_THEMES_DIR}/${theme_name}"
    
    print_step "2" "Installing theme files..."
    
    mkdir -p "${GRUB_THEMES_DIR}"
    
    if [[ -d "${dest_path}" ]]; then
        print_warning "Removing existing theme installation"
        rm -rf "${dest_path}"
    fi
    
    # Simulate progress
    (
        cp -r "${source_path}" "${dest_path}" 2>/dev/null
    ) &
    local cp_pid=$!
    show_spinner $cp_pid "Copying theme files"
    
    wait $cp_pid
    
    print_success "Theme installed to: ${C_DIM}${dest_path}${C_RESET}"
}

update_grub_theme_config() {
    local theme_name="$1"
    local theme_path="${GRUB_THEMES_DIR}/${theme_name}/theme.txt"
    
    print_step "3" "Updating GRUB configuration..."
    
    sed -i '/^GRUB_THEME=/d' "${GRUB_CONFIG}"
    echo "GRUB_THEME=\"${theme_path}\"" >> "${GRUB_CONFIG}"
    
    print_success "Configuration updated"
}

apply_builtin_theme() {
    local theme_name="$1"
    local theme_path="${THEMES_DIR}/${theme_name}"
    
    print_header_box "Applying Built-in Theme" "Theme: ${theme_name}"
    
    validate_theme "${theme_path}"
    install_theme "${theme_path}" "${theme_name}"
    update_grub_theme_config "${theme_name}"
}

apply_local_theme() {
    local theme_name="$1"
    local local_path="$2"
    
    local_path=$(eval echo "${local_path}")
    local_path=$(readlink -f "${local_path}")
    
    print_header_box "Applying Local Theme" "Source: ${local_path}"
    
    validate_theme "${local_path}"
    install_theme "${local_path}" "${theme_name}"
    update_grub_theme_config "${theme_name}"
}

apply_git_theme() {
    local theme_name="$1"
    local git_url="$2"
    
    print_header_box "Applying Git Theme" "Repository: ${git_url}"
    
    if ! command -v git &> /dev/null; then
        error_exit "Git is not installed. Install it with: sudo apt install git"
    fi
    
    print_section "Git Clone" "$SYM_PACKAGE"
    
    mkdir -p "${TMP_DIR}"
    
    print_info "Cloning repository..."
    (
        git clone --depth 1 "${git_url}" "${TMP_DIR}/repo" &> /dev/null
    ) &
    local git_pid=$!
    show_spinner $git_pid "Downloading theme from Git"
    
    wait $git_pid || error_exit "Failed to clone repository: ${git_url}"
    
    print_success "Repository cloned successfully"
    
    validate_theme "${TMP_DIR}/repo"
    install_theme "${TMP_DIR}/repo" "${theme_name}"
    update_grub_theme_config "${theme_name}"
}

# ============================================================================
# CONFIGURATION FUNCTIONS
# ============================================================================

set_grub_resolution() {
    local resolution="$1"
    
    if [[ ! "${resolution}" =~ ^[0-9]+x[0-9]+$ ]]; then
        error_exit "Invalid resolution format. Use WIDTHxHEIGHT (e.g., 1920x1080)"
    fi
    
    print_section "Resolution Configuration" "$SYM_GEAR"
    
    sed -i '/^GRUB_GFXMODE=/d' "${GRUB_CONFIG}"
    echo "GRUB_GFXMODE=${resolution}" >> "${GRUB_CONFIG}"
    
    print_success "Resolution set to: ${C_BOLD}${resolution}${C_RESET}"
}

set_grub_font() {
    local font_size="$1"
    
    if [[ ! "${font_size}" =~ ^[0-9]+$ ]]; then
        error_exit "Invalid font size. Must be a number (e.g., 24)"
    fi
    
    print_section "Font Generation" "$SYM_GEAR"
    
    local font_source="/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf"
    local font_dest="/boot/grub/fonts/custom_${font_size}.pf2"
    
    if [[ ! -f "${font_source}" ]]; then
        font_source="/usr/share/fonts/truetype/liberation/LiberationMono-Regular.ttf"
        if [[ ! -f "${font_source}" ]]; then
            error_exit "System font not found. Install DejaVu or Liberation fonts."
        fi
    fi
    
    mkdir -p "/boot/grub/fonts"
    
    print_info "Generating font (size: ${font_size})..."
    (
        grub-mkfont -s "${font_size}" -o "${font_dest}" "${font_source}" &> /dev/null
    ) &
    local font_pid=$!
    show_spinner $font_pid "Creating custom font"
    
    wait $font_pid || error_exit "Failed to generate font"
    
    sed -i '/^GRUB_FONT=/d' "${GRUB_CONFIG}"
    echo "GRUB_FONT=\"${font_dest}\"" >> "${GRUB_CONFIG}"
    
    print_success "Font generated: ${C_DIM}${font_dest}${C_RESET}"
}

restore_default_theme() {
    print_header_box "Restoring Default Theme" "Removing custom theme configuration"
    
    backup_grub_config
    
    print_section "Theme Removal" "$SYM_GEAR"
    
    sed -i '/^GRUB_THEME=/d' "${GRUB_CONFIG}"
    
    print_success "Custom theme removed"
    
    update_grub
}

list_builtin_themes() {
    print_header_box "Available Themes" "Built-in theme collection"
    
    if [[ ! -d "${THEMES_DIR}" ]]; then
        print_warning "Themes directory not found: ${THEMES_DIR}"
        print_footer "info"
        return
    fi
    
    print_section "Theme Gallery" "$SYM_STAR"
    
    local theme_count=0
    local valid_themes=()
    local invalid_themes=()
    
    for theme_dir in "${THEMES_DIR}"/*; do
        if [[ -d "${theme_dir}" ]]; then
            local theme_name=$(basename "${theme_dir}")
            if [[ -f "${theme_dir}/theme.txt" ]]; then
                valid_themes+=("$theme_name")
                ((theme_count++))
            else
                invalid_themes+=("$theme_name")
            fi
        fi
    done
    
    # Display valid themes
    if [[ ${#valid_themes[@]} -gt 0 ]]; then
        for theme in "${valid_themes[@]}"; do
            echo -e "${C_BRAND}${BOX_V}${C_RESET}  ${C_SUCCESS}${SYM_CHECK}${C_RESET} ${C_BRIGHT_GREEN}${theme}${C_RESET}"
        done
    fi
    
    # Display invalid themes
    if [[ ${#invalid_themes[@]} -gt 0 ]]; then
        echo -e "${C_BRAND}${BOX_V}${C_RESET}"
        print_warning "Invalid themes (missing theme.txt):"
        for theme in "${invalid_themes[@]}"; do
            echo -e "${C_BRAND}${BOX_V}${C_RESET}  ${C_ERROR}${SYM_CROSS}${C_RESET} ${C_DIM}${theme}${C_RESET}"
        done
    fi
    
    echo -e "${C_BRAND}${BOX_V}${C_RESET}"
    print_info "Total valid themes: ${C_BOLD}${theme_count}${C_RESET}"
    
    if [[ ${theme_count} -eq 0 ]]; then
        print_warning "No valid themes found. Add themes to: ${THEMES_DIR}"
    fi
    
    print_footer "info"
}

update_grub() {
    print_section "GRUB Update" "$SYM_ROCKET"
    
    print_info "Regenerating GRUB configuration..."
    
    if command -v update-grub &> /dev/null; then
        (
            update-grub &> /dev/null
        ) &
        local grub_pid=$!
        show_spinner $grub_pid "Running update-grub"
        wait $grub_pid || error_exit "Failed to update GRUB"
    elif command -v grub-mkconfig &> /dev/null; then
        (
            grub-mkconfig -o /boot/grub/grub.cfg &> /dev/null
        ) &
        local grub_pid=$!
        show_spinner $grub_pid "Running grub-mkconfig"
        wait $grub_pid || error_exit "Failed to update GRUB"
    else
        error_exit "Could not find update-grub or grub-mkconfig"
    fi
    
    print_success "GRUB bootloader updated successfully"
}

# ============================================================================
# HELP FUNCTION
# ============================================================================

show_help() {
    clear
    
    echo ""
    echo -e "${C_BRAND}"
    cat << 'EOF'
  ██████  ██████  ██    ██ ██████  ██    ██ ██ ██   ██
 ██       ██   ██ ██    ██ ██   ██ ██    ██ ██  ██ ██ 
 ██   ███ ██████  ██    ██ ██████  ██    ██ ██   ███  
 ██    ██ ██   ██ ██    ██ ██   ██  ██  ██  ██  ██ ██ 
  ██████  ██   ██  ██████  ██████    ████   ██ ██   ██
EOF
    echo -e "${C_RESET}"
    
    print_center "${C_BOLD}${C_BRIGHT_CYAN}GRUB Theme Manager CLI${C_RESET}"
    print_center "${C_DIM}Version ${VERSION}${C_RESET}"
    print_line "═" "$C_BRAND"
    
    cat << EOF

${C_BOLD}${C_BRIGHT_YELLOW}USAGE:${C_RESET}
    ${C_BRIGHT_CYAN}sudo grubvix.sh${C_RESET} ${C_DIM}[OPTIONS]${C_RESET}

${C_BOLD}${C_BRIGHT_YELLOW}MAIN MODE:${C_RESET}
    ${C_BRIGHT_GREEN}-t${C_RESET} ${C_DIM}NAME${C_RESET}        Apply theme (from built-in collection)

${C_BOLD}${C_BRIGHT_YELLOW}SOURCE MODIFIERS:${C_RESET} ${C_DIM}(use with -t)${C_RESET}
    ${C_BRIGHT_GREEN}-p${C_RESET} ${C_DIM}PATH${C_RESET}        Apply theme from local folder
    ${C_BRIGHT_GREEN}-g${C_RESET} ${C_DIM}URL${C_RESET}         Apply theme from Git repository

${C_BOLD}${C_BRIGHT_YELLOW}OTHER COMMANDS:${C_RESET}
    ${C_BRIGHT_GREEN}-l${C_RESET}              List available built-in themes
    ${C_BRIGHT_GREEN}-d${C_RESET}              Restore default GRUB theme
    ${C_BRIGHT_GREEN}-r${C_RESET} ${C_DIM}WxH${C_RESET}         Set GRUB resolution (e.g., 1920x1080)
    ${C_BRIGHT_GREEN}-f${C_RESET} ${C_DIM}SIZE${C_RESET}        Set GRUB font size (e.g., 24)
    ${C_BRIGHT_GREEN}-b${C_RESET}              Force backup of GRUB config
    ${C_BRIGHT_GREEN}-h${C_RESET}              Show this help menu

${C_BOLD}${C_BRIGHT_YELLOW}EXAMPLES:${C_RESET}

    ${C_DIM}# Apply built-in theme${C_RESET}
    ${C_BRIGHT_CYAN}sudo grubvix.sh -t mytheme${C_RESET}

    ${C_DIM}# Apply theme from local path${C_RESET}
    ${C_BRIGHT_CYAN}sudo grubvix.sh -t mytheme -p /path/to/theme${C_RESET}

    ${C_DIM}# Apply theme from Git repository${C_RESET}
    ${C_BRIGHT_CYAN}sudo grubvix.sh -t mytheme -g https://github.com/user/theme.git${C_RESET}

    ${C_DIM}# Set resolution and font size${C_RESET}
    ${C_BRIGHT_CYAN}sudo grubvix.sh -r 1920x1080 -f 24${C_RESET}

    ${C_DIM}# Apply theme with custom settings${C_RESET}
    ${C_BRIGHT_CYAN}sudo grubvix.sh -t mytheme -r 2560x1440 -f 32${C_RESET}

EOF

    print_line "═" "$C_BRAND"
    print_center "${C_DIM}Made with ${C_RED}♥${C_RESET}${C_DIM} for Linux${C_RESET}"
    print_line "═" "$C_BRAND"
    echo ""
}

# ============================================================================
# ARGUMENT PARSER
# ============================================================================

parse_arguments() {
    if [[ $# -eq 0 ]]; then
        show_help
        exit 0
    fi
    
    while getopts ":t:p:g:r:f:ldbh" opt; do
        case ${opt} in
            t) THEME_NAME="${OPTARG}"; MODE="theme" ;;
            p) LOCAL_PATH="${OPTARG}" ;;
            g) GIT_URL="${OPTARG}" ;;
            r) RESOLUTION="${OPTARG}" ;;
            f) FONT_SIZE="${OPTARG}" ;;
            l) MODE="list" ;;
            d) MODE="restore" ;;
            b) MODE="backup" ;;
            h) show_help; exit 0 ;;
            \?) error_exit "Invalid option: -${OPTARG}. Use -h for help." ;;
            :) error_exit "Option -${OPTARG} requires an argument." ;;
        esac
    done
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    parse_arguments "$@"
    
    # List mode doesn't require root
    if [[ "${MODE}" == "list" ]]; then
        list_builtin_themes
        exit 0
    fi
    
    # All other operations require root
    check_root
    check_dependencies
    
    case "${MODE}" in
        backup)
            print_header_box "Manual Backup" "Creating configuration backup"
            backup_grub_config
            print_footer "success"
            ;;
            
        restore)
            restore_default_theme
            print_footer "success"
            ;;
            
        theme)
            if [[ -z "${THEME_NAME}" ]]; then
                error_exit "Theme name required with -t option"
            fi
            
            if [[ -n "${LOCAL_PATH}" && -n "${GIT_URL}" ]]; then
                error_exit "Cannot use both -p and -g together"
            fi
            
            backup_grub_config
            
            if [[ -n "${GIT_URL}" ]]; then
                apply_git_theme "${THEME_NAME}" "${GIT_URL}"
            elif [[ -n "${LOCAL_PATH}" ]]; then
                apply_local_theme "${THEME_NAME}" "${LOCAL_PATH}"
            else
                apply_builtin_theme "${THEME_NAME}"
            fi
            
            if [[ -n "${RESOLUTION}" ]]; then
                set_grub_resolution "${RESOLUTION}"
            fi
            
            if [[ -n "${FONT_SIZE}" ]]; then
                set_grub_font "${FONT_SIZE}"
            fi
            
            update_grub
            
            print_section "Next Steps" "$SYM_INFO"
            print_info "Reboot your system to see the new theme"
            print_info "To restore defaults, run: ${C_BRIGHT_CYAN}sudo grubvix.sh -d${C_RESET}"
            
            print_footer "success"
            ;;
            
        *)
            if [[ -n "${RESOLUTION}" || -n "${FONT_SIZE}" ]]; then
                print_header_box "Configuration Update" "Modifying GRUB settings"
                backup_grub_config
                
                if [[ -n "${RESOLUTION}" ]]; then
                    set_grub_resolution "${RESOLUTION}"
                fi
                
                if [[ -n "${FONT_SIZE}" ]]; then
                    set_grub_font "${FONT_SIZE}"
                fi
                
                update_grub
                print_footer "success"
            else
                error_exit "No valid operation specified. Use -h for help."
            fi
            ;;
    esac
}

# ============================================================================
# ENTRY POINT
# ============================================================================

main "$@"

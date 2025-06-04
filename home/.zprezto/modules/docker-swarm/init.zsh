#!/usr/bin/env zsh

# Docker Swarm Activation System
# Provides activate/deactivate functions for Docker Swarm contexts with 1Password integration
#
# Configuration via environment variables:
#   SWARM_HOST                 - Target swarm hostname (default: swarm.local)
#   DOCKER_SWARM_1P_VAULT     - 1Password vault name (default: Private)
#   DOCKER_SWARM_1P_TITLE     - Base title for 1Password items (default: auto-generated)

# Suppress output when being sourced
if [[ "${(%):-%x}" != "${0}" ]]; then
    exec 3>&1 4>&2 >/dev/null 2>&1
fi

# Configuration
SWARM_HOST="${SWARM_HOST:-swarm.local}"
LOCAL_CERT_DIR="${HOME}/.docker/swarm-certs"
CONFIG_FILE="$LOCAL_CERT_DIR/docker-swarm-config.env"

# 1Password integration
ONEPASSWORD_VAULT="${DOCKER_SWARM_1P_VAULT:-Private}"
ONEPASSWORD_ITEM_TITLE="${DOCKER_SWARM_1P_TITLE:-Docker Swarm TLS Certificates - $SWARM_HOST}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Private logging functions
_log_info() { echo -e "${BLUE}[INFO]${NC} $1" >&2; }
_log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1" >&2; }
_log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }
_log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1" >&2; }

# Prompt integration - store original RPROMPT if not already backed up
if [[ -z "${ORIGINAL_RPROMPT_BACKUP:-}" ]]; then
    export ORIGINAL_RPROMPT_BACKUP="${RPROMPT:-}"
fi

# Function to update RPROMPT with swarm context
_docker_swarm_refresh_prompt() {
    if [[ -n "${DOCKER_SWARM_ACTIVE:-}" ]]; then
        # Extract hostname from DOCKER_HOST or use DOCKER_SWARM_ACTIVE
        local swarm_indicator
        if [[ -n "${DOCKER_HOST:-}" ]]; then
            local hostname="${${DOCKER_HOST#tcp://}%:*}"
            swarm_indicator="%{%F{cyan}%}(swarm:${hostname})%{%f%}"
        else
            swarm_indicator="%{%F{cyan}%}(swarm:${DOCKER_SWARM_ACTIVE})%{%f%}"
        fi

        # Append to original RPROMPT
        if [[ -n "$ORIGINAL_RPROMPT_BACKUP" ]]; then
            RPROMPT="${ORIGINAL_RPROMPT_BACKUP} ${swarm_indicator}"
        else
            RPROMPT="${swarm_indicator}"
        fi
    else
        # Restore original RPROMPT
        RPROMPT="${ORIGINAL_RPROMPT_BACKUP}"
    fi
}

# Hook into precmd to update prompt before each command
if [[ -n "${precmd_functions}" ]]; then
    precmd_functions+=(_docker_swarm_refresh_prompt)
else
    precmd_functions=(_docker_swarm_refresh_prompt)
fi

# Check if 1Password CLI is available and signed in
_check_1password_cli() {
    command -v op &> /dev/null && op account list &> /dev/null
}

# Cleanup temporary certificates
_cleanup_temp_certs() {
    if [[ -n "${DOCKER_CERT_PATH:-}" ]] && [[ "$DOCKER_CERT_PATH" == "$HOME/.docker/swarm/"* ]]; then
        [[ -d "$DOCKER_CERT_PATH" ]] && rm -rf "$DOCKER_CERT_PATH"
    fi
}

# Fetch certificates from 1Password
_fetch_certs_from_1password() {
    local base_title="$1" vault="$2" cert_dir="$3"

    local ca_title="$base_title - CA Certificate"
    local cert_title="$base_title - Client Certificate"
    local key_title="$base_title - Client Key"

    # Fetch CA certificate
    if ! op document get "$ca_title" --vault="$vault" --output="$cert_dir/ca.pem"; then
        _log_error "Failed to fetch CA certificate from 1Password"
        return 1
    fi
    chmod 600 "$cert_dir/ca.pem"

    # Fetch client certificate
    if ! op document get "$cert_title" --vault="$vault" --output="$cert_dir/cert.pem"; then
        _log_error "Failed to fetch client certificate from 1Password"
        return 1
    fi
    chmod 600 "$cert_dir/cert.pem"

    # Fetch client key
    if ! op document get "$key_title" --vault="$vault" --output="$cert_dir/key.pem"; then
        _log_error "Failed to fetch client key from 1Password"
        return 1
    fi
    chmod 600 "$cert_dir/key.pem"

    return 0
}

# Setup Docker environment from certificate directory
_setup_docker_env_from_certs() {
    local cert_dir="$1" host="$2"
    export DOCKER_HOST="tcp://$host:2376"
    export DOCKER_TLS_VERIFY="1"
    export DOCKER_CERT_PATH="$cert_dir"
}

# Activate Docker Swarm context
swarm_activate() {
    local swarm_name="${1:-$SWARM_HOST}"

    # Check if already activated in this shell
    if [[ -n "${DOCKER_SWARM_ACTIVE:-}" ]]; then
        _log_warning "Docker Swarm context '$DOCKER_SWARM_ACTIVE' is already active in this shell"
        _log_info "Use 'swarm deactivate' first to switch contexts"
        return 1
    fi

    # Store original Docker environment
    export DOCKER_SWARM_ORIGINAL_HOST="${DOCKER_HOST:-}"
    export DOCKER_SWARM_ORIGINAL_TLS_VERIFY="${DOCKER_TLS_VERIFY:-}"
    export DOCKER_SWARM_ORIGINAL_CERT_PATH="${DOCKER_CERT_PATH:-}"

    local cert_source=""

    # Try 1Password first, then fall back to local certificates
    if _check_1password_cli; then
        local temp_cert_dir="$HOME/.docker/swarm/$swarm_name"
        mkdir -p "$temp_cert_dir"
        chmod 700 "$temp_cert_dir"

        # Check if certificates are already cached and valid
        if [[ -f "$temp_cert_dir/ca.pem" && -f "$temp_cert_dir/cert.pem" && -f "$temp_cert_dir/key.pem" ]] && \
           [[ -s "$temp_cert_dir/ca.pem" && -s "$temp_cert_dir/cert.pem" && -s "$temp_cert_dir/key.pem" ]]; then
            _log_info "Using cached certificates from previous session"
            _setup_docker_env_from_certs "$temp_cert_dir" "$swarm_name"
            cert_source="1Password (cached)"
        else
            _log_info "Retrieving certificates from 1Password..."
            if _fetch_certs_from_1password "$ONEPASSWORD_ITEM_TITLE" "$ONEPASSWORD_VAULT" "$temp_cert_dir"; then
                _setup_docker_env_from_certs "$temp_cert_dir" "$swarm_name"
                cert_source="1Password"
            else
                _cleanup_temp_certs
                _log_warning "Failed to fetch from 1Password, trying local certificates..."
            fi
        fi
    fi

    # Fall back to local certificates if 1Password failed or isn't available
    if [[ -z "$cert_source" ]]; then
        if [[ -f "$CONFIG_FILE" ]]; then
            source "$CONFIG_FILE"
            cert_source="local files"
        else
            _log_error "No certificates available"
            _log_info "Ensure the following documents are in 1Password:"
            _log_info "  - $ONEPASSWORD_ITEM_TITLE - CA Certificate"
            _log_info "  - $ONEPASSWORD_ITEM_TITLE - Client Certificate"
            _log_info "  - $ONEPASSWORD_ITEM_TITLE - Client Key"
            return 1
        fi
    fi

    # Set swarm context indicator
    export DOCKER_SWARM_ACTIVE="$swarm_name"

    # Test connection
    if docker info &>/dev/null; then
        _log_success "Docker Swarm context '$swarm_name' activated"
        _log_info "Certificate source: $cert_source"

        # Trigger prompt refresh
        _docker_swarm_refresh_prompt
        if [[ -n "${functions[zle]}" ]] && zle; then
            zle reset-prompt 2>/dev/null || true
        fi
        return 0
    else
        _log_error "Cannot connect to Docker Swarm"
        swarm_deactivate
        return 1
    fi
}

# Deactivate Docker Swarm context
swarm_deactivate() {
    if [[ -z "${DOCKER_SWARM_ACTIVE:-}" ]]; then
        _log_warning "No Docker Swarm context is currently active"
        return 1
    fi

    local active_context="$DOCKER_SWARM_ACTIVE"

    # Clean up temporary certificates before restoring environment
    _cleanup_temp_certs

    # Restore original Docker environment
    if [[ -n "${DOCKER_SWARM_ORIGINAL_HOST}" ]]; then
        export DOCKER_HOST="${DOCKER_SWARM_ORIGINAL_HOST}"
    else
        unset DOCKER_HOST
    fi

    if [[ -n "${DOCKER_SWARM_ORIGINAL_TLS_VERIFY}" ]]; then
        export DOCKER_TLS_VERIFY="${DOCKER_SWARM_ORIGINAL_TLS_VERIFY}"
    else
        unset DOCKER_TLS_VERIFY
    fi

    if [[ -n "${DOCKER_SWARM_ORIGINAL_CERT_PATH}" ]]; then
        export DOCKER_CERT_PATH="${DOCKER_SWARM_ORIGINAL_CERT_PATH}"
    else
        unset DOCKER_CERT_PATH
    fi

    # Clean up swarm-specific variables
    unset DOCKER_SWARM_ACTIVE DOCKER_SWARM_ORIGINAL_HOST DOCKER_SWARM_ORIGINAL_TLS_VERIFY DOCKER_SWARM_ORIGINAL_CERT_PATH

    _log_success "Docker Swarm context '$active_context' deactivated"

    # Trigger prompt refresh
    _docker_swarm_refresh_prompt
    if [[ -n "${functions[zle]}" ]] && zle; then
        zle reset-prompt 2>/dev/null || true
    fi
}

# Show current context status
swarm_status() {
    echo "Docker Context Status:"

    if [[ -n "${DOCKER_SWARM_ACTIVE:-}" ]]; then
        echo "  Active Swarm: $DOCKER_SWARM_ACTIVE"
        echo "  Docker Host: $DOCKER_HOST"
        echo "  TLS Verify: $DOCKER_TLS_VERIFY"
        echo "  Cert Path: $DOCKER_CERT_PATH"

        # Show certificate source
        if [[ "$DOCKER_CERT_PATH" == "$HOME/.docker/swarm/"* ]]; then
            echo "  Cert Source: 1Password (cached)"
        elif [[ "$DOCKER_CERT_PATH" == "$LOCAL_CERT_DIR" ]]; then
            echo "  Cert Source: Local files"
        else
            echo "  Cert Source: Unknown"
        fi
        echo ""

        # Test connection
        if docker info --format "{{.Swarm.LocalNodeState}}" &>/dev/null; then
            local swarm_state=$(docker info --format "{{.Swarm.LocalNodeState}}")
            echo "  Connection: ✓ Working (State: $swarm_state)"

            local node_count=$(docker info --format "{{.Swarm.Nodes}}" 2>/dev/null || echo "unknown")
            local manager_count=$(docker info --format "{{.Swarm.Managers}}" 2>/dev/null || echo "unknown")
            echo "  Nodes: $node_count"
            echo "  Managers: $manager_count"
        else
            echo "  Connection: ✗ Failed"
        fi
    else
        echo "  Active Context: Local Docker"
        if [[ -n "${DOCKER_HOST:-}" ]]; then
            echo "  Docker Host: $DOCKER_HOST"
        else
            echo "  Docker Host: unix:///var/run/docker.sock (default)"
        fi
    fi
}

# List available swarm configurations
swarm_list() {
    echo "Available Docker Swarm configurations:"

    if [[ -d "$LOCAL_CERT_DIR" ]] && [[ -f "$CONFIG_FILE" ]]; then
        local docker_host_line=$(grep "DOCKER_HOST" "$CONFIG_FILE")
        local host="${${${docker_host_line#*\"}%\"*}#tcp://}"
        host="${host%:*}"
        echo "  $host (local files)"
    fi

    if _check_1password_cli; then
        echo "  1Password integration available"
    else
        echo "  1Password integration not available"
    fi
}

# Main command handler
swarm() {
    case "${1:-help}" in
        activate|a)   swarm_activate "${2:-}" ;;
        deactivate|d) swarm_deactivate ;;
        status|s)     swarm_status ;;
        list|l)       swarm_list ;;
        help|h|*)     echo "Usage: swarm {activate|deactivate|status|list}" ;;
    esac
}

# Tab completion for zsh
_swarm_complete() {
    local -a commands
    commands=(
        'activate:Activate Docker Swarm context'
        'deactivate:Deactivate current context'
        'status:Show current context status'
        'list:List available configurations'
        'help:Show usage information'
    )
    _describe 'swarm commands' commands
}

# Enable completion
compdef _swarm_complete swarm

# Initialize prompt integration
_docker_swarm_refresh_prompt

# Restore output when sourcing is done
if [[ "${(%):-%x}" != "${0}" ]]; then
    exec 1>&3 2>&4
    exec 3>&- 4>&-
fi
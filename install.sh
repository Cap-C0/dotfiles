#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="git@github.com:Cap-C0/dotfiles.git"
NVIM_DIR="$HOME/.config/nvim"
NVIM_REPO="https://github.com/Cap-C0/capc0nvim.git"

config() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

echo "==> Dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Cloning dotfiles bare repo..."
  git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
  config config status.showUntrackedFiles no

  if ! config checkout 2>/tmp/dotfiles-checkout-err; then
    echo "Existing files would be overwritten by checkout, backing them up..."
    backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    grep -E "^\s+\S" /tmp/dotfiles-checkout-err | while read -r file; do
      mkdir -p "$backup_dir/$(dirname "$file")"
      mv "$HOME/$file" "$backup_dir/$file"
    done
    config checkout
    echo "Backed up conflicting files to $backup_dir"
  fi
  rm -f /tmp/dotfiles-checkout-err
else
  echo "Pulling latest..."
  config pull
fi

echo "==> Neovim config"
if [[ -d "$NVIM_DIR/.git" ]]; then
  git -C "$NVIM_DIR" pull
elif [[ -e "$NVIM_DIR" ]]; then
  echo "warning: $NVIM_DIR exists but isn't a git repo, skipping"
else
  git clone "$NVIM_REPO" "$NVIM_DIR"
fi

echo "==> Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -f "$HOME/Brewfile" ]]; then
  brew bundle --file="$HOME/Brewfile"
else
  echo "No ~/Brewfile tracked yet, skipping brew bundle"
fi

echo "==> Done. Open a new shell to pick up changes."

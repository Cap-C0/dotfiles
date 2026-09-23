# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# python3 works how I want
if [[ -f .venv/bin/activate ]]; then
  source .venv/bin/activate
fi
# Aiases
alias ll='ls -lah'
alias v='nvim'
alias journ='v +"set wrap" +"Copilot disable" scp://home//home/simonmartin/Personal/notes/note'
alias pyg='pygmentize'
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias grt='cd $(git rev-parse --show-toplevel)'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Vim in terminal
bindkey -v
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/capc0/.opam/opam-init/init.zsh' ]] || source '/Users/capc0/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# Created by `pipx` on 2026-04-23 22:34:35
export PATH="$PATH:/Users/capc0/.local/bin"

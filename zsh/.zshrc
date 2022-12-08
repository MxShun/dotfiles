# ---------------------------------------------------------
# PATH
# ---------------------------------------------------------
export PATH="$HOME/dev/bin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

# ---------------------------------------------------------
# Enable Powerlevel10k
# ---------------------------------------------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------------------------------------------------------
# prompt
# ---------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------------------------------------------------
# completion
# ---------------------------------------------------------
# command complement
autoload -Uz compinit && compinit

# match lower and higher
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# select by tab or arrow
zstyle ':completion:*:default' menu select=1

# save only individuals
setopt hist_ignore_all_dups

# ---------------------------------------------------------
# Zinit
# ---------------------------------------------------------
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit ice depth=1; zinit light romkatv/powerlevel10k

# ---------------------------------------------------------
# plugin list
# ---------------------------------------------------------

zinit ice wait lucid
zinit light zsh-users/zsh-completions
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# ---------------------------------------------------------
# alias
# ---------------------------------------------------------
alias login='saml2aws login -a dfm-admin'
alias aws='aws --profile=saml'

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit && compinit
fi


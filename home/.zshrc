zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#zmodload zsh/zprof

export PATH=$HOME/go/bin:$HOME/bin:$HOME/miniconda3/bin:$HOME/.cargo/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
export DISPLAY=$WSL_HOST:0

export EDITOR=/usr/bin/nvim
export BROWSER='/mnt/c/Program Files/Mozilla Firefox/firefox.exe'

export FZF_DEFAULT_OPTS="--preview 'cat {}'"
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
#export FZF_TMUX_HEIGHT=100%
export FZF_DEFAULT_OPTS='
--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
--color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

setopt extendedglob
unsetopt BG_NICE

[[ -s $HOME/.zsh_aliases ]] && source ~/.zsh_aliases
[[ -s $HOME/.zsh_ssh ]] && source $HOME/.zsh_ssh

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# fasd
#bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
#bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
#bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)

#POWERLEVEL9K_MODE='nerdfont-complete'
#source  ~/powerlevel9k/powerlevel9k.zsh-theme
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(date time dir vcs anaconda newline status)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
#POWERLEVEL9K_MODE='nerdfont-complete'


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

#zinit ice atinit'zmodload zsh/zprof' \
#  atload'zprof | head -n 20; zmodload -u zsh/zprof'
zinit light zdharma/fast-syntax-highlighting
#zinit ice atinit'zmodload zsh/zprof' \
#  atload'zprof | head -n 20; zmodload -u zsh/zprof'
zinit light zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=true

#zinit wait lucid for \
#  romkatv/powerlevel10k

setopt sharehistory
zinit lucid for \
  OMZL::prompt_info_functions.zsh \
  OMZL::git.zsh \
  OMZL::history.zsh

zinit wait lucid for \
  OMZL::grep.zsh \
  OMZL::history.zsh \
  OMZL::cli.zsh \
  OMZL::key-bindings.zsh \
  OMZL::spectrum.zsh \
  OMZL::completion.zsh \
  OMZP::git \
  OMZP::git-extras \
  OMZP::autojump \
  OMZP::fzf \
  OMZP::fasd \
  OMZP::command-not-found

CASE_SENSITIVE="true"

setopt promptsubst

PS1="> "
zinit ice wait'!0'
#zinit lucid for OMZT::gnzh
#zinit lucid for OMZT::agnoster
zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit wait lucid for \
  atinit"zicompinit; zicdreplay"  \
    zdharma/fast-syntax-highlighting \
    OMZP::colored-man-pages \
  as"completion" \
    OMZP::docker/_docker

#zinit light matthieusb/zsh-sdkman

zinit pack"binary+keys" for fzf
#zinit light Aloxaf/fzf-tab
zinit snippet "https://raw.githubusercontent.com/lincheney/fzf-tab-completion/master/zsh/fzf-zsh-completion.sh"
#zstyle ':completion:*:*:*:default' menu yes select search

# SDKMAN!

if [[ ! -s ~/.sdkman/bin/sdkman-init.sh ]]
then
  if read -q "INSTALL_SDKMAN?SDKMAN! is not installed. Do you want to install it? [yN]"
  then
    curl -s "https://get.sdkman.io" | bash
  fi
fi
if [[ -s ~/.sdkman/bin/sdkman-init.sh ]]
then
  export SDKMAN_DIR="$HOME/.sdkman"
  zinit wait lucid src"$HOME/.sdkman/bin/sdkman-init.sh" for zdharma/null
fi

cd $HOME
#zprof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#zprof

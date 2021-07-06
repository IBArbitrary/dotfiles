################################################################################
# ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
# ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
# ██████╔╝███████║███████╗███████║██████╔╝██║
# ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
# ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
# ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
################################################################################
# o┳━┓┳━┓┳━┓┳━┓o┏┓┓┳━┓┳━┓┳━┓┓ ┳
# ┃┃━┃┃━┫┃┳┛┃━┃┃ ┃ ┃┳┛┃━┫┃┳┛┗┏┛
# ┇┇━┛┛ ┇┇┗┛┇━┛┇ ┇ ┇┗┛┛ ┇┇┗┛ ┇
################################################################################
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -la'
alias ll='ls -l'

alias cls='clear'
alias c='clear'
alias r='source ~/.bashrc'
alias q='exit'
alias :q='exit'
alias f='fish'

timer_now() {
    date +%s%N
}

timer_start() {
    timer_start=${timer_start:-$(timer_now)}
}

timer_stop() {
    local delta_us=$((($(timer_now) - $timer_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if (( h > 0 )); then
        timer_show=${h}h${m}m
    elif (( m > 0 )); then
        timer_show=${m}m${s}s
    elif (( s >= 10 )); then
        timer_show=${s}.$((ms / 100 ))s
    elif (( s > 0 )); then
        timer_show=${s}.$(printf %03d $ms)s
    elif (( ms >= 100 )); then
        timer_show=${ms}ms
    elif (( ms > 0 )); then
        timer_show=${ms}.$(( us / 100 ))ms
    else
        timer_show=${us}us
    fi
    unset timer_start
}

__prompt_command() {
    local EXIT="$?"
    PS1=""
    local prompt="❯ᵇ "
    local none='\[\e[0m\]'
    local bold='\[\e[1m\]'
    local faint='\[\e[2m\]'
    local italic='\[\e[4m\]'
    local teal='\[\e[96m\]'
    local grey='\[\e[37m\]'
    local red='\[\e[91m\]'
    local green='\[\e[92m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'

    timer_stop
    local lasttime=$timer_show
    local lasttimelength=${#lasttime}
    local lasttimelength=$(expr $lasttimelength + 1)

    local cwd=$(pwd | sed "s,$HOME,~,")
    local columns=$(tput cols)
    local lines=$(tput lines)
    local rlength="12"
    local llength=${#cwd}
    #local exitlength=${#EXIT}
    local exitlength=$(expr ${#EXIT} + 1)
    local longenough=$(echo $lasttime | grep -P '\d\.\d+s')

    if [ $EXIT = 0 ]; then
        if [ $longenough ]; then
            local padlength=$(expr $columns - $rlength - $llength - $lasttimelength - 0)
        else
            local padlength=$(expr $columns - $rlength - $llength - 0)
        fi
    else
        if [ $longenough ]; then
            local padlength=$(expr $columns - $rlength - $llength - $exitlength - $lasttimelength - 0)
        else
            local padlength=$(expr $columns - $rlength - $llength - $exitlength - 0)
        fi
    fi

    local pad=$(seq -s· $padlength | tr -d '[:digit:]')

    # line separation between prompts
    PS1+="\n"
    # current directory
    PS1+="${bold}${teal}\w${none} "
    # seperation between cwd and time
    PS1+="${faint}${grey}${pad}${none} "
    if [ $EXIT != 0 ]; then
        PS1+="${bold}${red}${EXIT}${none} "
    fi
    # last command run-time
    if [ $longenough ]; then
        PS1+="${italic}${faint}${grey}${lasttime}${none} "
    fi
    # time
    PS1+="${faint}${grey}\D{}${none}"
    # prompt line
    PS1+="\n"
    #if last exit code 1 red prompt else green prompt
    if [ $EXIT != 0 ]; then
        PS1+="${red}${prompt}${none}" # Add red if exit code non 0
    else
        PS1+="${green}${prompt}${none}"
    fi
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=__prompt_command # Function to generate PS1 after CMDs

# For setting default text editor
export VISUAL='emacsclient --create-frame --alternate-editor=""'
export EDITOR='emacsclient --create-frame --alternate-editor=""'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
eval 'dircolors ~/.dircolors' >/dev/null

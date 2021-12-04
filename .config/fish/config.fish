# color customisations
# set -U fish_color_command brgreen
# set -U fish_color_cwd brgreen
# set -U fish_color_cwd_root brred
# set -U fish_color_error brred
# set -U fish_color_escape bryellow
# set -U fish_color_operator brblue
# set -U fish_color_quote bryellow
# set -U fish_color_redirection brcyan
# set -U fish_color_status brred

function splash
    set -l splash (find ~/.config/fish/scripts/color-scripts/ -type f | shuf -n 1)
    $splash
    set -e splash
end

function fish_greeting
    set me (whoami)
    echo -e "\e[2;37mhello there, \e[1m$me\e[0m\e[2;37m.\e[0m"
end


# reloading fish config
function reload
    clear
    source ~/.config/fish/config.fish
    clear
    neofetch
end

abbr -a r reload
zoxide init fish | source

#========== FZF ================================= 

export FZF_DEFAULT_COMMAND="fd -t f"
export FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934 --layout=reverse --border=sharp --prompt="# " --pointer=">" --marker="+"'
export FZF_ALT_C_OPTS="--height=50% --black --preview 'tree -C {} | head -200' --header='Choose directory to change to.'"
export FZF_ALT_C_COMMAND="fd -t d -H"
export FZF_CTRL_T_COMMAND="fd -H"
export FZF_CTRL_T_OPTS="--height=50% --black --header='Choose file/folder.'"
export FZF_CTRL_R_OPTS="--height=50% --black --header='Choose command from history.' --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# powershell habit
function cls
    command clear
end

abbr -a c clear

# vtop gruvbox theme
function vtop
    command vtop -t gruvbox
end

# wallpaper-slideshow
function wp-ss
    bgchd -dir ~/Pictures/wallpapers/ -bcknd feh -intv 10m -rpl
end

# dotfiles alias for bare git repo
alias dots '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias la 'ls -ah --group-directories-first'
alias lA 'ls -Ah --group-directories-first'
alias ll 'ls -oh'
alias lla 'ls -oah'
alias llA 'ls -oAh'
alias lc 'ls | wc -l'
alias lca 'la | wc -l'
alias lcA 'lA | wc -l'

# x-server + prime-switch
alias xx 'exec sh -c "startx; sudo /usr/bin/prime-switch"'

# doom-emacs
alias doom "~/packages/doom-emacs/bin/doom"
alias orca xxiivv-orca
alias b "buku --suggest"

# identify key id
function idkey
    xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
end

abbr -a mine 'prime-run padsp java -jar ~/packages/tlauncher/TLauncher-2.75.jar'

function pacs
    pacman -Slq | fzf --prompt 'pacman> ' \
        --header 'Install packages.
<c-p>: pacman, <c-a>: aur' \
        --bind 'ctrl-p:change-prompt(pacman> )+reload(pacman -Slq)' \
        --bind 'ctrl-a:change-prompt(aur> )+reload(yay -Slq)' \
        --multi --black --height=80% --preview 'yay -Si {1}' \
        --preview-window bottom | xargs -ro yay -S
    pacman -Qqe >~/.config/pac-kages.txt
end

function pacr
    pacman -Qq | fzf --prompt 'all> ' \
        --header='Remove packages.
<c-a>: all, <c-e>: explicit, <c-y>: aur-explicit' \
        --bind 'ctrl-a:change-prompt(all> )+reload(pacman -Qq)' \
        --bind 'ctrl-e:change-prompt(exp> )+reload(pacman -Qe)' \
        --bind 'ctrl-y:change-prompt(aur> )+reload(pacman -Qm)' \
        --multi --black --height=80% --preview 'yay -Si {1}' \
        --preview-window bottom | xargs -ro sudo pacman -Rsn
    pacman -Qqe >~/.config/pac-kages.txt
end

export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"

# file-opener function. might come in handy.
function fzfr
    fzf -m | xargs -d'\n' -r $argv
end

function rmn
    find . -type f -not -name "$argv" | xargs rm
end

# checking install history of pacman
abbr -a pach "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -r | fzf"

# check updates
abbr -a cu checkupdates
abbr -a syu "sudo pacman -Syu"
# quit vim syntax
abbr -a :q exit

function zt
    tabbed -c -r 2 zathura -e id $argv & disown
end

function cf
    cd ~/.config
    set config_dir (fd -t d -H | fzf)
    cd $config_dir
end

export VISUAL='emacsclient -c -a ""'
export EDITOR='emacsclient -t -a "vim"'
export TERM='xterm-kitty'
export YTFZF_ENABLE_FZF_DEFAULT_OPTS=1
export BAR_VISIBLE=1
export PATH="$PATH:$HOME/.rvm/bin"
export SXHKD_SHELL='sh'

abbr -a fc "emacsclient --create-frame --alternate-editor="" ~/.config/fish/config.fish &"
abbr -a nus "vnstat -d"
abbr -a g git
abbr -a da "dots add"
abbr -a dau "dots add -u"
abbr -a dc "dots commit"
abbr -a dcm "dots commit -m"
abbr -a dp "dots push"
abbr -a ds "dots status"
abbr -a ga "git add"
abbr -a gad "git add ."
abbr -a gau "git add -u"
abbr -a gc "git commit"
abbr -a gcm "git commit -m"
abbr -a gp "git push"
abbr -a gpb "git push both"
abbr -a grv "git remote -v"
abbr -a gs "git status"
abbr -a pi "sudo pip3 install"
abbr -a pu "sudo pip3 uninstall"
abbr -a pi2 "sudo pip install"
abbr -a q exit
abbr -a st "cd /media/storage/"
abbr -a pc "sudo pacman -Sc"
abbr -a yc "yay -Sc"
abbr -a rd "sudo pacman -Rcns"
abbr -a di "dict -d gcide"
abbr -a th "dict -d moby-thesaurus"
abbr -a sstar "sudo systemctl start"
abbr -a sstop "sudo systemctl stop"
abbr -a sstat "sudo systemctl status"
abbr -a senab "sudo systemctl enable"
abbr -a sdesb "sudo systemctl disable"
abbr -a nf neofetch
abbr -a ytf "youtube-dl -F"
abbr -a ytd youtube-dl
abbr -a sk "screenkey --bg-color '#282828' --font-color '#a89984' -s small --vis-shift -t 0.5"
abbr -a mp ncmpcpp
abbr -a et "emacsclient -t -a 'vim'"
abbr -a e 'emacsclient --create-frame --alternate-editor="" &'
abbr -a pgpush 'pass git push origin master'
abbr -a pgpull 'pass git pull origin master'
abbr -a mci 'sudo make clean install'
abbr -a pg 'pacgraph -b "#282828" -l "#665c54" -t "#b8bb26" -d "#a89984" -p 5 40 -e -s --disable-palette -f (date +%s)'
abbr -a yt 'ytfzf --subt -tf --preview-side=right'
abbr -a xo xdg-open
abbr -a fm 'pcmanfm & disown'
abbr -a sub 'subliminal download -l en'
abbr -a ser 'cd /media/storage/series/'
abbr -a mov 'cd /media/storage/movies/'
abbr -a proj 'cd /media/storage/projects/'
abbr -a docs 'cd /media/storage/documents/'
abbr -a bks 'cd /media/storage/books/'
abbr -a cam 'mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
abbr -a mans "man -k . | cut -d "-" -f1 | fzf | cut -d " " -f1 | xargs -r man"
abbr -a hor "cd /media/storage/horizon/"

alias zathurat 'tabbed -c -r 2 zathura -e id'
eval 'dircolors ~/.dircolors' >/dev/null

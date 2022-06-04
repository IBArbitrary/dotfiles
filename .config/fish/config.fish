################################################################################
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
################################################################################
# o┳━┓┳━┓┳━┓┳━┓o┏┓┓┳━┓┳━┓┳━┓┓ ┳
# ┃┃━┃┃━┫┃┳┛┃━┃┃ ┃ ┃┳┛┃━┫┃┳┛┗┏┛
# ┇┇━┛┛ ┇┇┗┛┇━┛┇ ┇ ┇┗┛┛ ┇┇┗┛ ┇
################################################################################

# display random splash art
function splash
    set -l splash (find ~/.config/fish/scripts/color-scripts/ -type f | shuf -n 1)
    $splash
    set -e splash
end

# greeting function for fish
function fish_greeting
    set me (whoami)
    echo -e "\e[2;37mhello there, \e[1m$me\e[0m\e[2;37m.\e[0m"
end

# reload fishconfig
function reload
    clear
    source ~/.config/fish/config.fish
    clear
    neofetch
end

# clear snippet, powershell style
function cls
    command clear
end

# start wallpaper carousel
function wp-ss
    bgchd -dir /media/storage/pictures/wallpapers/ -bcknd feh -intv 10m -rpl
end

# identify keypress name
function idkey
    xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
end

# identify window class name
function idwin
    xprop | grep WM_CLASS
end

# snippet useful for wordle games
function words
    grep "^[a-z]\{$argv[1]\}\$" /usr/share/dict/words
end

# mount function
function mnt
    sudo mount "/dev/$argv[1]" "/media/$argv[2]"
end

# unmount function
function umnt
    sudo umount "/media/$argv[1]"
end

# fzf aided package installer
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

# fzf aided package uninstaller
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

# snippet to embed vobsub sub onto video
function vobsub-embed
    ffmpeg -i $argv[1] -i $argv[2] -i $argv[3] \
        -map 0:v -map 0:a -c copy -map 1 -c:s:1 dvd_subtitle -metadata:s:s:1 \
        language=eng $argv[4]
end

# snippet to convert gdrive link to static img link
function gdrive-img-link
    echo $argv[1] \
        | grep -Po "(?<=drive.google.com/file/d/)(.*)(?=/view?.*)" \
        | sed "s/^/https:\/\/drive.google.com\/uc?export=view\&id=/"
end

# return files using fzf search
function fzfr
    fzf -m | xargs -d'\n' -r $argv
end

# negating rm
function rmn
    find . -type f -not -name "$argv" | xargs rm
end

# compare dirs for backup purposes
function bu-compdir
    if test -z $argv[3]
        diff -q $argv[1] $argv[2] | grep -Po "(?<=Only in $argv[1]: )(.*)"
    else if test -n $argv[3]
        diff -q $argv[1] $argv[2] | grep -Po "(?<=Only in $argv[2]: )(.*)"
    end
end

# open multi pdfs as tabbed zathura
function zt
    tabbed -c -r 2 zathura -e id $argv & disown
end

function zat
    zathura $argv[1] & disown
end

# quick cd to config dirs
function cf
    cd ~/.config
    set config_dir (fd -t d -H | fzf)
    cd $config_dir
end

# to caculate difference between given date and current date
function howlong
    datediff $argv[1] (date +"%Y-%m-%d") -f "%yy %mm %dd"
end

# to make and change to dir
function cdm
    mkdir $argv[1]
    cd $argv[1]
end

# abbreviations
abbr -a :q exit
abbr -a bks 'cd /media/storage/books/'
abbr -a bum "bu-compdir /media/storage/movies/ /media/external/movies/"
abbr -a bus "bu-compdir /media/storage/series/ /media/external/series/"
abbr -a c clear
abbr -a cu checkupdates
abbr -a da "dots add"
abbr -a dau "dots add -u"
abbr -a dc "dots commit"
abbr -a dcm "dots commit -m"
abbr -a di "dict -d gcide"
abbr -a docs 'cd /media/storage/documents/'
abbr -a dp "dots push"
abbr -a ds "dots status"
abbr -a e 'emacsclient --create-frame --alternate-editor="" &'
abbr -a et "emacsclient -t -a 'vim'"
abbr -a fc "emacsclient --create-frame --alternate-editor="" ~/.config/fish/config.fish &"
abbr -a fm 'pcmanfm & disown'
abbr -a g git
abbr -a ga "git add"
abbr -a gad "git add ."
abbr -a gau "git add -u"
abbr -a gc "git commit"
abbr -a gcm "git commit -m"
abbr -a gp "git push"
abbr -a gpb "git push both"
abbr -a grv "git remote -v"
abbr -a gs "git status"
abbr -a hor "cd /media/storage/horizon/"
abbr -a mans "man -k . | cut -d "-" -f1 | fzf | cut -d " " -f1 | xargs -r man"
abbr -a mci 'sudo make clean install'
abbr -a mnte "mnt sda1 external"
abbr -a mntu "mnt sda1 usb"
abbr -a mov 'cd /media/storage/movies/'
abbr -a mp ncmpcpp
abbr -a nf neofetch
abbr -a nus "vnstat -d"
abbr -a pach "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -r | fzf"
abbr -a pc "sudo pacman -Sc"
abbr -a pg 'pacgraph -b "#282828" -l "#665c54" -t "#b8bb26" -d "#a89984" -p 5 40 -e -s --disable-palette -f (date +%s)'
abbr -a pgpull 'pass git pull origin master'
abbr -a pgpush 'pass git push origin master'
abbr -a pi "sudo pip3 install"
abbr -a pi2 "sudo pip install"
abbr -a proj 'cd /media/storage/projects/'
abbr -a pu "sudo pip3 uninstall"
abbr -a q exit
abbr -a r reload
abbr -a rd "sudo pacman -Rcns"
abbr -a sdesb "sudo systemctl disable"
abbr -a senab "sudo systemctl enable"
abbr -a ser 'cd /media/storage/series/'
abbr -a sk "screenkey --bg-color '#282828' --font-color '#a89984' -s small --vis-shift -t 0.5"
abbr -a sstar "sudo systemctl start"
abbr -a sstat "sudo systemctl status"
abbr -a sstop "sudo systemctl stop"
abbr -a st "cd /media/storage/"
abbr -a sub 'subliminal download -l en'
abbr -a syu "sudo pacman -Syu"
abbr -a th "dict -d moby-thesaurus"
abbr -a umnte "umnt external"
abbr -a umntu "umnt usb"
abbr -a xo xdg-open
abbr -a yc "yay -Sc"
abbr -a yt 'ytfzf --subt -tf --preview-side=right'
abbr -a ytd youtube-dl
abbr -a ytf "youtube-dl -F"
abbr -a syncall "rsync -avu /media/storage/books/ /media/external/books/;
  rsync -avu /media/storage/music/ /media/external/music;
  rsync -avu /media/storage/pictures/wallpapers/ /media/external/wallpapers/;
  rsync -avu /media/storage/series/ /media/external/series/;
  rsync -avu /media/storage/movies/ /media/external/movies/
"

# aliases
alias b "buku --suggest"
alias doom "~/packages/doom-emacs/bin/doom"
alias dots '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lA 'ls -Ah --group-directories-first'
alias la 'ls -ah --group-directories-first'
alias lc 'ls | wc -l'
alias lcA 'lA | wc -l'
alias lca 'la | wc -l'
alias ll 'ls -oh'
alias llA 'ls -oAh'
alias lla 'ls -oah'
alias orca xxiivv-orca
alias ssh "kitty +kitten ssh"
alias xx 'exec sh -c "startx \"$XDG_CONFIG_HOME/X11/xinitrc\"; sudo /usr/bin/prime-switch"'
alias zar zaread
alias fillcol 'xclip -selection clipboard -o | fold -w 78 -s | xclip -selection clipboard -i'
alias pycharm 'pycharm nosplash'
alias svn "svn --config-dir \"$XDG_CONFIG_HOME/subversion\""
alias yarn="yarn --use-yarnrc \"$XDG_CONFIG_HOME/yarn/config\""
alias nvidia-setting="nvidia-settings --config=\"$XDG_CONFIG_HOME/nvidia/settings\""
alias wget="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""

# XDG paths
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

export LESSHISTFILE=-

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export MATHEMATICA_USERBASE="$XDG_CONFIG_HOME/mathematica"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export RUSTUP_HOOME="$XDG_DATA_HOME/rustup"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GOPATH="$XDG_DATA_HOME/go"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

export AWT_TOOLKIT=MToolKit
export BAR_VISIBLE=1
export EDITOR='emacsclient -t -a "vim"'
export FZF_ALT_C_COMMAND="fd -t d -H"
export FZF_ALT_C_OPTS="--height=50% --black --preview 'tree -C {} | head -200' --header='Choose directory to change to.'"
export FZF_CTRL_R_OPTS="--height=50% --black --header='Choose command from history.' --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_COMMAND="fd -H"
export FZF_CTRL_T_OPTS="--height=50% --black --header='Choose file/folder.'"
export FZF_DEFAULT_COMMAND="fd -t f"
export FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934 --layout=reverse --border=rounded --prompt="# " --pointer=" >" --marker="+"'
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export SXHKD_SHELL='sh'
export TERM='xterm-kitty'
export VISUAL='emacsclient -c -a ""'
export YTFZF_ENABLE_FZF_DEFAULT_OPTS=1
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# miscellaneous commands
zoxide init fish | source
eval dircolors "$XDG_CONFIG_HOME/dircolors" >/dev/null
gpgconf --launch gpg-agent

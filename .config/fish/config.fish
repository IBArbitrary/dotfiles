function splash
	set -l splash (find ~/.config/fish/scripts/color-scripts/ -type f | shuf -n 1)
	$splash
	set -e splash
end

# reloading fish config
function reload
	clear
	source ~/.config/fish/config.fish
	splash
end

abbr -a r reload

#========== FZF ================================= 

# setting default command to be 'fd'
export FZF_DEFAULT_COMMAND="fd -t f"
# setting theme and some options
export FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934 --layout=reverse --border=sharp --prompt="# " --pointer=">" --marker="+"'
# setting defaults for changing directories
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

# x-server + prime-switch
alias x 'exec sh -c "startx; sudo /usr/bin/prime-switch"'

# doom-emacs
alias doom "~/.doom-emacs/bin/doom"
abbr -a e 'emacsclient --create-frame --alternate-editor="" &'
abbr -a mine 'padsp java -jar ~/packages/tlauncher/TLauncher-2.75.jar'

function pacs
	pacman -Slq | fzf --prompt 'pacman> ' \
	   --header 'Install packages.
<c-p>: pacman, <c-a>: aur' \
	   --bind 'ctrl-p:change-prompt(Pacman> )+reload(pacman -Slq)' \
	   --bind 'ctrl-a:change-prompt(Aur> )+reload(yay -Slq)' \
	   --multi --black --height=80% --preview 'yay -Si {1}' | xargs -ro yay -S
end
	
function pacr
	pacman -Qq | fzf --prompt 'all> ' \
	   --header='Remove packages.
<c-a>: all, <c-e>: explicit, <c-y>: aur-explicit' \
	   --bind 'ctrl-a:change-prompt(all> )+reload(pacman -Qq)' \
	   --bind 'ctrl-e:change-prompt(exp> )+reload(pacman -Qe)' \
	   --bind 'ctrl-y:change-prompt(aur> )+reload(pacman -Qm)' \
	   --multi --black --height=80% --preview 'yay -Si {1}' | xargs -ro sudo pacman -Rsn
end

export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"

# file-opener function. might come in handy.
function fzfr
	fzf -m | xargs -d'\n' -r $argv;
end

# checking install history of pacman
abbr -a pach "expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -r | fzf"

# check updates
abbr -a cu "checkupdates"
abbr -a syu "sudo pacman -Syu"
# quit vim syntax
abbr -a :q "exit"

export EDITOR='emacsclient --create-frame --alternate-editor=""'

# editing fish config
abbr -a fc "emacsclient --create-frame --alternate-editor="" ~/.config/fish/config.fish &"
abbr -a nu "vnstat -d"
abbr -a g "git"
abbr -a da "dots add -u"
abbr -a dc "dots commit -m"
abbr -a dp "dots push origin master"
abbr -a ds "dots status"
abbr -a ga "git add ."
abbr -a gc "git commit -m"
abbr -a gp "git push origin master"
abbr -a gs "git status"
abbr -a pi "sudo pip3 install"
abbr -a pu "sudo pip3 uninstall"
abbr -a pi2 "sudo pip install"
abbr -a q "exit"

alias zathurat 'tabbed -c -r 2 zathura -e id'

# reloading fish config
function reload
	source ~/.config/fish/config.fish
end

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

# vtop gruvbox theme
function vtop
	command vtop -t gruvbox
end

# wallpaper-slideshow
function wp-ss
	bgchd -dir ~/Pictures/wallpapers/ -bcknd feh -intv 10m -rpl
end

# book opening script
function book --description 'Book opener with fzf'
	set CD (pwd)
	cd /media/storage/books/ 
	set books (find * -type f| fzf --header="Choose books." -m)
	if test $books
		zathura $books &
	end
	cd $CD
	set -e CD
end

# dotfiles alias for bare git repo
alias dots '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# x-server + prime-switch
alias x 'exec sh -c "startx; sudo /usr/bin/prime-switch"'

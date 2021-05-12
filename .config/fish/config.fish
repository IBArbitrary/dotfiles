# reloading fish config
function reload
	source ~/.config/fish/config.fish
end

# FZF - gruvbox theme, some other minutiae
function fzf
	command fzf --color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934 -m --layout=reverse --border=sharp --ansi --padding=1 --prompt="# " --pointer=">" --marker="+"
end

# powershell habit
function cls
	command clear
end

# vtop gruvbox theme
function vtop
	command vtop -t gruvbox
end

function book --description 'Book opener with fzf'
	set CD (pwd)
	cd /media/storage/books/ 
	set books (find * -type f| fzf --header="Choose books.")
	if test $books
		zathura $books &
	end
	cd $CD
	set -e CD
end

# dotfiles alias for bare git repo
alias dots '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

"===============================================================================
" ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
" ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
" ██║   ██║██║██╔████╔██║██████╔╝██║
" ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"  ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"   ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"===============================================================================
" o┳━┓┳━┓┳━┓┳━┓o┏┓┓┳━┓┳━┓┳━┓┓ ┳
" ┃┃━┃┃━┫┃┳┛┃━┃┃ ┃ ┃┳┛┃━┫┃┳┛┗┏┛
" ┇┇━┛┛ ┇┇┗┛┇━┛┇ ┇ ┇┗┛┛ ┇┇┗┛ ┇
"===============================================================================
" GVIM settings
set gfn=SauceCodePro\ Nerd\ Font\ 12

set bg=dark
set go-=m " disable menu bar
set go-=T " disable tool bar
set go-=r " disable scroll bar
set go-=L " disable left scroll bar

" color for terminal
set t_Co=256
set cursorline
syntax on
set colorcolumn=80

" mouse options
set mouse=a
set scf
set mousef

" tabs and indenting
set ts=4
set sw=4

" some misc set-s
set number relativenumber
set backspace=indent,eol,start
set ruler
set title
set encoding=utf-8
filetype plugin on
filetype indent on
set updatetime=100
set shortmess+=c
set signcolumn=yes
set hls is
set wildmenu

" Plugins (vim-plug) -------------------------------
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-signify'

Plug 'sheerun/vim-polyglot'
call plug#end()
"---------------------------------------------------

" remaps

	" elementary maps
	nnoremap <SPACE> <Nop>
	let mapleader = " "
	inoremap jk <Esc>
	nnoremap <Esc> :noh<CR>

	" Startify
	nnoremap <C-\> :Startify<CR>
	let g:startify_custom_header = [
	\' _____________/\/\_______________________________________________',
	\' _/\/\__/\/\__________/\/\/\__/\/\_______________________________',
	\' _/\/\__/\/\__/\/\____/\/\/\/\/\/\/\_____________________________',
	\' ___/\/\/\____/\/\____/\/\__/\__/\/\_____________________________',
	\' _____/\______/\/\/\__/\/\______/\/\_____________________________',
	\' ________________________________________________________________',
	\]

	" NERD tree
	map <leader>n :NERDTreeToggle<CR>

	" windows, buffers and tabs
	
		" buffers
		nnoremap <leader>b :buffers<CR>:buffer<Space>
		nnoremap <leader>jj :bnext<CR>
		nnoremap <leader>kk :bprev<CR>
		nnoremap <leader>zz :bdelete<CR>
	
		" windows
		
			" window navigation
			map <C-h> <C-w>h
			map <C-j> <C-w>j
			map <C-k> <C-w>k
			map <C-l> <C-w>l

			" split controls
			map <leader>hh :sp<Space>
			map <leader>vv :vsp<Space>
			map <leader>ww :new<Space>

		" tabs
		nnoremap <leader>tj :tabnext<CR>
		nnoremap <leader>tk :tabprevious<CR>
		nnoremap <leader>tf :tabfirst<CR>
		nnoremap <leader>tl :tablast<CR>
		nnoremap <leader>tt :tabnew<Space>


	" themes
	autocmd vimenter * ++nested colorscheme gruvbox " overall

	" airline settings
	let g:AirlineTheme = 'gruvbox'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#show_tab_nr = 1
	let g:airline#extensions#tabline#tab_nr_type = 1
	let g:airline#extensions#tabline#excludes = ['branches', 'index']
	let g:airline#extensions#tabline#buffer_idx_mode = 1

" disabling bell
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

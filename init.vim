call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'feline-nvim/feline.nvim'
Plug 'hashivim/vim-terraform'

Plug 'EdenEast/nightfox.nvim'
Plug 'windwp/nvim-autopairs'

call plug#end()

set background=dark
colorscheme carbonfox
set termguicolors

lua << EOF
require("telescope").setup{}
require("telescope").load_extension "file_browser"
require("nvim-autopairs").setup{}
EOF

set nocompatible

filetype off
filetype plugin indent on

set noerrorbells
set number
set backspace=indent,eol,start
set showcmd
set showmode

set noswapfile
set nobackup
set nowritebackup
set splitright
set splitbelow
set encoding=utf-8
set autowrite
set autoread
set laststatus=2
set hidden

set ruler
au FocusLost * :wa

set fileformats=unix,dos,mac
set noshowmatch
set noshowmode
set incsearch
set hlsearch
set ignorecase
set smartcase
set ttyfast
set lazyredraw

set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
set re=1

set conceallevel=0

command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

set wrap
set textwidth=79
set formatoptions=qrn1

set autoindent
set complete-=i
set showmatch
set smarttab

set et
set tabstop=4
set shiftwidth=4
set expandtab

set nrformats-=octal
set shiftround

set notimeout
set ttimeout
set ttimeoutlen=10

set complete=.,w,b,u,t
set completeopt=longest,menuone

if &history < 1000
	set history=50
endif

if &tabpagemax < 50
	set tabpagemax=50
endif

if !empty(&viminfo)
	set viminfo^=!
endif

if !&scrolloff
	set scrolloff=1
endif

if !&sidescrolloff
	set sidescrolloff=5
endif

set display+=lastline

if has('mouse')
	set mouse=r
endif

let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux" && !has('nvim')
	set ttymouse=xterm
endif

if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if has("autocmd")
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\	exe "normal! g`\"" |
					\ endif

	augroup END
else
endif

syntax enable
if has('gui_running')
	set transparency=3
	set regexpengine=1
	syntax enable
endif

let mapleader = ","
let g:mapleader = ","

nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fB <cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent> <leader>q :Sayonara<CR>
nmap <leader>w :w!<cr>

nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

nnoremap <space> zz
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.cpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.hpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.jade setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.rb setlocal expandtab ts=2 sw=2

augroup filetypedetect
	au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
	au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

au FileType nginx setlocal noet ts=4 sw=4 sts=4

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
autocmd BufEnter *.go colorscheme nofrils-dark

autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2 expandtab

autocmd BufNewFile,BufReadPost *.md setl ts=4 sw=4 sts=4 expandtab

autocmd BufNewFile,BufRead *.lua setlocal noet ts=4 sw=4 sts=4

autocmd FileType dockerfile set noexpandtab

autocmd FileType fstab,systemd set noexpandtab
autocmd FileType gitconfig,sh,toml set noexpandtab

autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab

au BufRead,BufNewFile MAINTAINERS set ft=toml

au BufRead,BufNewFile *.workflow set ft=hcl

au BufRead,BufNewFile *.mips set ft=mips

autocmd FileType gitcommit setlocal spell

autocmd FileType sh set tabstop=2 sw=2 expandtab

set wildmenu
set wildmode=list:full

autocmd BufWritePre * :%s/\s\+$//e

set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.spl
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.luac
set wildignore+=migrations
set wildignore+=go/pkg
set wildignore+=go/bin
set wildignore+=go/bin-vagrant
set wildignore+=*.pyc
set wildignore+=*.orig

let g:terraform_fmt_on_save=1

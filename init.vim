call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'feline-nvim/feline.nvim'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-rails'

Plug 'EdenEast/nightfox.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ellisonleao/gruvbox.nvim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'tpope/vim-fugitive'

call plug#end()

set background=dark
" colorscheme carbonfox
colorscheme gruvbox
set termguicolors

lua << EOF
require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "lua", "vim", "vimdoc", "go", "ruby", "javascript", "typescript" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

require("telescope").setup{}
require("telescope").load_extension "file_browser"
require("telescope").load_extension "live_grep_args"
require("nvim-autopairs").setup{}
require("bufferline").setup{}
require('lualine').setup{}
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
nnoremap <leader>fg <cmd>Telescope live_grep grep_open_files=true<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fB <cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <silent> <leader>q :Sayonara<CR>
nmap <leader>w :w!<cr>

nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

nnoremap <space> zz
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.cpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.hpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.jade setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.rb setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.js setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.jsx setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.ts setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.tsx setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.mjs setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.cjs setlocal expandtab ts=2 sw=2

augroup filetypedetect
	au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
	au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

au FileType nginx setlocal noet ts=4 sw=4 sts=4

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

autocmd BufNewFile,BufRead *.erb setl filetype=html sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead *.css setl filetype=css sw=2 ts=2 sts=2

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

set conceallevel=0

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" COC settings
set updatetime=300
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


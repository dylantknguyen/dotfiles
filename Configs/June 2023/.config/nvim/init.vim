""" Basic """
syntax on
set relativenumber
set nu
set hidden
set smartindent

""" Searching """
set incsearch
set ignorecase
set nohlsearch

""" History """
set noswapfile
set nobackup
set undodir=~/.vim/undo
set undofile

""" Tabbing """
set tabstop=2 
set softtabstop=2
set shiftwidth=2
set expandtab

""" Plugins """
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jalvesaq/nvim-r', {'branch': 'stable'}
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mcchrish/nnn.vim'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'sainnhe/gruvbox-material'
call plug#end()

""" Themes """
set background=dark
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

""" Keybinds """
let mapleader = ","

"" Buffers & General ""
map <Esc><Esc> :w<CR>
nmap <leader>n :bnext<CR>
nmap <leader>p :bprev<CR>
nnoremap <c-b> :Buffers<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-l> :Files<CR>
nnoremap <C-h> :History<CR>
nnoremap <CR> :noh<CR><CR>


"" File Manager ""
let g:nnn#set_default_mappings = 0
nnoremap <silent> <leader>nn :NnnPicker%:p:h<CR>

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>a  <Plug>(coc-codeaction-selected)
imap <leader>l <Plug>(coc-snippets-expand)
nmap <C-f> :Rg<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

""" Command Completion """
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

command! -nargs=* W w

""" Git Commits """
" au FileType gitcommit set tw=72

""" Vimtex """
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

""" Type-Specific Settings """
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType python,java set tabstop=4 shiftwidth=4

""" Emmet """
let g:user_emmet_install_global = 0
autocmd FileType html,css,htmldjango EmmetInstall
let g:user_emmet_leader_key='<C-X>'
let g:user_emmet_settings = {
\  'variables': {'lang': 'en'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!doctype html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

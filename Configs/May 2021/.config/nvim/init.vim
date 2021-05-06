""" Basic """
syntax on
set number relativenumber
set smartindent
set nu
set number relativenumber
set noswapfile
set nobackup
set undodir=~/.vim/undo
set undofile
set incsearch

""" Tabbing """
set tabstop=2 
set softtabstop=2
set shiftwidth=2
set expandtab

""" Plugins """
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mcchrish/nnn.vim'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
call plug#end()

""" Themes """

""" Keybinds """
let mapleader = ","

let g:nnn#set_default_mappings = 0
nnoremap <silent> <leader>nn :NnnPicker<CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <C-l> :Files<CR>
nnoremap <C-h> :History<CR>
nnoremap <CR> :noh<CR><CR>
map <Esc><Esc> :w<CR>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <C-f> :Rg<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

command! -nargs=* W w

""" Git Commits """
au FileType gitcommit set tw=72

""" Vimtex """
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

""" Emmet """
let g:user_emmet_install_global = 0
autocmd FileType html,css,htmldjango EmmetInstall
let g:user_emmet_leader_key='<C-X>'
let g:user_emmet_settings = {
\  'html': {
\    'snippets': {
\      'html:5': '!!!+html[lang="${lang}"]>(head>(meta[charset=${charset}]+meta[name="viewport" content="width=device-width, initial-scale=1.0"]+meta[http-equiv="X-UA-Compatible" content="ie=edge"]+title{}<body{${newline}${newline}}'
\    }
\ }
\}


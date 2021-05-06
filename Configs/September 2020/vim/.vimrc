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
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab

""" Plugins """
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mcchrish/nnn.vim'
Plug 'lervag/vimtex'
call plug#end()

""" Themes """

""" Keybinds """
let mapleader = ","

nnoremap <C-p> :Files<CR>
map <Esc><Esc> :w<CR>

let g:nnn#set_default_mappings = 0
nnoremap <silent> <leader>nn :NnnPicker<CR>

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>a  <Plug>(coc-codeaction-selected)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

command! -nargs=* W w

""" Vimtex """
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" LaTeX-Box: compiling LaTeX
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for' : 'tex' }

" Rykka.vim: Improved highlighting for RestructuredText
Plug 'Rykka/riv.vim', { 'for' : 'rst' }

" NERDTree: makes nicer directory viewing
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Syntastic: syntax checking
Plug 'scrooloose/syntastic'

" Hardmode: Why, oh why did I do this?
Plug 'wikitopian/hardmode'

" Vim-Airline: fancy status line
Plug 'vim-airline/vim-airline'

" Vim Fugitive: Git wrapper
Plug 'tpope/vim-fugitive'

" Thesaurus Query: query thesaurus.com for words
Plug 'ron89/thesaurus_query.vim'

" Vim Go: The Go plugin
Plug 'fatih/vim-go', { 'for' : 'go' }

" Initialize plugin system
call plug#end()


"""""""""""""
" LaTeX Box "
"""""""""""""
" Ignore warning when using subfiles and compiling using LaTeX-Box
let g:LatexBox_ignore_warnings = ['Cannot patch \\document']


"""""""""""""
" Rykka-VIM "
"""""""""""""
let g:riv_disable_folding=1 "RST folding


""""""""""""
" NerdTree "
""""""""""""
" Open NerdTree with plain 'vi' command
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open NerdTree with <C-n>
map <C-n> :NERDTreeToggle<CR>


"""""""""""""
" Syntastic "
"""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3' " use python3, not python
let g:syntastic_tex_checkers=['lacheck']
let g:syntastic_loc_list_height=5 " Smaller error window


"""""""""""""
" Hard Mode "
"""""""""""""
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
set lazyredraw


"""""""""""""""
" Vim Airline "
"""""""""""""""
" TODO: add customization

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

" Ctrlp: Fuzzy file finder, buffers, etc.
Plug 'ctrlpvim/ctrlp.vim'

" Sort python imports
Plug 'tweekmonster/impsort.vim'

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
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


"""""""""
" CtrlP	"
"""""""""
" remap opening command
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Setup some default ignores
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
	\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" Automatically install vim plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" VimTex: compiling LaTeX (more modern than LaTeX-Box)
Plug 'lervag/vimtex', { 'for' : 'tex' }

" Syntastic: syntax checking
Plug 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': ['.dat'] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" Vim-Airline: fancy status line
Plug 'vim-airline/vim-airline'

" Vim Fugitive: Git wrapper
Plug 'tpope/vim-fugitive'

" Thesaurus Query: query thesaurus.com for words
Plug 'ron89/thesaurus_query.vim'

" Vim Go: The Go plugin
Plug 'fatih/vim-go', { 'for' : 'go', 'do': 'GoInstallBinaries' }

" Split Join: split and join structs
Plug 'AndrewRadev/splitjoin.vim'

" Ctrlp: Fuzzy file finder, buffers, etc.
Plug 'ctrlpvim/ctrlp.vim'

" Sort python imports
Plug 'tweekmonster/impsort.vim'

" Rust coding features
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" Black: code formatter
Plug 'psf/black', { 'branch': 'stable' }

" MyPy: type checking
Plug 'spirosbax/vim-mypy'

" Flake8: linting
Plug 'nvie/vim-flake8'

" Submode: new submodes for making things easier
Plug 'kana/vim-submode'

" Ale: Asynchronous Linting
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()


""""""""""""
" NerdTree "
""""""""""""
" Open NerdTree with plain 'vi' command
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open NerdTree with <C-n>
" map <C-n> :NERDTreeToggle<CR>


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
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers=['flake8']
let g:syntastic_tex_checkers=['lacheck']
let g:syntastic_loc_list_height=5 " Smaller error window


"""""""""""""""
" Vim Airline "
"""""""""""""""
" TODO: add customization
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


"""""""""
" CtrlP "
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


""""""""""
" Vim-Go "
""""""""""
map <C-n> :cnext<CR>
map <C-m> :cnext<CR>
nnoremap <leader>a :cclose<CR>
let g:go_list_type = "quickfix"
" Previous default of 10s set before async was available
let g:go_test_timeout = '10000s'
let g:go_fmt_command = 'goimports'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

""""""""""""
" Polyglot "
""""""""""""
" Breaks vim-tex
let g:polyglot_disabled = ['latex']

"""""""""""""
" UltiSnips "
"""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

""""""""
" Rust "
""""""""
let g:rustfmt_autosave = 1


"""""""""""
" Submode "
"""""""""""

" Window resizing submode!!!
""""""""""""""""""""""""""""

" A message will appear in the message line when you're in a submode
" and stay there until the mode has exited.
let g:submode_always_show_submode = 1

" We're taking over the default <C-w> setting. Don't worry we'll do
" our best to put back the default functionality.
call submode#enter_with('window', 'n', '', '<C-w>')

" Note: <C-c> will also get you out to the mode without this mapping.
" Note: <C-[> also behaves as <ESC>
call submode#leave_with('window', 'n', '', '<ESC>')

" Go through every letter
for key in ['a','b','c','d','e','f','g','h','i','j','k','l','m',
\           'n','o','p','q','r','s','t','u','v','w','x','y','z']
  " maps lowercase, uppercase and <C-key>
  call submode#map('window', 'n', '', key, '<C-w>' . key)
  call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
  call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-'.key . '>')
endfor
" Go through symbols. Sadly, '|', not supported in submode plugin.
for key in ['=','_','+','-','<','>']
  call submode#map('window', 'n', '', key, '<C-w>' . key)
endfor

" Old way, just in case.
nnoremap <Leader>w <C-w>

" I don't like <C-w>q, <C-w>c won't exit Vim when it's the last window.
call submode#map('window', 'n', '', 'q', '<C-w>c')
call submode#map('window', 'n', '', '<C-q>', '<C-w>c')

" <lowercase-pipe> sets the width to 100 columns, pipe (<S-\>) by default
" maximizes the width.
call submode#map('window', 'n', '', '\', ':vertical resize 100<CR>')

" Resize faster
call submode#map('window', 'n', '', '+', '3<C-w>+')
call submode#map('window', 'n', '', '-', '3<C-w>-')
call submode#map('window', 'n', '', '<', '10<C-w><')
call submode#map('window', 'n', '', '>', '10<C-w>>')


""""""""""""""
" Black Hole "
""""""""""""""
" Thanks https://ddrscott.github.io/blog/2016/bs-to-the-black-hole/
func! BlackHoleDeleteOperator(type)
  if a:type ==# 'char'
    execute 'normal! `[v`]"_d'
  elseif a:type ==# 'line'
    execute 'normal! `[V`]"_d'
  else
    execute 'normal! `<' . a:type . '`>"_d'
  endif
endf

" Map to <BS> because it's under worked in Vim.
nnoremap <silent> <BS> <Esc>:set opfunc=BlackHoleDeleteOperator<CR>g@
vnoremap <silent> <BS> :<C-u>call BlackHoleDeleteOperator(visualmode())<CR>

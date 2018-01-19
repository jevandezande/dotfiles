" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" VimTex: compiling LaTeX (more modern than LaTeX-Box)
Plug 'lervag/vimtex', { 'for' : 'tex' }

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
Plug 'fatih/vim-go', { 'for' : 'go', 'do': 'GoInstallBinaries' }

" Split Join: split and join structs
Plug 'AndrewRadev/splitjoin.vim'

" Ctrlp: Fuzzy file finder, buffers, etc.
Plug 'ctrlpvim/ctrlp.vim'

" Sort python imports
Plug 'tweekmonster/impsort.vim'

" Vim Polyglot: syntax and proper indents
Plug 'sheerun/vim-polyglot'

" Ultisnips: snippets plugin
Plug 'SirVer/ultisnips'

" Initialize plugin system
call plug#end()


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
" Breaks bim-tex
let g:polyglot_disabled = ['latex']

"""""""""""""
" UltiSnips "
"""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

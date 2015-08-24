" vim:fdm=marker
" .vimrc

set shell=/bin/zsh

" Complatibility {{{

set nocompatible
set noedcompatible

" never, ever, go into Ex mode
nnoremap Q <nop>

" }}}

" Clear {{{

filetype off
autocmd!

" }}}

let s:dotvim = fnamemodify(globpath(&rtp, '.locator'), ':p:h')

" Utils {{{

exec ':so '.s:dotvim.'/functions/util.vim'

" }}}

" Local vimrc configuration {{{

let s:localrc = expand(s:dotvim . '/local.vimrc')
if filereadable(s:localrc)
    exec ':so ' . s:localrc
endif

" }}}

" NeoBundle {{{

" NeoBundle auto-installation and setup {{{

" Auto installing NeoBundle
let iCanHazNeoBundle=1
let neobundle_readme=expand(s:dotvim . '/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle.."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let iCanHazNeoBundle=0
endif


" Call NeoBundle
if has('vim_starting')
    set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand($HOME.'/.vim/bundle/'))

" is better if NeoBundle rules NeoBundle (needed!)
NeoBundle 'Shougo/neobundle.vim'
" }}}

" Bundles {{{

" Shougo's way {{{

" Vimproc to asynchronously run commands (NeoBundle, Unite)
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" Unite. The interface to rule almost everything
NeoBundle 'Shougo/unite.vim'

" Unite sources
NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
NeoBundleLazy 'tsukkee/unite-help', {'autoload':{'unite_sources':'help'}}
NeoBundleLazy 'ujihisa/unite-locate', {'autoload':{'unite_sources':'locate'}}
NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : { 'unite_sources' :
            \ ['history/command', 'history/search']}}
NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {'unite_sources' :
            \ 'filetype', }}
NeoBundleLazy 'osyo-manga/unite-quickfix', {'autoload':{'unite_sources':
            \ ['quickfix', 'location_list']}}
NeoBundleLazy 'osyo-manga/unite-fold', {'autoload':{'unite_sources':'fold'}}
NeoBundleLazy 'tacroe/unite-mark', {'autoload':{'unite_sources':'mark'}}
NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':
            \['file_mru', 'directory_mru']}}

" File explorer (needed where ranger is not available)
NeoBundleLazy 'Shougo/vimfiler', {'autoload' : { 'commands' : ['VimFiler', 'VimFilerExplorer']}}

" Unite plugin that provides command line completition
NeoBundle 'joedicastro/unite-cmdmatch'

" Unite plugin that provides spell suggestions
NeoBundle 'kopischke/unite-spell-suggest'
" }}}

" Source control {{{

" Admin Git
NeoBundle 'tpope/vim-fugitive'
" Show git repository changes in the current file
NeoBundle 'airblade/vim-gitgutter'
" Git viewer
NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'],
            \ 'autoload':{'commands':'Gitv'}}
" }}}

" Markdown {{{

NeoBundle 'itspriddle/vim-marked'

" }}}

" Hexadecimal editor
NeoBundle 'Shougo/vinarise.vim'

NeoBundle 'scrooloose/syntastic'

" Smart and fast date changer
NeoBundle 'tpope/vim-speeddating'

" marks admin
NeoBundle 'kshenoy/vim-signature'

" A better looking status line
NeoBundle 'bling/vim-airline'

NeoBundle 'fatih/vim-go', {'autoload': {'filetypes': ['go']}}

NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'rdnetto/YCM-Generator'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Chiel92/vim-autoformat'
NeoBundle 'vim-scripts/argtextobj.vim'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'sjl/vitality.vim'

" local bundles {{{

let s:extrarc = expand(s:dotvim . '/extra.vimrc')
if filereadable(s:extrarc)
    exec ':so ' . s:extrarc
endif

" }}}

" }}}

call neobundle#end()

" Auto install the Plugins {{{

" First-time plugins installation
if iCanHazNeoBundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    set nomore
    NeoBundleInstall
endif

" Check if all of the plugins are already installed, in other case ask if we
" want to install them (useful to add plugins in the .vimrc)
NeoBundleCheck
" }}}

" }}}

" Leaders {{{

let mapleader=','
let maplocalleader='\\'

" }}}

" Encodings {{{

" a fix for any plugin that needs the locale to be set explicitly.
let $LC_ALL="en_US.UTF-8"
set encoding=utf-8

" }}}

" Basics {{{

set tabpagemax=100

" copy to Mac's clipboard
set clipboard=unnamed

" have 500 lines of command-line (etc) history:
set history=500

" remember all of these between sessions:
" * don't save marks - doesn't work well with multiple vim instances saving to a
"   single location.
" * 10 search terms
" * save upto 500 lines of registers
" * don't save info for file in /mnt
" * don't highlight previous search terms on start
set viminfo='0,f0,<500,/10,r/mnt,h

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" don't make it look like there are line breaks where there aren't:
set nowrap

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions=crqn
set textwidth=80

set infercase

set lazyredraw

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

set laststatus=2

set ttyfast
set title

" switch modes faster
set ttimeoutlen=0

" when we reload, tell vim to restore the cursor to the saved position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" | endif

" }}}

" Tab & Indent settings {{{

" use indents of 4 spaces, and have them copied down lines:
set shiftwidth=4
set shiftround
set tabstop=4
set softtabstop=4
set expandtab
set smarttab

" enable filetype detection:
filetype plugin indent on
set autoindent
set smartindent

vnoremap > >gv
vnoremap < <gv

" }}}

" relative/absolute line numbers {{{

set number
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" }}}

" copy to end-of-line {{{

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" }}}

" Command-line completion {{{

set wildmenu
set wildignore+=*.a,*.o                " Leave out files from completion
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store
set wildignore+=.pyc
set wildignore+=*~,*.swp,*.tmp
set wildmode=list:longest,full

" }}}

" Searching {{{

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch
set hlsearch

" center vertically after searching
nmap n nzz
nmap N Nzz

" }}}

" Color scheme {{{

if (&t_Co > 2)
    set t_Co=16
    set background=dark
    colorscheme solarized
endif

" }}}

" highlighting {{{

highlight SignColumn ctermbg=0
highlight SignColumn ctermfg=4

highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000

" }}}

" key behaviour & navigation {{{

" set END behavior
"noremap  <expr> [4~  (col('.') == match(getline('.'),    '\s*$')   ? '$'  : 'g_')
noremap  <expr> [4~  '$'
"vnoremap <expr> [4~  (col('.') == match(getline('.'),    '\s*$')   ? '$h' : 'g_')
vnoremap <expr> [4~  '$'
imap <End>  <C-o>[4~

" set HOME behavior
noremap <expr> <silent> OH col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> OH <C-o>OH
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-o><Home>

set nostartofline

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert, visual, and normal modes:
set whichwrap=h,l,~,[,],<,>

" }}}

" shortmess {{{

set shortmess+=a
set shortmess+=I

" }}}

" line highlight {{{

" Highlight current line
autocmd WinLeave * set nocursorline
" in current window
autocmd WinEnter * set cursorline

" }}}

" undo {{{

" persist undos
set undofile
set undodir=~/.vim/undos
set undolevels=10000
set undoreload=10000

silent! call MakeDirIfNoExists('~/.vim/undos')

" }}}

" diff {{{

set diffopt=filler,iwhite

" }}}

" syntax highlighting {{{

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
    syntax on
endif

" }}}

" mouse {{{

" have the mouse enabled all the time:
set mouse=a
set mousefocus

" }}}

" Comments format {{{

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!).
set comments+=b:\"

" }}}

" airline {{{

set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1

" }}}

" netrw {{{

let g:netrw_sort_options="i"
let g:netrw_keepdir=1

" }}}

" tagbar {{{

let g:tagbar_tmp_shell = 0
let g:tagbar_single_click = 1

" }}}

" Syntactic {{{

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", " proprietary attribute \"app-", " proprietary attribute \"class\""]

" }}}

" Easymotion {{{

" easymotion search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" }}}

" YouCompleteMe {{{

set completeopt-=preview
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_invoke_completion = '<C-Space>'

au FileType c,cpp,slang nmap <localleader>gd :<C-u>YcmCompleter GoTo<CR>
au FileType c,cpp,slang nmap <localleader>gt :<C-u>YcmCompleter GetType<CR>

" }}}

" goyo {{{

function! g:Vimrc_goyo_before()
    autocmd! WinLeave *
    autocmd! WinEnter *
    autocmd! InsertEnter *
    autocmd! InsertLeave *

    set nocursorline
endfunction

function! g:Vimrc_goyo_after()
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
endfunction

if exists('g:goyo_before_callbacks')
    let g:goyo_before_callbacks = g:goyo_before_callbacks + [ function('g:Vimrc_goyo_before') ]
else
    let g:goyo_before_callbacks = [ function('g:Vimrc_goyo_before') ]
endif

if exists('g:goyo_after_callbacks')
    let g:goyo_after_callbacks = g:goyo_after_callbacks + [ function('g:Vimrc_goyo_after') ]
else
    let g:goyo_after_callbacks = [ function('g:Vimrc_goyo_after') ]
endif

" }}}

" fugitive {{{

"nnoremap <silent> <leader>ss :<C-u>Gstatus<CR>
"nnoremap <silent> <leader>sd :<C-u>Gdiff<CR>
"nnoremap <silent> <leader>sw :<C-u>Gwrite<CR>
"nnoremap <silent> <leader>sr :<C-u>Gread<CR>
"nnoremap <silent> <leader>sc :<C-u>Gcommit<CR>
"nnoremap <silent> <leader>sb :<C-u>Gblame<CR>

" }}}

" Gitv {{{

let g:Gitv_OpenHorizontal = 1
let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_PromptToDeleteMergeBranch = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1
cabbrev gitv Gitv

"nnoremap <silent> <leader>sh :<C-u>Gitv<CR>
"nnoremap <silent> <leader>sf :<C-u>Gitv!<CR>
"vnoremap <silent> <leader>sf :<C-u>Gitv!<CR>

" }}}

" Unite {{{

let g:unite_source_grep_max_candidates = 0
if executable('ack')
    " Use ack in unite grep source.
    let g:unite_source_rec_async_command = 'find'
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--smart-case --no-break --nocolor -H --word-regexp --nofollow'
endif
nnoremap <buffer><expr> t unite#smart_map("t", unite#do_action('tabswitch'))

nnoremap <leader>nb :<C-u>Unite buffer<CR>

" File Access
nnoremap <leader>fo :<C-u>Unite -no-split -start-insert -sync -default-action=open file_rec/async:!<CR>
nnoremap <leader>fr :<C-u>Unite -start-insert -default-action=tabswitch -sync file_rec/async:!<CR>

" Ack/grep
nnoremap <leader>ac :<C-u>UniteWithCursorWord grep:.<CR>
nnoremap <leader>al :<C-u>Unite grep:.<CR>

nnoremap <leader>ur :<C-u>UniteResume<CR>

" }}}

" Vimfiler {{{

let g:vimfiler_as_default_explorer = 1

" }}}

" vim-autoformat {{{

let g:formatdef_astyle_c = '"astyle --mode=c --style=google --keep-one-line-blocks --keep-one-line-statements --add-brackets --indent=spaces=4 --attach-namespaces --indent-preproc-block --indent-preproc-define --indent-col1-comments --min-conditional-indent=0 --max-instatement-indent=120 --unpad-paren --pad-oper --pad-header --align-pointer=name --break-closing-brackets --max-code-length=200 --break-after-logical"'
let g:formatdef_astyle_cpp = g:formatdef_astyle_c

" }}}

" vim-marked {{{

let g:marked_app = "/Applications/Marked\ 2.app/Contents/MacOS/Marked\ 2"

nnoremap <silent> <localleader>em :<C-u>MarkedOpen<CR>

" }}}

" vim-go {{{

let g:go_fmt_command = "goimports"

au FileType go nmap <localleader>gs <Plug>(go-implements)
au FileType go nmap <localleader>gi <Plug>(go-info)
au FileType go nmap <localleader>gr <Plug>(go-run)
au FileType go nmap <localleader>gb <Plug>(go-doc)
"au FileType go nmap <localleader>gt <Plug>(go-test)
au FileType go nmap <localleader>gd <Plug>(go-def-tab)
au FileType go nmap <localleader>gc <Plug>(go-coverage)
au FileType go nmap <localleader>ge <Plug>(go-rename)
au FileType go nmap gd <Plug>(go-def)

" }}}

" vim-gitgutter {{{

let g:gitgutter_override_sign_column_highlight = 0

" }}}

" file types {{{

exec ':so '.s:dotvim.'/functions/cproject.vim'

augroup filetype
    autocmd BufNewFile,BufRead *.txt setlocal filetype=human
    autocmd BufNewFile,BufRead CMake*.txt setlocal filetype=cmake
    autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
    autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown
    autocmd BufReadPost CMakeLists.txt call OpenProject()

    " in human-language files, automatically format everything at 72 chars:
    autocmd FileType human setlocal formatoptions+=t textwidth=80 spell spelllang=en_gb

    autocmd FileType markdown setlocal formatoptions+=t textwidth=80 spell spelllang=en_gb

    " force no auto-formatting of python code
    autocmd FileType python setlocal formatoptions-=t

    " for C-like programming, have automatic indentation:
    autocmd FileType c,cpp,slang setlocal cindent

    " for both CSS and HTML, use genuine tab characters for indentation, to make
    " files a few bytes smaller:
    autocmd FileType html,css setlocal noexpandtab tabstop=4

    " in makefiles, don't expand tabs to spaces, since actual tab characters are
    " needed:
    autocmd FileType make setlocal noexpandtab shiftwidth=4 tabstop=4
augroup END

" }}}

" Execution permissions by default to shebang (#!) files {{{

augroup shebang_chmod
  autocmd!
  autocmd BufNewFile  * let b:brand_new_file = 1
  autocmd BufWritePost * unlet! b:brand_new_file
  autocmd BufWritePre *
        \ if exists('b:brand_new_file') |
        \   if getline(1) =~ '^#!' |
        \     let b:chmod_post = '+x' |
        \   endif |
        \ endif
  autocmd BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup END

" }}}

" Save as root {{{

cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" }}}

" Toggles {{{

" Keystrokes to toggle options are defined here. They are all set to normal
" mode keystrokes beginning with <leader>t

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap <silent> <leader>th :<C-u>set invhls hls?<CR>

" line numbers {{{
exec ':so '.s:dotvim.'/functions/line-numbers.vim'
nnoremap <silent> <leader>tn :<C-u>call NumberToggle()<CR>

" }}}

" have \tw ("toggle wrap") toggle line wrapping on/off and report the change
nnoremap <silent> <leader>tw :<C-u>set invwrap wrap?<CR>
" have \tp ("toggle paste") toggle paste on/off and report the change
nnoremap <silent> <leader>tp :<C-u>set invpaste paste?<CR>

" Bracket autoclose {{{

exec ':so '.s:dotvim.'/functions/autoclose-brackets.vim'
let g:autoclose_on=0
nnoremap <silent> <leader>tc :call AutocloseToggle()<CR>

" }}}

" }}}

" trailing space cleanup (don't override current search)
nnoremap <silent> <leader>rt :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<CR>

" header guard {{{

exec ':so '.s:dotvim.'/functions/headerguard.vim'
nnoremap <silent> <leader>rg :call AddHeaderGuard()<CR>

" }}}

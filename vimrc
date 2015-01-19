" .vimrc

set shell=/bin/zsh

set nocompatible
filetype off

" first clear any existing autocommands:
autocmd!

let fresh_install=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let fresh_install=1
endif

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Plugins
Plugin 'gmarik/vundle'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/unite.vim'
Plugin 'tpope/vim-markdown'
Plugin 'itspriddle/vim-marked'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'gregsexton/gitv'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'junegunn/goyo.vim'
Plugin 'amix/vim-zenroom2'
Plugin 'jngeist/vim-multimarkdown'
Plugin 'fatih/vim-go'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'matthewsimo/angular-vim-snippets'
Plugin 'claco/jasmine.vim'
Plugin 'majutsushi/tagbar'
Plugin 'wincent/command-t'

if fresh_install == 1
    echo "Installing Bundles"
    echo ""
    :BundleInstall
endif

set tabpagemax=100

set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_enable_fugitive=1
let g:airline_enable_syntastic=1
let g:airline_theme='dark'
"let g:airline_left_sep = '⮀'
"let g:airline_right_sep = '⮂'
"let g:airline_linecolumn_prefix = '⭡'
"let g:airline_fugitive_prefix = '⭠ '
"let g:airline_paste_symbol = 'ρ'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let Tlist_WinWidth = 45

let g:netrw_sort_options="i"
let g:netrw_keepdir=1

let g:tagbar_tmp_shell = 0
let g:tagbar_single_click = 1

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
"iunmap OH

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" 
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1

let g:clang_snippets=1
let g:clang_snippets_engine='clang_complete'

let g:syntastic_c_config_file = '.clang_complete'
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", " proprietary attribute \"app-", " proprietary attribute \"class\""]

" easymotion search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

set noedcompatible
set encoding=utf-8

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r
set shortmess+=a
set shortmess+=I

set sessionoptions+=unix,slash

" Highlight current line
autocmd WinLeave * set nocursorline
" in current window
autocmd WinEnter * set cursorline

set nostartofline

" persist undos
set undofile
set undodir=~/.vim/undos
set undolevels=10000
set undoreload=10000

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

function! g:vimrc_goyo_before()
    autocmd! WinLeave *
    autocmd! WinEnter *
    autocmd! InsertEnter *
    autocmd! InsertLeave *

    set nocursorline
endfunction

function! g:vimrc_goyo_after()
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
endfunction

if exists('g:goyo_before_callbacks')
    let g:goyo_before_callbacks = g:goyo_before_callbacks + [ function('g:vimrc_goyo_before') ]
else
    let g:goyo_before_callbacks = [ function('g:vimrc_goyo_before') ]
endif

if exists('g:goyo_after_callbacks')
    let g:goyo_after_callbacks = g:goyo_after_callbacks + [ function('g:vimrc_goyo_after') ]
else
    let g:goyo_after_callbacks = [ function('g:vimrc_goyo_after') ]
endif

" copy to Mac's clipboard
set clipboard=unnamed

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert, visual, and normal modes:
set whichwrap=h,l,~,[,],<,>

" * User Interface

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
    syntax on
endif

" have fifty lines of command-line (etc) history:
set history=500
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
set mouse=a
set mousefocus

" don't have files trying to override this .vimrc:
set nomodeline


" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set nowrap

" use indents of 4 spaces, and have them copied down lines:
set shiftwidth=4
set shiftround
set tabstop=4
set softtabstop=4
set expandtab
set smarttab

vnoremap > >gv
vnoremap < <gv

" show the bottom 'status bar'
"set ruler
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions=crqn
set textwidth=80

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::

" * Text Formatting -- Specific File Formats

set background=dark
colorscheme solarized

highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000

set lazyredraw

"highlight Comment ctermbg=0 ctermfg=2
"highlight TabLine ctermbg=7

" enable filetype detection:
filetype plugin indent on
set autoindent
set smartindent

"set foldmethod=syntax
"set foldlevel=0
"set foldcolumn=1
"set foldnestmax=3
"set foldminlines=5

augroup filetype
  autocmd BufNewFile,BufRead *.txt setlocal filetype=human
augroup END

" in human-language files, automatically format everything at 72 chars:
autocmd FileType human setlocal formatoptions+=t textwidth=80

autocmd FileType markdown setlocal formatoptions+=t textwidth=80 spell spelllang=en_gb

" force no auto-formatting of python code
autocmd FileType python setlocal formatoptions-=t

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang setlocal cindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
"autocmd FileType html setlocal formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css setlocal noexpandtab tabstop=4

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed:
autocmd FileType make setlocal noexpandtab shiftwidth=4 tabstop=4

" JSON
autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" Go
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gb <Plug>(go-doc)
"au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <Leader>gd <Plug>(go-def-tab)
au FileType go nmap <leader>gc <Plug>(go-coverage)
au FileType go nmap <Leader>ge <Plug>(go-rename)
au FileType go nmap gd <Plug>(go-def)

let g:go_fmt_command = "goimports"

" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch
set hlsearch

" center vertically after searching
nmap n nzz
nmap N Nzz

set wildmenu
set wildignore+=*.a,*.o                " Leave out files from completion
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set wildmode=list:longest,full

let g:Gitv_OpenHorizontal = 1
let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_PromptToDeleteMergeBranch = 1
let g:Gitv_WipeAllOnClose = 1
cabbrev gitv Gitv

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" * Tags
" search for tag lists from the directory of the current file, upwards
set tags=./.tags;
noremap <C-[> <C-T>

" don't scan dictionary files for auto completions
"set complete=.,w,k
set infercase

" * Keystrokes -- Moving Around

" scroll the window (but leaving the cursor in the same place) by a couple of
" lines up/down with <Ins>/<Del> (like in `Lynx'):
noremap [A <C-Y>
noremap [B <C-E>

" Cycle through tabs with Ctrl-Tab and Ctrl-Shift-Tab
noremap [1;5I gt
inoremap [1;5I gt
noremap [1;6I gT
inoremap [1;6I gT

" Open a new tab with Ctrl-t
nnoremap <C-t> :tabe .<CR>

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>
" and have Ctrl-] mapped to %
noremap  %

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" * Keystrokes -- Formatting

" have <Tab> (and <Shift>+<Tab> where it works) change the level of
" indentation:
inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.]

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" * Keystrokes -- Toggles

" Keystrokes to toggle options are defined here.  They are all set to normal
" mode keystrokes beginning \t but some function keys (which won't work in all
" terminals) are also mapped.

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>

let g:marked_app = "/Applications/Marked\ 2.app/Contents/MacOS/Marked\ 2"
nnoremap <silent> \mo :MarkedOpen<CR>

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap \th :set invhls hls?<CR>

nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>
nnoremap <silent> \gs :Gstatus<CR>

function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <silent> \n :call NumberToggle()<CR>

function! AutocloseOn()
    inoremap { {}<left>
    inoremap ( ()<left>
    inoremap [ []<left>
    inoremap " ""<left>
    inoremap ' ''<left>
endfunc

function! AutocloseOff()
    inoremap { {
    inoremap ( (
    inoremap [ [
    inoremap " "
    inoremap ' '
endfunc
nnoremap <silent> \cn :call AutocloseOn()<CR>
nnoremap <silent> \cf :call AutocloseOff()<CR>
call AutocloseOff()

nnoremap \rt :%s/[ \t]\+$//<CR>

" when we reload, tell vim to restore the cursor to the saved position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" | endif

function! AddHeaderGuard()

    let m = matchlist(bufname("%"), '.*/\(.*\.h\)$\|\(.*\.h\)$')
    let fname = substitute((m[1] == "") ? m[2] : m[1], '\.', '_', 'g')

    if fname != ""
        let guard = "__" . toupper(fname) . "__"
        call append(0, ["#ifndef " . guard, "#define " . guard])
        call append(line('$'), "#endif /* " . guard . " */")
    endif

endfunction " AddHeaderGuard()
nnoremap \hg :call AddHeaderGuard()<CR>

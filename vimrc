" .vimrc

" a fix for any plugin that needs the locale to be set explicitly.
let $LC_ALL="en_US.UTF-8"

set shell=/bin/zsh

set nocompatible
filetype off

" never, ever, go into Ex mode
nnoremap Q <nop>

" first clear any existing autocommands:
autocmd!

set runtimepath+=$HOME/.vim/bundle/Vundle.vim/
runtime autoload/vundle.vim

if exists( '*vundle#rc' )
  filetype off
  call vundle#rc()

  " Plugins
  Plugin 'gmarik/Vundle.vim'

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
  Plugin 'claco/jasmine.vim'
  Plugin 'majutsushi/tagbar'
  Plugin 'Shougo/vimproc.vim'
  Plugin 'MattesGroeger/vim-bookmarks'
  Plugin 'sjl/vitality.vim'
  Plugin 'Chiel92/vim-autoformat'
  Plugin 'rdnetto/YCM-Generator'
  Plugin 'vim-scripts/argtextobj.vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'tpope/vim-dispatch'
  Plugin 'christoomey/vim-tmux-navigator'
endif

command!  InstallVundle
\ if ! InstallVundle()                                                            |
\   echohl ErrorMsg                                                               |
\   echomsg 'Failed to install Vundle automatically. Please install it yourself.' |
\   echohl None                                                                   |
\ endif
function! InstallVundle()
  let vundle_repo = 'https://github.com/gmarik/Vundle.vim.git'
  let path = substitute( $HOME . '/.vim/bundle/Vundle.vim', '/', has( 'win32' ) ? '\\' : '/', 'g' )
  if ! executable( 'git' )
    echohl ErrorMsg | echomsg 'Git is not available.' | echohl None | return 0
  endif
  if ! isdirectory( path )
    silent! if ! mkdir( path, 'p' )
      echohl ErrorMsg | echomsg 'Cannot create directory (may be a regular file): ' . path | echohl None | return 0
    endif
  endif
  echo 'Cloning vundle...'
  if system( 'git clone "' . vundle_repo . '" "' . path . '"'  ) =~ 'fatal'
    echohl ErrorMsg | echomsg 'Cannot clone ' . vundle_repo . ' (' . path . ' may be not empty)' | echohl None | return 0
  endif
  echo 'Vundle installed. Please restart vim and run :PluginInstall'
  return 1
endfunction

set tabpagemax=100

set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1

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
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 0

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

" Diffs
set diffopt=filler,iwhite

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

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
" this very one!).
set comments+=b:\"

" * Text Formatting -- Specific File Formats

set t_Co=16
set background=dark
colorscheme solarized

highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000

set lazyredraw

" enable filetype detection:
filetype plugin indent on
set autoindent
set smartindent

augroup filetype
  autocmd BufNewFile,BufRead *.txt setlocal filetype=human
  autocmd BufNewFile,BufRead CMake*.txt setlocal filetype=cmake
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

" Cycle through tabs with Ctrl-Tab and Ctrl-Shift-Tab
noremap <C-Tab> gt
inoremap <C-Tab> gt
noremap <C-S-Tab> gT
inoremap <C-S-Tab> gT

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

" Unite configuration and mappings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#default_action('file', 'tabswitch')
"call unite#custom#default_action('grep', 'tabswitch')
call unite#custom#default_action('vim_bookmarks', 'tabswitch')
let g:unite_source_grep_max_candidates = 600
if executable('ack')
    " Use ack in unite grep source.
    let g:unite_source_rec_async_command = 'find'
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--smart-case --no-break --nocolor -H --word-regexp --nofollow'
endif
nnoremap <buffer><expr> t unite#smart_map("t", unite#do_action('tabswitch'))

let g:bookmark_no_default_key_mappings = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_center = 1

highlight SignColumn ctermbg=0
highlight SignColumn ctermfg=4

" Finds the Git super-project directory.
function! g:BMBufferFileLocation(file)
    let filename = 'vim-bookmarks'
    let current_loc = ''
    let location = ''
    if expand("%") ==# ""
        let current_loc = expand("%:p:h")
    else
        let current_loc = a:file
    endif

    if isdirectory(fnamemodify(current_loc, ":p:h").'/.git')
        " Current work dir is git's work tree
        let location = fnamemodify(current_loc, ":p:h")
    else
        " Look upwards (at parents) for a directory named '.git'
        let location = finddir('.git', fnamemodify(current_loc, ":p:h").'/.;').'/..'
    endif
    if len(location) > 0
        return simplify(location.'/.'.filename)
    else
        return simplify(fnamemodify(a:file, ":p:h").'/.'.filename)
    endif
endfunction

" vim-autoformat configuration
let g:formatprg_c = "astyle"
let g:formatprg_cpp = g:formatprg_c
let g:formatprg_args_c = '--style=attach --keep-one-line-blocks --keep-one-line-statements --add-brackets --indent=spaces=4 --attach-namespaces --indent-preproc-block --indent-preproc-define --indent-col1-comments --min-conditional-indent=0 --max-instatement-indent=120 --unpad-paren --pad-oper --pad-header --align-pointer=name --break-closing-brackets --max-code-length=200 --break-after-logical'
let g:formatprg_args_cpp = g:formatprg_args_c

" relative/absolute line numbers
set number
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

" bracket auto-closing
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

" trailing space cleanup
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

let g:current_project_dir = ''
function! OpenProject()
    if !exists("t:NERDTreeBufName") && exists('g:loaded_nerd_tree')
        let g:current_project_dir = expand("%:p:h")
        call g:NERDTreeCreator.CreatePrimary(g:current_project_dir)
    endif
endfunction

au BufReadPost CMakeLists.txt call OpenProject()

function! CompileProject()
    let concurrency = system('/bin/echo -n $(cat /proc/cpuinfo | grep "^processor" | wc -l)')
    execute 'Dispatch' 'make' '-j'.concurrency '-C' g:current_project_dir
endfunction

let g:marked_app = "/Applications/Marked\ 2.app/Contents/MacOS/Marked\ 2"

nnoremap <leader>nb :<C-u>Unite buffer<CR>

au FileType c,cpp,slang nmap <leader>gd :<C-u>YcmCompleter GoTo<CR>
au FileType c,cpp,slang nmap <leader>gt :<C-u>YcmCompleter GetType<CR>

" Go
au FileType go nmap <leader>gs <Plug>(go-implements)
au FileType go nmap <leader>gi <Plug>(go-info)
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-doc)
"au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gd <Plug>(go-def-tab)
au FileType go nmap <leader>gc <Plug>(go-coverage)
au FileType go nmap <leader>ge <Plug>(go-rename)
au FileType go nmap gd <Plug>(go-def)

" Source Control
nnoremap <silent> <leader>ss :<C-u>Gstatus<CR>
nnoremap <silent> <leader>sd :<C-u>Gdiff<CR>
nnoremap <silent> <leader>sw :<C-u>Gwrite<CR>
nnoremap <silent> <leader>sr :<C-u>Gread<CR>
nnoremap <silent> <leader>sc :<C-u>Gcommit<CR>
nnoremap <silent> <leader>sb :<C-u>Gblame<CR>
nnoremap <silent> <leader>sh :<C-u>Gitv<CR>
nnoremap <silent> <leader>sf :<C-u>Gitv!<CR>
vnoremap <silent> <leader>sf :<C-u>Gitv!<CR>

" File Access
nnoremap <leader>fo :<C-u>Unite -no-split -start-insert -sync -default-action=open file_rec/async:!<CR>
nnoremap <leader>fr :<C-u>Unite -start-insert -default-action=tabswitch -sync file_rec/async:!<CR>

" Ack/grep
nnoremap <leader>ac :<C-u>UniteWithCursorWord -no-quit grep:.<CR>
nnoremap <leader>al :<C-u>Unite -no-quit grep:.<CR>

" vim-bookmarks configuration and mappings
nmap <leader>bt :<C-u>BookmarkToggle<CR>
nmap <leader>bi :<C-u>BookmarkAnnotate<CR>
nmap <leader>ba :<C-u>BookmarkShowAll<CR>
nmap <leader>bn :<C-u>BookmarkNext<CR>
nmap <leader>bp :<C-u>BookmarkPrev<CR>
nmap <leader>bc :<C-u>BookmarkClear<CR>
nmap <leader>bx :<C-u>BookmarkClearAll<CR>

noremap <leader>af :Autoformat<CR><CR>

" Toggles
" Keystrokes to toggle options are defined here.  They are all set to normal
" mode keystrokes beginning \t but some function keys (which won't work in all
" terminals) are also mapped.

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap <silent> <leader>th :<C-u>set invhls hls?<CR>
nnoremap <silent> <leader>tn :<C-u>call NumberToggle()<CR>
nnoremap <silent> <leader>tw :<C-u>set invwrap wrap?<CR>
" have \tp ("toggle paste") toggle paste on/off and report the change
nnoremap <silent> <leader>tp :<C-u>set invpaste paste?<CR>

" External tasks
nnoremap <silent> <leader>eb :call CompileProject()<CR>
nnoremap <silent> <leader>em :<C-u>MarkedOpen<CR>

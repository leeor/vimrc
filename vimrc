" vim:fdm=marker
" .vimrc

" with inspiration from:
" https://github.com/joedicastro/dotfiles/blob/master/vim/vimrc
" https://github.com/zaiste/vimified/blob/20d3fa6a9648301fd9c5f86322614d59301868bc/vimrc

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
let s:uname = system('uname')[0:-2]

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

" Unite plugin that provides command line completion
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
NeoBundle 'joedicastro/vim-github-dashboard'
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

NeoBundle 'lyuts/vim-rtags'

" YouCompleteMe {{{

NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'rdnetto/YCM-Generator'

" }}}

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Chiel92/vim-autoformat'
NeoBundle 'vim-scripts/argtextobj.vim'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'mtth/scratch.vim'

" undo on steroids
NeoBundleLazy 'sjl/gundo.vim', { 'autoload' : {'commands': 'GundoToggle'}}

" colorschemes {{{

NeoBundle 'altercation/vim-colors-solarized'

" }}}

" OS-specific bundles {{{

let s:os_bundles = expand(s:dotvim . '/' . s:uname . '.bundles')
if filereadable(s:os_bundles)
    exec ':so ' . s:os_bundles
endif

" }}}

" local bundles {{{

let s:local_bundles = expand(s:dotvim . '/local.bundles')
if filereadable(s:local_bundles)
    exec ':so ' . s:local_bundles
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
let maplocalleader=' '

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
set viminfo='1000,f0,<500,/10,r/mnt,h

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

set scrolloff=5

" cursor change (block <-> line) in TMUX
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

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
    if s:uname ==# "Linux"
        let g:solarized_contrast="high"
    endif
    colorscheme solarized
endif

" }}}

" highlighting {{{

highlight SignColumn ctermbg=0
highlight SignColumn ctermfg=4

highlight diffAdded guifg=#00bf00
highlight diffRemoved guifg=#bf0000

" line highlight {{{

" Highlight current line
autocmd WinLeave * set nocursorline
" in current window
autocmd WinEnter * set cursorline

" }}}

" highlight last inserted text {{{
nnoremap gV `[v`]

" }}}

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

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

set nostartofline

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ convert case over line breaks; also have the cursor keys
" wrap in insert, visual, and normal modes:
set whichwrap=h,l,~,[,],<,>

nnoremap j gj
nnoremap k gk

" }}}

" shortmess {{{

set shortmess+=a
set shortmess+=I

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

" Syntastic {{{

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", " proprietary attribute \"app-", " proprietary attribute \"class\""]

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '⚡'
let g:syntastic_style_warning_symbol = '⚡'

" }}}

" Easymotion {{{

" easymotion search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" }}}

" vim-rtags {{{

let g:rtagsUseDefaultMappings = 0

" }}}

" YouCompleteMe {{{

set completeopt-=preview
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_invoke_completion = '<C-Space>'

" }}}

" fugitive {{{

nnoremap <Leader>gn :Unite output:echo\ system("git\ init")<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>go :Gread<CR>
nnoremap <Leader>gR :Gremove<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gB :Gbrowse<CR>
nnoremap <Leader>gp :Git! push<CR>
nnoremap <Leader>gP :Git! pull<CR>
nnoremap <Leader>gi :Git!<Space>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gE :Gedit<Space>
nnoremap <Leader>gl :exe "silent Glog <Bar> Unite -no-quit
            \ quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gL :exe "silent Glog -- <Bar> Unite -no-quit
            \ quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gt :!tig<CR>:redraw!<CR>
nnoremap <Leader>gS :exe "silent !shipit"<CR>:redraw!<CR>
nnoremap <Leader>gg :exe 'silent Ggrep -i '.input("Pattern: ")<Bar>Unite
            \ quickfix -no-quit<CR>
nnoremap <Leader>ggm :exe 'silent Glog --grep='.input("Pattern: ").' <Bar>
            \Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggt :exe 'silent Glog -S='.input("Pattern: ").' <Bar>
            \Unite -no-quit quickfix'<CR>

nnoremap <Leader>ggc :silent! Ggrep -i<Space>

" for the diffmode
noremap <Leader>du :diffupdate<CR>

if !exists(":Gdiffoff")
    command Gdiffoff diffoff | q | Gedit
endif
noremap <Leader>dq :Gdiffoff<CR>

" }}}

" Gitv {{{

let g:Gitv_OpenHorizontal = 1
let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_PromptToDeleteMergeBranch = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1
cabbrev gitv Gitv

nnoremap <silent> <leader>gv :Gitv --all<CR>
nnoremap <silent> <leader>gV :Gitv! --all<CR>
vnoremap <silent> <leader>gV :Gitv! --all<CR>

" }}}

" Unite {{{

" defaults {{{

call unite#filters#sorter_default#use(['sorter_rank'])

let g:default_context = {
    \ 'winheight' : 15,
    \ 'update_time' : 200,
    \ 'prompt' : '>>> ',
    \ 'enable_start_insert' : 0,
    \ 'enable_short_source_names' : 0,
    \ 'marked_icon' : '✓',
    \ 'ignorecase' : 1,
    \ 'smartcase' : 1,
\ }

call unite#custom#profile('default', 'context', default_context)

let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_split_rule = 'botright'
let g:unite_data_directory = s:dotvim.'/tmp/unite'
call MakeDirIfNoExists(s:dotvim.'/tmp/unite')

" }}}

" time formats {{{

let g:unite_source_buffer_time_format = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_file_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '

" }}}

" grep {{{

let g:unite_source_grep_max_candidates = 0
let g:unite_source_rec_async_command = 'find'
"if executable('ag')
"    let g:unite_source_grep_command='ag'
"    let g:unite_source_grep_default_opts='--nocolor --nogroup --noheading -a -S -w'
"    let g:unite_source_grep_recursive_opt=''
"    let g:unite_source_grep_search_word_highlight = 1
if executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--smart-case --no-break --nocolor -H --nofollow'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
endif

" }}}

nnoremap <leader>ur :<C-u>UniteResume<CR>

" Menus {{{

" menu prefix key (for all Unite menus) {{{
nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
" }}}

" menus menu {{{
nnoremap <silent>[menu]u :Unite -silent -winheight=20 menu<CR>

let g:unite_source_menu_menus = {}

" }}}

" files menu {{{

" File Access
nnoremap <leader>fo :<C-u>Unite -start-insert -sync -default-action=open file_rec/async:!<CR>
nnoremap <leader>fm :<C-u>Unite file_mru<CR>

let g:unite_source_menu_menus.files = {
    \ 'description' : '          files & dirs
        \                                          ⌘ [space]o',
    \}
let g:unite_source_menu_menus.files.command_candidates = [
        \['▷ open file                                                  ⌘ ,fo',
            \'Unite -no-split -start-insert -sync -default-action=open file_rec/async:!'],
        \['▷ open more recently used files                              ⌘ ,fm',
            \'Unite file_mru'],
        \['▷ save as root                                               ⌘ :w!!',
            \'exe "write !sudo tee % >/dev/null"'],
    \]

nnoremap <silent>[menu]o :Unite -silent -winheight=17 -start-insert menu:files<CR>
" }}}

" file searching menu {{{

" Ack/grep
nnoremap <leader>ac :<C-u>UniteWithCursorWord -start-insert grep:.:--word-regexp<CR>
nnoremap <leader>aC :<C-u>UniteWithCursorWord -start-insert -no-quit grep:.:--word-regexp<CR>
nnoremap <leader>al :<C-u>Unite -start-insert grep:.<CR>
nnoremap <leader>aL :<C-u>Unite -start-insert -no-quit grep:.<CR>

let g:unite_source_menu_menus.grep = {
    \ 'description' : '           search files
        \                                          ⌘ [space]a',
    \}
let g:unite_source_menu_menus.grep.command_candidates = [
    \['▷ grep current word (ag → ack → grep)                        ⌘ ,ac',
        \'UniteWithCursorWord -start-insert grep:.:--word-regexp'],
    \['▷ grep current word (ag → ack → grep, persist)               ⌘ ,aC',
        \'UniteWithCursorWord -no-quit -start-insert grep:.:--word-regexp'],
    \['▷ grep (ag → ack → grep)                                     ⌘ ,al',
        \'Unite -start-insert grep'],
    \['▷ grep (ag → ack → grep, persist)                            ⌘ ,aL',
        \'Unite -no-quit -start-insert grep'],
    \['▷ find',
        \'Unite find'],
    \['▷ locate',
        \'Unite -start-insert locate'],
    \]
nnoremap <silent>[menu]a :Unite -silent menu:grep<CR>

" }}}

" buffers, tabs & windows menu {{{

nnoremap <leader>nb :<C-u>Unite -start-insert buffer<CR>
nnoremap <leader>nB :<C-u>Unite tab<CR>
nnoremap <leader>nl :<C-u>Unite location_list<CR>
nnoremap <leader>nq :<C-u>Unite quickfix<CR>
nnoremap <leader>nc :<C-u>close<CR>
nnoremap <leader>nd :<C-u>bd<CR>

let g:unite_source_menu_menus.navigation = {
    \ 'description' : '     navigate by buffers, tabs & windows
        \                   ⌘ [space]n',
    \}
let g:unite_source_menu_menus.navigation.command_candidates = [
    \['▷ buffers                                                    ⌘ ,nb',
        \'Unite buffer'],
    \['▷ tabs                                                       ⌘ ,nB',
        \'Unite tab'],
    \['▷ windows',
        \'Unite window'],
    \['▷ location list                                              ⌘ ,nl',
        \'Unite location_list'],
    \['▷ quickfix                                                   ⌘ ,nq',
        \'Unite quickfix'],
    \['▷ resize windows',
        \'WinResizerStartResize'],
    \['▷ close current window                                       ⌘ ,nc',
        \'close'],
    \['▷ delete buffer                                              ⌘ ,nd',
        \'bd'],
    \]
nnoremap <silent>[menu]n :Unite -silent menu:navigation<CR>

" }}}

" source code menu {{{

au FileType c,cpp,cmake nnoremap <localleader>st :<C-u>Unite -start-insert -vertical -winwidth=40 -direction=topleft -toggle -buffer-name=outline outline<CR>
au FileType c,cpp,cmake nnoremap <localleader>sr :<C-u>Unite -auto-preview -start-insert rtags/references<CR>
au FileType c,cpp,cmake nnoremap <localleader>sd :<C-u>call rtags#JumpTo()<CR>
au FileType c,cpp,cmake nnoremap <localleader>ss :<C-u>Unite -auto-preview -start-insert rtags/symbol:i<CR>
au FileType c,cpp,cmake nnoremap <localleader>sS :<C-u>Unite -auto-preview -start-insert rtags/symbol<CR>
au FileType c,cpp,cmake nnoremap <localleader>sR :<C-u>call rtags#RenameSymbolUnderCursor()<CR>
au FileType c,cpp,cmake nnoremap <localleader>si :<C-u>call rtags#SymbolInfo()<CR>
au FileType c,cpp,cmake nnoremap <localleader>sI :<C-u>call rtags#ReindexFile()<CR>
au FileType c,cpp,cmake nnoremap <localleader>sP :<C-u>call rtags#PreprocessFile()<CR>
au FileType c,cpp,cmake nnoremap <localleader>sp :<C-u>Unite -start-insert rtags/project<CR>

let g:unite_source_menu_menus.source_code = {
    \ 'description' : '    source code menu
        \                                      ⌘ [space]s',
    \}
let g:unite_source_menu_menus.source_code.command_candidates = [
    \['▷ show outlines & tags (ctags)                               ⌘ [space]st',
        \'Unite -start-insert -vertical -winwidth=40 -direction=topleft -toggle -buffer-name=outline outline'],
    \['▷ search for references                                      ⌘ [space]sr',
        \'Unite -auto-preview -start-insert rtags/references'],
    \['▷ jump to definition                                         ⌘ [space]sd',
        \'call rtags#JumpTo()'],
    \['▷ find symbol by name                                        ⌘ [space]ss',
        \'Unite -auto-preview -start-insert rtags/symbol:i'],
    \['▷ find symbol by name (case sensitive)                       ⌘ [space]sS',
        \'Unite -auto-preview -start-insert rtags/symbol'],
    \['▷ rename symbol under cursor                                 ⌘ [space]sR',
        \'call rtags#RenameSymbolUnderCursor()'],
    \['▷ symbol info                                                ⌘ [space]si',
        \'call rtags#SymbolInfo()'],
    \['▷ reindex current file                                       ⌘ [space]sI',
        \'call rtags#ReindexFile()'],
    \['▷ preprocess current file                                    ⌘ [space]sP',
        \'call rtags#PreprocessFile()'],
    \['▷ select project                                             ⌘ [space]sp',
        \'call rtags#ProjectList()'],
    \]


" }}}

" buffer internal searching menu {{{

nnoremap <leader>fl :<C-u>Unite -auto-preview -start-insert line<CR>
nnoremap [menu]* :<C-u>UniteWithCursorWord -no-split -auto-preview line<CR>
nnoremap <leader>ft :<C-u>Unite -vertical -winwidth=40 -direction=topleft -toggle outline<CR>
nnoremap <leader>fm :<C-u>Unite -auto-preview marks<CR>
nnoremap <leader>f; :<C-u>Unite -toggle grep:%::FIXME\|TODO\|NOTE\|XXX\|@todo<CR>

let g:unite_source_menu_menus.searching = {
    \ 'description' : '      searches inside the current buffer
        \                    ⌘ [space]f',
    \}
let g:unite_source_menu_menus.searching.command_candidates = [
    \['▷ search line                                                ⌘ ,fl',
        \'Unite -auto-preview -start-insert line'],
    \['▷ search word under the cursor                               ⌘ [space]*',
        \'UniteWithCursorWord -no-split -auto-preview line'],
    \['▷ search marks',
        \'Unite -auto-preview mark                                  ⌘ ,fm'],
    \['▷ search folds',
        \'Unite -vertical -winwidth=30 -auto-highlight fold'],
    \['▷ search changes',
        \'Unite change'],
    \['▷ search jumps',
        \'Unite jump'],
    \['▷ search undos',
        \'Unite undo'],
    \['▷ search tasks                                               ⌘ ,f;',
        \'Unite -toggle grep:%::FIXME|TODO|NOTE|XXX|@todo'],
    \]
nnoremap <silent>[menu]f :Unite -silent menu:searching<CR>
" }}}

" yanks, registers & history menu {{{

nnoremap <leader>i :<C-u>Unite history/yank<CR>
nnoremap <leader>q: :<C-u>Unite history/command<CR>
nnoremap <leader>q/ :<C-u>Unite history/search<CR>

let g:unite_source_menu_menus.registers = {
    \ 'description' : '      yanks, registers & history
        \                            ⌘ [space]i',
    \}
let g:unite_source_menu_menus.registers.command_candidates = [
    \['▷ yanks                                                      ⌘ ,i',
        \'Unite history/yank'],
    \['▷ commands       (history)                                   ⌘ q:',
        \'Unite history/command'],
    \['▷ searches       (history)                                   ⌘ q/',
        \'Unite history/search'],
    \['▷ registers',
        \'Unite register'],
    \['▷ messages',
        \'Unite output:messages'],
    \]
nnoremap <silent>[menu]i :Unite -silent menu:registers<CR>
" }}}

" text editing menu {{{

nnoremap <leader>tg :<C-u>GundoToggle<CR>

let g:unite_source_menu_menus.text = {
    \ 'description' : '           text editing
        \                                          ⌘ [space]e',
    \}
let g:unite_source_menu_menus.text.command_candidates = [
    \['▷ toggle gundo                                               ⌘ ,tg',
        \'GundoToggle'],
    \['▷ toggle search results highlight                            ⌘ ,th',
        \'set invhlsearch'],
    \['▷ toggle line numbers                                        ⌘ ,tn',
        \'call NumberToggle()'],
    \['▷ toggle wrapping                                            ⌘ ,tw',
        \'set invwrap wrap?'],
    \['▷ toggle fold                                                ⌘ za',
        \'normal za'],
    \['▷ open all folds                                             ⌘ zR',
        \'normal zR'],
    \['▷ close all folds                                            ⌘ zM',
        \'normal zM'],
    \['▷ toggle paste mode                                          ⌘ ,tp',
        \'normal ,P'],
    \['▷ remove trailing whitespaces                                ⌘ ,rt',
        \'normal ,et'],
    \]
nnoremap <silent>[menu]e :Unite -silent -winheight=20 menu:text <CR>
" }}}

" neobundle menu {{{
let g:unite_source_menu_menus.neobundle = {
    \ 'description' : '      plugins administration with neobundle
        \                 ⌘ [space]b',
    \}
let g:unite_source_menu_menus.neobundle.command_candidates = [
    \['▷ neobundle',
        \'Unite neobundle'],
    \['▷ neobundle log',
        \'Unite neobundle/log'],
    \['▷ neobundle lazy',
        \'Unite neobundle/lazy'],
    \['▷ neobundle update',
        \'Unite neobundle/update'],
    \['▷ neobundle search',
        \'Unite neobundle/search'],
    \['▷ neobundle install',
        \'Unite neobundle/install'],
    \['▷ neobundle check',
        \'Unite -no-empty output:NeoBundleCheck'],
    \['▷ neobundle docs',
        \'Unite output:NeoBundleDocs'],
    \['▷ neobundle clean',
        \'NeoBundleClean'],
    \['▷ neobundle rollback',
        \'exe "NeoBundleRollback" input("plugin: ")'],
    \['▷ neobundle list',
        \'Unite output:NeoBundleList'],
    \['▷ neobundle direct edit',
        \'NeoBundleExtraEdit'],
    \]
nnoremap <silent>[menu]b :Unite -silent -start-insert menu:neobundle<CR>
" }}}

" git menu {{{
let g:unite_source_menu_menus.git = {
    \ 'description' : '            admin git repositories
        \                                ⌘ [space]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ git viewer             (gitv)                              ⌘ ,gv',
        \'normal ,gv'],
    \['▷ git viewer - buffer    (gitv)                              ⌘ ,gV',
        \'normal ,gV'],
    \['▷ git status             (fugitive)                          ⌘ ,gs',
        \'Gstatus'],
    \['▷ git diff               (fugitive)                          ⌘ ,gd',
        \'Gdiff'],
    \['▷ git commit             (fugitive)                          ⌘ ,gc',
        \'Gcommit'],
    \['▷ git log                (fugitive)                          ⌘ ,gl',
        \'exe "silent Glog | Unite -no-quit quickfix"'],
    \['▷ git log - all          (fugitive)                          ⌘ ,gL',
        \'exe "silent Glog -all | Unite -no-quit quickfix"'],
    \['▷ git blame              (fugitive)                          ⌘ ,gb',
        \'Gblame'],
    \['▷ git add/stage          (fugitive)                          ⌘ ,gw',
        \'Gwrite'],
    \['▷ git checkout           (fugitive)                          ⌘ ,go',
        \'Gread'],
    \['▷ git rm                 (fugitive)                          ⌘ ,gR',
        \'Gremove'],
    \['▷ git mv                 (fugitive)                          ⌘ ,gm',
        \'exe "Gmove " input("destino: ")'],
    \['▷ git push               (fugitive, buffer output)           ⌘ ,gp',
        \'Git! push'],
    \['▷ git pull               (fugitive, buffer output)           ⌘ ,gP',
        \'Git! pull'],
    \['▷ git command            (fugitive, buffer output)           ⌘ ,gi',
        \'exe "Git! " input("comando git: ")'],
    \['▷ git edit               (fugitive)                          ⌘ ,gE',
        \'exe "command Gedit " input(":Gedit ")'],
    \['▷ git grep               (fugitive)                          ⌘ ,gg',
        \'exe "silent Ggrep -i ".input("Pattern: ") | Unite -no-quit quickfix'],
    \['▷ git grep - messages    (fugitive)                          ⌘ ,ggm',
        \'exe "silent Glog --grep=".input("Pattern: ")." | Unite -no-quit quickfix"'],
    \['▷ git grep - text        (fugitive)                          ⌘ ,ggt',
        \'exe "silent Glog -S".input("Pattern: ")." | Unite -no-quit quickfix"'],
    \['▷ git init                                                   ⌘ ,gn',
        \'Unite output:echo\ system("git\ init")'],
    \['▷ git cd                 (fugitive)',
        \'Gcd'],
    \['▷ git lcd                (fugitive)',
        \'Glcd'],
    \['▷ git browse             (fugitive)                          ⌘ ,gB',
        \'Gbrowse'],
    \['▷ github dashboard       (github-dashboard)                  ⌘ ,gD',
        \'exe "GHD! " input("Username: ")'],
    \['▷ github activity        (github-dashboard)                  ⌘ ,gA',
        \'exe "GHA! " input("Username or repository: ")'],
    \['▷ github issues & PR                                         ⌘ ,gS',
        \'normal ,gS'],
    \]
nnoremap <silent>[menu]g :Unite -silent -winheight=29 -start-insert menu:git<CR>
" }}}

" vim menu {{{
let g:unite_source_menu_menus.vim = {
    \ 'description' : '            vim
        \                                                   ⌘ [space]v',
    \}
let g:unite_source_menu_menus.vim.command_candidates = [
    \['▷ choose colorscheme',
        \'Unite colorscheme -auto-preview'],
    \['▷ mappings',
        \'Unite mapping -start-insert'],
    \['▷ edit configuration file (vimrc)',
        \'edit $MYVIMRC'],
    \['▷ choose filetype',
        \'Unite -start-insert filetype'],
    \['▷ vim help',
        \'Unite -start-insert help'],
    \['▷ vim commands',
        \'Unite -start-insert command'],
    \['▷ vim functions',
        \'Unite -start-insert function'],
    \['▷ vim runtimepath',
        \'Unite -start-insert runtimepath'],
    \['▷ vim command output',
        \'Unite output'],
    \['▷ unite sources',
        \'Unite source'],
    \['▷ kill process',
        \'Unite -default-action=sigkill -start-insert process'],
    \['▷ launch executable (dmenu like)',
        \'Unite -start-insert launcher'],
    \]
nnoremap <silent>[menu]v :Unite menu:vim -silent -start-insert<CR>
" }}}

" }}}

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

" gundo {{{

let g:gundo_preview_bottom = 1

" }}}

" Auto commands {{{

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

autocmd! BufWritePost vimrc :so %

" when we reload, tell vim to restore the cursor to the saved position
autocmd! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" | endif
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

" additional functions {{{

exec ':so '.s:dotvim.'/functions/rename3.vim'

" }}}

" os-specific and local config {{{

let s:os_vimrc = expand(s:dotvim . '/' . s:uname . '.vimrc')
if filereadable(s:os_vimrc)
    exec ':so ' . s:os_vimrc
endif

let s:local_vimrc = expand(s:dotvim . '/local.vimrc')
if filereadable(s:local_vimrc)
    exec ':so ' . s:local_vimrc
endif

" }}}

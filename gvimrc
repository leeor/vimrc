if has("gui_gtk2")
    set guifont=Sauce\ Code\ Powerline\ 11
elseif has("gui_macvim")
    set guifont=Sauce\ Code\ Powerline:h12
elseif has ("gui_win32")
    set guifont=Sauce\ Code\ Powerline:h12
end

set noantialias

set lines=53
set columns=120

set guioptions=gmr

highlight SignColumn guibg=#073642
highlight BookmarkSign guifg=Cyan

au FileType go TagbarOpen

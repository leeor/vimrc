if has("gui_gtk2")
    set guifont=Inconsolata-dz\ Medium\ 11
elseif has("gui_macvim")
    set guifont=Inconsolata-dz\ for\ Powerline:h12
elseif has ("gui_win32")
    set guifont=Inconsolata-dz\ for\ Powerline:h12
end

set noantialias

set lines=53
set columns=120

set guioptions=gmr

highlight SignColumn guibg=#073642
highlight BookmarkSign guifg=Cyan

au FileType go TagbarOpen

set go-=T                       " hide the toolbar
set go-=m                       " hide the menu
" The next two lines are quite tricky, but in Gvim, if you don't do this, if you
" only hide all the scrollbars, the vertical scrollbar is showed anyway
set go+=rRlLbh                  " show all the scrollbars
set go-=rRlLbh                  " hide all the scrollbars

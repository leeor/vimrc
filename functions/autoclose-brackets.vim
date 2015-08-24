" bracket auto-closing
function! AutocloseToggle()
    if (g:autoclose_on == 0)
        let g:autoclose_on=1
        inoremap { {}<left>
        inoremap ( ()<left>
        inoremap [ []<left>
        inoremap " ""<left>
        inoremap ' ''<left>
    else
        let g:autoclose_on=0
        inoremap { {
        inoremap ( (
        inoremap [ [
        inoremap " "
        inoremap ' '
    endif
endfunc

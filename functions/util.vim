function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

" Remove last \r,\n,\r\n from a:str.
function! Chomp(str)
  return substitute(a:str, '\%(\r\n\|[\r\n]\)$', '', '')
endfunction

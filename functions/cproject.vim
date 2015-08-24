let g:current_project_dir = ''
function! OpenProject()
    if g:current_project_dir == ''
        let g:current_project_dir = expand("%:p:h")
        call VimFilerExplorer
        nnoremap <silent> <leader>eb :call CompileProject()<CR>
    endif
endfunction

function! CompileProject()
    let concurrency = system('/bin/echo -n $(cat /proc/cpuinfo | grep "^processor" | wc -l)')
    execute 'Dispatch' 'make' '-j'.concurrency '-C' g:current_project_dir
endfunction

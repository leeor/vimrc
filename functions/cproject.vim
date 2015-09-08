let g:current_project_dir = '.'
function! OpenProject()
    if g:current_project_dir == ''
        let g:current_project_dir = expand("%:p:h")
    endif
    nnoremap <silent> <leader>eb :call CompileProject()<CR>
endfunction

function! CompileProject()
    if (filereadable('/proc/cpuinfo'))
        let concurrency = system('/bin/echo -n $(cat /proc/cpuinfo | grep "^processor" | wc -l)')
    elseif (system('/bin/echo -n $(uname)') ==# 'Darwin')
        let concurrency = system('/bin/echo -n $(sysctl -n hw.ncpu)')
    endif
    execute 'Dispatch' 'make' '-j'.concurrency '-C' g:current_project_dir
endfunction

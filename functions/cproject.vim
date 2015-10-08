let g:current_project_dir = '.'
function! CompileProject()
    let make_cmd = ''
    let make_args = ''
    if (filereadable(g:current_project_dir . "/build.ninja"))
        let make_cmd = 'ninja'
    elseif (filereadable(g:current_project_dir . "/Makefile"))
        let make_cmd = 'make'
        if (filereadable('/proc/cpuinfo'))
            let concurrency = system('/bin/echo -n $(cat /proc/cpuinfo | grep "^processor" | wc -l)')
        elseif (system('/bin/echo -n $(uname)') ==# 'Darwin')
            let concurrency = system('/bin/echo -n $(sysctl -n hw.ncpu)')
        endif
        let make_args = '-j'.concurrency
    endif

    if (make_cmd != '')
        exec 'set makeprg=' . make_cmd . '\ ' . make_args . '\ -C\ ' . g:current_project_dir
        exec 'Make'
    endif
endfunction

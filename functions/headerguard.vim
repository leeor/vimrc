function! AddHeaderGuard()
    let m = matchlist(bufname("%"), '.*/\(.*\.h\)$\|\(.*\.h\)$')
    let fname = substitute((m[1] == "") ? m[2] : m[1], '\.', '_', 'g')

    if fname != ""
        let guard = "__" . toupper(fname) . "__"
        call append(0, ["#ifndef " . guard, "#define " . guard])
        call append(line('$'), "#endif /* " . guard . " */")
    endif
endfunction " AddHeaderGuard()

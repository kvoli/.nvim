let g:vimtex_view_method='zathura'
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_method='latexmk'
let g:vimtex_syntax_nospell_comments=1
let g:vimtex_quickfix_method='pulp'

let g:vimtex_compiler_latexmk = {
                  \ 'build_dir' : '',
                  \ 'callback' : 1,
                  \ 'continuous' : 1,
                  \ 'executable' : 'latexmk',
                  \ 'hooks' : [],
                  \ 'options' : [
                  \   '-verbose',
                  \   '-file-line-error',
                  \   '-synctex=1',
                  \   '-interaction=nonstopmode',
                  \   '-shell-escape',
                  \ ],
                  \}

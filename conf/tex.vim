let g:vimtex_view_method='zathura'
let g:tex_flavor='latex'
let g:vimtex_syntax_nospell_comments=1
let g:vimtex_compiler_latexrun_engines = {'_': 'xelatex'}
let g:vimtex_compiler_latexmk_engines = {'_': '-xelatex'}
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'out',
      \ 'callback' : 1,
      \ 'continuous' : 1,
      \ 'options' : [
      \   '-shell-escape',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}
let g:vimtex_syntax_packages = {'minted': {'load': 1}}
let g:vimtex_quickfix_open_on_warning = 0
let g:Tex_IgnoredWarnings =
      \'Underfull'."\n".
      \'Overfull'."\n".
      \'specifier changed to'."\n".
      \'You have requested'."\n".
      \'Missing number, treated as zero.'."\n".
      \'There were undefined references'."\n".
      \'Citation %.%# undefined'."\n".
      \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 8

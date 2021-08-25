let g:mapleader = "\<Space>"            " set leader key

syntax enable                           " Enables syntax highlighing

let g:base16_shell_path="/home/kvoli/.config/base16/output/shell/"
let base16colorspace=256  " Access colors present in 256 colorspace

"au BufWrite * :Autoformat               " format on write

highlight VertSplit cterm=NONE          " rm vertical split
highlight HorizontalSplit cterm=NONE    " rm horizontal split

set relativenumber                      " set relative numbering
set hidden                              " to enable multi
set wrap                                " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                        " treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set autoindent                          " Makes indenting automatic
set smartindent                         " Makes indenting smart
set cindent                             " Makes indenting smarter for c programs
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set foldcolumn=0                        " remove highlighting on bars
set signcolumn=no                       " remove highlighting on bars
set spelllang=en_us                     " set language to american english
set fillchars+=vert:\                   " set split char to null
set undodir=~/.config/nvim/undo/        " set local change dir for undo plug
set undofile                            " set undo on
let g:polyglot_disabled = ['solidity']  " set disabled syntax hightlighting for solidity smart contracts

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

function! s:base16_customize() abort
  call Base16hi("VertSplit", g:base16_gui00, g:base16_gui00, g:base16_cterm00, g:base16_cterm00, "", "")
  call Base16hi("HorizontalSplit", g:base16_gui00, g:base16_gui00, g:base16_cterm00, g:base16_cterm00, "", "")
  call Base16hi("LineNr", g:base16_gui03, g:base16_gui00, g:base16_cterm03, g:base16_cterm00, "", "")
  call Base16hi("CursorLineNr", g:base16_gui06, g:base16_gui00, g:base16_cterm06, g:base16_cterm00, "", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END


autocmd VimEnter * hi Normal ctermbg=none
autocmd vimenter * ++nested colorscheme void-bear

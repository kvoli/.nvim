let g:mapleader = "\<Space>"            " set leader key

syntax enable                           " Enables syntax highlighing

highlight VertSplit cterm=NONE          " rm vertical split
highlight HorizontalSplit cterm=NONE    " rm horizontal split
"au BufWrite * :Autoformat               " format on write

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
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set foldcolumn=0                        " remove highlighting on bars
set signcolumn=no                       " remove highlighting on bars
set spelllang=en_us                     " set language to american english
set fillchars+=vert:\                   " set split char to null
set undodir=~/.config/nvim/undo/        " set local change dir for undo plug
set undofile                            " set undo on
let g:polyglot_disabled = ['solidity']  " set disabled syntax hightlighting for solidity smart contracts

autocmd VimEnter * hi Normal ctermbg=none
autocmd vimenter * ++nested colorscheme wal

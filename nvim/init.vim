call plug#begin('~/AppData/Local/nvim/plugged')

" Dark theme
Plug 'joshdick/onedark.vim'

" Does what vcvarsall.bat does and add everything from VisualStudio to the PATH
Plug 'hattya/vcvars.vim'

" Automatically close your brackets/etc
Plug 'jiangmiao/auto-pairs'
" Add back closing tag for jiangmiao/auto-pairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<C-b>'

" Displays a | for indentation
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '⁞'
let g:indentLine_color_term = 239 " Solarized base2 color 

" Overwrites Yggdroot/indentLine conceal level properly for Json
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Nice status bar
Plug 'vim-airline/vim-airline'
" Disable all extensions for vim-airline for better performance
let g:airline_extensions=['coc']
let g:airline#extensions#coc#enabled = 1

" Displays directory file system on the side
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['.git$']

" Markdown
Plug 'gabrielelana/vim-markdown'

" Navigate large c/c++ projects and jump to definitions fast
Plug 'ludovicchabant/vim-gutentags'

" Code completion
Plug 'ycm-core/YouCompleteMe', { 'do': 'python install.py --tern-completer' }


call plug#end()

syntax on
colorscheme onedark
set encoding=utf-8
set updatetime=300
set signcolumn=yes
set wildmenu
set wildmode=full
set switchbuf=useopen,usetab
set history=500
set splitbelow
set splitright
set number

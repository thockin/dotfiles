set mouse=        " Disable nvim mouse handling
set nocompatible  " Enables Vim specific features
filetype off      " Reset filetype detection

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format.
" New installs need to
"     mkdir -p ~/.vim/bundle
"     git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
" Then run :PluginInstall
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" New installs need to run :GoInstallBinaries or :GoUpdateBinaries
Plugin 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_sameids = 0  " FIXME: breaks visual selections
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
let g:go_gopls_enabled = 1
nnoremap gp :GoDefPop<CR>
"let g:go_gopls_options = ["-rpc.trace",  "-logfile=/tmp/gopls.log", "-debug=localhost:8099"]
"let g:go_debug=['lsp', 'shell-commands']

" New installs need to run:
"     ./install.py --clangd-completer --go-completer
Plugin 'Valloric/YouCompleteMe'
let g:ycm_gopls_binary_path = 'gopls' " use $PATH

" New installs need to do (in vim): :Copilot setup
Plugin 'github/copilot.vim'
let g:copilot_workspace_folders = ['~/src/kubernetes', '~/src/git-sync-v4']

call vundle#end()

filetype plugin indent on       " Re-enable filetype detection

set bg=dark                     " I like dark backgrounds
"hi MatchParen cterm=bold,italic ctermbg=none
set guicursor=n-v-c-i:block
set ttyfast                     " Indicate fast terminal conn for faster redraw
set laststatus=1                " Show status line iff 2+ windows
set modeline                    " Allow file-embedded modelines
set hlsearch                    " Highlight search terms
set showcmd                     " Show last command
set completeopt=menuone         " Show insertion menu for completions
set list                        " Show listchars
set listchars=tab:»-\ ,extends:›,precedes:‹,nbsp:·,trail:·
set tabstop=4                   " Tab width
set shiftwidth=4                " How much to shoft text
set ai                          " Auto-indent
syn on                          " Syntax highlighting
set textwidth=78                " Default text width
set formatoptions+=t            " Textwidth formatting
set backspace=indent,eol,start  " Makes backspace key more powerful
set autowrite                   " Automatically save before :next, :make etc.
set cursorline                  " Highlight the current line
set formatoptions+=j            " Elide comment-leader when joining comment lines
set maxmempattern=10000         " Let plugins use more memory for things like syntax
set foldmethod=indent           " FIXME: "syntax" is better but suuuuuuper slow
set nofoldenable
set foldlevel=50
set timeoutlen=1000 ttimeoutlen=0 " kill some flicker
set signcolumn=number           " Show errors in the line-num column
set guicursor=a:blinkon100      " Blink the cursor

" Center search results
nnoremap n nzz
nnoremap N Nzz

" colors
colorscheme pablo
highlight CurSearch guifg=yellow guibg=NONE gui=bold

" syntax colors
highlight Comment           guifg=#a0c0ff guibg=NONE gui=NONE cterm=NONE
highlight LineNr            guifg=#afafaf guibg=NONE gui=NONE cterm=NONE
highlight Type              guifg=#60ff60 guibg=NONE gui=NONE cterm=NONE
highlight Special           guifg=#ff8888 guibg=NONE gui=NONE cterm=NONE
highlight YcmWarningSection guifg=#ff8844 guibg=NONE gui=NONE cterm=NONE

" diff colors
highlight diffFile      guifg=#ffff00 guibg=NONE gui=bold cterm=NONE
highlight diffIndexLine guifg=#ffff00 guibg=NONE gui=NONE cterm=NONE
highlight diffNewFile   guifg=#00ff00 guibg=NONE gui=NONE cterm=NONE
highlight diffOldFile   guifg=#ff3300 guibg=NONE gui=NONE cterm=NONE
highlight diffLine      guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
highlight diffSubname   guifg=#999999 guibg=NONE gui=NONE cterm=NONE
highlight diffAdded     guifg=#00ff00 guibg=NONE gui=NONE cterm=NONE
highlight diffRemoved   guifg=#ff3300 guibg=NONE gui=NONE cterm=NONE

" listchars colors
highlight Whitespace guifg=#888888 guibg=NONE gui=NONE cterm=NONE

" Popup menu colors
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=15 ctermbg=4 guifg=#ffffff guibg=#000000

" Go error messages
highlight SpellBad term=standout cterm=bold ctermfg=7 ctermbg=1 guifg=White guibg=Red


" Keyboard shortcuts
nnoremap % :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
" Jump to next window
nnoremap ww :wincmd w<CR>
" Jump to next/prev file
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" Go to begin/end
nnoremap gb [{
nnoremap ge ]}
nnoremap gt :GoDefType<CR>
" gd is already mapped to :GoDef

if has("autocmd")
    " When editing a file, always jump to the last cursor position
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" markdown
au BufRead,BufNewFile *.md set filetype=markdown

" go
au FileType go setl tabstop=4
au FileType go setl shiftwidth=4
au FileType go setl formatoptions-=t  " No textwidth formatting
au FileType go setl number
au FileType go setl nolist

" yaml
au FileType yaml setl indentkeys-=<:>
au FileType yaml setl tabstop=2
au FileType yaml setl shiftwidth=2
au FileType yaml setl expandtab
au FileType yaml setl number

" sh
au FileType sh setl expandtab
au FileType sh setl tabstop=4
au FileType sh setl shiftwidth=4
au FileType sh setl list

"""-au FileType python setlocal errorformat=%+P[%f],%t:\ %#%l:%m
"""-au FileType python setlocal makeprg=/home/build/static/projects/gpylint/gpylint.par\ %
"""-
"""-" make tw=0 when lines in the file are already longer than 80.
"""-" see   :help fo-table
"""-au BufEnter * setlocal formatoptions+=l
"""-
"""-augroup cprog
"""-  " Remove all cprog autocommands
"""-  au!
"""-
"""-  " When starting to edit a file:
"""-  "   For *.c and *.h files set formatting of comments and set C-indenting on.
"""-  "   For other files switch it off.
"""-  "   Don't change the order, it's important that the line with * comes first.
"""-
"""-  " i dont like cindent autoindent is fine with me.
"""- " autocmd BufRead *       set formatoptions=tcql nocindent comments&
"""- " autocmd BufRead *.c,*.h set formatoptions=croql nocindent ai comments=sr:/*,mb:*,el:*/,://
"""- "autocmd BufRead *.c,*.h,*.C,*.cc set formatoptions=croql cindent cinoptions={4 shiftwidth=4 comments=sr:/*,mb:*,el:*/,://
"""- "autocmd BufRead *.c,*.h,*.C,*.cc syn region myFold start="{" end="}" transparent fold
"""-" autocmd BufRead *.c,*.h,*.C,*.cc syn region myFold start="/\*" skip="/\*" end="\*/" transparent fold
"""- "autocmd BufRead *.c,*.h,*.C,*.cc syn region myComment	start=.^/\*. skip=./\*. end=.\*/. fold
"""- "autocmd BufRead *.c,*.h,*.C,*.cc hi def link myComment Comment
"""-
"""- "autocmd BufRead *.c,*.h,*.C,*.cc syn sync fromstart
"""- "autocmd BufRead *.c,*.h,*.C,*.cc set foldmethod=syntax
"""-augroup END
"""-

function! Marks()
    marks
    echo('Mark: ')

    " getchar() - prompts user for a single character and returns the chars
    " ascii representation
    " nr2char() - converts ASCII `NUMBER TO CHAR'

    let s:mark = nr2char(getchar())
    " remove the `press any key prompt'
    redraw

    " build a string which uses the `normal' command plus the var holding the
    " mark - then eval it.
    execute "normal! '" . s:mark
endfunction

nnoremap ' :call Marks()<CR>

source ~/.exrc

"""-:set textwidth=78
"""-:set expandtab
"""-:set fileformats=unix,dos
"""-:set viminfo='50,<200,/100
"""-:set history=50


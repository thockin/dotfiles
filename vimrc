set nocompatible  " Enables Vim specific features
filetype off      " Reset filetype detection

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/Vundle.vim'

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

Plugin 'Valloric/YouCompleteMe'

"Plugin 'bling/vim-airline'
"let g:airline#extensions#default#enabled = 0
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#left_sep = '**'
"let g:airline#extensions#tabline#left_alt_sep = '|'

call vundle#end()

filetype plugin indent on       " Re-enable filetype detection

set bg=dark                     " I like dark backgrounds
set ttyfast                     " Indicate fast terminal conn for faster redraw
set laststatus=1                " Show status line iff 2+ windows
set modeline                    " Allow file-embedded modelines
set hlsearch                    " Highlight search terms
set showcmd                     " Show last command
set completeopt=menuone         " Show insertion menu for completions
set list                        " Show listchars
set listchars=tab:>-,trail:_    " Render tabs and trailing spaces
set tabstop=4                   " Tab width
set shiftwidth=4                " How much to shoft text
set ai                          " Auto-indent
syn on                          " Syntax highlighting
set textwidth=78                " Default text width
set backspace=indent,eol,start  " Makes backspace key more powerful
set autowrite                   " Automatically save before :next, :make etc.
set cursorline                  " Highlight the current line

" Keyboard shortcuts
nnoremap % :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap ww :wincmd w<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
"nnoremap n nzzzv
"nnoremap N Nzzzv

if has("autocmd")
    " When editing a file, always jump to the last cursor position
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" markdown
au BufRead,BufNewFile *.md set filetype=markdown

" go
au FileType go setl tabstop=4
au FileType go setl shiftwidth=4
au FileType go setl textwidth=1000
au FileType go setl number
au FileType go setl nolist

" yaml
au FileType yaml setl indentkeys-=<:>
au FileType yaml setl tabstop=2
au FileType yaml setl shiftwidth=2
au FileType yaml setl expandtab
au FileType yaml setl number


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
"""-set hlsearch
"""-
"""-set bs=2		" allow backspacing over everything in insert mode
"""-
"""-"set exrc	       " allow exrc per dir
"""-"set secure	       " dont allow bad stuff in per-dir exrc
"""-
"""-"set cmdheight=3
"""-"set confirm            " To get a dialog when a command fails
"""-
"""-set laststatus=0
"""-set backup		" keep a backup file
"""-set backupdir=./.backup,/tmp,.
"""-
"""-set statusline=
"""-set swapsync=
"""-
"""-"map <F9> :set paste<CR>
"""-"map <F10> :set nopaste<CR>
"""-
"""-" shortcuts to jump around quickfixes.  zo opens the fold if any under the
"""-" match.
"""-map <F2> :cp<CR>zv
"""-map <S-F2> :cpf<CR>zv
"""-map <F3> :cc<CR>zv
"""-map <F4> :cn<CR>zv
"""-map <S-F4> :cnf<CR>zv
"""-map <S-F3> :make<CR>:cclose<CR>:copen<CR><C-W><C-P>
"""-map <F5> :qa<CR>
"""-map <F6> :diffget<CR>
"""-" In a perforce merge-edit, split the 3 bits into a 3-way-diff.
"""-map <F7> ?^>>>>?<CR>j"ay/^====/<CR>//<CR>j"by//<CR>//<CR>j"cy/^<<<</<CR>:new c.tmp<CR>"cpkdd:diffthis<CR>:vnew b.tmp<CR>"bpkdd:diffthis<CR>:vnew a.tmp<CR>"apkdd<CR>:diffthis<CR>
"""-" Select one of 3 ways of 3 way diff, and merge back into document.
"""-map <F8> 1G"ayG:bdel! a.tmp<CR>:bdel! b.tmp<CR>:bdel! c.tmp<CR>?^>>>><CR>d/^<<<<<CR>dd<CR>"aP<CR>
"""-map <F10> :make<CR>:cclose<CR>:copen<CR><C-W><C-P>
"""-
"""-
"""-augroup filetypedetect
"""-au BufNewFile,BufRead /tmp/g4_*,*p4-change*,*p4-client* call EnterPerforceFile()
"""-augroup END
"""-" END Perforce editing help

source ~/.exrc

"""-:set textwidth=78
"""-:set expandtab
"""-:highlight clear SpecialKey
"""-:highlight SpecialKey ctermfg=DarkGrey guibg=DarkGrey
"""-:set fileformats=unix,dos
"""-:set viminfo='50,\"200
"""-:set history=50

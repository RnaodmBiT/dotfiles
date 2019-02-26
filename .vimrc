" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"

set guifont=Monospace\ 11
set autochdir
colorscheme evening

set foldmethod=indent
set foldlevel=99

nnoremap <space> za
inoremap jk <Esc>

" Add tab navigation shortcuts
nmap <C-Tab> gt
nmap <C-S-Tab> gT
nmap <c-t> :tabedit<CR>

" Setup OmniCppComplete
set nocp
filetype plugin on
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
filetype off
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set cindent
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set softtabstop=4
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
set cino=g0,(0
" wrap lines at 100
set textwidth=100
set formatoptions+=t
set autoindent
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="Ben Mitchell <rnaodm5@gmail.com>"

" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" switch between header/source with F4
map <F4> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
" recreate tags file with F5
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :!make<CR>
" build and program
map <F8> :!make program<CR>
" build using makeprg with <S-F7>
map <S-F7> :!make clean all<CR>
" goto definition with F12
map <F12> <C-]>
" in diff mode we use the spell check keys for merging
if &diff
  ” diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
  " :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  " set spellfile=~/.vim/spellfile.add
  " map <M-Down> ]s
  " map <M-Up> [s
endif

" Add trailing whitespace highlighting
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" highlight TabCharacters ctermbg=darkred guibg=darkred
" autocmd BufWinEnter * match TabCharacters /\t/

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tikhomirov/vim-glsl'
autocmd! BufNewFile,BufRead *.vert,*.frag set ft=glsl

Plugin 'gmarik/Vundle.vim'

"Plugin 'tmhedberg/SimpylFold'
"let g:SimpylFold_docstring_preview=1

"Plugin 'vim-scripts/indentpython.vim'

Bundle 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Plugin 'vim-syntastic/syntastic'

"Plugin 'nvie/vim-flake8'

"Plugin 'jistr/vim-nerdtree-tabs'

"Plugin 'tpope/vim-fugitive'

"Plugin 'Lokaltog/powerline', { 'rtp': 'powerline/bindings/vim/' }

"let python_highlight_all=1

call vundle#end()
filetype plugin indent on

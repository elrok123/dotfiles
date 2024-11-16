set nocompatible              " be iMproved, required
filetype off                  " required
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'whatyouhide/vim-gotham'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'ntpeters/vim-airline-colornum'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'valloric/youcompleteme'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-rails'
Plugin 'bogado/file-line'
Plugin 'slim-template/vim-slim'
Plugin 'chrisbra/csv.vim'
Plugin 'shime/vim-livedown'
Plugin 'nestorsalceda/vim-strip-trailing-whitespaces'
Plugin 'Chiel92/vim-autoformat'
Plugin 'kshenoy/vim-signature'
Plugin 'restore_view.vim'
Plugin 'itchyny/vim-cursorword'
Plugin 'myusuf3/numbers.vim'
Plugin 'jaxbot/semantic-highlight.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'Rigellute/shades-of-purple.vim'
Plugin 'janko/vim-test'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'towolf/vim-helm'
Plugin 'equal-l2/vim-base64'
Plugin 'w0rp/ale'

Plugin 'catppuccin/vim'
Plugin 'jaredgorski/SpaceCamp'
Plugin 'clausreinke/typescript-tools.vim', { 'do': 'npm install' }

call vundle#end()            " required
filetype plugin indent on    " required
syn on

" SOPs
let g:sops_files_match = "{*.sops}"

set wildignore+=*/tmp/*,*/node_modules/*,

" JS Stuff
let g:ale_fixers = {
 \ 'javascript': ['eslint'],
 \ 'typescript': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1


filetype plugin on
au BufNewFile,BufRead * if &ft == '' | set ft=bash | endif
au BufRead,BufNewFile *.ts		setlocal filetype=typescript
au BufRead,BufNewFile *.tsx		setlocal filetype=typescript
set rtp+=~/.vim/bundle/typescript-tools/typescript-tools.vim/

let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'leaderf': 1,
      \ 'mail': 1,
      \ 'bash': 1,
      \ 'json': 1,
      \ 'vim': 1
      \}

set number
set syntax=on
set clipboard=unnamed
set mouse=a
set encoding=UTF-8
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

" Trigger configuration. Do not use tab if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="tab"
let g:UltiSnipsJumpForwardTrigger="c-b"
let g:UltiSnipsJumpBackwardTrigger="c-z"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" CSV Configuration
let g:csv_delim=','
let g:csv_start = 1
let g:csv_end = 200


set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

set cursorline
set cursorline
set cursorcolumn

" Better regex engine (needed for faster ruby syntax highlighting)
set re=0
set ttyfast
set lazyredraw

set ttymouse=xterm2
set mouse=a

" zz to save
nnoremap zz :updatecr
set showcmd

nnoremap Leaders :SemanticHighlightTogglecr

" Max line length
set colorcolumn=100

function! TabCloseRight(bang)
    let cur=tabpagenr()
    while cur < tabpagenr('$')
        exe 'tabclose' . a:bang . ' ' . (cur + 1)
    endwhile
endfunction

function! TabCloseLeft(bang)
    while tabpagenr() > 1
        exe 'tabclose' . a:bang . ' 1'
    endwhile
endfunction

command! -bang Tabcloseright call TabCloseRight('bang')
command! -bang Tabcloseleft call TabCloseLeft('bang')

" Gruvbox Theme
"let g:gruvbox_italic=1
"let g:airline_theme = 'spacecamp'
set termguicolors
" colorscheme catppuccin_mocha
colorscheme spacecamp



" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap silent tC-n :TestNearestCR
nmap silent tC-f :TestFileCR
nmap silent tC-s :TestSuiteCR
nmap silent tC-l :TestLastCR
nmap silent tC-g :TestVisitCR

function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

hi link Repeat Statement

set rtp+=/System/Volumes/Data/Users/conner/Library/Python/3.9/lib/python3.9/site-packages/powerline/bindings/tmux/powerline.conf

if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Meslo\ LG\ S\ for\ Powerline
   endif
endif

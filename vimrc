" Use Vim settings instead of Vi settings
set nocompatible

" Load all plugins specified in ~/.vim/vundle.vim.
" We let the Vundle plugin manage all other plugins.
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif

" General configuration
set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set mouse=a
set backspace=indent,eol,start
set autoread

" Turn syntax highlighting on.
syntax on
set background=dark
colorscheme molokai_256

" Indentation
filetype on
filetype plugin on
filetype indent on

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smarttab

" Scrolling
set scrolloff=8

" Turn off swap files
set noswapfile
set nobackup
set nowb

" Strip trailing spaces when saving file.
"autocmd BufWritePre * :%s/\s\+$//e

" Show status bar and title.
set laststatus=2

" Set file format to Unix.
set ff=unix

" Fortran free-form source
let fortran_free_source=1

" Completion
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" Latex 
"let g:vimtex_fold_enabled = 1
let g:latex_quickfix_ignored_warnings =
  \"Underfull"."\n"
  \"Overfull"."\n"
  \"specifier changed to"."\n"
  \"You have requested"."\n"
  \"Missing number, treated as zero."."\n"
  \"There were undefined references"."\n"
  \"Latex Warning:"."\n"
  \"Citation %.%# undefined"
  \"Package".

let g:Tex_IgnoreLevel = 9

let g:vimtex_view_general_viewer
                  \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
            let g:vimtex_view_general_options = '-r @line @pdf @tex'

            " This adds a callback hook that updates Skim after compilation
            let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
            function! UpdateSkim(status)
              if !a:status | return | endif

              let l:out = b:vimtex.out()
              let l:tex = expand('%:p')
              let l:cmd = [g:vimtex_view_general_viewer, '-r']
              if !empty(system('pgrep Skim'))
                call extend(l:cmd, ['-g'])
              endif
              if has('nvim')
                call jobstart(l:cmd + [line('.'), l:out, l:tex])
              elseif has('job')
                call job_start(l:cmd + [line('.'), l:out, l:tex])
              else
                call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
              endif
            endfunction

let g:vimtex_quickfix_ignore_all_warnings = 1

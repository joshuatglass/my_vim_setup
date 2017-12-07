" vim: foldmethod=marker

" Plugin Management  {{{1
filetype off
let $VIMHOME=expand('<sfile>:p:h')
silent! call plug#begin($VIMHOME.'/bundle')

  " Coding / Development
  Plug 'git@github.com:tpope/vim-fugitive'
  Plug 'git@github.com:airblade/vim-gitgutter'
  Plug 'git@github.com:vim-syntastic/syntastic.git'
  Plug 'git@github.com:tpope/vim-commentary.git'
  Plug 'git@github.com:Shougo/neosnippet'
  Plug 'git@github.com:PhilRunninger/vim-snippets'
  Plug 'git@github.com:tpope/vim-dispatch', { 'on': 'Dispatch' }

  " File Management
  Plug 'git@github.com:vifm/vifm.vim.git', { 'on': 'EditVifm' }
  Plug 'git@github.com:jlanzarotta/bufexplorer.git'

  " Colorschemes
  Plug 'git@github.com:guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
  Plug 'git@github.com:morhetz/gruvbox.git'

  " Miscellaneous Utilities
  Plug 'git@github.com:sotte/presenting.vim.git'
  Plug 'git@github.com:Shougo/neocomplcache.vim'
  Plug 'git@github.com:kshenoy/vim-signature'
  Plug 'git@github.com:mbbill/undotree', { 'on': 'UndotreeToggle' }
  Plug 'git@github.com:junegunn/vim-easy-align'
  Plug 'git@github.com:mtth/scratch.vim'
  Plug 'git@github.com:tpope/vim-repeat'
  Plug 'git@github.com:tpope/vim-surround'
  Plug 'git@github.com:tpope/vim-unimpaired'
  Plug 'git@github.com:tommcdo/vim-exchange.git'
  Plug 'git@github.com:scrooloose/vim-slumlord'
  Plug 'git@github.com:PhilRunninger/vim-sessions.git'

  " Filetype-specific
  Plug 'git@github.com:suan/vim-instant-markdown.git', { 'for': 'markdown' }
  Plug 'git@github.com:tpope/vim-markdown', { 'for': 'markdown' }
  Plug 'git@github.com:elzr/vim-json', { 'for': 'json' }
  Plug 'git@github.com:vim-scripts/NSIS-syntax-highlighting', { 'for': ['nsi', 'nsh'] }
  Plug 'git@github.com:chrisbra/csv.vim', { 'for': 'csv' }
  Plug 'git@github.com:tpope/vim-jdaddy', { 'for': 'json' }
  Plug 'git@github.com:aklt/plantuml-syntax', { 'for': 'uml' }

call plug#end()
filetype plugin indent on

" Miscellaneous settings   {{{1
set encoding=utf-8                  " Sets the character encoding to use inside vim.
set scrolloff=3                     " Minimum # of lines above and below cursor
set sidescrolloff=3                 " minimum nr. of columns to left and right of cursor
set sidescroll=1                    " Minimum number of columns to scroll horizontal
set confirm                         " Ask what to do with unsave/read-only files
set tags=./tags;/                   " List of filenames used by the tag command
set backspace=indent,eol,start      " How backspace works at start of line
set whichwrap+=<,>,[,]              " Allow specified keys to cross line boundaries
set ttimeoutlen=10                  " Time out time for key codes in milliseconds (Removes delay after <Esc> in Command mode.)
let g:netrw_dirhistmax = 0          " Prevent creation of .netrwhist files.
let mapleader=" "                   " Character to use for <leader> mappings
syntax on                           " Turn syntax highlighting on.

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Command line options   {{{1
set history=1000                    " number of command-lines that are remembered.
set wildmenu                        " use menu for command line completion
set wildmode=full                   " mode for 'wildchar' command-line expansion
if v:version > 703
  set wildignorecase                " specifies how command line completion is done
endif
set wildignore+=*.a,*.o,*.beam      " files matching these patterns are not completed
set wildignore+=*.bmp,*.gif,*.jpg,*.ico,*.png
set wildignore+=.DS_Store,.git,.ht,.svn
set wildignore+=*~,*.swp,*.tmp

" Function to toggle visual selection between: lowercase, Title Case, and UPPERCASE.   {{{1
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap <silent> ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" Tab settings and behavior   {{{1
set autoindent      " take indent for new line from previous line
set smartindent     " smart autoindenting for c programs
set softtabstop=4   " number of spaces that <tab> uses when editing
set tabstop=4       " number of spaces that <tab> in file uses
set shiftwidth=4    " number of spaces to use for (auto)indent step
set expandtab       " use spaces when <tab> is inserted

" Which things are displayed on screen?   {{{1
set showcmd         " show (partial) command in last line of screen
set noshowmode      " [no] message on status line show current mode
set showmatch       " briefly jump to matching bracket if inserting one
set number          " print the line number in front of each line
set list                                            " show <tab> and <eol>
set listchars=tab:∴·,extends:→,precedes:←,trail:●   " characters for displaying in list mode
augroup trailingSpaces
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:●
    autocmd InsertLeave * :set listchars+=trail:●
augroup END
set fillchars=stl:\ ,stlnc:\ ,vert:\                " characters to use for displaying special items
set showtabline=0                                   " tells when the tab pages line is displayed

" Undo/Backup/Swap file settings   {{{1
set undolevels=100                        " maximum number of changes that can be undone
set undofile                              " automatically save undo history to an undo file
set undodir=$VIMHOME/cache/undo//         " list of directory names for undo files
set directory=$VIMHOME/cache/swapfiles//  " list of directory names for swap files
set nobackup                              " [do not] keep backup file after overwriting a file
set backupdir=$VIMHOME/cache/backups//    " list of directory namde for the backup file
set laststatus=2                          " tells when last window has status line

" Disable the bells (audible and visual).   {{{1
set noerrorbells    " [do not] ring the bells for error messages
set visualbell      " use visual bell instead of beeping
set t_vb=

" Window behavior and commands   {{{1
set splitbelow      " new window from split is below the current one
set splitright      " new window is put right of the current one
set winminheight=0  " minimum number of lines for any window
set winminwidth=0   " minimum number of columns for any window

nnoremap <silent> <leader>w <C-W>
nnoremap <silent> <Up> 5<C-W>+
nnoremap <silent> <Down> 5<C-W>-
nnoremap <silent> <Right> 10<C-W>>
nnoremap <silent> <Left> 10<C-W><
nnoremap <silent> <leader>x <C-W>_<C-W>\|
nnoremap <silent> <C-H> <C-W>h
nnoremap <silent> <C-J> <C-W>j
nnoremap <silent> <C-K> <C-W>k
nnoremap <silent> <C-L> <C-W>l

" Searching settings   {{{1
set hlsearch        " highlight matches with last search pattern
set incsearch       " highlight match wile typing search pattern
set ignorecase      " ignore case in search patterns
set smartcase       " no ignore case when pattern has uppercase
nnoremap <silent> <leader><Space> :nohlsearch<CR>
runtime macros/matchit.vim
nnoremap <silent> n   nzzzv
nnoremap <silent> N   Nzzzv
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
nnoremap <silent> <leader>/ :vimgrep "<C-R>/" %<CR>:copen<CR>
vnoremap <silent> <leader>/ y:vimgrep "<C-R>0" %<CR>gv:copen<CR>

" Swap j/k and gj/gk   {{{1
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Show/hide cursorline and cursorcolumn   {{{1
nnoremap <silent> + :set cursorline! cursorcolumn!<CR>
nnoremap <silent> - :set cursorline!<CR>
nnoremap <silent> \| :set cursorcolumn!<CR>

" Change cwd to current buffer's directory   {{{1
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Remove trailing spaces   {{{1
nnoremap <leader>d<space> :%s/\s\+$//c<CR>

" Show what highlighting is used under the cursor {{{1
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Auto-command Definitions   {{{1
augroup reloadVimrc " Re-source this file when saving it   {{{2
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup meta " Get help (with K key) when editing vimscript
  autocmd!
  autocmd FileType vim setlocal keywordprg=:help
augroup END

augroup checktime   " terminal mode hack for autoread option   {{{2
  autocmd!
  if !has("gui_running")
    "silent! necessary; otherwise, throws errors when using command line window.
    autocmd BufEnter        * silent! checktime
    autocmd CursorHold      * silent! checktime
    autocmd CursorHoldI     * silent! checktime
    "these two _may_ slow things down. Remove if they do.
    autocmd CursorMoved     * silent! checktime
    autocmd CursorMovedI    * silent! checktime
  endif
augroup END
set autoread        " automatically read file when changed outside of vim

augroup jumpToPreviousLocation " When editing a file, always jump to its last known cursor position.   {{{2
    autocmd!
    autocmd BufReadPost *
             \ if line("'\"") > 1 && line("'\"") <= line("$") |
             \     execute "normal! g`\"" |
             \ endif
augroup END

augroup pivotalTrackerIDToCommitMesage " Grab PivotalTracker ID and start commit message.  {{{2
    autocmd!
    autocmd BufReadPost COMMIT_EDITMSG execute "silent! normal! qzq/# On branch.\\{-}\\zs\\d\\{8,}\<CR>\"zy//e\<CR>gg\"zPI[#\<ESC>A] \<ESC>:1,1s/\\[#\\] //\<CR>"
augroup END

augroup vhtFileTypes " Set filetype of VHT Log files   {{{2
    autocmd!
    autocmd BufReadPost TIALOutputLog*.txt set filetype=vht
    autocmd BufReadPost MainOutputLog*.txt set filetype=vht
    autocmd BufReadPost IVROutputLog*.txt set filetype=vht
    autocmd BufReadPost debug.log set filetype=vht
    autocmd BufReadPost error.log set filetype=vht
    autocmd BufReadPost *.{[0123456789]}\\\{1,99\} set filetype=vht
augroup END

" Buffer-related settings and mappings   {{{1
set hidden          " don't unload buffer when it is abandoned
nnoremap <silent> # :buffer #<CR>
nnoremap <silent> <leader>n :bnext<CR>
nnoremap <silent> <leader>p :bprevious<CR>

set nostartofline   " commands (don't) move cursor to first non-blank in line
augroup bufferEvents
    autocmd!
    " remember and set the position of text in buffer when switching
    autocmd bufleave * let b:winview = winsaveview()
    autocmd bufenter * if(exists('b:winview')) | call winrestview(b:winview) | endif
augroup end

" Settings for Managed Plugins   {{{1
" BufExplorer   {{{2
let g:bufExplorerDisableDefaultKeyMapping=1
let g:bufExplorerShowNoName=1
let g:bufExplorerDefaultHelp=0
let g:bufExplorerDetailedHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerReverseSort=1
nnoremap <silent> <leader>b :ToggleBufExplorer<CR>

" Presenting   {{{2
let g:presenting_top_margin = 2

" EasyAlign   {{{2
vmap <Enter> <Plug>(EasyAlign)

" Fugitive   {{{2
nnoremap <silent> <F3> "zyiw/<C-R>z<CR>:Ggrep -e '<C-R>z'<CR><CR>:copen<CR>:redraw!<CR>
vnoremap <silent> <F3> "zy/<C-R>z<CR>:Ggrep -e '<C-R>z'<CR><CR>:copen<CR>:redraw!<CR>

" NeoComplCache / NeoSnippet   {{{2
set completeopt=longest,menuone

let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_temporary_dir=$VIMHOME.'/cache/neocomplcache'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

let g:neosnippet#disable_runtime_snippets = { '_' : 1  }
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory=$VIMHOME.'/bundle/vim-snippets/snippets'
let g:neosnippet#data_directory=$VIMHOME.'/cache/neosnippet'

imap <C-O> <Plug>(neosnippet_expand_or_jump)
smap <C-O> <Plug>(neosnippet_expand_or_jump)
xmap <C-O> <Plug>(neosnippet_expand_target)

" Vifm   {{{2
nnoremap <silent> <leader>o :EditVifm<CR>

" Scratch   {{{2
let g:scratch_insert_autohide = 0
let g:scratch_no_mappings = 1
let g:scratch_persistence_file = $VIMHOME.'/cache/scratch.txt'
nnoremap gs :Scratch<CR>
nnoremap gS :Scratch!<CR>
xnoremap gs :ScratchSelection<CR>
xnoremap gS :ScratchSelection!<CR>

" Syntastic   {{{2
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Undotree   {{{2
nnoremap <silent> <leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2

" vim-sessions   {{{2
set sessionoptions-=help
set sessionoptions-=blank
set sessionoptions-=tabpages
let g:pathToSessions = $VIMHOME.'/cache/sessions'

" vim-snippets   {{{2
let g:snips_author = "Phil Runninger"
let g:snips_email = "prunninger@virtualhold.com"
let g:snips_github = "https://github.com/PhilRunninger"

" Color Settings and Status Line   {{{1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

let g:statusline_insert='cterm=none ctermfg=15 ctermbg=20'     " White on Blue
let g:statusline_modified='cterm=none ctermfg=217 ctermbg=124' " Pink on Red
let g:statusline_unmodified='cterm=none ctermfg=16 ctermbg=40' " Black on Green

highlight MatchParen cterm=bold    ctermbg=none ctermfg=13  " Magenta
highlight VertSplit  cterm=reverse ctermfg=237  ctermbg=246 " Same as StatusLineNC
highlight WildMenu   cterm=none    ctermfg=16   ctermbg=178 " Black on Gold
highlight User1      cterm=none    ctermbg=17   ctermfg=12  " Blue on Dark Blue
highlight User2      cterm=none    ctermbg=52   ctermfg=160 " Red on Dark Red

function! StatuslineColorInsert()
    exec 'highlight StatusLine '.g:statusline_insert
endfunction
function! StatuslineColorNormal()
    exec 'highlight StatusLine ' . (&modified ? g:statusline_modified : g:statusline_unmodified)
endfunction

if v:version > 703
  augroup setStatuslineColors
    autocmd!
    autocmd InsertEnter,InsertChange,TextChangedI * call StatuslineColorInsert()
    autocmd InsertLeave,TextChanged,BufWritePost,BufEnter * call StatuslineColorNormal()
  augroup END
endif

set statusline=%3p%%\ %4v
set statusline+=\ %1*%(\ %{fugitive#head(8)}\ %)%*
set statusline+=%2*%(%{&modifiable?&readonly?\"\ ro\ \":\"\":\"\ RO\ \"}%)%*
set statusline+=\ %{&ft}
set statusline+=\ %{&ff}
set statusline+=\ %f
set statusline+=%=
set statusline+=%#ErrorMsg#%{SyntasticStatuslineFlag()}%*
set statusline+=\ %{SessionNameStatusLineFlag()}

call StatuslineColorNormal()

" Custom, machine-specific post processing   {{{1
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/post_vimrc'
if filereadable(s:path)
  execute 'source' s:path
endif

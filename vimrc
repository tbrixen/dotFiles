" PLUGINS ---------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'aklt/plantuml-syntax'
Plug 'bling/vim-airline'
Plug 'bronson/vim-visual-star-search'
Plug 'christoomey/vim-tmux-navigator'
Plug 'connorholyday/vim-snazzy'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'iamcco/markdown-preview.nvim'
Plug 'jjaderberg/vim-ft-asciidoc'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mileszs/ack.vim'
Plug 'plasticboy/vim-markdown'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'robcsi/viewmaps.vim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'troydm/zoomwintab.vim'
Plug 'vim-scripts/groovyindent-unix'
Plug 'w0rp/ale'
if has('python3')
  Plug 'honza/vim-snippets'
endif
Plug 'haya14busa/incsearch.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" }}}

" OPTIONS ---------------------- {{{
set nocompatible
set showcmd         " Display incomplete commands
set relativenumber  " Show line number relative to line of cursor
set number          " Show line number of cursor
set cursorline      " Highlight screen line of cursor
set hidden          " Don't prompt to save hidden windows
set wildmenu        " Show possible completion on command line
set wildmode=longest:list,full " 1. tab: ist all options 2. tab: complete to the longest common string
set laststatus=2    " Always show status line
set encoding=utf-8  " Make vim work in UTF-8
set list            " Show whitespace as special chars - see listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things

" Search
set ignorecase      " Case insensitive
set smartcase       " Override ignorecase, if searching for uppercase
set incsearch       " While typing, show matches
set showmatch       " Briefly jump to matching bracket during insert

set ttyfast         " Improve smoothness, by redraw whole window for each char
set ttimeoutlen=50  " Only wait 50 ms to assume a :mapping is done

" Tabs
set smartindent     " Do automatic indent on c-like programs
set autoindent      " Copy indent when starting a new line
set expandtab       " In insert mode, use spaces when pressing <tab>
set tabstop=2       " Number of spaces a \t counts for 
set softtabstop=2   " Number of spaces a \t count for during editing
set shiftwidth=2    " Number of spaces for each step of (auto)indent

set colorcolumn=80

" If RipGrep is available, use it for grep
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Enable jump between keywords
" [Niel] p 128
runtime macros/matchit.vim

filetype plugin indent on " Automatically detect file types
" }}}

" KEY MAPS ---------------------- {{{
" Make space the leader
map <SPACE> <leader>

" Jump between bracket pairs by tab
nnoremap <tab> %
vnoremap <tab> %

" Maps to escape insert mode
noremap <C-c> <Esc>
inoremap jk <Esc>

" Save buffer using leader
nnoremap <leader>w :w<CR>
inoremap <leader>w <Esc>:w<CR>

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Marks should go to the column, not just the line. Why isn't this the default?
nnoremap ' `

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" Remove current buffer from buffer list without closing window
cnoremap bq  :bp <BAR> bd #<cr>
cnoremap bq! :bp <BAR> bd! #<cr>

" As default, don't :find in /usr/include
set path-=/usr/include

" Edit and find recursively
set wildcharm=<C-z>
nnoremap ,e :e **/*<C-z><S-Tab>
nnoremap ,f :find **/*<C-z><S-Tab>

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" }}}

" COLORS ---------------------- {{{
silent! colorscheme snazzy

syntax enable
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" }}}

" CUSTOM COMMANDS AND FUNCTIONS ---------------------- {{{
" Insert time
" Advanced use: strftime("%Y-%m-%d %a %H:%M %p")
nmap <F3> i<C-R>=strftime("%H:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%H:%M %p")<CR>
nmap <F12> <ESC>:w <bar> execute 'silent !\%USERPROFILE\%\Documents\Noter\journal\update.bat' <bar> e <bar> normal zo<CR>
imap <F12> <ESC>:w <bar> execute 'silent !\%USERPROFILE\%\Documents\Noter\journal\update.bat' <bar> e <bar> normal zo<CR>

" }}}

" FILE TYPE TRIGGERS ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

autocmd BufNewFile,BufRead *.json set ft=javascript

" If filetype contains <project name, it should be considered as an Ant script
autocmd BufNewFile,BufRead *.xml if search('<project name', 'nw') | set ft=ant | endif

autocmd syntax groovy,Jenkinsfile setlocal foldmethod=indent | setlocal foldlevel=1
autocmd syntax ant setlocal foldmethod=indent | setlocal foldlevel=1

" }}}

" PLUGINS SETTINGS ---------------------- {{{

" Markdown ---------------------- {{{
nnoremap <Leader>pp :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nnoremap <Leader>pv :RunSilent open /tmp/vim-pandoc-out.pdf<CR>

let g:vim_markdown_folding_level=2
let g:vim_markdown_autowrite = 1
" Enable latex math highlight
let g:vim_markdown_math=1
" }}}

" Markdown-preview.nvim ---------------------- {{{

" Don't close browser windows when changing buffer
let g:mkdp_auto_close = 0
" }}}

" Vim-airline---------------------- {{{
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" PyMode ---------------------- {{{
let g:pymode_lint = 0
" }}}

" CtrlP ---------------------- {{{
let g:ctrlp_working_path_mode = 'r'
" Easy bindings for its various modes
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap <leader>o :CtrlPBuffer<cr>
" Don't jump to viewport with buffer, but use corrent viewport
" This helps to restore splits on the same buffer
let g:ctrlp_switch_buffer = 0
" }}}

" vim-easy-align ---------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" git-gutter ---------------------- {{{
nmap <leader>ghn <Plug>(GitGutterNextHunk)
nmap <leader>ghp <Plug>(GitGutterPrevHunk)
nmap <Leader>ghv <Plug>(GitGutterPreviewHunk)
nmap <Leader>ghu <Plug>(GitGutterUndoHunk)
" }}}

" vim-unimparied ---------------------- {{{
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]
" }}}

" fzf ---------------------- {{{
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
nmap <leader>ll :Lines<cr>
" }}}

" tagbar ---------------------- {{{
nmap <F7> :TagbarToggle<CR>
" }}}

" Ack ---------------------- {{{
" Tell ack.vim to use ripgrep instead
let g:ackprg = 'rg --vimgrep --no-heading'
" }}}

" Vim-rooter ---------------------- {{{
let g:rooter_patterns = ['vimrooter', '.git/']
" }}}

" ale ---------------------- {{{
let g:ale_linters = {
\   'sh': ['shellcheck'],
\   'Dockerfile': ['hadolint'],
\}
" }}}

" vim-json ---------------------- {{{
" workaround needed when you use elzr/vim-json with indentLine
" https://github.com/elzr/vim-json/issues/23
let g:indentLine_noConcealCursor=""
" }}}

" vim-tmux-navigator ---------------------- {{{
"let g:tmux_navigator_no_mappings = 1

" See https://stackoverflow.com/questions/9520676/macvim-iterm2-tmux-bind-alt-meta
execute "set <A-j>=\ej"
execute "set <A-k>=\ek"
execute "set <A-h>=\eh"
execute "set <A-l>=\el"
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
" }}}

" ViewMap ---------------------- {{{
nnoremap <silent> <leader>dn :ViewMaps n quickfix<CR> "display normal mode maps
nnoremap <silent> <leader>di :ViewMaps i quickfix<CR> "display insert mode maps
nnoremap <silent> <leader>dv :ViewMaps v quickfix<CR> "display visual mode maps
" }}}

" incsearch ---------------------- {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}
"
" coc-nvim ---------------------- {{{
let g:coc_global_extensions = ['coc-sh', 'coc-snippets', 'coc-vimlsp', 'coc-json']
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}

" }}}


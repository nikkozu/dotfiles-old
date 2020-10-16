" Sections:
" 	-> Extend plugin lists
" 	-> General
" 	-> Custom commands
" 	-> Plugin configurations
" 	-> Keyboard Layout Map
" 	-> Coc.nvim configurations


"""""""""""""""""""""""""""""""""""""""""""""""""
" => Extend plugin lists
"""""""""""""""""""""""""""""""""""""""""""""""""
" Extend plugin lists from .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif


"""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set auto read when a file is changed from the outside
set autoread
au FocusGained, BufEnter * checktime

" Encoding
set encoding=utf-8

" Sets how many lines of history VIM has to remember
set history=500

" Configure backspace so it acts as it should act
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Turn on modelines
set modelines=0

" Status bar
set laststatus=2

" Change indent size
set expandtab
set tabstop=2
set shiftwidth=2

" Enter after brackets auto add indent
inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O

" Ignore case when searcing
set ignorecase

" Highlight search results
set hlsearch

" Enable incremental search
set incsearch

" Include only uppercase words with uppercase search term
set smartcase

" Highlight matching pairs of brackets.
" Use the '%' character to jump between them
set matchpairs+=<:>

" important!!
set termguicolors

" Turn on syntax highlighting
let g:miramare_enable_italic=1

" let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_invert_selection=0
colorscheme miramare

" Automatically wrap text that extends beyond the screen length
set wrap

" Display 5 lines above/below the cursor when scrolling with a mouse
set scrolloff=5

" Speed up scrolling in vim
set ttyfast

" Show line numbers
set number

" Enable mouse
set mouse=nv

" Automatically change the current directory
" For Discord Presence workspace status
set autochdir

" tsconfig.json is actually jsonc
" Help Typescript set the correct filetype
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc


"""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom commands
"""""""""""""""""""""""""""""""""""""""""""""""""
" Open .vimrc file with command
command! NvimConfig :e ~/.vimrc
" Open .vimrc.plug file with command
command! NvimPlugConfig :e ~/.vimrc.plug
" Copy full path of current buffer to clipboard
command! -nargs=0 CopyCWD :let @+ = getcwd()


"""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configurations
"""""""""""""""""""""""""""""""""""""""""""""""""
" Airline general
let g:airline_theme='miramare'
let g:airline_powerline_fonts=1
" Airline git
let g:airline#extensions#branch#enabled=1
" Airline tabline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#tabs_label=''
let g:airline#extensions#tabline#buffers_label=''
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#show_tab_count=0
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#tab_min_count=2
let g:airline#extensions#tabline#show_splits=0
let g:airline#extensions#tabline#show_tab_nr=0
let g:airline#extensions#tabline#show_tab_type=0

" Vimsence general
let g:vimsence_small_text='NeoVim'
let g:vimsence_small_image='neovim'

" previm markdown
let g:previm_open_cmd='brave-dev'

" nerdcommenter
" Add spaces after comment deliminters
let g:NERDSpaceDelims=1

"""""""""""""""""""""""""""""""""""""""""""""""""
" => Keyboard Layout Map
"""""""""""""""""""""""""""""""""""""""""""""""""
function Keyboard(type)
	if a:type == "workman"
		" (O)pen line -> (L)ine
		nnoremap l o
    nnoremap o l
    nnoremap L O
    nnoremap O L
    " Search (N)ext -> (J)ump
    nnoremap j n
    nnoremap n j
    nnoremap J N
    nnoremap N J
    nnoremap gn gj
    nnoremap gj gn
    " (E)nd of word -> brea(K) of word
    nnoremap k e
    nnoremap e k
    nnoremap K E
    nnoremap E <nop>
    nnoremap gk ge
    nnoremap ge gk
    " (Y)ank -> (H)aul
    nnoremap h y
    onoremap h y
    nnoremap y h
    nnoremap H Y
    nnoremap Y H
	else " qwerty
		call UnmapWorkman()
	endif
endfunction

function UnmapWorkman()
	" unmap workman keys
  silent! nunmap h
  silent! ounmap h
  silent! nunmap j
  silent! nunmap k
  silent! nunmap l
  silent! nunmap y
  silent! nunmap n
  silent! nunmap e
  silent! nunmap o
  silent! nunmap H
  silent! nunmap J
  silent! nunmap K
  silent! nunmap L
  silent! nunmap Y
  silent! nunmap N
  silent! nunmap E
  silent! nunmap O
endfunction

function LoadKeyboard()
	let keys = $keyboard
	if (keys == "workman")
		call Keyboard("workman")
	endif
endfunction

autocmd VimEnter * call LoadKeyboard()

:noremap <Leader>q :call Keyboard("qwerty")<CR>:echom "Qwerty Keyboard Layout"<CR>
:noremap <Leader>w :call Keyboard("workman")<CR>:echom "Workman Keyboard Layout"<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""
" => Coc.nvim configurations
"""""""""""""""""""""""""""""""""""""""""""""""""
" Disable preview window
set completeopt-=preview

" Prettier command for coc.nvim
command! -nargs=0 Prettier 	:CocCommand prettier.formatFile
" Eslint fix command
command! -nargs=0 EslintFix :CocCommand eslint.executeAutofix

" coc.nvim config
let g:coc_global_extensions=[
			\ 'coc-snippets',
			\ 'coc-pairs',
			\ 'coc-tsserver',
			\ 'coc-eslint',
			\ 'coc-prettier',
			\ 'coc-json',
      \ 'coc-html'
			\ ]

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <C-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion. `<C-g>u` means break undo chain at current position
" coc only does snippet and additional edit on confirm
inoremap <expr> <Cr> pumvisible() ? "\<C-y>" : "\<c-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>


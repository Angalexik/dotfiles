"							_
"  _ ____		_(_)_ __ ___
" | '_ \ \ / | | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|

" Disable some polyglot language packs
let g:polyglot_disabled = ['gdscript', 'markdown']

" Plugins
call plug#begin('~/.nvim_plugins')

" Colour scheme
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'reedes/vim-colors-pencil'
" QOL
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'LucHermitte/local_vimrc'
Plug 'LucHermitte/lh-vim-lib'
" Various FileType support
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'liuchengxu/vista.vim'
Plug 'kevinoid/vim-jsonc'
Plug 'Freedzone/kerbovim'
Plug 'maxbane/vim-asm_ca65'
Plug 'OmniSharp/omnisharp-vim'
" Plug 'cespare/vim-toml'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tpope/vim-markdown'
Plug 'clktmr/vim-gdscript3'
" Plug 'DonnieWest/kotlin-vim'
" Plug 'tfnico/vim-gradle'
Plug 'rubixninja314/vim-mcfunction'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/npm.nvim', {'do': 'npm install'}
" Visual changes
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'junegunn/goyo.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'frazrepo/vim-rainbow'

call plug#end()

" temporary
set runtimepath^=/home/alex/dotfiles/coc-computercraft

" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ""
let g:airline_right_sep = ""

let g:airline#extensions#tabline#enabled = 1

" Unmap <C-q> to prevent interference with my commands
map <C-q> <Nop>

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" Remaps
let mapleader = ' '
" Fast sav
map <leader>w :w!<cr>
" Fast search
map <leader><space> /
map <leader><C-space> ?
" Change to writing mode
nmap <leader>zz :source ~/.config/nvim/markdown.vim<cr>
" Nicer buffer switching
nmap <C-q>l :bnext<cr>
nmap <C-q>h :bprevious<cr>
nmap <C-q-l> :bnext<cr>
nmap <C-q-h> :bprevious<cr>

" Vim rooter
let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', 'gradle/', 'Cargo.toml', 'tsconfig.json', '*.sln', 'Makefile']

" Visual settings
colorscheme nord
set encoding=UTF-8
set number
set breakindent
set termguicolors

" Search
set ignorecase
set smartcase
set hlsearch

" Indentation
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set noexpandtab
set autoindent

" Rainbow brackets 🌈
let g:rainbow_active = 0
let g:rainbow_ctermfgs = [220, 203, 213]
let g:rainbow_guifgs = ['#ffd700', '#ff5f5f', '#ff87ff']
let g:rainbow_load_separately = [
	\ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
	\ ]

" Markdown settings
let g:mkdp_markdown_css = expand('~/.config/nvim/markdown.css')
let g:mkdp_page_title = '„${name}“'
" let g:markdown_enable_spell_checking = 0

" Fold settings
set foldmethod=marker
set foldmarker=#region,#endregion

" Allow json comments
autocmd FileType json setlocal filetype=jsonc

" Custom comments for vim-commetary
autocmd FileType jsonc setlocal commentstring=//\ %s
autocmd FileType kerboscript setlocal commentstring=//\ %s

" Custom devicons icons
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ks'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.zshrc'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['zshrc'] = ''

if filereadable('gradlew')
	compiler gradlew
endif

" ALE Settings
let g:ale_fixers = {
\	'javascript': ['eslint'],
\	'typescript': ['eslint'],
\ 'python': ['yapf'],
\ 'cs': ['omnisharp']
\}

let g:ale_linters = {
\ 'python': ['pylint', 'pyright', 'pyls'],
\ 'cs': ['omnisharp', 'csc'],
\ 'javascript': ['eslint', 'tsserver'],
\	'typescript': ['eslint', 'tsserver']
\}

let g:ale_cs_csc_assembly_path = ['.']
let g:ale_css_stylelint_options = '--config ~/.config/stylelintrc.js'

" Coc.nvim settings
" -----------------------------------

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

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
	return !col || getline('.')[col - 1]	=~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gy :ALEGoToTypeDefinition<CR>
nmap <silent> gr :ALEFindReferences<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn :ALERename<CR>

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a	<Plug>(coc-codeaction-selected)
nmap <leader>a	<Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call		 CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR	 :call		 CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a	:<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e	:<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c	:<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o	:<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s	:<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j	:<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k	:<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p	:<C-u>CocListResume<CR>

" Coc.nvim custom options
" -------------------------

nmap <silent> <C-d> <Plug>(coc-cursors-word)*
xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn
nmap <leader>f :ALEFix<CR>

inoremap <ESC> <ESC> :call coc#float#close_all() <CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile

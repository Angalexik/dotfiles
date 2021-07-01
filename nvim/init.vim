"							_
"  _ ____		_(_)_ __ ___
" | '_ \ \ / | | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|


" Plugins
call plug#begin('~/.nvim_plugins')

" Colour scheme
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'reedes/vim-colors-pencil'

" QOL
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'cohama/lexima.vim'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'ggandor/lightspeed.nvim'
" Plug 'LucHermitte/local_vimrc'
" Plug 'LucHermitte/lh-vim-lib'
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'karb94/neoscroll.nvim'

" Completion/LSP
Plug 'dense-analysis/ale'
Plug 'nathunsmitty/nvim-ale-diagnostic'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'onsails/lspkind-nvim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" Various FileType support
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'mattn/emmet-vim'
Plug 'evanleck/vim-svelte'
Plug 'liuchengxu/vista.vim'
Plug 'digitaltoad/vim-pug'
" Plug 'kevinoid/vim-jsonc'
Plug 'Freedzone/kerbovim'
Plug 'maxbane/vim-asm_ca65'
Plug 'OmniSharp/omnisharp-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Plug 'cespare/vim-toml'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tpope/vim-markdown'
Plug 'clktmr/vim-gdscript3'
" Plug 'DonnieWest/kotlin-vim'
" Plug 'tfnico/vim-gradle'
Plug 'rubixninja314/vim-mcfunction'
Plug 'neoclide/npm.nvim', {'do': 'npm install'}

" Visual changes
Plug 'airblade/vim-gitgutter'
Plug 'glepnir/galaxyline.nvim'
Plug 'mhinz/vim-startify'
Plug 'junegunn/goyo.vim'
" Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

call plug#end()

" Auto install
autocmd VimEnter *
	\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\|	 PlugInstall --sync | q
	\| endif

" temporary
set runtimepath^=/home/alex/dotfiles/coc-computercraft

" Status line
lua require('statusline')

" Set up devicons
lua << EOF

local devicons = require'nvim-web-devicons'

devicons.setup {
	override = {
		txt = {
			icon = "",
			color = "#6d8086",
			name = "Text"
		}
	}
}

-- Startify devicons
function _G.webDevIcons(path)
 	local filename = vim.fn.fnamemodify(path, ':t')
 	local extension = vim.fn.fnamemodify(path, ':e')
 	return devicons.get_icon(filename, extension, { default = true })
end

EOF

function! StartifyEntryFormat() abort
 	return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" Remaps
let mapleader = ' '
" Fast save
map <leader>w :w!<cr>
" Fast search
map <leader><space> /
map <leader><C-space> ?
" Change to writing mode
nmap <leader>zz :source ~/.config/nvim/markdown.vim<cr>
" Enable mouse
set mouse=a
" Exit terminal
tnoremap <esc> <C-\><C-N>

" Smooth scrolling
lua require('neoscroll').setup()

" Vim rooter
let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', 'gradle/', 'Cargo.toml', 'tsconfig.json', '*.sln', '*.csproj', 'Makefile']

" Visual settings
colorscheme nord
let g:nord_enable_treesitter = 1
set encoding=UTF-8
set relativenumber
set number
set breakindent
set termguicolors
set noshowmode
set signcolumn=yes
set scrolloff=4
highlight link ALEInfoSign CocInfoSign
highlight ALEInfo guifg=#88c0d0 gui=underline
" Gitgutter symbols
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_modified_removed = '~'

" Keep buffers after abandoning
set hidden

" Barbar
" Move to previous/next
nnoremap <silent>		 <A-,> :BufferPrevious<CR>
nnoremap <silent>		 <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>		 <A-<> :BufferMovePrevious<CR>
nnoremap <silent>		 <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>		 <A-1> :BufferGoto 1<CR>
nnoremap <silent>		 <A-2> :BufferGoto 2<CR>
nnoremap <silent>		 <A-3> :BufferGoto 3<CR>
nnoremap <silent>		 <A-4> :BufferGoto 4<CR>
nnoremap <silent>		 <A-5> :BufferGoto 5<CR>
nnoremap <silent>		 <A-6> :BufferGoto 6<CR>
nnoremap <silent>		 <A-7> :BufferGoto 7<CR>
nnoremap <silent>		 <A-8> :BufferGoto 8<CR>
nnoremap <silent>		 <A-9> :BufferLast<CR>
" Close buffer
nnoremap <silent>		 <A-c> :BufferClose<CR>
" Wipeout buffer
"													 :BufferWipeout<CR>
" Close commands
"													 :BufferCloseAllButCurrent<CR>
"													 :BufferCloseBuffersLeft<CR>
"													 :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>		 :BufferPick<CR>

let g:bufferline = get(g:, 'bufferline', {})

let g:bufferline.icon_custom_colors = 'white'
highlight! BufferTabpageFill guifg=#d8dee9 guibg=#2e3440

highlight! BufferCurrent guifg=#d8dee9 guibg=#4c566a
highlight link BufferCurrentIndex BufferCurrent
highlight link BufferCurrentSign BufferCurrent
highlight! BufferCurrentMod guifg=#88c0d0 guibg=#4c566a
highlight! BufferCurrentTarget guifg=#bf616a guibg=#4c566a

highlight link BufferVisible BufferCurrent
highlight link BufferVisibleMod BufferCurrentMod
highlight link BufferVisibleIndex BufferCurrentIndex
highlight link BufferVisibleSign BufferCurrentSign
highlight link BufferVisibleTarget BufferCurrentTarget

highlight! BufferInactive guifg=#616e88 guibg=#2e3440
highlight link BufferInactiveIndex BufferInactive
highlight link BufferInactiveSign BufferInactive
highlight! BufferInactiveSign guifg=#d8dee9 guibg=#2e3440
highlight! BufferInactiveMod guifg=#88c0d0 guibg=#2e3440
highlight! BufferInactiveTarget guifg=#bf616a guibg=#2e3440


" Treesitter settings
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true,							-- false will disable the whole extension
		disable = { "c_sharp" }
	},
	context_commentstring = {
		enable = true
	}
}
EOF

" Search
set ignorecase
set smartcase
set hlsearch

" Clipboard
set clipboard=unnamedplus

" Indentline
let g:indent_blankline_buftype_exclude = ['terminal', 'help']
let g:indent_blankline_filetype_exclude = ['startify']
let g:indent_blankline_char = "│"
let g:indent_blankline_use_treesitter = v:true

" Indentation
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set noexpandtab
set autoindent

" Close tag
lua <<EOF
require'nvim-treesitter.configs'.setup {
	autotag = {
		enable = true,
	}
}
EOF

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
" autocmd FileType svelte setlocal commentstring=<!--\ %s\ -->

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

let g:ale_disable_lsp = 1

let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'python': ['yapf'],
\ 'cs': []
\}

let g:ale_linters = {
\ 'python': ['pylint', 'pyright', 'pyls'],
\ 'cs': [],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint']
\}

let g:ale_css_stylelint_options = '--config ~/.config/stylelintrc.js'

let g:ale_sign_warning = ''
let g:ale_sign_error = ''
let g:ale_sign_info = ''

let g:ale_virtualtext_cursor = 1

" GoTo code navigation.
" nmap <silent> gd :ALEGoToDefinition<CR>
" nmap <silent> gy :ALEGoToTypeDefinition<CR>
" nmap <silent> gr :ALEFindReferences<CR>

" Symbol renaming.
" nmap <silent> <leader>rn :ALERename<CR>
" Code format
nmap <silent> <leader>f :ALEFix<CR>

" autocmd CursorHold * silent ALEHover

" Omnisharp settings
let g:OmniSharp_highlighting = 3
let g:OmniSharp_typeLookupInPreview = 1

" LSP things
lua <<EOF

-- Show diagnostics in ALE
require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		virtual_text = false,
		signs = true,
		update_in_insert = false,
	}
)

local lspinstall = require('lspinstall')
local nvim_lsp = require('lspconfig')

lspinstall.setup()

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	-- vim.api.nvim_command("autocmd CursorHold * silent lua vim.lsp.buf.hover({focuasble=false})")
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)

end

local pid = vim.fn.getpid()

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { "svelte", "tsserver", "vimls", "omnisharp" }
local servers = lspinstall.installed_servers()
for _, lsp in ipairs(servers) do
	if lsp == "sumneko_lua" then
		nvim_lsp[lsp].setup(require'lua-lsp')
	elseif lsp == "csharp" then
		nvim_lsp[lsp].setup{
			cmd = { "/home/alex/.local/share/nvim/lspinstall/csharp/omnisharp/run", "-lsp", "-hpid", tostring(vim.fn.getpid()), "-v" }
		}
	else
		nvim_lsp[lsp].setup { on_attach = on_attach }
	end
end

require('lspkind').init({
	symbol_map = {
		Text = '',
		Method = '',
		Function = '',
		Constructor = '',
		Variable = '',
		Class = 'פּ',
		Interface = 'ﰮ',
		Module = '',
		Property = '襁',
		Unit = '',
		Value = '',
		Enum = '',
		Keyword = '',
		Snippet = '﬌',
		Color = '',
		File = '',
		Folder = '',
		EnumMember = '',
		Constant = '',
		Struct = ''
	}
})

EOF

" Speed up CursorHold
set updatetime=300

" nvim compe
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:false
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:false

let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>			compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>			compe#close('<C-e>')
inoremap <silent><expr> <C-f>			compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>			compe#scroll({ 'delta': -4 })

lua <<EOF

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
		local col = vim.fn.col('.') - 1
		if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				return true
		else
				return false
		end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif vim.fn.call("vsnip#available", {1}) == 1 then
		return t "<Plug>(vsnip-expand-or-jump)"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end
_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
		return t "<Plug>(vsnip-jump-prev)"
	else
		-- If <S-Tab> is not working in your terminal, change it to <C-h>
		return t "<S-Tab>"
	end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

EOF

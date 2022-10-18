" <-- Functions

function! SaveSess()
  " SaveSess if user created file called 'Session.vim' in directory and g:saveSession exists
  if filereadable('Session.vim') && exists("g:saveSession") | Obsession | endif
endfunction

function! RestoreSess()
  " @% == "" Is to check if vim is in the [No Name] buffer or not
  " If it is not then dont restore session as user has vimmed into a file
  if @% != "" | return 0 | endif

  " Set g:saveSession to 1 so that vim saves session when exit
  let g:saveSession=1

  " Load session if session file is found on vim enter
  if filereadable('Session.vim') | execute 'source Session.vim' | endif
endfunction

" --> Functions




" <-- Keybinds

" Use space as leader key
map <Space>  <Leader>

" Set j and k to move up/down one DISPLAYED line (ignore wrapping)
nnoremap k  gk
nnoremap j  gj
vnoremap k  gk
vnoremap j  gj

" Navigate down/up/left/right 5/10 lines/chars
nnoremap <C-k>       5k
nnoremap <C-j>       5j
nnoremap <C-l>       5l
nnoremap <C-h>       5h
vnoremap <C-k>       5k
vnoremap <C-j>       5j
vnoremap <C-l>       5l
vnoremap <C-h>       5h

" <A-;>/<A-'> as escape key
nmap     <A-;>  <Esc>
vnoremap <A-;>  <Esc>
inoremap <A-;>  <Esc>
snoremap <A-;>  <Esc>
tnoremap <A-;>  <Esc><C-\><C-n>
nmap     <A-'>  <Esc>
vnoremap <A-'>  <Esc>
inoremap <A-'>  <Esc>
snoremap <A-'>  <Esc>
tnoremap <A-'>  <Esc><C-\><C-n>

" Set ctrl+bksp and ctrl+w to delete whole word properly
inoremap <C-w>   <Esc>gi<C-w>
inoremap <C-BS>  <Esc>gi<C-w>
inoremap <C-h>   <Esc>gi<C-w>
cnoremap <C-BS>  <C-w>
cnoremap <C-h>   <C-w>
tnoremap <C-BS>  <C-w>
tnoremap <C-h>   <C-w>

" Tab navigate/new/close
for i in range(1, 9)
  execute "nnoremap \<A-".i.">        ".i."gt"
  execute "inoremap \<A-".i.">  \<Esc>".i."gt"
  execute "vnoremap \<A-".i.">  \<Esc>".i."gt"
  execute "tnoremap \<A-".i.">  \<C-\>\<C-n>".i."gt"
endfor
nnoremap <silent><A-Ins>       :tabnew<CR>
nnoremap <silent><A-Del>       :tabclose<CR>
vnoremap <silent><A-Ins>  <Esc>:tabnew<CR>
vnoremap <silent><A-Del>  <Esc>:tabclose<CR>
inoremap <silent><A-Ins>  <Esc>:tabnew<CR>
inoremap <silent><A-Del>  <Esc>:tabclose<CR>
tnoremap <silent><A-Ins>  <C-\><C-n>:tabnew<CR>
tnoremap <silent><A-Del>  <C-\><C-n>:tabclose<CR>

" Telescope
nnoremap <silent><Leader>b     :Telescope buffers<CR>
nnoremap <silent><Leader>h     :Telescope help_tags<CR>
nnoremap <silent><Leader>g     :Telescope live_grep<CR>
nnoremap <silent><Leader>f     :Telescope find_files<CR>

" Trouble
nnoremap <silent><Leader>xx    :TroubleToggle document_diagnostics<CR><C-w><C-p>
nnoremap <silent><Leader>xw    :TroubleToggle workspace_diagnostics<CR><C-w><C-p>
nnoremap <silent><Leader>xq    :TroubleToggle quickfix<CR><C-w><C-p>
nnoremap <silent><Leader>xl    :TroubleToggle loclist<CR><C-w><C-p>
nnoremap <silent><Leader>xd    :TroubleToggle lsp_definitions<CR><C-w><C-p>
nnoremap <silent><Leader>xr    :TroubleToggle lsp_references<CR><C-w><C-p>
nnoremap <silent><Leader>xt    :TroubleToggle lsp_type_definitions<CR><C-w><C-p>

" If not using vscode, then enable terminal features
if !exists('g:vscode')
  " Terminal
  nnoremap <silent><A-t>         :if @% != "" \|\| &modified<CR>vsp\|wincmd w<CR>endif<CR>:term<CR>i
  nnoremap <silent><C-t>         :if @% != "" \|\| &modified<CR>sp\|wincmd w<CR>endif<CR>:term<CR>i
  vnoremap <silent><A-t>    <Esc>:if @% != "" \|\| &modified<CR>vsp\|wincmd w<CR>endif<CR>:term<CR>i
  vnoremap <silent><C-t>    <Esc>:if @% != "" \|\| &modified<CR>sp\|wincmd w<CR>endif<CR>:term<CR>i
  inoremap <silent><A-t>    <Esc>:if @% != "" \|\| &modified<CR>vsp\|wincmd w<CR>endif<CR>:term<CR>i
  inoremap <silent><C-t>    <Esc>:if @% != "" \|\| &modified<CR>sp\|wincmd w<CR>endif<CR>:term<CR>i
  snoremap <silent><A-t>    <Esc>:if @% != "" \|\| &modified<CR>vsp\|wincmd w<CR>endif<CR>:term<CR>i
  snoremap <silent><C-t>    <Esc>:if @% != "" \|\| &modified<CR>sp\|wincmd w<CR>endif<CR>:term<CR>i

  " Make <C-w>w work in Terminal mode
  tnoremap <silent><C-w>  <C-\><C-n><C-w>
endif

" --> Keybinds




" <-- Settings

" Enable syntax highlighting
syntax enable

" Hide ~ on the number line
let &fcs='eob: '

" Save undo history (make a new dir called undohistory in nvim config)
set undodir=~/.config/nvim/undohistory
set undofile

" Enables mouse support
set mouse=a

" Sets tab to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always shows the tabline
set showtabline=2

" Disables the sign column
set signcolumn=no

" Set shared clipboard
set clipboard^=unnamed,unnamedplus

" Don't redraw screen every time
set lazyredraw

" Disable swap files
set noswapfile

" Adds column numbers to the left (relative)
set number
set relativenumber

" Basically allows vim to show colors
set termguicolors

" Don't save options
set sessionoptions-=options

" Folding
set foldmethod=marker
set foldmarker=<--,-->

" Enable smart case insensitive searches
set ignorecase
set smartcase

" Highlight the line where the cursor is
set cursorline

" --> Settings




" <-- Plugins

call plug#begin('~/.config/nvim/plugged')

" Neovim LSP Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'williamboman/mason.nvim'

" Autocomplete Plugins
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Diagnostic Plugins
Plug 'folke/trouble.nvim'

" Editor Plugins
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'Sublimeful/AutoClose'
Plug 'Sublimeful/vim-brackets'
Plug 'google/vim-searchindex'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Cosmetic Plugins
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'hoob3rt/lualine.nvim'
Plug 'alvarosevilla95/luatab.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}

" ColorScheme Plugins
Plug 'savq/melange'

call plug#end()

" --> Plugins




" <-- Lua Settings
lua << EOF

-- LSP/Completion
local lsp = require('lspconfig')
local cmp = require('cmp')

-- Function to check if there is words before the cursor
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Function feedkeys
local feedkeys = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Completion Setup
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<A-j>'] = cmp.mapping.scroll_docs(4),
    ['<A-k>'] = cmp.mapping.scroll_docs(-4),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.confirm({select = true})
      else
        fallback()
      end
    end, {'i'}),
    ['<C-j>'] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end, {'i'}),
    ['<C-k>'] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end, {'i'}),
    ['<C-e>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      end if vim.fn['vsnip#jumpable'](1) == 1 then
        feedkeys('<Plug>(vsnip-jump-next)', '')
      end
    end, {'i', 's'}),
    ['<C-q>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      end if vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkeys('<Plug>(vsnip-jump-prev)', '')
      end
    end, {'i', 's'}),
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
  formatting = {
    format = require('lspkind').cmp_format(),
  },
})

-- C# setup (requires omnisharp-mono, also requires VSCode for Unity development)
local omnisharp_bin = "C:/omnisharp-mono/OmniSharp.exe"
local pid = vim.fn.getpid()
lsp.omnisharp.setup {
  cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)};
  root_dir = lsp.util.root_pattern("*.csproj", "*.sln");
  ...
}

-- lsp_signature setup
require('lsp_signature').setup({
  debug = false,
  bind = true,
  doc_lines = 10,
  floating_window = true,
  floating_window_above_cur_line = true,
  floating_window_off_x = -1,
  floating_window_off_y =  0,
  fix_pos = false,
  hint_enable = false,
  hint_prefix = "λ ",
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter",
  max_height = 12,
  max_width = -1,
  handler_opts = {
    border = "rounded"
  },
  always_trigger = false,
  auto_close_after = nil,
  extra_trigger_chars = {},
  zindex = 200,
  padding = '',
  transparency = nil,
  shadow_blend = 36,
  shadow_guibg = 'Black',
  timer_interval = 200,
  toggle_key = nil
})

-- Setup lsp for each server
local servers = {'pyright', 'rust_analyzer', 'tsserver', 'jdtls', 'clangd', 'bashls', 'dartls', 'csharp_ls', 'html', 'emmet_ls', 'cssls'}
for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = nil,
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }
end

-- Setup mason, the lsp installer
require("mason").setup()

-- Diagnostic Configuration
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 4,
      prefix = ' ',
    },
    underline = true,
    signs = true,
  }
)

-- Treesitter Configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {"html"},
  },
  indent = {
    enable = false,
    disable = {},
  },
}

-- Trouble Configuration
require("trouble").setup {
  padding = false,
  height = 5
}

-- Telescope Configuration
local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Esc>"] = actions.close,
        ["<A-;>"] = actions.close,
        ["<A-'>"] = actions.close,
        ["<C-w>"] = {"<C-w>", type="command"},
        ["<C-h>"] = {"<C-w>", type="command"},
        ["<C-BS>"] = {"<C-w>", type="command"},
      }
    }
  }
}

-- LuaLine Configuration
require('lualine').setup {}

-- LuaTab Configuration
require('luatab').setup {}

EOF
" --> Lua Settings




" <-- AutoCommands

" Formatting options to turn off some annoying things
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

" Autocommands for saving and restoring sessions
autocmd VimLeave *        call SaveSess()
autocmd VimEnter * nested call RestoreSess()

" Autocommands for highlighting trailing spaces (disabled by default, uncomment next line to enable)
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=magenta guibg=magenta
autocmd InsertEnter * match     ExtraWhitespace /\S\@<=\s\+\%#\@<!$/
autocmd InsertLeave * match     ExtraWhitespace /\S\@<=\s\+$/
autocmd BufWinEnter * match     ExtraWhitespace /\S\@<=\s\+$/
autocmd BufWinLeave * call      clearmatches()

" --> AutoCommands




" <-- Theme

colorscheme melange

" --> Theme

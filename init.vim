" <-- Functions

function! TabSweep()
  " Remember current tab number
  let t=tabpagenr()

  " Cycle through all the tabs
  for i in range(1, tabpagenr('$'))
    execute "normal".i."gt"
  endfor

  " Go back to original tab
  execute "normal".t."gt"
endfunction

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

function! OpenInTab(node)
  " Open the file in the current tab
  call a:node.activate({'reuse': 'all', 'where': 'p', 'keepopen': 1})

  " Call tabsweep to refresh the tab names
  call timer_start(0, {-> TabSweep()})
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
inoremap <C-k>  <Esc>5k
inoremap <C-j>  <Esc>5j
inoremap <C-l>  <Esc>5l
inoremap <C-h>  <Esc>5h

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

" Toggles NERDTree
nnoremap <silent><C-b>         :NERDTreeToggle<CR><C-w>w
vnoremap <silent><C-b>    <Esc>:NERDTreeToggle<CR><C-w>w
inoremap <silent><C-b>    <Esc>:NERDTreeToggle<CR><C-w>w
tnoremap <silent><C-b>    <C-\><C-n>:NERDTreeToggle<CR><C-w>w

" NERDTree set to current directory
nnoremap <silent><Leader>c     :if @% != "" && @% != "NERD_tree_1"<CR>NERDTree %\|wincmd w<CR>endif<CR>

" Telescope
nnoremap <silent><Leader>b     :Telescope buffers<CR>
nnoremap <silent><Leader>p     :Telescope neoclip<CR>
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
  tnoremap <silent><A-t>    <C-\><C-n>:if @% != "" \|\| &modified<CR>vsp\|wincmd w<CR>endif<CR>:term<CR>i
  tnoremap <silent><C-t>    <C-\><C-n>:exit<CR>

  " Make <C-w>w work in Terminal mode
  tnoremap <silent><C-w>  <C-\><C-n><C-w>
endif

" --> Keybinds




" <-- Settings

" Enable syntax highlighting
syntax enable

" Hide ~ on the number line
let &fcs='eob: '

" NERDTree configuration
let g:NERDTreeWinSize=30
let g:NERDTreeChDirMode=2
let g:NERDTreeShowHidden=1
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_autoclose=0
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_synchronize_view=0
let g:nerdtree_tabs_synchronize_focus=0

" Autosave configuration
let g:auto_save_events=["InsertLeave", "TextChanged", "CursorHold", "CursorHoldI"]
let g:auto_save_silent=1
let g:auto_save=1

" Updatetime for auto save
set updatetime=1000

" Save undo history (make a new dir called undohistory in nvim config)
set undofile
set undodir=~/.config/nvim/undohistory

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

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'

Plug 'Sublimeful/AutoClose'
Plug 'Sublimeful/vim-brackets'

Plug 'folke/trouble.nvim'
Plug '907th/vim-auto-save'
Plug 'hoob3rt/lualine.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'RRethy/vim-hexokinase'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'google/vim-searchindex'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'alvarosevilla95/luatab.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}



Plug 'glepnir/zephyr-nvim'
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'

call plug#end()

" --> Plugins




" <-- Lua Settings
lua << EOF

-- Completion/LSP
local servers = {'pyright', 'rust_analyzer', 'tsserver', 'jdtls', 'clangd', 'bashls', 'dartls', 'csharp_ls', 'html', 'emmet_ls', 'cssls'}

local cmp = require('cmp')
local lsp = require('lspconfig')

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
    {name = 'vsnip'},
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
for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = nil,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

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

-- Neoclip Configuration
require('telescope').load_extension('neoclip')
require('neoclip').setup {
  keys = {
    telescope = {
      i = {
        paste_behind = "<C-p>",
        paste = "<CR>",
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

" Autocommands for opening files in NERDTree
autocmd VimEnter * call NERDTreeAddKeyMap({'key': '<2-LeftMouse>', 'scope': 'FileNode', 'callback': 'OpenInTab', 'override': 1})
autocmd VimEnter * call NERDTreeAddKeyMap({'key': '<CR>',          'scope': 'FileNode', 'callback': 'OpenInTab', 'override': 1})

" Autocommands for saving and restoring sessions
autocmd VimLeave *        call SaveSess()
autocmd VimEnter * nested call RestoreSess()

" Autocommands for highlighting trailing spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=magenta guibg=magenta
autocmd InsertEnter * match     ExtraWhitespace /\S\@<=\s\+\%#\@<!$/
autocmd InsertLeave * match     ExtraWhitespace /\S\@<=\s\+$/
autocmd BufWinEnter * match     ExtraWhitespace /\S\@<=\s\+$/
autocmd BufWinLeave * call      clearmatches()

" --> AutoCommands




" <-- Theme

colorscheme kanagawa

" --> Theme

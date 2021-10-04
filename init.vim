




" <-- Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'unblevable/quick-scope'

Plug 'tpope/vim-obsession'

Plug 'hoob3rt/lualine.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'voldikss/vim-floaterm'

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'Raimondi/delimitMate'
Plug 'Sublimeful/vim-brackets'



Plug 'nightsense/stellarized'
Plug 'koirand/tokyo-metro.vim'
Plug 'rafalbromirski/vim-aurora'
Plug 'bignimbus/pop-punk.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ayu-theme/ayu-vim'

call plug#end()

" --> Plugins




" <-- Functions

function! TabSweep()
  " remember current tab number
  let currentTabNumber=tabpagenr()

  " cycle through all the tabs
  for i in range(1, tabpagenr('$'))
    execute "normal " . i . "gt"
  endfor

  " go back to original tab
  execute "normal " . currentTabNumber . "gt"
endfunction

function! SaveSess()
  " SaveSess if user created file called 'Session.vim' in directory and g:saveSession exists
  if filereadable('Session.vim') && exists("g:saveSession") | Obsession | endif
endfunction

function! RestoreSess()
  " @% == "" is to check if vim is in the [No Name] buffer or not
  " if it is not then dont restore session as user has vimmed into a file
  if @% != "" | return 0 | endif

  " set g:saveSession to 1 so that vim saves session when exit
  let g:saveSession=1

  " load session if session file is found on vim enter
  if filereadable('Session.vim') | execute 'source Session.vim' | endif

  " call tabsweep to refresh the tab names
  call timer_start(0, {-> TabSweep()})
endfunction

function! OpenInTab(node)
  " switch to file window to get file name
  wincmd l

  " if the current file name is [No Name], then open the file in the current tab
  " otherwise, open the file in a new tab
  if @% == ""
    wincmd h
    call a:node.activate({'reuse': 'all', 'where': 'p', 'keepopen': 1})
  else
    wincmd h
    call a:node.activate({'reuse': 'all', 'where': 't', 'keepopen': 1})
  endif

  " call tabsweep to refresh the tab names
  call timer_start(0, {-> TabSweep()})
endfunction

" --> Functions




" <-- Keybinds

" use space as leader key
map <Space>  <Leader>

" escape key
inoremap <C-G>  <Esc>
cnoremap <C-G>  <C-C>

" set j and k to move up/down one DISPLAYED line (ignore wrapping)
nnoremap k  gk
nnoremap j  gj
vnoremap k  gk
vnoremap j  gj

" Navigate down/up/left/right 5/10 lines/chars
nnoremap <C-k>  5k
nnoremap <C-j>  5j
nnoremap <C-l>  5l
nnoremap <C-h>  5h
vnoremap <C-k>  5k
vnoremap <C-j>  5j
vnoremap <C-l>  5l
vnoremap <C-h>  5h

" set ctrl+bksp and ctrl+w to delete whole word properly
inoremap <C-BS>  <Esc>gi<C-w>
inoremap <C-h>   <Esc>gi<C-w>
inoremap <C-w>   <Esc>gi<C-w>
cnoremap <C-BS>  <C-w>
cnoremap <C-h>   <C-w>

" tab new/close/navigate
nnoremap <silent> <C-Ins>     :tabnew<CR>
nnoremap <silent> <C-Del>     :tabclose<CR>
for i in range(1, 9)
  execute "nnoremap \<A-" . i . "> " . i . "gt"
endfor

" toggles NERDTree
nnoremap <silent> <C-b>       :NERDTreeMirrorToggle<CR><C-w>w
inoremap <silent> <C-b>  <Esc>:NERDTreeMirrorToggle<CR><C-w>w

" bind f5 to run run.sh file (if it exists)
nnoremap <f5>                 :wa<CR>:!run.sh<CR><CR>
inoremap <f5>            <Esc>:wa<CR>:!run.sh<CR><CR>

" Floaterm
nnoremap <silent> <C-t>       :FloatermToggle<CR>
tnoremap <silent> <C-t>       <C-\><C-n>:FloatermToggle<CR>
inoremap <silent> <C-t>  <Esc>:FloatermToggle<CR>

" FZF
nnoremap <silent> <Leader>f   :Files<CR>
nnoremap <silent> <C-_>       :Rg<CR>

" Show diagnostics in popup
nnoremap <silent> <Leader>d   :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" Show definition in split screen
nnoremap <silent> <Leader>D   :sp<CR>:lua vim.lsp.buf.definition()<CR>

" --> Keybinds




" <-- Settings

" theme/colorscheme
colorscheme tokyo-metro
colorscheme stellarized

" enable syntax highlighting
syntax enable

" hide ~ on the number line
let &fcs='eob: '

" NERDTree configuration
let g:NERDTreeWinSize=30
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus=2
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_synchronize_view=0
let g:nerdtree_tabs_synchronize_focus=0

" Floaterm configuration
let g:floaterm_title='SubTerm'
let g:floaterm_width=0.6
let g:floaterm_height=0.8

" FZF configuration
let g:fzf_action={'Enter': 'tab split'}

" save undo history (make a new dir called undohistory in nvim config)
set undofile
set undodir=~/.config/nvim/undohistory

" enables mouse support
set mouse=a

" sets tab to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" always shows the tabline
set showtabline=2

" disables the sign column 
set signcolumn=no

" set shared clipboard
set clipboard^=unnamed,unnamedplus

" don't redraw screen every time
set lazyredraw

" disable swap files
set noswapfile

" highlights the line the cursor is on
set cursorline 

" adds column numbers to the left (relative)
set number
set relativenumber

" basically allows vim to show colors
set termguicolors

" Don't save options
set sessionoptions-=options  

" folding
set foldmethod=marker
set foldmarker=<--,-->

" enable smart case insensitive searches
set ignorecase
set smartcase

" --> Settings




" <-- Lua Settings
lua << EOF



-- LuaLine configuration
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'palenight',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {{'diagnostics',
      sources = {"nvim_lsp"},
      symbols = {
        error = ' ',
        warn = ' ',
        info = ' ',
        hint = ' '
      }},
      'encoding', 
      'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {},
}



-- LspConfig & Completion
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  require('completion').on_attach(client, bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'jdtls', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach
  }
end



-- Autocomplete keymaps and settings
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

function _G.smart_stab()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

vim.api.nvim_set_keymap('i', '<Tab>',   'v:lua.smart_tab()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.smart_stab()',{expr = true, noremap = true})

vim.g.completion_confirm_key = ""
vim.g.completion_timer_cycle = 1
vim.g.completion_trigger_on_delete = 1
vim.g.completion_matching_strategy_list = { "substring", "fuzzy" }
vim.g.completion_matching_smart_case = 1
vim.g.completion_sorting = "length"

vim.o.completeopt = 'menuone,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'



-- Custom completion icons
require('vim.lsp.protocol').CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}



-- Diagnostic Configuration
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This sets the spacing and the prefix, obviously.
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
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "html",
    "scss"
  },
}
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }



EOF
" --> Lua Settings




" <-- AutoCommands

" set pwd to current directory
silent! lcd %:p:h

" formatting options to turn off some annoying things
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

" --> AutoCommands






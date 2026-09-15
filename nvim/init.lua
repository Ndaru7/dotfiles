vim.pack.add {
    -- main plugin
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/oil.nvim',
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    "https://github.com/echasnovski/mini.nvim.git",
    "https://github.com/tpope/vim-fugitive",

    -- colorscheme
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/catppuccin/nvim",

    -- auto completion 
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",

    -- optional
    "https://github.com/sphamba/smear-cursor.nvim",

}

-- general
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.confirm = true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)


-- colorscheme
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
})
vim.cmd.colorscheme("catppuccin-nvim")
-- vim.cmd.colorscheme("tokyonight")


-- cursor animation
require("smear_cursor").setup({
    --- options
})

-- status line
require("lualine").setup()


-- filetype
vim.filetype.add {
    extension = { 
	jinja = "jinja",
	jinja2 = "jinja",
	j2 = "jinja",
    }
}

-- treesitter 
require('nvim-treesitter').install { 
    'python',
    'lua',
    'go',
    'html',
    'css',
    'jinja',
    'bash',
}

-- oil (file explorer)
require("oil").setup({
     keymaps = { ['<C-h>'] = false },
     columns = { 'size', 'mtime' },
     delete_to_trash = true,
     skip_confirm_for_simple_edits = true,
})
vim.keymap.set('n', '<leader><leader>', ':Oil<CR>', { silent = true })

-- lsp config
--
-- python
vim.lsp.config("ty", {
    settings = {
	ty = {  },
    },
})
vim.lsp.enable("ty")

-- c (clangd)
vim.lsp.config("clangd", {
    cmd = {"clangd"},
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},
    root_markers = {".clangd", ".git"}
})
vim.lsp.enable("clangd")

-- jinja
vim.lsp.enable("jinja_lsp")

-- django
vim.lsp.config("djlsp", {
    cmd = {"uv", "run" ,"djlsp"},
    filetypes = {"htmldjango", "django-html"},
    root_markers = {
        "manage.py",
        "pyproject.toml",
        ".git",
    },
})
vim.lsp.enable("djlsp")

-- html
vim.lsp.config("superhtml", {
    filetypes = { "html" }
})
vim.lsp.enable("superhtml")

-- go (gopls)
vim.lsp.enable("gopls")

-- lua
vim.lsp.config("lua-lsp", {
    cmd = {"lua-lsp"},
    filetypes = {"lua"}
})
vim.lsp.enable("lua-lsp")


-- lsp keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.o.signcolumn = 'yes:1'
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error' })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
    end,
})

-- Command :Format
vim.api.nvim_create_user_command("Format", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)

    if vim.bo.filetype ~= "html" then
        vim.notify("Format hanya untuk file HTML", vim.log.levels.WARN)
        return
    end

    if vim.fn.executable("superhtml") == 0 then
        vim.notify("superhtml tidak ditemukan di PATH", vim.log.levels.ERROR)
        return
    end

    -- simpan buffer terlebih dahulu
    vim.cmd("write")

    -- jalankan formatter
    vim.fn.system({
        "superhtml",
        "fmt",
        -- "--check",
        filename,
    })

    -- reload jika file berubah
    vim.cmd("edit!")
end, {})

-- html django
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "templates/*.html",
        "**/templates/*.html",
    },
    callback = function()
        vim.bo.filetype = "htmldjango"
    end,
})

-- nvim-cmp
local cmp = require('cmp')

cmp.setup({
    window = {
	completion = cmp.config.window.bordered(),
	documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>']     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>']   = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']     = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    }),

    -- Hapus baris dibawah untuk mengaktifkan auto trigger
    -- completion = {
    --     autocomplete = false,
    -- },
})

-- diagnostic
vim.diagnostic.config({
    update_in_insert = false, 
    underline = true,
    severity_sort = true,
    float = {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
})

-- telescope
local status_tel, builtin = pcall(require, 'telescope.builtin')
if status_tel then
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

-- auto pairs
local status_pairs, pairs = pcall(require, 'mini.pairs')
if status_pairs then
    pairs.setup({
        mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
            
            ['Close('] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
            ['Close['] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
            ['Close{'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
            
            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^\\].', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        },
    })
end

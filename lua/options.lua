local o = vim.o
local g = vim.g

-- Basic settings
o.number = true
o.relativenumber = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.cursorline = true
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.fillchars = "eob: "
o.ignorecase = true
o.smartcase = true
o.timeoutlen = 400
o.undofile = true
o.updatetime = 250
o.termguicolors = true

-- Disable some default plugins (netrw disabled in lazy.lua)

-- add yours here!
-- o.cursorlineopt ='both' -- to enable cursorline!

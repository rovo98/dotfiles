require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--

-- Enable relative line numbers
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

-- neovide
--
if vim.g.neovide then
  vim.g.neovide_opacity = 0.95
  vim.g.neovide_normal_opacity = 0.95

  vim.g.neovide_theme = 'auto'
end

local state = { enable_magic_search = true, space_visible = false }

local M = {}

local function set(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_extend("force", { silent = true }, opts or {})
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function jump_diag(count)
  vim.diagnostic.jump({
    count = count,
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end
      vim.diagnostic.open_float(bufnr, {
        border = "rounded",
        scope = "cursor",
      })
    end,
  })
end

local function diagnostic_loclist()
  vim.diagnostic.setloclist({
    title = "Diagnostics",
    format = function(diagnostic)
      local message = diagnostic.message:gsub("%s+", " ")
      local source = diagnostic.source and (" [" .. diagnostic.source .. "]") or ""
      local code = diagnostic.code and (" (" .. tostring(diagnostic.code) .. ")") or ""
      return message .. source .. code
    end,
  })
end

function M.setup_early_mappings()
  local rhs = state.enable_magic_search and "/\\v" or "/"
  vim.keymap.set({ "n", "v" }, "/", rhs, {
    remap = false,
    silent = false,
  })
end

function M.setup()
  set("i", "<C-b>", "<ESC>^i", "Beginning of line")
  set("i", "<C-e>", "<End>", "End of line")
  set("i", "<C-h>", "<Left>", "Move left")
  set("i", "<C-l>", "<Right>", "Move right")
  set("i", "<C-j>", "<Down>", "Move down")
  set("i", "<C-k>", "<Up>", "Move up")

  set("n", "<Esc>", "<cmd> noh <CR>", "Clear highlight")
  set("n", "<C-d>", "10j", "Five lines down")
  set("n", "<C-u>", "10k", "Five lines up")
  set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", { expr = true })
  set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", { expr = true })
  set("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", { expr = true })
  set("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", { expr = true })
  set("n", "<leader>bn", "<cmd> enew <CR>", "New buffer")
  set("n", "<leader>fm", function()
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ async = true })
    else
      vim.notify("conform.nvim is unavailable", vim.log.levels.WARN)
    end
  end, "Format buffer")
  set("n", "<Space>th", function()
    if state.space_visible then
      vim.opt.listchars:remove("space:·")
    else
      vim.opt.listchars:append("space:·")
    end
    state.space_visible = not state.space_visible
  end, "Toggle space visible status")
  set("n", "<leader>wv", ":vsp<CR>", "Split window vertically")
  set("n", "<leader>wh", ":sp<CR>", "Split window horizontally")
  set("n", "<leader>wc", "<C-w>c", "Close picked split window")
  set("n", "<leader>wo", "<C-w>o", "Close other split window")
  set("n", "<leader>w,", ":vertical resize -10<CR>", "Reduce vertical window size")
  set("n", "<leader>w.", ":vertical resize +10<CR>", "Increase vertical window size")
  set("n", "<leader>wj", ":horizontal resize -5<CR>", "Reduce horizontal window size")
  set("n", "<leader>wk", ":horizontal resize +5<CR>", "Increase vertical window size")
  set("n", "<leader>w=", "<C-w>=", "Make split windows equal in size")
  set("n", "<leader><Tab>s", "<cmd>tab split<CR>", "Split window use tab")
  set("n", "<leader><Tab>h", "<cmd>tabprev<CR>", "Switch to previous tab")
  set("n", "<leader><Tab>j", "<cmd>tabnext<CR>", "Switch to next tab")
  set("n", "<leader><Tab>f", "<cmd>tabfirst<CR>", "Switch to first tab")
  set("n", "<leader><Tab>l", "<cmd>tablast<CR>", "Switch to last tab")
  set("n", "<leader><Tab>c", "<cmd>tabclose<CR>", "Close tab")
  set("n", "zo", "<CMD>foldopen<CR>", "Open fold")
  set("n", "zc", "<CMD>foldclose<CR>", "Close fold")

  set("v", "<C-j>", "5j", "Five lines down")
  set("v", "<C-k>", "5k", "Five lines up")
  set("v", "<C-d>", "10j", "Five lines down")
  set("v", "<C-u>", "10k", "Five lines up")
  set("v", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", { expr = true })
  set("v", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", { expr = true })
  set("v", "<", "<gv", "Indent line")
  set("v", ">", ">gv", "Indent line")

  set("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", { expr = true })
  set("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", { expr = true })
  set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', "Do not copy replaced text", { silent = true })

  set("c", "<C-j>", "<C-n>", "Next line")
  set("c", "<C-k>", "<C-p>", "Previous line")

  set("t", "<ESC>", "<C-\\><C-n>", "Back to normal mode")
  set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode")
end

function M.setup_lsp(bufnr)
  local opts = { buffer = bufnr }

  set("n", "gD", vim.lsp.buf.declaration, "LSP declaration", opts)
  set("n", "gd", function()
    require("telescope.builtin").lsp_definitions(require("telescope.themes").get_dropdown())
  end, "LSP definition", opts)
  set("n", "K", vim.lsp.buf.hover, "LSP hover", opts)
  set("n", "gri", function()
    require("telescope.builtin").lsp_implementations(require("telescope.themes").get_dropdown())
  end, "LSP implementation", opts)
  set("n", "gi", function()
    require("telescope.builtin").lsp_implementations(require("telescope.themes").get_dropdown())
  end, "LSP implementation", opts)
  set("n", "<leader>ls", vim.lsp.buf.signature_help, "LSP signature help", opts)
  set("n", "grt", function()
    require("telescope.builtin").lsp_type_definitions(require("telescope.themes").get_dropdown())
  end, "LSP definition type", opts)
  set("n", "<leader>D", function()
    require("telescope.builtin").lsp_type_definitions(require("telescope.themes").get_dropdown())
  end, "LSP definition type", opts)
  set("n", "<leader>ca", vim.lsp.buf.code_action, "LSP code action", opts)
  set("v", "<leader>ca", vim.lsp.buf.code_action, "LSP code action", opts)
  set("n", "grr", function()
    require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy())
  end, "LSP references", opts)
  set("n", "grx", vim.lsp.codelens.run, "Run codelens", opts)
  set("n", "<leader>lf", function()
    vim.diagnostic.open_float({ border = "rounded" })
  end, "Floating diagnostic", opts)
  set("n", "[d", function()
    jump_diag(-1)
  end, "Goto prev", opts)
  set("n", "]d", function()
    jump_diag(1)
  end, "Goto next", opts)
  set("n", "<leader>q", diagnostic_loclist, "Diagnostic setloclist", opts)
  set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder", opts)
  set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder", opts)
  set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders", opts)
  set("n", "<leader>L", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle LSP inlay hints", opts)
end

return M

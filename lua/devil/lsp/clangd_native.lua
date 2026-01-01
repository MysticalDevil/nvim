local M = {}

local util = require("devil.lsp.util")

local function find_best_build_dir(root_dir)
  local luv = vim.uv or vim.loop

  if luv.fs_stat(root_dir .. "/compile_commands.json") then
    return nil -- 返回 nil 表示直接使用根目录，不需额外参数
  end

  local exact_build = root_dir .. "/build"
  if luv.fs_stat(exact_build .. "/compile_commands.json") then
    return exact_build
  end

  local pattern = root_dir .. "/*build*/compile_commands.json"
  local matches = vim.fn.glob(pattern, true, true)

  if #matches == 0 then
    return nil
  end

  table.sort(matches, function(a, b)
    local stat_a = luv.fs_stat(a)
    local stat_b = luv.fs_stat(b)
    if not stat_a then
      return false
    end
    if not stat_b then
      return true
    end
    return stat_a.mtime.sec > stat_b.mtime.sec
  end)

  return vim.fn.fnamemodify(matches[1], ":h")
end

function M.setup()
  local has_config, clangd_conf = pcall(require, "devil.lsp.config.clangd")
  if not has_config then
    vim.notify("Could not load devil.lsp.config.clangd", vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = clangd_conf.filetypes or { "c", "cpp", "objc", "objcpp", "cuda" },
    callback = function(args)
      local root_dir = vim.fs.root(args.buf, {
        "compile_commands.json",
        ".git",
        "build.sh",
        "CMakeLists.txt",
        "Makefile",
      }) or vim.fn.getcwd()

      local build_dir = find_best_build_dir(root_dir)

      local config = vim.deepcopy(clangd_conf)
      config.root_dir = root_dir
      config.name = "clangd"

      config.capabilities = vim.tbl_deep_extend("keep", config.capabilities or {}, util.common_capabilities())
      config.on_attach = function(client, bufnr)
        util.default_on_attach(client, bufnr)
      end

      if build_dir then
        if type(config.cmd) == "table" then
          table.insert(config.cmd, "--compile-commands-dir=" .. build_dir)
        end

        local folder_name = vim.fn.fnamemodify(build_dir, ":t")
        vim.notify("Clangd context: " .. folder_name, vim.log.levels.INFO)
      end

      vim.lsp.start(config, {
        reuse_client = function(client, conf)
          return client.name == conf.name
            and client.config.root_dir == conf.root_dir
            and vim.deep_equal(client.config.cmd, conf.cmd)
        end,
      })
    end,
  })
end

return M

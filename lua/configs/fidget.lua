local status, fidget = pcall(require, "fidget")
if not status then
  vim.notify("fidget not found")
  return
end

local opts = {
  text = {
    spinner = "zip", -- animation shown when tasks ar ongoing
    done = "", -- character shown when all tasks are complete
    commenced = "Started", -- message shown when task started
    completed = "Completed", -- message shown when task completes
  },
  sources = {
    ["null-ls"] = {
      ignore = true,
    },
  },
}

fidget.setup(opts)

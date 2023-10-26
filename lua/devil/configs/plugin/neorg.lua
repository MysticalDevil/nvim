local status, neorg = pcall(require, "neorg")
if not status then
  vim.notify("neorg not found", vim.log.levels.ERROR)
  return
end

neorg.setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Notes",
        },
        default_workspace = "notes",
      },
    },
  },
})

local status, flit = pcall(require, "flit")
if not status then
  vim.notify("flit.nvim not found", "error")
  return
end

local opts = {
  keys = { f = "f", F = "F", t = "t", T = "T" },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "v",
  multiline = true,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {},
}

flit.setup(opts)

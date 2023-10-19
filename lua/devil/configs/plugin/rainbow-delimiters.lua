local status, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if not status then
  vim.ontify("rainbow-delimiters.nvim not found", "error")
  return
end

vim.g.rainbow_delimiters = {
  strategy = {
    [""] = rainbow_delimiters.strategy["global"],
    vim = rainbow_delimiters.strategy["local"],
    latex = function()
      if vim.fn.line("$") > 10000 then
        return nil
      elseif vim.fn.line("$") > 1000 then
        return rainbow_delimiters.strategy["global"]
      end
      return rainbow_delimiters.strategy["local"]
    end,
  },
  query = {
    [""] = "rainbow-delimiters",
    lua = "rainbow-blocks",
    javascript = "rainbow-delimiters-react",
  },
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  },
}

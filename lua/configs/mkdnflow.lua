local mkd = require('uConfig').mkdnflow
if type(mkd) == 'table' and mkd.enable then
  local opts = {
    modules = {
      maps = false,
    },
    filetypes = { md = true, mdx = true, markdown = true },
    links = {
      style = 'markdown',
      implicit_extension = nil,
      transform_implicit = false,
      transform_explicit = function(text)
        text = text:gsub(' ', '-')
        text = text:lower()
        text = os.date('%Y-%m-%d-') .. text
        return text
      end,
    },
  }
  require('mkdnflow').setup(opts)

  local mkdnflowGroup = vim.api.nvim_create_augroup('mkdnflowGroup', {
    clear = true,
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = mkdnflowGroup,
    pattern = { 'markdown', 'md', 'mdx' },
    callback = function()
      local opts = { buffer = vim.api.nvim_get_current_buf() }
      keymap('n', mkd.next_link, '<CMD>MkdnNextLink<CR>', opts)
      keymap('n', mkd.prev_link, '<CMD>MkdnPrevLink<CR>', opts)
      keymap('n', mkd.next_heading, '<CMD>MkdnNextHeading<CR>', opts)
      keymap('n', mkd.prev_heading, '<CMD>MkdnPrevHeading<CR>', opts)
      keymap('n', mkd.go_back, '<CMD>MkdnGoBack<CR>', opts)
      keymap('n', mkd.follow_link, '<CMD>MkdnFollowLink<CR>', opts)
      keymap('n', mkd.toggle_item, '<CMD>MkdnToggleToDo<CR>', opts)
      keymap({ 'n', 'x' }, mkd.follow_link, '<CMD>MkdnFollowLink<CR>', opts)
    end
  })
end

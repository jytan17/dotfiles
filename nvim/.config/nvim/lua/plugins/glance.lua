return {
  'dnlhc/glance.nvim',
  cmd = 'Glance',
  keys = {
    { 'gpd', '<cmd>Glance definitions<CR>', desc = 'Peek definitions' },
    { 'gpA', '<cmd>Glance references<CR>', desc = 'Peek references' },
    { 'gpI', '<cmd>Glance implementations<CR>', desc = 'Peek implementations' },
    { 'gpy', '<cmd>Glance type_definitions<CR>', desc = 'Peek type definitions' },
  },
  opts = {
    height = 18,
    border = { enable = true, top_char = '─', bottom_char = '─' },
    list = { position = 'right', width = 0.33 },
    theme = { enable = true, mode = 'auto' },
    hooks = {
      before_open = function(results, open, jump, method)
        if #results == 0 then
          vim.notify('No ' .. method .. ' found', vim.log.levels.INFO)
        else
          open(results)
        end
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

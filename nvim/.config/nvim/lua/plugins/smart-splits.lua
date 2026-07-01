return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  opts = {
    -- Resize: when at nvim edge, resize the tmux pane instead
    at_edge = 'stop',
    resize_mode = {
      hooks = {
        on_leave = function() vim.notify('Exited resize mode') end,
      },
    },
  },
  keys = {
    -- Resize splits: <leader>s + hjkl (mirrors tmux prefix + hjkl)
    { '<leader>sh',     function() require('smart-splits').resize_left(5) end,  desc = 'Resize left' },
    { '<leader>sj',     function() require('smart-splits').resize_down(5) end,  desc = 'Resize down' },
    { '<leader>sk',     function() require('smart-splits').resize_up(5) end,    desc = 'Resize up' },
    { '<leader>sl',     function() require('smart-splits').resize_right(5) end, desc = 'Resize right' },
    { '<leader>s<Left>',  function() require('smart-splits').resize_left(5) end,  desc = 'Resize left' },
    { '<leader>s<Down>',  function() require('smart-splits').resize_down(5) end,  desc = 'Resize down' },
    { '<leader>s<Up>',    function() require('smart-splits').resize_up(5) end,    desc = 'Resize up' },
    { '<leader>s<Right>', function() require('smart-splits').resize_right(5) end, desc = 'Resize right' },

    -- Swap splits: <leader>s + HJKL (mirrors tmux prefix + HJKL)
    { '<leader>sH', function() require('smart-splits').swap_buf_left() end,  desc = 'Swap left' },
    { '<leader>sJ', function() require('smart-splits').swap_buf_down() end,  desc = 'Swap down' },
    { '<leader>sK', function() require('smart-splits').swap_buf_up() end,    desc = 'Swap up' },
    { '<leader>sL', function() require('smart-splits').swap_buf_right() end, desc = 'Swap right' },
    { '<leader>s<S-Left>',  function() require('smart-splits').swap_buf_left() end,  desc = 'Swap left' },
    { '<leader>s<S-Down>',  function() require('smart-splits').swap_buf_down() end,  desc = 'Swap down' },
    { '<leader>s<S-Up>',    function() require('smart-splits').swap_buf_up() end,    desc = 'Swap up' },
    { '<leader>s<S-Right>', function() require('smart-splits').swap_buf_right() end, desc = 'Swap right' },

    -- Balance splits
    { '<leader>s=', '<C-w>=', desc = 'Balance splits' },
  },
}
-- vim: ts=2 sts=2 sw=2 et

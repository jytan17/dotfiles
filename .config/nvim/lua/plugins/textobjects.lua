-- nvim-treesitter-textobjects: Only used for query files (.scm)
-- The plugin's lua code is incompatible with new nvim-treesitter API
-- We delete the plugin files to prevent the incompatible code from running
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  build = "rm -rf plugin lua", -- Remove incompatible plugin/lua dirs, keep queries/
}

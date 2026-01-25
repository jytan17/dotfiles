return {
  init_options = {
    settings = {
      -- Ignore specific rules (e.g., E501 = line too long, F401 = unused import)
      lint = {
        ignore = { "E501" },
      },
      -- Format settings
      format = {
        args = { "--line-length", "100" },
      },
    },
  },
}

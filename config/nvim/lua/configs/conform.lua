local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    yaml = { "yamlfmt" },
    ["_"] = { "trim_whitespace", "trim_newlines" },
  },
}

return options

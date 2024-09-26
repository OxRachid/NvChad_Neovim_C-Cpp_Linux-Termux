local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    sh = { "shellcheck" }, -- Add this line
    bash = { "shellcheck" },
}

lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})

lint.linters.shellcheck.args = {
    "shellcheck",
    "--format",
    '-',
    "stdout",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    pattern = "*.sh",
    callback = function()
        lint.try_lint()
    end,
})

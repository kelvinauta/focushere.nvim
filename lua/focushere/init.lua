local M = {}
function M.focusHere()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]
    local bufnr = 0
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local ns_id = vim.api.nvim_create_namespace("focus_here")
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    if start_line > 0 then
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, 0, 0, {
            end_line = start_line - 1,
            hl_group = "Comment",
            hl_eol = true
        })
    end
    if end_line < line_count - 1 then
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, end_line + 1, 0, {
            end_line = line_count,
            hl_group = "Comment",
            hl_eol = true
        })
    end
end

function M.focusClear()
    vim.api.nvim_buf_clear_namespace(0, -1, 0, -1)
end

function M.setup()
    vim.api.nvim_create_user_command('FocusHere', M.focusHere, { range = true })
    vim.api.nvim_create_user_command('FocusClear', M.focusClear, {})
end

-- {
--     "kelvinauta/focushere.nvim",
--     config = function ()
--        require("focushere.nvim").setup()
--         -- Optional KeyMap
--         vim.keymap.set("v","<A-f>" , ":FocusHere<CR>" , {noremap=true, silent=true})
--         vim.keymap.set("n","<A-f>" , ":FocusClear<CR>" , {noremap=true, silent=true})
--     end
-- }
return M

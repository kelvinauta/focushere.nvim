local M = {}
M.bufs_focused = {}
function M.genereteNameSpace()
    local buf_id = vim.api.nvim_get_current_buf()
    local title = "focushere" .. buf_id
    local buf_foc = {
        id = buf_id,
        title = title,
        namespace = vim.api.nvim_create_namespace(title)
    }
    M.bufs_focused[buf_foc.id] = buf_foc
    return buf_foc
end

function M.focusHere()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]
    local bufnr = 0
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local ns_id = M.genereteNameSpace().namespace
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    if start_line > 0 then
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, 0, 0, {
            end_line = start_line - 1,
            hl_group = "Comment",
            hl_eol = true
        })
    end
    if end_line < line_count - 1 then
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, end_line, 0, {
            end_line = line_count,
            hl_group = "Comment",
            hl_eol = true
        })
    end
end

function M.undoFocus()
    if M.bufs_focused[vim.api.nvim_get_current_buf()] then
        M.focusClear()
    else
        vim.cmd("undo")
    end
end

function M.focusClear(buf_id)
    buf_id = buf_id or vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_clear_namespace(0, -1, 0, -1)
    M.bufs_focused[buf_id] = nil
end

function M.test_setup()
    vim.api.nvim_create_user_command('TestFocusHere', M.focusHere, { range = true })
    vim.api.nvim_create_user_command('TestFocusClear', M.focusClear, {})
    vim.keymap.set('n', 'u', M.undoFocus, {}) -- WARN: Remap undo
    vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
        callback = function(ev)
            M.focusClear(ev.buf)
        end
    })
    vim.keymap.set("v", "zf", ":TestFocusHere<CR>" )
    vim.keymap.set("n", "zf", ":TestFocusClear<CR>" )
end
function M.setup()
    vim.api.nvim_create_user_command('FocusHere', M.focusHere, { range = true })
    vim.api.nvim_create_user_command('FocusClear', M.focusClear, {})
    vim.keymap.set('n', 'u', M.undoFocus, {}) -- WARN: Remap undo
    vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
        callback = function(ev)
            vim.print(ev)
            M.focusClear(ev.buf)
        end
    })
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

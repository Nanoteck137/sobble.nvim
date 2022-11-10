local Path = require "plenary.path"

-- TODO(patrik):
--   Change the path for the projects

local M = {}

M.get_projects = function()
    local file_content = Path:new("~/test.json"):read()
    local obj = vim.json.decode(file_content)
    return obj
end

M.load_project = function(proj)
    if proj.cwd == nil then
        vim.notify("Missing 'cwd' in project", vim.log.levels.ERROR)
        return
    end

    local path = Path.new(proj.cwd):expand()
    path = Path.new(path)

    vim.cmd("tcd " .. tostring(path))
    if proj.open_file then
        vim.cmd("e " .. proj.open_file);
    end
end

return M

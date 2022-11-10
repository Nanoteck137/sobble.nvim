local entry_display = require "telescope.pickers.entry_display"
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local Path = require "plenary.path"

-- TODO(patrik):
--   Load project definitions from file?
--   Load project (in new tab?)
--   Let the user pick project
--   Reload the project list

local projects = {
    {
        title = "Decker Wooh wooh wooh",
        cwd = "~/decker",
        open_file = "src/main.rs"
    },
    {
        title = "Test 1",
        cwd = "~/decker/wooh/wooh/wooh/wooh",
        open_file = "src/main.rs"
    },
    {
        title = "Test 2",
        cwd = "~/decker",
        open_file = "src/main.rs"
    },
}

local M = {}

M.load_project = function(proj)
    if proj.cwd == nil then
        vim.notify("Missing 'cwd' in project", vim.log.levels.ERROR)
        return
    end

    local path = Path.new(proj.cwd):expand()
    path = Path.new(path)

    vim.cmd("tcd " .. tostring(path))
    if proj.open_file ~= nil then
        vim.cmd("e " .. proj.open_file);
    end
end

M.test = function()
    local displayer = entry_display.create {
        separator = " ",
        items = {
            { width = 32 },
            {},
        },
    }

    local make_display = function(entry)
        return displayer {
            entry.value.title,
            entry.value.cwd
        }
    end

    local opts = {
        finder = finders.new_table({
            results = projects,
            entry_maker = function(proj)
                return {
                    value = proj,
                    ordinal = proj.title,
                    display = make_display
                }
            end
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),

        attach_mappings = function(prompt_bufnr, map)
            local enter = function()
                actions.close(prompt_bufnr)

                local selected = action_state.get_selected_entry()
                M.load_project(selected.value);
            end

            map("i", "<CR>", enter)
            map("n", "<CR>", enter)

            return true
        end,
    }

    local test = pickers.new(opts, {})
    test:find()
end

return M

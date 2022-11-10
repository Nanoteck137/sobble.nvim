local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error("This plugin requires nvim-telescope/telescope.nvim")
end

local entry_display = require "telescope.pickers.entry_display"
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local sobble = require "sobble"

local setup = function(opts)
end

local projects = function(opts)
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

    pickers.new(opts, {
        finder = finders.new_table({
            results = sobble.get_projects(),
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
                sobble.load_project(selected.value);
            end

            map("i", "<CR>", enter)
            map("n", "<CR>", enter)

            return true
        end,
    }):find()
end

return telescope.register_extension {
    setup = setup,
    exports = {
        sobble = projects,
    },
}

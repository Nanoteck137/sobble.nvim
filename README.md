# sobble.nvim

Quick project opener for Neovim

## Getting Started

### Required dependencies

- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) is required.

### Optional dependencies
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)

### Installation
Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    'nanoteck137/sobble.nvim'
    requires = { { 'nvim-lua/plenary.nvim' } }
}
```

Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'nvim-lua/plenary.nvim'
Plug 'nanoteck137/sobble.nvim'
```

## Usage

### Setup

```lua
require('sobble.nvim').setup {
    config_path = 'path to config'
}

-- Example
require('sobble.nvim').setup {
    config_path = '~/projects.json'
}
```

### Usage with Telescope

```lua
-- Load the sobble telescope extension
-- Required to use :Telescope sobble
require('telescope').load_extension('sobble')
```

```viml
" Easiest way to use the plugin
:Telescope sobble
```

### API

```lua
-- Get all the projects
local projects = require('sobble').get_projects()

-- Load project
require('sobble').load_project(projects[1])
```

## Authors

Patrik Millvik Rosenström <patrik.millvik@gmail.com>

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details

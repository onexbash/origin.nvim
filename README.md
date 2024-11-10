# origin.nvim

**Author**: onexbash
**GitHub**: [github.com/onexbash](https://github.com/onexbash)

## Table of Contents

- [Installation](#installation)
- [Dependencies](#dependencies)
- [Configuration](#configuration)
  - [opts](#opts)
  - [defaults](#defaults)
- [Roadmap](#roadmap)
  - [Planned](#planned)
  - [Maybe](#maybe)

## Installation

### lazy.nvim

```lua
{
	"onexbash/origin.nvim",
	dependencies = { "folke/noice.nvim" },
    -- you need to atleast pass an empty opts table so lazy.nvim calls the setup function in the background.
    opts = {
        -- add your config opts here
    },
}
```

## Dependencies

- [folke/noice.nvim](https://github.com/folke/noice.nvim)

## Configuration

### opts

this project is perfectly compatible with lazy.nvim and also exposes the opts{} table that can be used instead of the setup() function.
| opt | type | accepted values | description |
|-----------|--------|-------------------------------------------|-----------------------------------------------|
| tmp_dir | string | "/any/dir/with/write/permissions" | where the remote repository is stored temporary |
| provider | string | github, gitlab, bitbucket, custom | where the repository is hosted |

### defaults

```lua
opts = {
    tmp_dir = "/tmp/onetmp",
	provider = "github",
}
```

## Roadmap

### Planned

- Add support for more providers (Gitlab, Bitbucket, Azure Devops & Custom/Self-Hosted)
- Improve Documentation
- Add more opts for user customization
- Implement more use cases for working with remote repositories

### Maybe

- Add unit tests
- SSH Access to directories on remote servers
- Use curl & tar under the hood instead of git clone

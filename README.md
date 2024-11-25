# FocusHere
FocusHere te permite que el highlight solo funcione en aquel fragmento
de codigo o texto que deseas enfocarte.

# Why
Los plugins de Zen Mode son buenas opciones pero yo simplemente aveces quiero enfocar
un texto por encima de otros y no entrar en modo Zen. And the truth is, I don't know if nvim already has a native function for this lol

# Requeriments
i dont know my nvim is 0.10.1

# LazyVim Install

```lua
{
    "kelvinauta/focushere.nvim",
    config = function ()
       require("focushere.nvim").setup()
        -- Optional KeyMap
        vim.keymap.set("v","<A-f>" , ":FocusHere<CR>" , {noremap=true, silent=true})
        vim.keymap.set("n","<A-f>" , ":FocusClear<CR>" , {noremap=true, silent=true})
    end
}
```
# Functions
- `:FocusHere`: (visual mode) highlight only in this area 
- `:FocusClear`: (normal) Restore Normal highlight

# Future Features
If this repo reaches 20 stars:
- AutoMarks (customize in focus)
- Multi Focus in the same buffer
- Persistant Focus

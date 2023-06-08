local wilder = require('wilder')
wilder.setup({ modes = { ':', '/', '?' } })

wilder.set_option('renderer', wilder.popupmenu_renderer(
-- For a horizontal popup menu:
-- wilder.popupmenu_border_theme({
--     highlights = {
--         border = 'Normal', -- highlight to use for the border
--     },
--     -- 'single', 'double', 'rounded' or 'solid'
--     -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
--     border = 'rounded',
--     left = { ' ', wilder.popupmenu_devicons() },
--     right = { ' ', wilder.popupmenu_scrollbar() },
-- }),

-- For a command palette in the middle of the screen:
    wilder.popupmenu_palette_theme({
        -- 'single', 'double', 'rounded' or 'solid'
        -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
        border = 'rounded',
        max_height = '75%',      -- max height of the palette
        min_height = 0,          -- set to the same as 'max_height' for a fixed height window
        prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
        reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
    })
))

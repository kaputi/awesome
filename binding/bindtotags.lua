-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}
local modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Key bindings

function _M.get(globalkeys)
  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it work on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,

        --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- View tag only.
        awful.key({modkey}, "#" .. i + 9, function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then tag:view_only() end
        end, {description = "Go to Tag #" .. i, group = "tag"}),

        --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Toggle tag display.
        awful.key({modkey, "Control"}, "#" .. i + 9, function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then awful.tag.viewtoggle(tag) end
        end, {description = "Join Tags Temporarily" .. i, group = "tag"}),

        --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Move client to tag.
        awful.key({modkey, "Shift"}, "#" .. i + 9, function()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then client.focus:move_to_tag(tag) end
          end
        end, {description = "Move to Tag #" .. i, group = "tag"}),

        --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- Toggle tag on focused client.
        awful.key({modkey, "Control", "Shift"}, "#" .. i + 9, function()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then client.focus:toggle_tag(tag) end
          end
        end, {description = "View Client on Multiple Tags" .. i, group = "tag"}))
  end

  return globalkeys
end
-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
  __call = function(_, ...)
    return _M.get(...)
  end
})

-- config for Evgeniy Sharapov
-- smart reloading of the config 

-- Interesting Links:
--   https://medium.com/@jhkuperus/window-management-with-hammerspoon-personal-productivity-c77adc436888
--   https://medium.com/macoclock/solve-shortcut-hell-in-macos-building-a-hyper-key-1cb8838bf521

local hyper = require('hyper')
local wm = require('win-management')

hyper.install('F18') -- set to F18 which is right_alt on my MBP

hyper.bindKey('r', function()
  hs.reload()
  hs.alert.show('Reloaded')
end)

function show()
   hs.alert.show('Hello')
end

-- adding Window Manager Lunette
-- https://github.com/scottwhudson/Lunette
hs.loadSpoon("Lunette")
spoon.Lunette:bindHotkeys()

--[[
-- fullscreen
hyper.bindKey('up', wm.windowMaximize)
-- resize to center
hyper.bindKey('down', function() wm.moveWindowToPosition(wm.screenPositions.center) end)
-- window to the left half
hyper.bindKey('left', function() wm.moveWindowToPosition(wm.screenPositions.left) end)
-- window to the right
hyper.bindKey('right', function() wm.moveWindowToPosition(wm.screenPositions.right) end)
-- window to the top half
hyper.bindKey('1', function() wm.moveWindowToPosition(wm.screenPositions.top) end)
-- window to the bottom half
hyper.bindKey('2', function() wm.moveWindowToPosition(wm.screenPositions.bottom) end)

-- mobing windows between screens
hyper.bindShiftKey('right', function() hs.window.focusedWindow():moveOneScreenEast() end)
hyper.bindShiftKey('left', function() hs.window.focusedWindow():moveOneScreenWest() end)
--]]


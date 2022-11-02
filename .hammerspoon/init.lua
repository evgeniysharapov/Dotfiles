-- config for Evgeniy Sharapov
-- smart reloading of the config 

-- Interesting Links:
--   https://medium.com/@jhkuperus/window-management-with-hammerspoon-personal-productivity-c77adc436888
--   https://medium.com/macoclock/solve-shortcut-hell-in-macos-building-a-hyper-key-1cb8838bf521

local hyper = require('hyper')
local wm = require('win-management')

-- set Hyper to F18 which is right_alt on my MBP
hyper.install('F18') 

hyper.bindKey('r', function()
  hs.reload()
  hs.alert.how('Reloaded')
end)

-- adding Window Manager Lunette
-- https://github.com/scottwhudson/Lunette
--[[
hs.loadSpoon("Lunette")
-- customize bindings onto a Hyper key
customBindings = {
  leftHalf = {
    {{"cmd", "alt"}, "left"},
  },
  rightHalf = {
    {{"cmd", "alt"}, "right"},
  },
  topHalf = {
    {{"cmd", "alt"}, "up"},
  },
  bottomHalf = {
    {{"cmd", "alt"}, "down"},
  },
  topLeft = {
    {{"ctrl", "cmd"}, "Left"},
  },
  topRight = {
    {{"ctrl", "cmd"}, "Right"},
  },
  bottomLeft = {
    {{"ctrl", "cmd", "shift"}, "Left"},
  },
  bottomRight = {
    {{"ctrl", "cmd", "shift"}, "Right"},
  },
  fullScreen = {
    {{"cmd", "alt"}, "F"},
  },
  center = {
    {{"cmd", "alt"}, "C"},
  },
  nextThird = {
    {{"ctrl", "alt"}, "Right"},
  },
  prevThird = {
    {{"ctrl", "alt"}, "Left"},
  },
  enlarge = {
    {{"ctrl", "alt", "shift"}, "Right"},
  },
  shrink = {
    {{"ctrl", "alt", "shift"}, "Left"},
  },
  undo = {
    {{"F19"}, "Z"},
  },
  redo = {
    {{"alt", "cmd", "shift"}, "Z"},
  },
  nextDisplay = {
    {{"ctrl", "alt", "cmd"}, "Right"},
  },
  prevDisplay = {
    {{"ctrl", "alt", "cmd"}, "Left"},
  }
}
spoon.Lunette:bindHotkeys(customBindings)
]]--


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


-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require "storyboard"
require( "globals" )

-- load scenetemplate.lua

local options =
{
	effect = "fade",
	time = 400,
	params =
	{
		level = GAME_LEVEL,
	}
}
storyboard.gotoScene("game", options)

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):
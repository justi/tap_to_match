----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
scene.timer = null

-- requires
require( "class" )
require( "globals" )
require( "mysprite" )
require( "tile" )
require( "tilesmanager" )
require( "mytimer" )


backgroundSpriteData = require( "backgroundsprites" )
----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function scene:tick( event )

  if self.ready_to_tiles == true then
		if self.timer:getCallback('TimerStarted') == true then
		  self.ready_to_tiles = false
      self.tilesManager:createTiles(TILES_COUNT)
		end
	end

	-- add tiles
	-- update tiles
	-- update time
	-- update score
	-- game over if fail
	-- next level if pass
end



-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	self.ready_to_tiles = true

	bakckgroundImageSheet = graphics.newImageSheet( "images/background.png", backgroundSpriteData:getSheet( ) )

	backgroundImage = display.newImage( bakckgroundImageSheet, backgroundSpriteData:getFrameIndex("game_page") )

	group:insert( backgroundImage )

	local button = display.newRect( 100, 100, 100, 50)
  button:setFillColor( math.random(255), math.random(255), math.random(255) )
  --button.markTime = system.getTimer()
  group:insert( button )
  self.timer = MyTimer ( button, group )
  self.tilesManager = TilesManager( group )


  
	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
  
  Runtime:addEventListener( "enterFrame", function (event)
		 	return self:tick(event)
		end
	)

	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	Runtime:removeEventListener( "enterFrame", tick )
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene


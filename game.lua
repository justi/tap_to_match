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
		  self.tilesManager:removeGraphics( self.myGroup )
      self.tilesManager:createTiles( )
		end
	end
	if self.timer:getCallback('TimerStopped') == true or self.timer:getCallback('TimeOver') == true then
    local gameIsOver = false

    if self.timer:getCallback('TimeOver') == true then
      gameIsOver = true
    end

	  local options =
		{
			effect = "fade",
			time = 400,
			params =
			{
				gameTime = self.tilesManager:getGameTime(),
				level = self.tilesManager:getGameLevel(),
				gameIsOver = gameIsOver
			}
		}

	  self.tilesManager:removeTilesListeners( )
	  Runtime:removeEventListener( "enterFrame", self.tickHandler )
		storyboard.removeAll()
	  storyboard.gotoScene("results", options)
	end
end

function scene:prepareGraphicsItems( level )
	local group = self.view

	bakckgroundImageSheet = graphics.newImageSheet( "images/background.png", backgroundSpriteData:getSheet( ) )

	backgroundImage = display.newImage( bakckgroundImageSheet, backgroundSpriteData:getFrameIndex("game_page") )

	group:insert( backgroundImage )

	local myGroup = display.newGroup()

  _W = display.contentWidth 
  _H = display.contentHeight 

  local btnPading = 30
  local btnWidth = _W - 2*btnPading
  local btnHeight = _H - 5*btnPading
  local posX = 0 + btnPading
  local posY = 3*btnPading

	self.button = display.newRoundedRect( posX, posY, btnWidth, btnHeight, 10)
  self.button:setFillColor( 255, 230, 240 )

  self.textInfo = display.newText( "Select tiles ascending\nbelow 10 seconds!", posX + btnPading, posY + btnPading*2, btnWidth, btnHeight, native.systemFont, 16 )
	self.textInfo:setTextColor( 0, 0, 0, 255 )
  
  local text = string.format( "Level %s ", level )
	self.textLevelInfo = display.newText(text, posX + btnPading, posY + btnPading*4, btnWidth, btnHeight, native.systemFont, 30)
	self.textLevelInfo:setTextColor( 15, 25, 50, 255 )

	self.textInst = display.newText( "Ready?", posX + btnPading*2, posY + btnHeight - btnPading*2, native.systemFont, 40 )
	self.textInst:setTextColor( 0, 0, 0, 255 )

	myGroup:insert( self.button )
	myGroup:insert( self.textInst )
	myGroup:insert( self.textLevelInfo )
	myGroup:insert( self.textInfo )
  group:insert( myGroup )

  self.myGroup = myGroup
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	self.ready_to_tiles = true

	local params = event.params
	local level = params.level

	self:prepareGraphicsItems( level )

  self.timer = MyTimer ( self.button, group )
  self.tilesManager = TilesManager( level, group )
  self.tilesManager.timer = self.timer

  self.tickHandler = function ( event )
      self:tick()
  end

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
  
  Runtime:addEventListener( "enterFrame", self.tickHandler )
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	Runtime:removeEventListener( "enterFrame", self.tickHandler )
	
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

local function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName

   if ( "back" == keyName and phase == "up" ) then
      if ( storyboard.currentScene == "splash" ) then
         native.requestExit()
      else
         if ( storyboard.isOverlay ) then
            storyboard.hideOverlay()
         else
            local lastScene = storyboard.returnTo
            print( "previous scene", lastScene )
            if ( lastScene ) then
               storyboard.gotoScene( lastScene, { effect="crossFade", time=500 } )
            else
               native.requestExit()
            end
         end
      end
   end

   if ( keyName == "volumeUp" and phase == "down" ) then
      local masterVolume = audio.getVolume()
      print( "volume:", masterVolume )
      if ( masterVolume < 1.0 ) then
         masterVolume = masterVolume + 0.1
         audio.setVolume( masterVolume )
      end
   elseif ( keyName == "volumeDown" and phase == "down" ) then
      local masterVolume = audio.getVolume()
      print( "volume:", masterVolume )
      if ( masterVolume > 0.0 ) then
         masterVolume = masterVolume - 0.1
         audio.setVolume( masterVolume )
      end
   end
   return true  --SEE NOTE BELOW
end

--add the key callback
Runtime:addEventListener( "key", onKeyEvent )


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


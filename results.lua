----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- requires
require( "class" )
require( "globals" )

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

function scene:prepareGraphicsItems( params )
	local group = self.view

	local gameTime = params.gameTime

	bakckgroundImageSheet = graphics.newImageSheet( "images/background.png", backgroundSpriteData:getSheet( ) )

	backgroundImage = display.newImage( bakckgroundImageSheet, backgroundSpriteData:getFrameIndex("result_page") )

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
  self.button.alpha = 0.5
  local text1 = ""
  local text2 = ""
  if params.gameIsOver == false then 
    text1 = string.format( "You did it in %02d:%02d !", gameTime/1000, gameTime % 1000 / 10 )
    text2 = "Go to next level"
  else
  	text1 = string.format( "Game Over")
  	text2 = "Replay level?"
  end
  self.textInfo = display.newText(text1, posX + btnPading, posY + btnPading*2, btnWidth, btnHeight, native.systemFont, 25 )
	self.textInfo:setTextColor( 0, 0, 0, 255 )

	self.textInst = display.newText(text2, posX, posY + btnHeight - btnPading*2, native.systemFont, 35 )
	self.textInst:setTextColor( 0, 0, 0, 255 )

	myGroup:insert( self.button )
	myGroup:insert( self.textInst )
	myGroup:insert( self.textInfo )
  group:insert( myGroup )

  self.myGroup = myGroup
end

function scene:TouchBtn( )
	local options =
		{
			effect = "fade",
			time = 400,
			params =
			{
				level = self.level,
			}
		}
	storyboard.gotoScene("game", options)
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	self.ready_to_tiles = true
  
  local params = event.params 

  self:prepareGraphicsItems( params )

	if params.gameIsOver == false then
		params.level = params.level + 1
		self.level = params.level
	else
		self.level = params.level
	end

  self.btnHandler = function ( event )
    if event.phase == "began" then 
      return self:TouchBtn( )
    end
  end

  self.button:addEventListener( "touch", self.btnHandler)
	

	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
  
  
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view

	self.button:removeEventListener( "touch", self.btnHandler)
	self.myGroup:removeSelf( )
	self.myGroup = nil

	storyboard.removeAll()
	
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


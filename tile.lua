-- Timer Class
Tile = Class( MySprite )

function Tile:new( group, number )
	-- Create a new sprite and add it to the group

	minColorVal = TILE_MIN_COLOR_VAL
	self.number = number
  local myGroup = display.newGroup()
  self.spriteInst = myGroup

	local graphicsInst = display.newRoundedRect( 0, 0, 50, 50, 10)
	self.spriteInst.rVal =  math.random(255 - minColorVal) + minColorVal 
	self.spriteInst.gVal =  math.random(255 - minColorVal) + minColorVal 
  self.spriteInst.bVal =  math.random(255 - minColorVal) + minColorVal 

	graphicsInst:setFillColor(self.spriteInst.rVal, self.spriteInst.gVal, self.spriteInst.bVal)
	self.spriteInst.graphicsInst = graphicsInst

	local textInst = display.newText( self.number, 0, 0, native.systemFont, 16 )
	textInst:setTextColor( 0, 0, 0, 255 )
	self.spriteInst.textInst = textInst

	-- insert items into group, order is important
	myGroup:insert( graphicsInst )
	myGroup:insert( textInst )

  self.spriteInst = myGroup
	self.spriteInst.object = self
  
  if group ~= nil then
		group:insert( self.spriteInst )
	end
end

function Tile:prepareText( fontSize, tileSize )
	self.spriteInst.textInst.size = fontSize
  moveVal = self.spriteInst.width/2 + 2
	self.spriteInst.textInst.x = self.spriteInst.textInst.x + moveVal - self.spriteInst.textInst.width/2
	self.spriteInst.textInst.y = self.spriteInst.textInst.y + moveVal - self.spriteInst.textInst.height/2
end

function Tile:Touched( )
  self:TouchedAnim( 1 )
  return true
end

function Tile:TouchedAnim( val )
	if val == 1 then
    local tapSound = audio.loadSound( "sounds/tap.mp3" )
    local narrationChannel = audio.play( tapSound, { duration=1000 } )
    -- self.spriteInst.graphicsInst.strokeWidth = 3
    -- self.spriteInst.graphicsInst:setStrokeColor(self.spriteInst.rVal - minColorVal, self.spriteInst.gVal - minColorVal, self.spriteInst.bVal - minColorVal, 100)
    -- self.spriteInst.alpha = 0.0
    transition.to( self.spriteInst, { time=200, alpha=0} )
	end
end
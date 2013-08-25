-- Timer Class
Tile = Class( MySprite )

function Tile:new( group, number )
	-- Create a new sprite and add it to the group

	minColorVal = TILE_MIN_COLOR_VAL
  local myGroup = display.newGroup()
  self.spriteInst = myGroup

	local graphicsItem = display.newRoundedRect( 0, 0, 50, 50, 10)
	graphicsItem:setFillColor( math.random(255 - minColorVal) + minColorVal, math.random(255 - minColorVal) + minColorVal, math.random(255 - minColorVal) + minColorVal)
	self.spriteInst.graphicsInst = graphicsItem

	local textItem = display.newText( number, 0, 0, "Helvetica", 16 )
	textItem:setTextColor( 0, 0, 0, 255 )
	self.spriteInst.textInst = textItem

	-- insert items into group, in the order you want them displayed:
	myGroup:insert( graphicsItem )
	myGroup:insert( textItem )

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
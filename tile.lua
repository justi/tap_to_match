-- Timer Class
Tile = Class( MySprite )

function Tile:new( group )
	-- Create a new sprite and add it to the group

  self.spriteInst = display.newRect( 50, 50, 50, 50)
  self.spriteInst:setFillColor( math.random(255), math.random(255), math.random(255) )

  -- Store the instance in the sprite
	self.spriteInst.object = self
  
  self:initialise( group )
end

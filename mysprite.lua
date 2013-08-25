MySprite = Class( )

function MySprite:moveTo( posX, posY )
	self.spriteInst.x = posX
	self.spriteInst.y = posY
end

function MySprite:move( distanceX, distanceY )
	self.spriteInst.x = self.spriteInst.x + distanceX
	self.spriteInst.y = self.spriteInst.y + distanceY
end

function MySprite:initialise( group )
	if group ~= nil then
		group:insert( self.spriteInst )
	end
end

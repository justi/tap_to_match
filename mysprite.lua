MySprite = Class( )

function MySprite:moveTo( posX, posY )
	self.spriteInst.x = posX
	self.spriteInst.y = posY
end

function MySprite:move( distanceX, distanceY )
	self.spriteInst.x = self.spriteInst.x + distanceX
	self.spriteInst.y = self.spriteInst.y + distanceY
end

function MySprite:setSize( a )
	ratio = a/self.spriteInst.width
	self.spriteInst:scale(ratio, ratio)
end

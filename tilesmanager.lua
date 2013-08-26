
-- Timer Class
TilesManager = Class( )

function TilesManager:new( level, group )
  -- Create a new sprite and add it to the group
  
  self.tiles = {}
  self.numbers = {}
  self.orientation = nil
  self.group = group
  self.rows = 0
  self.cols = 0
  self.maxTileSize = 0
  self.maxWidth = 0
  self.maxHeight = 0

  self.gameLevel = level
  
  self.currentGamePosition = 1

  self.tileTouchHandler = function (ev)
    if ev.phase == "began" then 
      return self:TileTouched( ev )
    end
  end

end

function TilesManager:createTiles( )

  display.setStatusBar(display.HiddenStatusBar) 
  self.maxWidth = display.contentWidth 
  self.maxHeight = display.contentHeight 

  ACTUAL_TILES_COUNT = TILES_COUNT + self.gameLevel

  sqrt = math.sqrt(ACTUAL_TILES_COUNT)
  floor = math.floor(sqrt)
  ceil = math.ceil(sqrt)
  round = math.round(sqrt)

  if self.maxHeight > self.maxWidth then
    self.orientation = "portrait"
    if round == floor then
      self.cols = floor
    else
      self.cols = ceil
    end
    self.rows = ceil
    self.maxTileSize = self.maxWidth / self.cols
  else
    self.orientation = "landscape"
    self.cols = ceil
    if round == floor then
      self.rows = floor
    else
      self.rows = ceil
    end
    self.maxTileSize = self.maxHeight / self.rows
  end
  
  self:prepareTiles( )
end

function TilesManager:prepareNumbers( )
  math.randomseed(system.getTimer())
  
  for i=1, ACTUAL_TILES_COUNT, 1 do
    self.numbers[i] = i
  end

  for i=1, ACTUAL_TILES_COUNT, 1 do
    local index1 = math.random(2, ACTUAL_TILES_COUNT )
    local index2 = math.random(2, ACTUAL_TILES_COUNT )
    local tmp = self.numbers[index1]
    self.numbers[index1] = self.numbers[index2]
    self.numbers[index2] = tmp
  end
end

function TilesManager:prepareTiles( )
  offsetXY = 2
  topOffset = 55
  padding = 10
  tileSize = self.maxTileSize - 10
  fontSize = 20

  self:prepareNumbers()

  for i=0, ACTUAL_TILES_COUNT -1, 1 do
    posX = math.floor((i%self.cols) * self.maxTileSize + offsetXY)
    posY = math.floor(math.floor(i/self.cols) * self.maxTileSize + offsetXY) + topOffset
    
    tile = Tile( self.group, self.numbers[i+1])
    tile:setSize(tileSize)
    tile:moveTo(posX, posY)

    tile:prepareText(fontSize, tileSize)

    self.tiles[i] = tile

    tile.spriteInst:addEventListener( "touch", self.tileTouchHandler)
  end
end

function TilesManager:IsProperTile( tile )
  if tile.number == self.currentGamePosition then
    return true
  else
    return false
  end
end

function TilesManager:chandleProperTouch( )
  self.currentGamePosition = self.currentGamePosition + 1
  -- points
  if self.currentGamePosition > ACTUAL_TILES_COUNT then
    self.timer:Stop(1)
  end
end

function TilesManager:chandleValidTouch( )
end

function TilesManager:TileTouched( ev )
  local tile = ev.target.object
  if self:IsProperTile(tile) then
    tile:Touched()
    self:chandleProperTouch()
  else
    self:chandleValidTouch()
  end
end

function TilesManager:removeGraphics( group )
  group:removeSelf( )
end

function TilesManager:removeTilesListeners( )
  for k, v in pairs(self.tiles) do 
    local tile = v
    tile.spriteInst:removeEventListener( "touch", self.tileTouchHandler )
  end
end

function TilesManager:getGameTime( )
  return self.timer.elapsedTime
end

function TilesManager:getGameLevel( )
  return self.gameLevel
end



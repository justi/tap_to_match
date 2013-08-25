
-- Timer Class
TilesManager = Class( )

function TilesManager:new( group )
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
end

function TilesManager:createTiles( )

  display.setStatusBar(display.HiddenStatusBar) 
  self.maxWidth = display.contentWidth 
  self.maxHeight = display.contentHeight 

  sqrt = math.sqrt(TILES_COUNT)
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
  
  offsetXY = 2
  topOffset = 80
  padding = 10
  tileSize = self.maxTileSize - 10
  fontSize = 20

  
  self:prepareNumbers()

  for i=0, TILES_COUNT -1, 1 do
    posX = math.floor((i%self.cols) * self.maxTileSize + offsetXY)
    posY = math.floor(math.floor(i/self.cols) * self.maxTileSize + offsetXY) + topOffset
    
    tile = Tile( self.group, self.numbers[i+1])
    tile:setSize(tileSize)
    tile:moveTo(posX, posY)

    tile:prepareText(fontSize, tileSize)

    self.tiles[i] = tile
  end
end

function TilesManager:prepareNumbers( )
  math.randomseed(system.getTimer())
  
  for i=1, TILES_COUNT, 1 do
    self.numbers[i] = i
  end

  for i=1, TILES_COUNT, 1 do
    local index1 = math.random(2, TILES_COUNT )
    local index2 = math.random(2, TILES_COUNT )
    local tmp = self.numbers[index1]
    self.numbers[index1] = self.numbers[index2]
    self.numbers[index2] = tmp
  end
end

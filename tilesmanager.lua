
-- Timer Class
TilesManager = Class( )

function TilesManager:new( group )
  -- Create a new sprite and add it to the group
  
  self.tiles = {}
  self.orientation = nil
  self.group = group
  self.rows = 0
  self.cols = 0
  self.maxTileSize = 0
  self.maxWidth = 0
  self.maxHeight = 0
end

function TilesManager:createTiles( count )

  display.setStatusBar(display.HiddenStatusBar) 
  self.maxWidth = display.contentWidth 
  self.maxHeight = display.contentHeight 

  sqrt = math.sqrt(count)
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
  
  offsetXY = self.maxTileSize/2
  topOffset = 80
  padding = 10

  for i=0, count-1, 1 do
    posX = math.floor((i%self.cols) * self.maxTileSize + offsetXY)
    posY = math.floor(math.floor(i/self.cols) * self.maxTileSize + offsetXY) + topOffset
    
    tile = Tile( self.group )
    tile:setSize(self.maxTileSize - 10)
    tile:moveTo(posX, posY)

    self.tiles[i] = tile
  end
end

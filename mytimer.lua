
-- Timer Class
MyTimer = Class( )

function MyTimer:new( triggerItem, group )

  _W = display.contentWidth 
  _H = display.contentHeight 

  self.rectangle = display.newRect( 0, 0, _W, 50)
  self.rectangle:setFillColor( 0, 255, 0)
  self.rectangle.alpha = 0.5

  self.txt_counter = display.newText( self:formatTime( TIME * 1000 ), 0, 0, native.systemFont, 50 )
  self.txt_counter.x = _W/2
  self.txt_counter.y = 25
  self.txt_counter:setTextColor( 0, 0, 0 )

  self.triggerItem = triggerItem

  self.textItem = textItem

  self.callback_name = nil

  self.elapsedTime = nil

  group:insert( self.rectangle )
  group:insert( self.txt_counter )
  self.trackTimeHandler = function ( ev )
      self:trackTime()
  end
  -- touch event for the button object
  triggerItem:addEventListener( "touch", function (ev)
    if ev.phase == "began" then 
      return self:startByTouch( )
    end
  end)
end

function MyTimer:formatTime( val )
  return string.format( "%02d:%02d", val/1000, val % 1000 / 10 )
end

function MyTimer:startByTouch( )
  self.markTime = system.getTimer()
  Runtime:addEventListener( "enterFrame", self.trackTimeHandler )
  
  -- callback
  self.callback_name = "TimerStarted"
  return true
end

function MyTimer:getCallback(name)
  local res = false
  if self.callback_name ~= nil then
    if self.callback_name == name then
      res = true
    end
  end
  return (res == true)
end

function MyTimer:trackTime( )
  self.elapsedTime = system.getTimer() - self.markTime 
  if self.elapsedTime < TIME * 1000 then
    self:updateBarColor(self.elapsedTime)
    self.txt_counter.text = self:formatTime( TIME * 1000 - self.elapsedTime )
  else
    self.txt_counter.text = self:formatTime( 0 )
    transition.to( self.rectangle, { time=duration, alpha=1} )
    self:Stop(0)
   end
   return true
end

function MyTimer:updateBarColor( val )
  local colorVal = 255/( TIME * 1000) * val 
  self.rectangle:setFillColor( colorVal, 255 - colorVal, 0)
end

function MyTimer:Stop( val )
  if val == 1 then
    self.callback_name = "TimerStopped"
  else
    self.callback_name = "TimeOver"
  end
  Runtime:removeEventListener( "enterFrame", self.trackTimeHandler )
end

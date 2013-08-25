-- Timer Class
MyTimer = Class( )

function MyTimer:new( triggerItem, group )
	-- Create a new sprite and add it to the group

  display.setStatusBar(display.HiddenStatusBar) 
	_W = display.contentWidth 
	_H = display.contentHeight 

	self.txt_counter = display.newText( 10.0, 0, 0, native.systemFont, 50 )
	self.txt_counter.x = _W/2
	self.txt_counter.y = _H/2
	self.txt_counter:setTextColor( 255, 255, 255 )

	group:insert( self.txt_counter )
	self.trackTimeHandler = function ( ev )
			self:trackTime()
	end
	-- touch event for the button object
	triggerItem:addEventListener( "touch", function (ev)
			if ev.phase == "began" then 
	      print("event began")
		 	  return self:startByTouch( )
		 	end
		end
	)
end

function MyTimer:formatTime( val )
	print ("val"..val/1000)
	print ("insec"..val % 1000 / 10)
	return string.format( "%i:%i", val/1000, val % 1000 / 10 )
end

function MyTimer:startByTouch( )
	self.markTime = system.getTimer()
	Runtime:addEventListener( "enterFrame", self.trackTimeHandler )

	return true
end

function MyTimer:trackTime( )
  elapsedTime = system.getTimer() - self.markTime 
  print ( "elapsedTime: "..elapsedTime)
	if elapsedTime < 10000 then
	  self.txt_counter.text = self:formatTime( 10000 - elapsedTime )
	else
		self.txt_counter.text = self:formatTime( 0 )

	  -- stop tracking time
	  Runtime:removeEventListener( "enterFrame", self.trackTimeHandler )
	 end
	 return true
end

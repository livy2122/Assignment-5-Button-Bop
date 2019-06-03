
-----Button Bop-------
---By Olivia Clement---





--Physics
local physics = require( "physics" )
physics.start()

halfW = display.contentWidth*0.5
halfH = display.contentHeight*0.5

----background and Score
local bkg = display.newImageRect( "galaxy.jpg", 2000, 2900, halfW, halfH )

score = 0
scoreText = display.newText(score, halfW, 10)


---one point is given when balloon is clicked 
local function balloonTouched(event)
	if ( event.phase == "began" ) then
		Runtime:removeEventListener( "enterFrame", event.self )
        event.target:removeSelf()
		score = score + 1
		scoreText.text = score
    end
end


--Your score is halved when bomb is touched
local function bombTouched(event)
	if ( event.phase == "began" ) then
		Runtime:removeEventListener( "enterFrame", event.self )
        event.target:removeSelf()
		score = math.floor(score * 0.5)
		scoreText.text = score
    end
end

----Deletes Object when off screen
local function offscreen(self, event)
	if(self.y == nil) then
		return
	end
	if(self.y > display.contentHeight + 50) then
		Runtime:removeEventListener( "enterFrame", self )
		self:removeSelf()
	end
end

--- Red and Grey button fall
local function addNewBalloonOrBomb()
	local startX = math.random(display.contentWidth*0.1,display.contentWidth*0.9)
	if(math.random(1,5)==1) then
		-- Grey Button function
		local bomb = display.newImage( "JUMP2.png", startX, -300)
		physics.addBody( bomb )
		bomb.enterFrame = offscreen
		Runtime:addEventListener( "enterFrame", bomb )
		bomb:addEventListener( "touch", bombTouched )
	else
		-- Red Button Function
		local balloon = display.newImage( "JUMP.png", startX, -300)
		physics.addBody( balloon )
		balloon.enterFrame = offscreen
		Runtime:addEventListener( "enterFrame", balloon )
		balloon:addEventListener( "touch", balloonTouched )
	end
end

-- Adds new Red or Grey Button (Generates new image/sprite)
addNewBalloonOrBomb()

-- Sprite is added every .5 seconds 
timer.performWithDelay( 500, addNewBalloonOrBomb, 0 )

---Button Bop
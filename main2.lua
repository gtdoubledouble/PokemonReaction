-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

function menu()

	display.setStatusBar( display.HiddenStatusBar )
	display.setDefault( "background", 255, 255, 255 )

	opening = audio.loadStream( "opening.mp3", {loop = 0} )
	audio.play( opening )

	frame = display.newImage( "frame.png" )
	frame.x = display.contentWidth/2 
	frame.y = display.contentHeight/2

	banner = display.newImage( "banner.png" )
	banner.x = display.contentWidth/2
	banner.y = display.contentHeight/2 - 100

	play = display.newImage( "play.png" )
	play.x = display.contentWidth/2
	play.y = display.contentHeight/2 - 25
	play:addEventListener( "touch", load )

	function exitGame()
		native.requestExit() -- only on Android
		--os.exit() Not recommended
	end
		
	quit = display.newImage( "exit.png" )
	quit.x = display.contentWidth/2
	quit.y = display.contentHeight/2 + 15
	quit:addEventListener( "touch", exitGame )
		
	name = display.newImage( "name.png" )
	name.x = display.contentWidth/2
	name.y = display.contentHeight
	name:scale(0.6, 0.6)
	
	menuGroup = display.newGroup()
	menuGroup:insert( frame )
	menuGroup:insert( banner )
	menuGroup:insert( play )
	menuGroup:insert( quit )
	menuGroup:insert( name )
	
end

function load()

	-- stop opening audio
	audio.stop()
	
	-- hide all menu elements
	menuGroup.isVisible = false 
	
	bg = display.newImage( "beach.png" , true )
	bg.x = display.contentWidth/2
	bg.y = display.contentHeight/2
	
	-- timer text at the bottom, starts at 20
	timerText = display.newText( "Round lasts 20 seconds", 0, 0, "Verdana", 20 )
	timerText.x = display.contentWidth/2
	timerText.y = display.contentHeight * 0.85
	timerText:setTextColor( 0, 0, 0 )
	
	timerNum = 20
	
	-- load BGM
	battle = audio.loadStream( "battle.mp3" )
	audio.play( battle )
	-- load sound effects to use later
	koffingSound = audio.loadStream( "koffing.mp3" )
	pokeballSound = audio.loadStream( "pokeball.mp3" )
	pikachuSound = audio.loadStream( "pikachu.mp3" )
	
	-- draw pokeballs

	pokeball1 = display.newImage( "pokeball.png" )
	pokeball1.x = display.contentWidth*0.25
	pokeball1.y = display.contentHeight*0.4
		
	pokeball2 = display.newImage( "pokeball.png" )
	pokeball2.x = display.contentWidth*0.75
	pokeball2.y = display.contentHeight*0.4
	
	pokeball3 = display.newImage( "pokeball.png" )
	pokeball3.x = display.contentWidth*0.25
	pokeball3.y = display.contentHeight*0.66
	
	pokeball4 = display.newImage( "pokeball.png" )
	pokeball4.x = display.contentWidth*0.75
	pokeball4.y = display.contentHeight*0.66
	
	-- add event listeners to pokeball buttons 
	-- make sure they aren't added in the UPDATE function or else it'll be triggered with each eventFrame
	
	pokeball1:addEventListener( "touch", subHP )
	pokeball2:addEventListener( "touch", subHP )
	pokeball3:addEventListener( "touch", subHP )
	pokeball4:addEventListener( "touch", subHP )
	-- point scoring text
		
	pikachu1 = display.newImage( "pikachu.png" )
	pikachu1:scale( 0.4, 0.4 )
	pikachu1.x = display.contentWidth*0.25
	pikachu1.y = display.contentHeight*0.4
	pikachu1:addEventListener( "touch", addHP )
	pikachu1.isVisible = false
	
	pikachu2 = display.newImage( "pikachu.png" )
	pikachu2:scale( 0.4, 0.4 )
	pikachu2.x = display.contentWidth*0.75
	pikachu2.y = display.contentHeight*0.4
	pikachu2:addEventListener( "touch", addHP )
	pikachu2.isVisible = false
	
	pikachu3 = display.newImage( "pikachu.png" )
	pikachu3:scale( 0.4, 0.4 )
	pikachu3.x = display.contentWidth*0.25
	pikachu3.y = display.contentHeight*0.66
	pikachu3:addEventListener( "touch", addHP )
	pikachu3.isVisible = false
	
	pikachu4 = display.newImage( "pikachu.png" )
	pikachu4:scale( 0.4, 0.4 )
	pikachu4.x = display.contentWidth*0.75
	pikachu4.y = display.contentHeight*0.66
	pikachu4:addEventListener( "touch", addHP )
	pikachu4.isVisible = false
	
	------- TEAM ROCKETS -----------
	
	teamRocket1 = display.newImage( "teamrocket.png" )
	teamRocket1:scale( 0.4, 0.4 )
	teamRocket1.x = display.contentWidth*0.25
	teamRocket1.y = display.contentHeight*0.4
	teamRocket1:addEventListener( "touch", evil )
	teamRocket1.isVisible = false
	
	teamRocket2 = display.newImage( "teamrocket.png" )
	teamRocket2:scale( 0.4, 0.4 )
	teamRocket2.x = display.contentWidth*0.75
	teamRocket2.y = display.contentHeight*0.4
	teamRocket2:addEventListener( "touch", evil )
	teamRocket2.isVisible = false
	
	teamRocket3 = display.newImage( "teamrocket.png" )
	teamRocket3:scale( 0.4, 0.4 )
	teamRocket3.x = display.contentWidth*0.25
	teamRocket3.y = display.contentHeight*0.66
	teamRocket3:addEventListener( "touch", evil )
	teamRocket3.isVisible = false
	
	teamRocket4 = display.newImage( "teamrocket.png" )
	teamRocket4:scale( 0.4, 0.4 )
	teamRocket4.x = display.contentWidth*0.75
	teamRocket4.y = display.contentHeight*0.66
	teamRocket4:addEventListener( "touch", evil )
	teamRocket4.isVisible = false
	
	-- make a group for all game elements, except HP bar and HP because they have complicated issues for switching and alignment
	gameObjects = display.newGroup()
	
	gameObjects:insert( bg )
	
	gameObjects:insert( pokeball1 )
	gameObjects:insert( pokeball2 )
	gameObjects:insert( pokeball3 )
	gameObjects:insert( pokeball4 )
	
	gameObjects:insert( pikachu1 )
	gameObjects:insert( pikachu2 )
	gameObjects:insert( pikachu3 )
	gameObjects:insert( pikachu4 )
		
	gameObjects:insert( teamRocket1 )
	gameObjects:insert( teamRocket2 )
	gameObjects:insert( teamRocket3 )
	gameObjects:insert( teamRocket4 )
	
	--gameObjects:insert( timerText )
	timerText:toFront()
	
	
	--[[
	-- DEBUG ONLY --
	-- Create buttons for adding and subtracting HP

	plus = display.newImage( "plus.png" )
	plus.x = display.contentWidth * 0.3
	plus.y = display.contentHeight * 0.8
	-- add listener at the bottom of this code (listeners can only be declared after the listener function is defined)

	minus = display.newImage( "minus.png" )
	minus.x = display.contentWidth * 0.7
	minus.y = display.contentHeight * 0.8
	--
	
	-- add listeners
	minus:addEventListener( "touch", subHP )
	plus:addEventListener( "touch", addHP )
	]]--
	
	-- default values
	-- change these values if you wish
	pikachuTime = 500 -- 800 ms by default
	teamRocketProbability = 0.2 -- probability = 1 in 1/0.1 = 10% by default
	missed = false
	
	init()
		
end

function init()

	scaleFactor = 3
	
	hp = display.newImage( "green.png" )
	hp:scale( scaleFactor * 1.5, scaleFactor * 1.1)
	
	hp.x = display.contentWidth * 0.5 
	hp.y = display.contentHeight * 0.2 
	
	fullHP = hp.width -- original width of the full bar, in this case 48 px
	fullHPx = hp.x

	widthChange = 3
	xChange = widthChange * scaleFactor/2
	
	hpbar = display.newImage( "hpbar.png" )
	hpbar:scale( 0.66, 0.66 )
	hpbar.x = display.contentWidth * 0.5
	hpbar.y = display.contentHeight * 0.2
		
	yellow = false
	red = false
	green = true

	t = 0
	
	changed = false -- value to make sure pikachu converts back into a pokeball
		
	gameStartTime = system.getTimer()
	
	Runtime:addEventListener( "enterFrame", update)

end

-- flags to indicate HP color
red = false
yellow = false
green = true
restart = false

-- Functions for adding and subtracting HP
function addHP( event )

	if event.phase == "began" then
	
		missed = false
		print ( missed )
		
		-- play pokeball sound to indicate pokeball was tapped
		audio.play( pikachuSound )
		
		-- addHP is a bit different from subHP
		-- if we surpass fullHP, we don't want to exceed the maximum, so we instantly adjust
		
		hp.width = hp.width + widthChange
		hp.x = hp.x + xChange
		
		if hp.width + widthChange >= fullHP then
			diff = fullHP - hp.width
			hp.width = fullHP -- we set width of HP bar to be full HP
			hp.x = hp.x + diff * scaleFactor/2 -- but we need to manually adjust hp's x value based on the difference that was adjusted
				
		elseif hp.width > fullHP * 0.55 then
			-- change back to green if it was yellow
			if yellow == true then
				greenHP()
				yellow = false
				red = false
			end
		
		elseif hp.width > fullHP * 0.3 then
			-- change to yellow if it was red
			if red == true then
				yellowHP()
				red = false
				green = false
			end
		
		end			
			
		return true
		
	else		
		return false
	end
end

function subHP( event )

	if event.phase == "began" then
	
		-- play pokeball sound to indicate pokeball was tapped
		audio.play( pokeballSound )
	
		if( hp.width - widthChange <= 2 ) then
			gameOver()		
		else	
			hp.width = hp.width - widthChange
			hp.x = hp.x - xChange
			print (" HP is "..hp.width)
			-- below 30% HP, HP bar turns yellow
			-- below 10% HP, HP bar turns red
			-- we must give the red condition priority, or else yellow will trigger by default
			
			if hp.width < fullHP * 0.3 then
				redHP()
			elseif hp.width < fullHP * 0.55 then
				print ( hp.width, hp.x, hp.y )
				yellowHP()
			end
		
		end
		
		return true
	else
		return false
	end
end

function missedPenalty()

	-- play pokeball sound to indicate pokeball was tapped
	audio.play( pokeballSound )
	
	if( hp.width - widthChange <= 2 ) then
		gameOver()		
	else	
		hp.width = hp.width - widthChange
		hp.x = hp.x - xChange
		print (" HP is "..hp.width)
		-- below 30% HP, HP bar turns yellow
		-- below 10% HP, HP bar turns red
		-- we must give the red condition priority, or else yellow will trigger by default
		
		if hp.width < fullHP * 0.3 then
			redHP()
		elseif hp.width < fullHP * 0.55 then
			print ( hp.width, hp.x, hp.y )
			yellowHP()
		end
		
	end
	
	missed = false
	
end

function evil( event )
	if event.phase == "began" then
		
		-- play koffing sound to indicate Team Rocket was tapped
		audio.play( koffingSound )
		
		if( hp.width - widthChange * 4 <= 2 ) then
			gameOver()		
		else	
			hp.width = hp.width - widthChange * 4
			hp.x = hp.x - xChange * 4
			print (" HP is "..hp.width)
			-- below 30% HP, HP bar turns yellow
			-- below 10% HP, HP bar turns red
			-- we must give the red condition priority, or else yellow will trigger by default
			
			if hp.width < fullHP * 0.3 then
				redHP()
			elseif hp.width < fullHP * 0.55 then
				print ( hp.width, hp.x, hp.y )
				yellowHP()
			end
		
		end
		
		return true
	else
		return false
	end
end


function greenHP()

	-- we need to take the HP bar's attributes before we remove it
	-- to sub back into the newly replaced HP bar
	
	if restart == false then
		currentHP = hp.width
		currentHPx = hp.x
	end
	
	-- remove the red/yellow bar
	hp:removeSelf() 
	
	-- load the new bar
	hp = display.newImage( "green.png" )
	hpbar:toFront() -- cop out trick
	
	-- scale and place, restore attributes
	hp:scale( scaleFactor, scaleFactor * 1.1 )
	hp.width = currentHP 
	hp.x = currentHPx
	hp.y = currentHPy	
	
	green = true
	
	restart = false
	
end

function yellowHP()

	-- we need to take the HP bar's attributes before we remove it
	-- to sub back into the newly replaced HP bar
	currentHP = hp.width
	currentHPx = hp.x
	currentHPy = hp.y
	
	-- remove the green bar
	hp:removeSelf() 
	
	-- load the new bar
	hp = display.newImage( "yellow.png" )
	hpbar:toFront() -- cop out trick
	
	-- scale and place, restore attributes
	hp:scale( scaleFactor, scaleFactor * 1.1 )
	hp.width = currentHP 
	hp.x = currentHPx
	hp.y = currentHPy
	
	print ( hp.width, hp.x, hp.y )
	
	yellow = true
	
end

function redHP()

	-- we need to take the HP bar's attributes before we remove it
	-- to sub back into the newly replaced HP bar
	currentHP = hp.width
	currentHPx = hp.x
	
	-- remove the yellow bar
	hp:removeSelf() 
		
	-- load the new bar
	hp = display.newImage( "red.png" )
	hpbar:toFront() -- cop out trick
	
	-- scale and place, restore attributes
	hp:scale( scaleFactor, scaleFactor * 1.1 )
	hp.width = currentHP 
	hp.x = currentHPx
	hp.y = currentHPy
	
	
	red = true
	
end

function change1()
	
	changed = true
	
	tr = math.random(1,1/teamRocketProbability) 
	
	if( tr == 1 ) then 
		pokeball1.isVisible = false
		teamRocket1.isVisible = true
	else
		pokeball1.isVisible = false
		pikachu1.isVisible = true
		missed = true
	end
	
	timer.performWithDelay(pikachuTime, changeBack1, 1)
		
end

function changeBack1()
		
	if( tr == 1 ) then
		pokeball1.isVisible = true
		teamRocket1.isVisible = false
	else
		pikachu1.isVisible = false
		pokeball1.isVisible = true
		print ( missed )
		if missed == true then missedPenalty() end
	end
		
end

function change2()

	changed = true
	
	tr = math.random(1,1/teamRocketProbability) 
	
	if( tr == 1 ) then 
		pokeball2.isVisible = false
		teamRocket2.isVisible = true
	else
		pokeball2.isVisible = false
		pikachu2.isVisible = true
		missed = true
	end
	
	timer.performWithDelay(pikachuTime, changeBack2, 1)
	
end

function changeBack2()
	
	if( tr == 1 ) then
		pokeball2.isVisible = true
		teamRocket2.isVisible = false
	else
		pikachu2.isVisible = false
		pokeball2.isVisible = true
		print ( missed )
		if missed == true then missedPenalty() end
	end
	
end

function change3()

	changed = true
	
	tr = math.random(1,1/teamRocketProbability) 
	
	if( tr == 1 ) then 
		pokeball3.isVisible = false
		teamRocket3.isVisible = true
	else
		pokeball3.isVisible = false
		pikachu3.isVisible = true
		missed = true
	end
	
	timer.performWithDelay(pikachuTime, changeBack3, 1)
end

function changeBack3()
	
	if( tr == 1 ) then
		pokeball3.isVisible = true
		teamRocket3.isVisible = false
	else
		pikachu3.isVisible = false
		pokeball3.isVisible = true
		print ( missed )
		if missed == true then missedPenalty() end		
	end
end

function change4()

	changed = true
	
	tr = math.random(1,1/teamRocketProbability) 
	
	if( tr == 1 ) then 
		pokeball4.isVisible = false
		teamRocket4.isVisible = true
	else
		pokeball4.isVisible = false
		pikachu4.isVisible = true
		missed = true
	end
	
	timer.performWithDelay(pikachuTime, changeBack4, 1)
end

function changeBack4()
	
	if( tr == 1 ) then
		pokeball4.isVisible = true
		teamRocket4.isVisible = false
	else
		pikachu4.isVisible = false
		pokeball4.isVisible = true
		print ( missed )
		if missed == true then missedPenalty() end
	end
	
end

function gameOver()
	
	
	-- stop audio
	audio.stop()
	-- remove game objects from view
	gameObjects.isVisible = false
	-- stop the update thread listener
	Runtime:removeEventListener( "enterFrame", update)
	-- remove HP bars and HP (they're weird)
	hpbar:removeSelf()
	hp:toBack()
	timerText:removeSelf()
	
	if hp.width <= 3 then
		print ( "You lose" )
		defeat = audio.loadStream( "defeat.mp3" )
		audio.play( defeat )
		scoreText = display.newText( "Game over", 0, 0, "Verdana", 50 )
		scoreText.x = display.contentWidth/2
		scoreText.y = display.contentHeight/2
		scoreText:setTextColor( 0, 0, 0 )
		scoreText:toFront()
	else
		victory = audio.loadStream( "victory.mp3" )
		audio.play( victory )
		scoreText = display.newText( "Score = ", 0, 0, "Verdana", 40 )
		scoreText.x = display.contentWidth/2
		scoreText.y = display.contentHeight/2
		scoreText.text = "Score = "..hp.width
		scoreText:setTextColor( 0, 0, 0 )
		scoreText:toFront()
	end
	
	function gameOverTransition()
		audio.stop()
		hp:removeSelf()
		scoreText:removeSelf()
		menu()
	end
	
	scoreText:addEventListener( "touch", gameOverTransition )
	
end

function update()
		
	if( system.getTimer() - gameStartTime > 4500 ) then
		
		-- this works and makes you instantly lose
		-- change1()
		
		if math.random(1,40) == 1 then 
				
			-- this code is never triggering on Android
			
			if changed == false then 
				currentTime = system.getTimer()
				change1() 
			else
				if system.getTimer() - currentTime > 800 then	changed = false end
			end
			
		elseif math.random(1,40) == 2 then  
		
			if changed == false then 
				currentTime = system.getTimer()
				change2() 
			else
				if system.getTimer() - currentTime > 800 then	changed = false end
			end
			
		elseif math.random(1,40) == 3 then 
		
			if changed == false then 
				currentTime = system.getTimer()
				change3() 
			else
				if system.getTimer() - currentTime > 800 then	changed = false end
			end
			
		elseif math.random(1,40) == 4 then
		
			if changed == false then 
				currentTime = system.getTimer()
				change4() 
				
			else
				if system.getTimer() - currentTime > 800 then	changed = false end
			end
		end
		
		-- deduct from timer
		timerNum = 20 - math.round( ( system.getTimer() - gameStartTime - 4500 ) / 1000 )
		--timerText.text( timerNum )
		timerText.text = timerNum
		
		if( timerNum < 0 ) then gameOver() end
	
	else
	
		if( system.getTimer() - gameStartTime > 3500 ) then	timerText.text = "1"
		elseif( system.getTimer() - gameStartTime > 2500 ) then	timerText.text = "2" 
		elseif( system.getTimer() - gameStartTime > 1500 ) then	timerText.text = "3" 
		elseif( system.getTimer() - gameStartTime > 0 ) then	
			timerText.size = 50
			timerText.text = "Ready?" 
		end	
	end
		
	--print (math.randomseed( t + 100 ))
	--print ( math.random(), math.random(), math.random() )
	
end


menu()


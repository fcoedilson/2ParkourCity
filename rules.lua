-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local widget = require "widget"

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImage( "img/fundo_inicio.png")
	background.anchorX = 0
	background.anchorY = 0
	background.y = 300

	local rulesMessageView = display.newRect(0,0,550,200)
	local rules_text = display.newImage( "img/rules_text.png")
	rules_text.width, rules_text.height = 500, 156 
	rules_text.x, rules_text.y = display.contentWidth/2, display.contentHeight/2
	rulesMessageView:setFillColor(1,1,1)
	rulesMessageView.alpha = 0.0
	rulesMessageView.x, rulesMessageView.y = display.contentWidth/2, display.contentHeight/2
	transition.to(rulesMessageView, {alpha = 0.7, time = 2000})

	local function goToMenu()
		composer.gotoScene("menu")
		composer.removeScene( "rules" )
	end

	local back = widget.newButton{
		labelColor = { default={0}, over={128} },
		defaultFile="img/botao_regras.png",
		overFile="img/botao_regras.png",
		width=154, height=80,
		onRelease = goToMenu
	}

	back.x = display.contentWidth*0.5
	back.y = display.contentHeight*0.65

	sceneGroup:insert( background )
	sceneGroup:insert( rulesMessageView )
	sceneGroup:insert( rules_text )
	sceneGroup:insert( back )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
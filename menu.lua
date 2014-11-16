-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

function scene:create( event )
	local sceneGroup = self.view
	local backgroundMusic = audio.loadStream( "chemistry.wav" )
	local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	W = display.contentWidth / 2
	H = display.contentHeight / 2

	widthScreen = display.contentWidth
	heightScreen = display.contentHeight
	topScreen = display.screenOriginY
	leftScreen = display.screenOriginX

	-- tela inicial
	local background = display.newImage("img/fundo_inicio.png")
	background.x, background.y = W, H

	local logo = display.newImage("img/logo.png")
	logo.x, logo.y = W, H


	-- forward declarations and other locals
	local playBtn

	-- 'onRelease' event listener for playBtn
	local function onPlayBtnRelease()
		
		-- go to level1.lua scene
		composer.gotoScene( "level1", "fade", 500 )
		
		return true	-- indicates successful touch
	end

	-- carrega outra cena
	local function buttonTap(event)
	   -- storyboard.gotoScene("fase1")
		composer.gotoScene("level1", "fade", 500)
	end


	-- mostrar as regras do jogo
	local function mostrarRegras(event)
		composer.gotoScene("rules", "fade", 500)
		composer.removeScene("menu")
	end


	local buttonStart = widget.newButton {
		id = "initButton", 
		left = (W/2)-90,
		top = H/2 + 285,
		width = 180,
		height = 100,
		defaultFile = "img/botao_start.png",
		onEvent = buttonTap
	}


	local buttonRegras = widget.newButton {

		left = (W/2 + 190),
		top = H/2 + 285,
		width = 180,
		height = 100,
		defaultFile = "img/botao_regras.png",
		onEvent = mostrarRegras
	}
	sceneGroup:insert( background )
	sceneGroup:insert( buttonStart )
	sceneGroup:insert( buttonRegras )
	sceneGroup:insert (logo)
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
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
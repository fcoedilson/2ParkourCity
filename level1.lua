-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- fase1.lua

W = display.contentWidth / 2
H = display.contentHeight / 2



widthScreen = display.contentWidth
heightScreen = display.contentHeight
topScreen = display.screenOriginY
leftScreen = display.screenOriginX

local widget = require("widget")
-- include Corona's "physics" library
local physics = require "physics"
physics.start()
--physics.setGravity (0,0)
--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

function scene:create( event )
	local sceneGroup = self.view
	baseline = 280
	velocidade = 6

	-- A per-frame event to move the elements
	local tAnt = system.getTimer()
	local tprev = system.getTimer()

	local function move(event)
		
		local tdelta = event.time - tprev
		tprev = event.time

		local speed1 = 0.01*tdelta
		local speed2 = 0.05*tdelta
		local speed3 = 0.1*tdelta

		cidade.x = cidade.x - speed1
		cidade2.x = cidade2.x - speed1

		calcada.x = calcada.x - speed3
		calcada2.x = calcada2.x - speed3

		pista.x = pista.x - speed3
		pista2.x = pista2.x - speed3
		
		if (cidade.x + cidade.contentWidth/2) < 0 then
			cidade:translate( 824 * 2, 0)
		end

		if (cidade2.x + cidade2.contentWidth/2) < 0 then
			cidade2:translate( 824 * 2, 0)
		end
		
		if (calcada.x + calcada.contentWidth/2) < 0 then
			calcada:translate( 824 * 2, 0)
		end
		
		if (calcada2.x + calcada2.contentWidth/2) < 0 then
			calcada2:translate( 824 * 2, 0)
		end

		if (pista.x + pista.contentWidth/2) < 0 then
			pista:translate( 824 * 2, 0)
		end
		
		if (pista2.x + pista2.contentWidth/2) < 0 then
			pista2:translate( 824 * 2, 0)
		end
		
	end


	background = display.newImage("img/urbando_fundo_cidade.png")
	background.x, background.y = W, H

	cidade = display.newImage("img/urbando_fundo_cidade.png")
	cidade.x, cidade.y = W, H

	cidade2 = display.newImage("img/urbando_fundo_cidade.png")
	cidade2.x, cidade2.y = W+824, H

	calcada = display.newImage("img/urbano_calcada_postes.png", 0, H)
	calcada.x, calcada.y = W, H

	calcada2 = display.newImage("img/urbano_calcada_postes.png", 0, H)
	calcada2.x, calcada2.y = W+824, H


	pista = display.newImage("img/pista.png")
	pista.x, pista.y = W, H

	pista2 = display.newImage("img/pista.png")
	pista2.x, pista2.y = W+824, H

	local contVidas = 3
	local chao = display.newRect (W,H+165,screenW,1)
	chao.alpha = 0
	physics.addBody (chao, "static", {bounce = 0})

	local teto = display.newRect (W,H-180,screenW,1)
	physics.addBody (teto, "static", {bounce = 0})

	local gameOverView = display.newRect(0,0,10000,10000)
	gameOverView:setFillColor(0,0,0)
	gameOverView.alpha = 0.0
	local gameOverTxt = display.newText ("Fim de Jogo!", W, H, nil, 72)
	gameOverTxt.alpha = 0

	local vidasCorte = require ("spriteVidas")
	local folhaVidas = graphics.newImageSheet ("img/spriteVidas.png", vidasCorte.sheetData)
	local sequenceDataVidas = {
		{name = "vida3", start = 4, count = 1},
		{name = "vida2", start = 3, count = 1},
		{name = "vida1", start = 2, count = 1},
		{name = "vida0", start = 1, count = 1}
	}

	local vidasSprite = display.newSprite (folhaVidas, sequenceDataVidas)
	vidasSprite.x = W-280 
	vidasSprite.y = H-160
	vidasSprite:setSequence ("vida"..contVidas)
	vidasSprite:play()


	local pontosCount = 0
	local pontos = display.newText("Pontos: "..pontosCount, display.contentWidth - 50, display.contentHeight - 300, nil, 20)
	pontos:setFillColor(0,0,0)
	pontos.x, pontos.y = W+240, H-160

	person = graphics.newImageSheet("img/greenman.png", {width = 128, height=128, numFrames=15, sheetContentWidth=512, sheetContentHeight=512})
	seqdata = {
		{name="andando",
		sheet=person,
		start=1,
		count=14,
		time=1000,
		loopCount=0},

		{name = "pulo",
		sheet=person,
		frames = {1, 15},
		time=1000,
		loopCount=1,
		loopDirection = "bounce"
		}
	}

	personagem = display.newSprite(person, seqdata)
    personagem.x = W-270
    personagem.y = H+100
    personagem.name = "personagem"
    personagem:setSequence("andando")
    personagem:play()

    physics.addBody(personagem, "dynamic", { density=1, friction=0.5, bounce=0 })
    personagem.isFixedRotation = true

	sceneGroup:insert(background)
	sceneGroup:insert(cidade)
	sceneGroup:insert(cidade2)
	sceneGroup:insert(calcada)
	sceneGroup:insert(calcada2)
	sceneGroup:insert(pista)
	sceneGroup:insert(pista2)
	sceneGroup:insert(personagem)
	sceneGroup:insert(vidasSprite)
	sceneGroup:insert(pontos)
	sceneGroup:insert(gameOverView)
	sceneGroup:insert(gameOverTxt)


	local enemies = {}
	local contEnemies = 1
	function createEnemy()
		local enemy
		local caixa = math.random(1,4)
		if caixa == 1 then
			enemy = display.newImage("img/bloco_floresta_simples.png")
		elseif caixa == 2 then
			enemy = display.newImage("img/bloco_urbano_simples.png")
		elseif caixa == 3 then
			enemy = display.newImage("img/bloco_floresta_duplo.png")
		else
			enemy = display.newImage("img/bloco_urbano_duplo.png")
		end
		physics.addBody (enemy, "kinematic", { density=3.0, friction=0.5, bounce=0.3 })
		enemy.isFixedRotation = true
		enemy.collision = onCollisionEnemy
		enemy:addEventListener("collision", enemy)
		sceneGroup:insert (enemy)
		enemy.name = "enemy"
		enemy.x = display.contentWidth
		enemy.y = display.contentHeight-350
		enemies[contEnemies] = enemy
		contEnemies = contEnemies + 1
		
		local function removeEnemy(object)
			if caixa > 2 then
				pontosCount = pontosCount + 20
			else
				pontosCount = pontosCount + 10
			end
			pontos.text = "Pontos: "..pontosCount
			display.remove(object)
		end

		transition.to (enemy, {time = 7000, x = -80, y = enemy.y, onComplete = removeEnemy})
	end
	tm = timer.performWithDelay (3000, createEnemy, -1)

	function removeAllEnemies ()
		for i=1, #enemies do
			if (enemies [i].name ~= nil) then
				display.remove (enemies [i])
				enemies [i].name = nil		
			end
		end	
	end

	function gameOver()
		timer.cancel (tm)
		Runtime:removeEventListener ("tap", pula)
		Runtime:removeEventListener ("enterFrame", move)
		removeAllEnemies()
		display.remove (personagem)
		display.remove (enemy)
		transition.to(gameOverView, {alpha = 0.9, time = 2000})
		gameOverTxt.alpha = 1
		gameOverView:addEventListener ("tap", goToMenu)
	end

	function onCollisionEnemy (self, event)
		if (event.other.name == "personagem") then
			transition.cancel(self)
			display.remove (self)
			contVidas = contVidas - 1
			vidasSprite:setSequence ("vida"..contVidas)
			if contVidas <= 0 then
				gameOver()
			end	
		end
	end
	
	function pula(event)
		personagem:applyLinearImpulse (0, -150, personagem.x, personagem.y)
	end

	Runtime:addEventListener( "enterFrame", move)
	Runtime:addEventListener("tap", pula)

	function goToMenu()
		composer.removeScene( "level1" )
		composer.gotoScene("menu")
	end


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
		--physics.start()
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
		--physics.stop()
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
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
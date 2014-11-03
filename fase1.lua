
-- fase1.lua

W = display.contentWidth / 2
H = display.contentHeight / 2


widthScreen = display.contentWidth
heightScreen = display.contentHeight
topScreen = display.screenOriginY
leftScreen = display.screenOriginX


local storyboard = require("storyboard")
local widget = require "widget"
local scene = storyboard.newScene()

baseline = 280
velocidade = 6

local tAnt = system.getTimer()



-- Grass
-- This is doubled so we can slide it
-- When one of the grass images slides offscreen, we move it all the way to the right of the next one.


-- A per-frame event to move the elements
local tPrevious = system.getTimer()

local function move(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.1 * tDelta )

	calcada.x = calcada.x - xOffset
	calcada2.x = calcada2.x - xOffset
	pista.x = pista.x - xOffset
	pista2.x = pista2.x - xOffset
	
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


-- A sprite sheet with a cat
local person = graphics.newImageSheet("img/sprite.png", {width = 128, height=128, numFrames=15})

local seqdata = {
	name="andando",
	start=1,
	count=15,
	time=500,
	loopCount=0,
}

local instance1 = display.newSprite(person, seqdata)
      instance1.x = display.contentWidth/2 - 100
      instance1.y = baseline + 120
      instance1:play()
      instance1:setSequence("andando")



background = display.newImage("img/urbando_fundo_cidade.png")
background.x, background.y = W, H
--background.width, background.height = 960, 640

calcada = display.newImage("img/urbano_calcada_postes.png", 0, H)
calcada.x, calcada.y = W, H

calcada2 = display.newImage("img/urbano_calcada_postes.png", 0, H)
calcada2.x, calcada2.y = W+824, H


pista = display.newImage("img/pista.png")
pista.x, pista.y = W, H

pista2 = display.newImage("img/pista.png")
pista2.x, pista2.y = W+824, H

local vida  = display.newImage("img/vida.png")
vida.x, vida.y = W-300, H-160
vida.width, vida.height = 20, 20


local vida1  = display.newImage("img/vida.png")
vida1.x, vida1.y = W-280, H-160
vida1.width, vida1.height = 20, 20


local vida2  = display.newImage("img/vida.png")
vida2.x, vida2.y = W-260, H-160
vida2.width, vida2.height = 20, 20


local pontos  = display.newImage("img/pontos.png")
pontos.x, pontos.y = W+240, H-160
pontos.width, pontos.height = 80, 20


local bs = display.newImage("img/bloco_urbano_simples.png")
bs.x, bs.y = W+400, H+200


local bd = display.newImage("img/bloco_urbano_duplo.png")
bd.x, bd.y = W+180, H+200

local bd = display.newImage("img/bloco_urbano_duplo.png")
bd.x, bd.y = W, H+200


-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)
    local group = self.view
end

-- Called when scene is about to move offscreen:
function scene:exitScene(event)
    local group = self.view
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene(event)
    local group = self.view
end


Runtime:addEventListener( "enterFrame", move)

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener("createScene", scene)

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener("enterScene", scene)

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener("exitScene", scene)

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener("destroyScene", scene)

---------------------------------------------------------------------------------

return scene


-- fase1.lua

W = display.contentWidth / 2
H = display.contentHeight / 2


widthScreen = display.contentWidth
heightScreen = display.contentHeight
topScreen = display.screenOriginY
leftScreen = display.screenOriginX

local widget = require("widget")

--- storyboard
local storyboard = require("storyboard")
local scene = storyboard.newScene()

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
--background.width, background.height = 960, 640

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




-- A sprite sheet with a cat
person = graphics.newImageSheet("img/greenman.png", {width = 128, height=128, numFrames=16, sheetContentWidth=512, sheetContentHeight=512})

seqdata = {
	name="andando",
	sheet=person,
	start=1,
	count=15,
	time=1000,
	loopCount=0,
}

instance1 = display.newSprite(person, seqdata)
     instance1.x = W
     instance1.y = H+100
     instance1:play()
     -- instance1:setSequence("andando")




Runtime:addEventListener( "enterFrame", move)

local function voltarScene(event)
    print "entrou no voltar"
    storyboard.gotoScene("menu", "fade", 500)
    return true
end



local buttonVoltar = widget.newButton{
	id = "regrasButton", 
    left = (W/2 + 190),
    top = H/2 + 285,
    width = 180,
    height = 100,
    defaultFile = "img/botao_regras.png",
    onEvent = voltarScene,
}


return scene

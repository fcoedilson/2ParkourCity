
-- menu.lua

-- inclui a biblioteca de Widgets

--- storyboard
storyboard = require("storyboard")
scene = storyboard.newScene()

local widget = require("widget")

W = display.contentWidth / 2
H = display.contentHeight / 2

widthScreen = display.contentWidth
heightScreen = display.contentHeight
topScreen = display.screenOriginY
leftScreen = display.screenOriginX

-- tela inicial
local background = display.newImage("img/logo.png")
background.x, background.y = W, H
--background.width, background.height = 960, 640


-- carrega outra cena
local function buttonTap(event)
   -- storyboard.gotoScene("fase1")
	storyboard.gotoScene("fase1", "fade", 500)
	return true
end


-- mostrar as regras do jogo
local function mostrarRegras(event)

	  local text = [[  Jogo Possui 2 fases
	  O jogador incia com 3 vidas por fase
	  Pular bloco simples soma 10 pontos
	  Pular bloco duplo  soma 20 pontos
	  Pular bloco degrau soma 30 pontos
	  Perde uma vida caso não pule 3 blocos seguidos 
	  Perder as 3 vidas restarta o Jogo ]]
	  local texto = display.newText(text, (W+50), (H), native.systemFont, 24) 
	  texto:setFillColor(255,0,0)
	  transition.to( texto, { time=6000, alpha=0 } ) 
  
end


local buttonTest = widget.newButton {
	id = "initButton", 
	left = (W/2)-90,
	top = H/2 + 285,
	width = 180,
	height = 100,
	defaultFile = "img/botao_start.png",
	onEvent = buttonTap
}


local buttonRegras = widget.newButton {

	id = "regrasButton", 
	left = (W/2 + 190),
	top = H/2 + 285,
	width = 180,
	height = 100,
	defaultFile = "img/botao_regras.png",
	onEvent = mostrarRegras
}


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


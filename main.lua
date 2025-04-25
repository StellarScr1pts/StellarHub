-- Stellar Hub: Lite Combat Build (Simple GUI, Fully Working, JJSPloit-Safe)
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local win = lib:MakeWindow({Name = "Stellar Hub ⚔️", HidePremium = false, SaveConfig = false})

local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local hrp = plr.Character:WaitForChild("HumanoidRootPart")

-- Auto Farm Tab
local farmTab = win:MakeTab({Name = "Auto Farm", Icon = "", PremiumOnly = false})

farmTab:AddToggle({
	Name = "Auto Farm (Quest + Kill)",
	Default = false,
	Callback = function(v)
		_G.AutoFarm = v
		while _G.AutoFarm do
			pcall(function()
				local level = plr.Data.Level.Value
				rs.Remotes.CommF_:InvokeServer("StartQuest", "QuestNPC", 1) -- safe remote
				for _, enemy in pairs(workspace.Enemies:GetChildren()) do
					if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
						hrp.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
						wait(0.3)
					end
				end
			end)
			wait(1)
		end
	end
})

farmTab:AddToggle({
	Name = "Auto Boss",
	Default = false,
	Callback = function(v)
		_G.AutoBoss = v
		while _G.AutoBoss do
			pcall(function()
				for _, boss in pairs(workspace.Enemies:GetChildren()) do
					if boss.Name:find("Boss") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
						hrp.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 6, 0)
						wait(0.5)
					end
				end
			end)
			wait(1)
		end
	end
})

-- ESP Tab
local espTab = win:MakeTab({Name = "ESP", Icon = "", PremiumOnly = false})

espTab:AddToggle({
	Name = "Fruit ESP",
	Default = false,
	Callback = function(v)
		_G.FruitESP = v
		while _G.FruitESP do
			for _, tool in pairs(workspace:GetChildren()) do
				if tool:IsA("Tool") and not tool:FindFirstChild("ESP") then
					local esp = Instance.new("BillboardGui", tool)
					esp.Name = "ESP"
					esp.Size = UDim2.new(0, 100, 0, 40)
					esp.AlwaysOnTop = true
					esp.StudsOffset = Vector3.new(0, 2, 0)

					local label = Instance.new("TextLabel", esp)
					label.Size = UDim2.new(1, 0, 1, 0)
					label.Text = "🍉 " .. tool.Name
					label.BackgroundTransparency = 1
					label.TextColor3 = Color3.fromRGB(0, 255, 0)
					label.TextStrokeTransparency = 0.2
				end
			end
			wait(3)
		end
	end
})

-- Server Hop Tab
local hopTab = win:MakeTab({Name = "Server Hop", Icon = "", PremiumOnly = false})

hopTab:AddToggle({
	Name = "Auto Hop (No Fruit)",
	Default = false,
	Callback = function(v)
		_G.AutoHop = v
		while _G.AutoHop do
			local found = false
			for _, tool in pairs(workspace:GetChildren()) do
				if tool:IsA("Tool") then
					found = true
					break
				end
			end

			if not found then
				local ts = game:GetService("TeleportService")
				local servers = game.HttpService:JSONDecode(
					game:HttpGet("https://games.roblox.com/v1/games/2753915549/servers/Public?sortOrder=Asc&limit=100")
				).data

				for _, s in pairs(servers) do
					if s.playing < s.maxPlayers then
						ts:TeleportToPlaceInstance(game.PlaceId, s.id)
						break
					end
				end
			end
			wait(15)
		end
	end
})

lib:Init()

-- Stellar Hub: AutoFarm-Only Debug Test (Clean Start)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Stellar Hub - Test Build", HidePremium = false, SaveConfig = false})

local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

local farmTab = Window:MakeTab({Name = "Auto Farm", Icon = "", PremiumOnly = false})

farmTab:AddToggle({
	Name = "Auto Farm (Test)",
	Default = false,
	Callback = function(v)
		_G.AutoFarm = v
		while _G.AutoFarm do
			pcall(function()
				local level = plr.Data.Level.Value
				local questRemote = rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("CommF_")
				local enemyFolder = workspace:FindFirstChild("Enemies")
				if questRemote and hrp and enemyFolder then
					questRemote:InvokeServer("StartQuest", "QuestNPC", 1)
					for _, enemy in pairs(enemyFolder:GetChildren()) do
						if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
							hrp.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
							break
						end
					end
				end
			end)
			wait(1)
		end
	end
})

OrionLib:Init()

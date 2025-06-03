local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🌼 GAGHub | Grow A Garden",
   LoadingTitle = "GAGHub",
   LoadingSubtitle = "Made by xxgamertungtungxx123",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = true,
   KeySettings = {
      Title = "GAGHub Access Key",
      Subtitle = "Key System",
      Note = "Get the key from the owner (xxgamertungtungxx123)",
      FileName = "GAGHubKey",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"GAG123"}
   }
})

local MainTab = Window:CreateTab("🌱 Main", nil)
local MainSection = MainTab:CreateSection("Duping & Spawning")

MainTab:CreateButton({
   Name = "🌿 Dupe All Seeds",
   Callback = function()
      for _, seed in pairs(game:GetService("ReplicatedStorage").Seeds:GetChildren()) do
         seed:Clone().Parent = game.Players.LocalPlayer.Backpack
      end
   end,
})

MainTab:CreateButton({
   Name = "🐾 Dupe All Pets",
   Callback = function()
      for _, pet in pairs(game:GetService("ReplicatedStorage").Pets:GetChildren()) do
         pet:Clone().Parent = game.Players.LocalPlayer:WaitForChild("Pets")
      end
   end,
})

MainTab:CreateButton({
   Name = "🍎 Dupe All Fruits",
   Callback = function()
      for _, fruit in pairs(game:GetService("ReplicatedStorage").Fruits:GetChildren()) do
         fruit:Clone().Parent = game.Players.LocalPlayer.Backpack
      end
   end,
})

MainTab:CreateInput({
   Name = "➕ Spawn Seed (Name)",
   PlaceholderText = "e.g. Sunflower",
   Callback = function(text)
      local seed = game.ReplicatedStorage.Seeds:FindFirstChild(text)
      if seed then seed:Clone().Parent = game.Players.LocalPlayer.Backpack end
   end,
})

MainTab:CreateInput({
   Name = "🐶 Spawn Pet (Name, Weight, Age)",
   PlaceholderText = "e.g. Dog, 15, 4",
   Callback = function(text)
      local name, weight, age = text:match("([^,]+),%s*(%d+),%s*(%d+)")
      local pet = game.ReplicatedStorage.Pets:FindFirstChild(name)
      if pet then
         local clone = pet:Clone()
         clone:SetAttribute("Weight", tonumber(weight))
         clone:SetAttribute("Age", tonumber(age))
         clone.Parent = game.Players.LocalPlayer.Pets
      end
   end,
})

MainTab:CreateInput({
   Name = "🍓 Spawn Fruit (Name, Mutation)",
   PlaceholderText = "e.g. Berry, Rainbow",
   Callback = function(text)
      local name, mutation = text:match("([^,]+),%s*([^,]+)")
      local fruit = game.ReplicatedStorage.Fruits:FindFirstChild(name)
      if fruit then
         local clone = fruit:Clone()
         clone:SetAttribute("Mutation", mutation)
         clone.Parent = game.Players.LocalPlayer.Backpack
      end
   end,
})

MainTab:CreateToggle({
   Name = "🌾 Autofarm Crops",
   CurrentValue = false,
   Callback = function(state)
      _G.AutoFarm = state
      task.spawn(function()
         while _G.AutoFarm do
            for _, plot in pairs(workspace.Plots:GetChildren()) do
               local crop = plot:FindFirstChild("Crop")
               if crop and crop:GetAttribute("ReadyToHarvest") then
                  firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, crop, 0)
                  firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, crop, 1)
               end
            end
            task.wait(1.5)
         end
      end)
   end,
})

MainTab:CreateInput({
   Name = "🛒 Autobuy Seed (Exact Name)",
   PlaceholderText = "e.g. Carrot",
   Callback = function(seedName)
      _G.AutoBuy = true
      task.spawn(function()
         while _G.AutoBuy do
            local remote = game.ReplicatedStorage:FindFirstChild("BuySeed")
            if remote then
               remote:FireServer(seedName)
            end
            task.wait(2)
         end
      end)
   end,
})

local MiscTab = Window:CreateTab("🛠️ Player", nil)

MiscTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(val)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
   end,
})

MiscTab:CreateSlider({
   Name = "JumpPower",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(val)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
   end,
})

Rayfield:Notify({
   Title = "GAGHub Loaded",
   Content = "Welcome, tester! Enjoy Grow A Garden with max power.",
   Duration = 6,
   Image = 13047715178,
   Actions = {
      Okay = {
         Name = "Let's Grow!",
         Callback = function()
            print("GAGHub active.")
         end
      }
   },
})

wait ("0.2")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Rayfield Example Window",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Mainection = MainTab:CreateSection("🔥Farming & More🔥")

local AutoCollectBondToggle = MainTab:CreateToggle({
    Name = "Auto Collect Bond",
    CurrentValue = false,
    Flag = "AutoCollectBond",
    Callback = function(Value)
        if Value then
            AutoCollectBonds()
        else
            -- Stop auto collecting bonds
        end
    end,
})

local function AutoCollectBonds()
    local train = game.Players.LocalPlayer.Character.HumanoidRootPart
    local bondCollectKey = Enum.KeyCode.E
    local townRange = {6250000, 6850000}
    local speed = 100

    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function(dt)
        if not AutoCollectBondToggle.CurrentValue then
            connection:Disconnect()
            return
        end

        -- Move character to town area
        if train and train.Parent then
            if train.CFrame.X < townRange[2] then
                train.CFrame = train.CFrame + Vector3.new(speed * dt, 0, 0)
            else
                train.CFrame = CFrame.new(townRange[1], train.CFrame.Y, train.CFrame.Z)
            end

            -- Simulate pressing the "E" key to collect bonds
            local UserInputService = game:GetService("UserInputService")
            UserInputService:SendInput({KeyCode = bondCollectKey})
        else
            warn("Character or HumanoidRootPart not found")
            AutoCollectBondToggle:Set(false)
            connection:Disconnect()
        end
    end)
end

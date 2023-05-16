-- Variables
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local characterESPEnabled = false -- Toggle this to enable/disable the ESP

-- ESP Function
local function updateESP()
    -- Clear previous ESP objects
    for _, v in ipairs(workspace:GetChildren()) do
        if v:IsA("BoxHandleAdornment") then
            v:Destroy()
        end
    end

    -- Create new ESP objects
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Create a box around the player's character
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "CharacterESP"
                box.Adornee = humanoidRootPart
                box.Size = humanoidRootPart.Size + Vector3.new(0.1, 0.1, 0.1)
                box.Color3 = Color3.new(1, 0, 0) -- Customize the color as needed
                box.Transparency = 0.7 -- Customize the transparency as needed
                box.Parent = character
            end
        end
    end
end

-- Toggle ESP
local function toggleESP()
    characterESPEnabled = not characterESPEnabled
    if characterESPEnabled then
        updateESP()
    else
        -- Clear all ESP objects
        for _, v in ipairs(workspace:GetChildren()) do
            if v:IsA("BoxHandleAdornment") and v.Name == "CharacterESP" then
                v:Destroy()
            end
        end
    end
end

-- Enable ESP when the game starts
toggleESP()

-- Bind a key to toggle the ESP on/off
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then -- Customize the key as needed
        toggleESP()
    end
end)

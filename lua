local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TARGETS = {
    ["username1"] = true,
    ["username2"] = true,
    ["username3"] = true,
}

local DELAY = 0
local leaving = false

-- Ginagawang lowercase para kahit uppercase/mixed-case
-- ang nasa TARGETS, ma-detect pa rin
local function normalize(name)
    return string.lower(tostring(name))
end

local function isTarget(player)
    if not player then
        return false
    end

    local username = normalize(player.Name)

    for targetName in pairs(TARGETS) do
        if normalize(targetName) == username then
            return true
        end
    end

    return false
end

local function checkPlayer(player)
    if leaving then
        return
    end

    if not isTarget(player) then
        return
    end

    leaving = true

    task.delay(DELAY, function()
        if LocalPlayer and LocalPlayer.Parent == Players then
            LocalPlayer:Kick("System Error")
        end
    end)
end

-- Check players na nasa server na
for _, player in ipairs(Players:GetPlayers()) do
    checkPlayer(player)
end

-- Check bagong players na sasali
Players.PlayerAdded:Connect(function(player)
    checkPlayer(player)
end)

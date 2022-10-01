-- Variables
_G.SettingsTable = {
    ClaimGroupBenefits = false;
    EggType = "";
    EggTP = "";
    WorldOption = "";
    GemType = "";
    MultiHatch = false;
    BuyEgg = false;
    SkipAnimation = false;
    AutoCraft = false;

    
}

local SettingsTableName = "AJ_Hatching_Settings_MS2.txt"

function SaveSettingsTableSettings()
    local json
    local HttpService = game:GetService("HttpService")
    if (writefile) then
        json = HttpService:JSONEncode(_G.SettingsTable)
        writefile(SettingsTableName, json)
    end
end

function LoadSettingsTableSettings()
    local HttpService = game:GetService("HttpService")
    if (readfile and isfile and isfile(SettingsTableName)) then
        _G.SettingsTable = HttpService:JSONDecode(readfile(SettingsTableName))
        game.StarterGui:SetCore(
               	"SendNotification",
            {
                Title = "SUCCESS!",
                Text = "Settings Have Been Loaded",
                Duration = 5
            }
        )
    end
end

function HatchEgg()
    spawn(function()
        while wait() do 
            if not _G.SettingsTable.BuyEgg then break end

            local args = {
                [1] = _G.SettingsTable.EggType,
                [2] = _G.SettingsTable.MultiHatch,
                [3] = true
            }

            game:GetService("ReplicatedStorage").Events.OpenEgg:FireServer(unpack(args))
        end
    end)
end

function SkipAnimation()
    spawn(function()
        game.ReplicatedStorage.ClientModules.Other.OpenEgg.HatchGui:Destroy()
    end)
end

function TweenToEgg()
    spawn(function()
        local args = {
            [1] = _G.SettingsTable.WorldOption
        }
        
        game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
        
        wait(5)
        local New_CFrame = game:GetService("Workspace").Eggs[_G.SettingsTable.EggTP].Price.CFrame
        local ts = game:GetService('TweenService')
        local char = game.Players.LocalPlayer.Character
        local part = char.HumanoidRootPart
        local ti = TweenInfo.new(5, Enum.EasingStyle.Linear)
        local tp = {CFrame = New_CFrame}
        ts:Create(part, ti, tp):Play()
    end)
end

function ClaimGroupBenefits()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.ClaimGroupBenefits then break end
            game:GetService("ReplicatedStorage").Functions.ClaimGroupBenefits:InvokeServer()
        end
    end)
end

function AutoFactoryCraft1()
    spawn(function()
        while wait(30) do
            local args = {
                [1] = 1
            }
            
            game:GetService("ReplicatedStorage").Events.ClaimFactoryCraft:FireServer(unpack(args))
            wait(1)
            local args = {
                [1] = _G.SettingsTable.GemType,
                [2] = 1
            }
            
            game:GetService("ReplicatedStorage").Events.StartFactoryCraft:FireServer(unpack(args))
        end
    end)
end

function AutoFactoryCraft2()
    spawn(function()
        while wait(30) do
            local args = {
                [1] = 2
            }
            
            game:GetService("ReplicatedStorage").Events.ClaimFactoryCraft:FireServer(unpack(args))
            wait(1)
            local args = {
                [1] = _G.SettingsTable.GemType,
                [2] = 2
            }
            
            game:GetService("ReplicatedStorage").Events.StartFactoryCraft:FireServer(unpack(args))
        end
    end)
end

function AutoFactoryCraft3()
    spawn(function()
        while wait(30) do
            local args = {
                [1] = 3
            }
            
            game:GetService("ReplicatedStorage").Events.ClaimFactoryCraft:FireServer(unpack(args))
            wait(1)
            local args = {
                [1] = _G.SettingsTable.GemType,
                [2] = 3
            }
            
            game:GetService("ReplicatedStorage").Events.StartFactoryCraft:FireServer(unpack(args))
        end
    end)
end

function CheckSettings()
    spawn(function()
        if _G.SettingsTable.GiftReward then
            ClaimGiftRewards()
        end
        if _G.SettingsTable.BuyEgg then
            HatchEgg()
        end
    end)
end

LoadSettingsTableSettings()

if _G.SettingsTable.SkipAnimation then
    SkipAnimation()
end
if _G.SettingsTable.AutoCraft then
    AutoFactoryCraft1()
    AutoFactoryCraft2()
    AutoFactoryCraft3()
end
if _G.SettingsTable.ClaimGroupBenefits then
    ClaimGroupBenefits()
end
if _G.SettingsTable.BuyEgg then
    HatchEgg()
end
if _G.SettingsTable.TpToEgg then
    TweenToEgg()
end



-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Buddy Foundation GUI", "DarkTheme")

-- CreditsUI
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("------------------ Buddy Foundation GUI ------------------")
local CreditsSection1 = CreditsTab:NewSection("Creator/Dev: A&J Gaming#1569")
local CreditsSection3 = CreditsTab:NewSection("Helper: Cor#0002")
local CreditsSection4 = CreditsTab:NewSection("Helper: wYn#0001 (Youtube Guides)")
local CreditsSection5 = CreditsTab:NewSection("-------------------------------------------------------------------")
local CreditsSection6 = CreditsTab:NewSection("Last Updated: 2022-09-30")
local CreditsSection7 = CreditsTab:NewSection("Last Update: New GUI + Many New Features!")
local CreditsSection8 = CreditsTab:NewSection("Upcoming Update: More New Features")
local CreditsSection10 = CreditsTab:NewSection("-------------------------------------------------------------------")

-- AutofarmUI
local AutoFarmTab = Window:NewTab("AutoFarm")
local AutoFarmSelection = AutoFarmTab:NewSection("Auto Farm Gems")
local AutoGroupRewardsSection = AutoFarmTab:NewSection("Auto Collect Group Rewards")

-- EggFarmingUI
local EggFarmingTab = Window:NewTab("Egg Farming")
local AutoHatchEggSection = EggFarmingTab:NewSection("Auto Hatch Egg")
local EggsLabel = AutoHatchEggSection:NewLabel("Eggs Hatched:")
local AutoTeleportSection = EggFarmingTab:NewSection("Auto Teleport To Egg")

-- MiscUI
local MiscTab = Window:NewTab("Miscellaneous")
local MiscFeaturesSelection = MiscTab:NewSection("Miscellaneous Features")

-- SettingsUI
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("Setting Options")

-- TogglesUI
local TogglesTab = Window:NewTab("Toggles")
local ToggleUISection = TogglesTab:NewSection("Toggle UI")

-- AutoFarm
AutoGroupRewardsSection:NewToggle("Auto Collect Group Rewards", "Auto Collects Group Rewards", function(bool)
    _G.SettingsTable.ClaimGroupBenefits = bool
    SaveSettingsTableSettings()
    if bool then
        ClaimGroupBenefits()
    end
end)
AutoFarmSelection:NewTextBox("Choose Gem Type: ", "Example: Candy 5, Coins 1 (Case Sensitive!)", function(GemTypetxt)
	_G.SettingsTable.GemType = GemTypetxt
    SaveSettingsTableSettings()
end)
AutoFarmSelection:NewToggle("Auto Factory Craft", "Auto Crafts Gems of your choosing", function(bool)
    _G.SettingsTable.AutoCraft = bool
    SaveSettingsTableSettings()
    if bool then
        AutoFactoryCraft1()
        AutoFactoryCraft2()
        AutoFactoryCraft3()
    end
end)

--EggFarming
AutoHatchEggSection:NewTextBox("Choose Egg: ", "Choose what egg you want to hatch (Case Sensitive!)", function(EggTypetxt)
	_G.SettingsTable.EggType = EggTypetxt
    SaveSettingsTableSettings()
end)
AutoHatchEggSection:NewToggle("Quad/Multi Hatch", "Quad/Multi Hatches Eggs", function(bool)
    _G.SettingsTable.MultiHatch = bool
    SaveSettingsTableSettings()
end)
AutoHatchEggSection:NewToggle("Start Hatching Egg", "Starts Hatching The Egg", function(bool)
    _G.SettingsTable.BuyEgg = bool
    SaveSettingsTableSettings()
    if bool then
        HatchEgg()
    end
end)
AutoHatchEggSection:NewButton("Skip Animation", "Skips The Hatching Animation", function()
    _G.SettingsTable.SkipAnimation = true
    SaveSettingsTableSettings()
    if _G.SettingsTable.SkipAnimation then
        SkipAnimation()
    end
end)
AutoTeleportSection:NewTextBox("Choose Egg: ", "Choose what egg you want to tp to (Case Sensitive!)", function(Eggtptxt)
	_G.SettingsTable.EggTP = Eggtptxt
    SaveSettingsTableSettings()
end)
AutoTeleportSection:NewDropdown("World", "Select Which World To TP To", {"The Overworld", "Cyber Galaxy", "Atlantis", "Candyland"}, function(WorldTextOption)
    _G.SettingsTable.WorldOption = WorldTextOption
    SaveSettingsTableSettings()
end)
AutoTeleportSection:NewButton("Teleport To Egg", "Teleports You To The Selected Egg", function()
    _G.SettingsTable.TpToEgg = true
    SaveSettingsTableSettings()
    if _G.SettingsTable.TpToEgg then
        TweenToEgg()
    end
end)

-- Misc 
MiscFeaturesSelection:NewButton("Anti AFK", "Allows you to AFK Forever", function()
    local bb=game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    bb:CaptureController()bb:ClickButton2(Vector2.new())
    end)
end)

--Settings
SettingsSection:NewButton("See Settings", "Shows Your Current Settings (Type /console in chat)", function()
    print("---CURRENT SETTINGS---")
    for i,v in pairs(_G.SettingsTable) do
        print(i,v)
    end
    for i,v in pairs(_G.TrackList) do
        print(i,v)
    end
    print("----------------------")
end)
SettingsSection:NewButton("Save Settings", "Saves your current Settings", function()
    SaveSettingsTableSettings()
end)
SettingsSection:NewButton("Load Settings", "Loads your saved Settings", function()
    LoadSettingsTableSettings()
    CheckSettings()
end)

-- Toggles
ToggleUISection:NewKeybind("Toggle The UI", "Toggles The UI", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)

-- Formatting Counts
function abb(Value)
    local Number
    local Formatted = Value
    while true do
        Formatted, Number = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (Number == 0) then
            break
        end
    end
    return Formatted
end

while wait() do
    local plr = game.Players.LocalPlayer
    local OnlyCount = {plr.Name}
    local count = 0
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        for n,b in pairs(OnlyCount) do
            if string.find(v.Name, b) then
                count = v.leaderstats["Eggs"].Value    
            end
        end
    end
    EggsLabel:UpdateLabel("Eggs Hatched: " .. abb(count))
end

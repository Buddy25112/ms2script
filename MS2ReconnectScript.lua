-- Variables
_G.SettingsTable = {
    ClaimGroupBenefits = false;
    EggType = "";
    EggTP = "";
    WorldOption = "";
    LayerOption = "";
    InstantWorldOption = "";
    GemType = "";
    MultiHatch = false;
    BuyEgg = false;
    SkipAnimation = false;
    AutoCraft = false;
    BuyShopBoosts = false;

    
}

_G.SecretsList = {
    TotalSecretsHatched = 0;
}

local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
end)

local username = game:GetService("Players").LocalPlayer.Name

local SettingsTableName = username .. "_Settings_MS2.txt"
local SecretsListName = username .. "_SecretsList_MS2.txt"

function SaveSettingsTableSettings()
    local json
    local HttpService = game:GetService("HttpService")
    if (writefile) then
        json = HttpService:JSONEncode(_G.SettingsTable)
        writefile(SettingsTableName, json)
        game.StarterGui:SetCore(
               	"SendNotification",
            {
                Title = "SUCCESS!",
                Text = "Settings Have Been Saved",
                Duration = 5
            }
        )
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

function SaveSettingsSecretsList()
    local json
    local HttpService = game:GetService("HttpService")
    if (writefile) then
        json = HttpService:JSONEncode(_G.SecretsList)
        writefile(SecretsListName, json)
    end
end

function LoadSettingsSecretsList()
    local HttpService = game:GetService("HttpService")
    if (readfile and isfile and isfile(SecretsListName)) then
        _G.SecretsList = HttpService:JSONDecode(readfile(SecretsListName))
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
	if _G.SettingsTable.WorldOption == "Christmas World" then
		wait(1)
		local args = {
		    [1] = "Surface"
		}

		game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
	end
        
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

function BuyLuckyBoosts()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyShopBoosts then break end
            local args = {
                [1] = "Lucky",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
            local args = {
                [1] = "Lucky",
                [2] = 2
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuySuperLuckyBoosts()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyShopBoosts then break end
            local args = {
                [1] = "Super Lucky",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
            local args = {
                [1] = "Super Lucky",
                [2] = 2
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuyOmegaLuckyBoosts()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyShopBoosts then break end
            local args = {
                [1] = "Omega Lucky",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
            local args = {
                [1] = "Omega Lucky",
                [2] = 2
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function AutoFactoryCraft1()
    spawn(function()
        while wait(30) do
            if not _G.SettingsTable.AutoCraft then break end
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
            if not _G.SettingsTable.AutoCraft then break end
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
            if not _G.SettingsTable.AutoCraft then break end
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

function TeleportToLayer()
    spawn(function()
        local args = {
            [1] = _G.SettingsTable.LayerOption
        }

        game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
    end)
end

function UnlockLayer()
    spawn(function()
        local args = {
            [1] = _G.SettingsTable.LayerOption .. "Sell"
        }

        game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
    end)
end

function InstantTeleportToLayer()
    spawn(function()
        local args = {
            [1] = _G.SettingsTable.InstantWorldOption
        }
        
        game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
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
LoadSettingsSecretsList()

if _G.SettingsTable.SkipAnimation then
    SkipAnimation()
end
if _G.SettingsTable.BuyShopBoosts then
    BuyLuckyBoosts()
    BuySuperLuckyBoosts()
    BuyOmegaLuckyBoosts()
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

local Headers = {["content-type"] = "application/json"}
local Chat = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller

-- The Main Function
local SecretsHatched
Chat.ChildAdded:Connect(function(instance)
    if string.find(instance.TextLabel.Text,"Server") then
            if string.find(instance.TextLabel.Text,"just") then
                if string.find(instance.TextLabel.Text,"hatched") then
                    if string.find(instance.TextLabel.Text,"a") then
                        if string.find(instance.TextLabel.Text, game:GetService("Players").LocalPlayer.Name) then
                            if string.find(instance.TextLabel.Text, "Secret") or string.find(instance.TextLabel.Text, "ANCIENT") then
                                LoadSettingsSecretsList()
                                SecretsHatched = _G.SecretsList.TotalSecretsHatched + 1
                                _G.SecretsList.TotalSecretsHatched = SecretsHatched
                                SaveSettingsSecretsList()
                        end
                    end
                end
            end
        end
    end
end)

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Hatchers Hub | Mining Simulator 2 | Version 1.0.2", "Midnight")

-- CreditsUI
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("--------------------- Hatchers Hub MS2 ---------------------")
local CreditsSection1 = CreditsTab:NewSection("Creator/Dev: PetSimulatorXPlayer#5011")
local CreditsSection2 = CreditsTab:NewSection("Helper: Cor#0002")
local CreditsSection3 = CreditsTab:NewSection("Helper: wYn#0001 (Youtube Guides)")
local CreditsSection4 = CreditsTab:NewSection("⚠️ Saved Settings Will Auto Load When Executed ⚠️")
local CreditsSection5 = CreditsTab:NewSection("-------------------------------------------------------------------")
local CreditsSection6 = CreditsTab:NewSection("Last Updated: 2022-11-14")
local CreditsSection7 = CreditsTab:NewSection("Last Update: 'Secrets Hatched' Counter + More!")
local CreditsSection8 = CreditsTab:NewSection("Upcoming Update: More New Features")
local CreditsSection9 = CreditsTab:NewSection("Discord Link: https://discord.gg/83aFw8rGM8")
local CreditsSection10 = CreditsTab:NewSection("-------------------------------------------------------------------")

-- AutofarmUI
local AutoFarmTab = Window:NewTab("AutoFarm")
local AutoFarmSelection = AutoFarmTab:NewSection("Auto Farm Gems")
local AutoGroupRewardsSection = AutoFarmTab:NewSection("Auto Collect Features")

-- EggFarmingUI
local EggFarmingTab = Window:NewTab("Egg Farming")
local AutoHatchEggSection = EggFarmingTab:NewSection("Auto Hatch Egg")
local EggsLabel = AutoHatchEggSection:NewLabel("Eggs Hatched:")
local AutoTeleportSection = EggFarmingTab:NewSection("Auto Teleport To Egg")

-- MiscUI
local MiscTab = Window:NewTab("Miscellaneous")
local LayersSection = MiscTab:NewSection("Layers")
local WorldsSection = MiscTab:NewSection("Worlds")
local OtherStuffSection = MiscTab:NewSection("More Stuff Coming Soon!")

-- Other GUI's
local OtherUITab = Window:NewTab("Other GUI's")
local NotMyGUISection = OtherUITab:NewSection("I do NOT OWN these GUIS! Credits to the devs")
local CorsGUISection = OtherUITab:NewSection("Tense's OP GUI")
local SystemExodusSection = OtherUITab:NewSection("System Exodus")

-- SettingsUI
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("Setting Options (Settings Save Per Account)")

-- HelpUI
local HelpTab = Window:NewTab("Help")
local DiscordlinkSection = HelpTab:NewSection("Need help with the GUI? Join the Discord for help!")
local SaveSettingsSection = HelpTab:NewSection("Settings that are saveable")
local NoSaveSettingsSection = HelpTab:NewSection("Settings that are not saveable")
local TextBoxHelpSection = HelpTab:NewSection("Press the ENTER key after typing in the textboxes")

-- TogglesUI
local TogglesTab = Window:NewTab("Toggles")
local ToggleUISection = TogglesTab:NewSection("Toggle UI")

-- AutoFarm
AutoGroupRewardsSection:NewToggle("Auto Collect Group Rewards", "Auto Collects Group Rewards", function(bool)
    _G.SettingsTable.ClaimGroupBenefits = bool
    if bool then
        ClaimGroupBenefits()
    end
end)
AutoGroupRewardsSection:NewToggle("Auto Buy Shop Boosts", "Auto Buys Shop boosts", function(bool)
    _G.SettingsTable.BuyShopBoosts = bool
    if bool then
        BuyLuckyBoosts()
        BuySuperLuckyBoosts()
        BuyOmegaLuckyBoosts()
    end
end)
AutoFarmSelection:NewDropdown("Craft Option", "Select Which Type you want to craft in factory", {"Coins 1", "Coins 2", "Coins 3", "Coins 4", "CyberTokens 1", "CyberTokens 2", "CyberTokens 3", "CyberTokens 4", "Shells 1", "Shells 2", "Shells 3", "Shells 4", "Shells 5", "Candy 1", "Candy 2", "Candy 3", "Candy 4", "Candy 5", "Bricks 1", "Bricks 2", "Bricks 3", "Bricks 4", "Bricks 5"}, function(GemTypetxt)
    _G.SettingsTable.GemType = GemTypetxt
end)
AutoFarmSelection:NewToggle("Auto Factory Craft", "Auto Crafts Gems of your choosing", function(bool)
    _G.SettingsTable.AutoCraft = bool
    if bool then
        AutoFactoryCraft1()
        AutoFactoryCraft2()
        AutoFactoryCraft3()
    end
end)


--EggFarming
AutoHatchEggSection:NewTextBox("Choose Egg: ", "Choose what egg you want to hatch (Case Sensitive!)", function(EggTypetxt)
	_G.SettingsTable.EggType = EggTypetxt
end)
AutoHatchEggSection:NewToggle("Quad/Multi Hatch", "Quad/Multi Hatches Eggs", function(bool)
    _G.SettingsTable.MultiHatch = bool
end)
AutoHatchEggSection:NewToggle("Start Hatching Egg", "Starts Hatching The Egg", function(bool)
    _G.SettingsTable.BuyEgg = bool
    if bool then
        HatchEgg()
    end
end)
AutoHatchEggSection:NewButton("Skip Animation", "Skips The Hatching Animation", function()
    _G.SettingsTable.SkipAnimation = true
    if _G.SettingsTable.SkipAnimation then
        SkipAnimation()
    end
end)
AutoHatchEggSection:NewButton("Disable Skip Animation", "turns off skip animation when auto loading", function()
    _G.SettingsTable.SkipAnimation = false
end)
AutoTeleportSection:NewTextBox("Choose Egg: ", "Choose what egg you want to tp to (Case Sensitive!)", function(Eggtptxt)
	_G.SettingsTable.EggTP = Eggtptxt
end)
AutoTeleportSection:NewDropdown("World", "Select Which World To TP To", {"Surface", "Cyber Galaxy", "Atlantis", "Candyland", "Toyland", "Christmas World"}, function(WorldTextOption)
    _G.SettingsTable.WorldOption = WorldTextOption
end)
AutoTeleportSection:NewButton("Teleport To Egg", "Teleports You To The Selected Egg", function()
    _G.SettingsTable.TpToEgg = true
    if _G.SettingsTable.TpToEgg then
        TweenToEgg()
    end
end)


-- Misc 
LayersSection:NewDropdown("World", "Select a place to tp / unlock", {"Hidden Treasure", "Frozen Depths", "Gloomy Basin", "Molten Core", "The Underworld", "Crystal Cavern", "Cyber Sewers", "Cosmic Abyss", "Cyber Core", "Glitched Chasm", "Rocky Depths", "Sea Shell Shallows", "City of Gold", "Dark Coral Depths", "Chocolate Caves", "Gummy Depths", "Cupcake Cavern", "Donut Depths", "Blocky Basin", "Bear Depths", "Building Depths", "Christmas World"}, function(LayerTextOption)
    _G.SettingsTable.LayerOption = LayerTextOption
end)
LayersSection:NewButton("Teleport to Layer", "Teleports you to the selected layer", function()
    TeleportToLayer()
end)
LayersSection:NewButton("Unlock Layer", "Unlocks the selected layer", function()
    UnlockLayer()
end)
WorldsSection:NewDropdown("World", "Select Which World To TP To", {"The Overworld", "Cyber Galaxy", "Atlantis", "Candyland", "Toyland", "GemGenie", "Christmas World"}, function(InstantWorldTextOption)
    _G.SettingsTable.InstantWorldOption = InstantWorldTextOption
end)
WorldsSection:NewButton("Teleport To World", "Teleports you to the selected world", function()
    InstantTeleportToLayer()
end)

-- Other Gui's 
CorsGUISection:NewDropdown("Tense's OP GUI Features:", "Most Of Tense's Op GUI's Features", {"Auto farm Blocks", "Egg Hatching", "Auto Collect Ores", "Auto Sell/Teleport", "AntiAFK", "Auto Trick Or Treat (OP)", "Auto Factory", "Fake Pet Equip", "Fake Pet Hatch", "Mass Delete Pets", "Auto Shiny", "Unlock/Teleport To Any Layer", "Pet Hatcher", "Stats Tracker", "Remote UI's", "Skip Animation", "SO MUCH MORE!"}, function()
end)
CorsGUISection:NewButton("Activate Script", "Executes the Script", function()
    loadstring(game:HttpGet(("https://raw.githubusercontent.com/wingedmother69/thingz/main/ms2ui.lua"),true))()
end)
SystemExodusSection:NewDropdown("System Exodus Features:", "Most Of System Exodus Features", {"Auto Farm Blocks (3x3)", "Auto Farm Eggs", "Pet Hatcher", "Auto Factory", "Auto Open Crates", "Auto Trick Or Treat", "Auto Claim Group Rewards", "Auto Delete Pets", "Statistics", "Skip Animation", "WAY MORE!"}, function()
end)
SystemExodusSection:NewButton("Activate Script", "Executes the Script", function()
    loadstring(game:HttpGet("https://www.system-exodus.com/scripts/MiningSimulator/MiningSimulator2.lua"))()
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


-- Help
DiscordlinkSection:NewButton("Discord Invite", "Click to recieve an invite to the discord server", function()
    (syn and syn.request or http_request or request)({ Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",Headers = {["Content-Type"] = "application/json",
                ["Origin"] = "https://discord.com"},
                    Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",
                        args = {code = "83aFw8rGM8"},
                            nonce = game:GetService("HttpService"):GenerateGUID(false)})})
end)
SaveSettingsSection:NewDropdown("Settings:", "Settings that will be saved", {"Craft Option", "Auto Factory Craft", "Auto Collect Group Rewards", "Auto Buy Shop Boosts", "Choose Egg: (Hatching)", "Quad/Multi Hatch", "Start Hatching Egg", "Skip Animation", "Disable Skip Animation", "Choose Egg: (Teleport)", "Select World (Egg Teleport)", "Teleport To Egg"}, function()
end)
NoSaveSettingsSection:NewDropdown("Settings", "Settings that will not be saved", {"All Other GUI's", "Select Layer (Teleport/Unlock)","Teleport To Layer","Unlock Layer", "Select World (Instant TP)", "Teleport to world"}, function()
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
    local count = 0
    count = game:GetService("Players")[username].leaderstats.Eggs.Value
    EggsLabel:UpdateLabel("Eggs Hatched: " .. abb(count) .. " | Secrets Hatched: " .. abb(_G.SecretsList.TotalSecretsHatched))
end

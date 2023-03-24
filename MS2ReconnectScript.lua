-- Mining Simulator 2 Gui
repeat task.wait() until game:IsLoaded()

-- Variables
_G.SettingsTable = {
    ClaimGroupBenefits = false;
    EggType = "None";
    BackupEggType = "None";
    BackupEggTP = "None";
    BackupWorldOption = "None";
    EggTP = "None";
    WorldOption = "None";
    LayerOption = "None";
    InstantWorldOption = "None";
    GemType = "None";
    EnableBackup = false;
    MultiHatch = false;
    BuyEgg = false;
    SkipAnimation = false;
    AutoCraft = false;
    BuyLucky1Hour = false;
    BuyLucky2Hour = false;
    BuySuperLucky1Hour = false;
    BuySuperLucky2Hour = false;
    BuyOmegaLucky1Hour = false;
    BuyOmegaLucky2Hour = false;
    FPSSettings = "60";
    Webhookssss = "";
    Intervals = 3600;
    ColorOption = "";
    Color = "";
    EggCount = false;
    RebirthCount = false;
    BlocksCount = false;
    StatsTrackerActivated = false;
    AutoSpinWheel = false;
    AutoBuySpins = false;
    AutoCollectSpins = false;
    BuyEventBoosts = false;
}
_G.SecretsList = {
    TotalSecretsHatched = 0;
}
_G.PlaceHolders = {
    AutoFactoryCraftPlaceHolder = "No";
    AutoCollectGroupRewardsPlaceHolder = "Deactivated";
    BuyLucky1HourPlaceHolder = "Deactivated";
    BuyLucky2HourPlaceHolder = "Deactivated";
    BuySuperLucky1HourPlaceHolder = "Deactivated";
    BuySuperLucky2HourPlaceHolder = "Deactivated";
    BuyOmegaLucky1HourPlaceHolder = "Deactivated";
    BuyOmegaLucky2HourPlaceHolder = "Deactivated";
    MultiHatchPlaceHolder = "Deactivated";
    SkipAnimationPlaceHolder = "Deactivated";
    AutoHatchEggPlaceHolder = "Deactivated";
    AutoTeleportToEggPlaceHolder = "No";
    EggCountTrackerPlaceHolder = "Deactivated";
    RebirthCountTrackerPlaceHolder = "Deactivated";
    BlockCountTrackerPlaceHolder = "Deactivated";
    StatsTrackerActivationPlaceHolder = "No";
    WebhookPlaceHolder = "None";
    IntervalsPlaceHolder = "3600 (Default)";
    ColorPlaceHolder = "Default (Light Blue)";
    WebhookErrorPlaceHolder = "No";
    EnableBackupPlaceHolder = "No";
    BackupActive = "No";
    AutoSpinWheelPlaceHolder = "Deactivated";
    AutoBuySpinsPlaceHolder = "Deactivated";
    AutoCollectSpinsPlaceHolder = "Deactivated";
    AutoBuyEventBoostsPlaceHolder = "Deactivated";
}

-- Module Locals
local LoadModule = require(game.ReplicatedStorage.LoadModule);
local GetLocalData = LoadModule("LocalData");
local DataCoinsCount = GetLocalData:GetData("Coins")
local DataCyberTokensCount = GetLocalData:GetData("CyberTokens")
local DataShellsCount = GetLocalData:GetData("Shells")
local DataCandyCount = GetLocalData:GetData("Candy")
local DataBricksCount = GetLocalData:GetData("Bricks")
local DataCrystalsCount = GetLocalData:GetData("Crystals")
local DataGemsCount = GetLocalData:GetData("Gems")
local DataStarsCount = GetLocalData:GetData("Stars")
local DataSilverCount = GetLocalData:GetData("Silver")

-- Locals
local username = game:GetService("Players").LocalPlayer.Name
local SettingsTableName = username .. "_Settings_MS2.txt"
local SecretsListName = username .. "_SecretsList_MS2.txt"
local CoinsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Coins.Label.text
local SpaceCoinsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.CyberTokens.Label.text
local ShellsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Shells.Label.text
local CandyCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Candy.Label.text
local BricksCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Bricks.Label.text
local CrystalCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Crystals.Label.text
local StarsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Stars.Label.text
local Headers = {["content-type"] = "application/json"}
local Chat = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller
local BoostAmount

-- AntiAFK
local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
end)


-- Functions
function FormatNumber(CurrencyC)
    local CC = CurrencyC:gsub(",", "")
    return CC
end

function FormatCurrency(CurrencyC)
    local CC = CurrencyC:gsub("%$", ""):gsub("+", "")
    return CC
end

function FormatBoostNumber(CurrencyC)
    local CC = CurrencyC:gsub("h", "")
    return CC
end

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

function AutoBuySpins()
    spawn(function()
        while wait() do 
            if not _G.SettingsTable.AutoBuySpins then break end
            game:GetService("ReplicatedStorage").Events.BuySpinToWin:FireServer()
        end
    end)
end
function AutoCollectSpins()
    spawn(function()
        while wait() do 
            if not _G.SettingsTable.AutoCollectSpins then break end
            game:GetService("ReplicatedStorage").Events.ClaimSpinToWin:FireServer()
        end
    end)
end
function AutoSpinWheel()
    spawn(function()
        while wait() do 
            if not _G.SettingsTable.AutoSpinWheel then break end
            game:GetService("ReplicatedStorage").Events.PlaySpinToWin:FireServer()
        end
    end)
end

function GetEggsLeft(Value)
    local DataCoinsCount = GetLocalData:GetData("Coins")
    local DataCyberTokensCount = GetLocalData:GetData("CyberTokens")
    local DataShellsCount = GetLocalData:GetData("Shells")
    local DataCandyCount = GetLocalData:GetData("Candy")
    local DataBricksCount = GetLocalData:GetData("Bricks")
    local DataCrystalsCount = GetLocalData:GetData("Crystals")
    local DataGemsCount = GetLocalData:GetData("Gems")
    local DataStarsCount = GetLocalData:GetData("Stars")
    local DataSilverCount = GetLocalData:GetData("Silver")
    local EggsLeft
    if _G.SettingsTable.EggType == "Basic Egg" then
        EggsLeft = DataCoinsCount / 55
    elseif _G.SettingsTable.EggType == "Spotted Egg" then
        EggsLeft = DataCoinsCount / 400
    elseif _G.SettingsTable.EggType == "Forest Egg" then
        EggsLeft = DataCoinsCount / 1900
    elseif _G.SettingsTable.EggType == "Exotic Egg" then
        EggsLeft = DataCoinsCount / 12000
    elseif _G.SettingsTable.EggType == "Arctic Egg" then
        EggsLeft = DataCoinsCount / 55000
    elseif _G.SettingsTable.EggType == "Ice Egg" then
        EggsLeft = DataCointCount / 225000
    elseif _G.SettingsTable.EggType == "Dark Egg" then
        EggsLeft = DataCoinsCount / 1500000
    elseif _G.SettingsTable.EggType == "Volcanic Egg" then
        EggsLeft = DataCoinsCount / 4500000
    elseif _G.SettingsTable.EggType == "Underworld Egg" then
        EggsLeft = DataCoinsCount / 10000000
    elseif _G.SettingsTable.EggType == "Crystal Egg" then
        EggsLeft = DataCoinsCount / 45000000
    elseif _G.SettingsTable.EggType == "Space Egg" then
        EggsLeft = DataCyberTokensCount / 250000
    elseif _G.SettingsTable.EggType == "Slime Egg" then
        EggsLeft = DataCyberTokensCount / 3000000
    elseif _G.SettingsTable.EggType == "Nebula Egg" then
        EggsLeft = DataCyberTokensCount / 12000000
    elseif _G.SettingsTable.EggType == "Cyborg Egg" then
        EggsLeft = DataCyberTokensCount / 32000000
    elseif _G.SettingsTable.EggType == "Glitched Egg" then
        EggsLeft = DataCyberTokensCount / 55000000
    elseif _G.SettingsTable.EggType == "Holographic Egg" then
        EggsLeft = DataCyberTokensCount / 90000000
    elseif _G.SettingsTable.EggType == "Coral Egg" then
        EggsLeft = DataShellsCount / 25000
    elseif _G.SettingsTable.EggType == "Snorkel Egg" then
        EggsLeft = DataShellsCount / 3250000
    elseif _G.SettingsTable.EggType == "Dark Coral Egg" then
        EggsLeft = DataShellsCount / 120000000
    elseif _G.SettingsTable.EggType == "Atlantis Egg" then
        EggsLeft = DataShellsCount / 250000000
    elseif _G.SettingsTable.EggType == "Gumdrop Egg" then
        EggsLeft = DataCandyCount / 25000
    elseif _G.SettingsTable.EggType == "Cake Egg" then
        EggsLeft = DataCandyCount / 3250000
    elseif _G.SettingsTable.EggType == "Candy Egg" then
        EggsLeft = DataCandyCount / 65000000
    elseif _G.SettingsTable.EggType == "Chocolate Egg" then
        EggsLeft = DataCandyCount / 99000000
    elseif _G.SettingsTable.EggType == "Pastry Egg" then
        EggsLeft = DataCandyCount / 150000000
    elseif _G.SettingsTable.EggType == "WindUp Egg" then
        EggsLeft = DataBricksCount / 25000
    elseif _G.SettingsTable.EggType == "Brick Egg" then
        EggsLeft = DataBricksCount / 3250000
    elseif _G.SettingsTable.EggType == "Toy Egg" then
        EggsLeft = DataBricksCount / 65000000
    elseif _G.SettingsTable.EggType == "Pixel Egg" then
        EggsLeft = DataBricksCount / 100000000
    elseif _G.SettingsTable.EggType == "Cartoon Egg" then
        EggsLeft = DataBricksCount / 500000000
    elseif _G.SettingsTable.EggType == "Mossy Egg" then
        EggsLeft = DataCrystalsCount / 250000
    elseif _G.SettingsTable.EggType == "Mushroom Egg" then
        EggsLeft = DataCrystalsCount / 20000000
    elseif _G.SettingsTable.EggType == "Element Egg" then
        EggsLeft = DataCrystalsCount / 300000000
    elseif _G.SettingsTable.EggType == "Red Egg" then
        EggsLeft = DataStarsCount / 20000000
    elseif _G.SettingsTable.EggType == "Yellow Egg" then
        EggsLeft = DataStarsCount / 100000000
    elseif _G.SettingsTable.EggType == "Fancy Egg" then
        EggsLeft = DataStarsCount / 300000000
    elseif _G.SettingsTable.EggType == "Comet Egg" then
        EggsLeft = DataStarsCount / 900000000
    elseif _G.SettingsTable.EggType == "Clover Egg" then
        EggsLeft = DataSilverCount / 20000000
    elseif _G.SettingsTable.EggType == "Brilliant Egg" then
        EggsLeft = DataSilverCount / 100000000
    elseif _G.SettingsTable.EggType == "Fortune Egg" then
        EggsLeft = DataSilverCount / 300000000
    elseif _G.SettingsTable.EggType == "Jackpot Egg" then
        EggsLeft = DataSilverCount / 900000000
    elseif _G.SettingsTable.EggType == "Lucky Egg" then
        EggsLeft = DataSilverCount / 1500000000
    else 
        EggsLeft = "Invalid Input or Not Updated"
    end
    local EggsLeft1
    local EggsLeft2
    if EggsLeft == "Invalid Input or Not Updated" then
        EggsLeft1 = EggsLeft
        EggsLeft2 = EggsLeft1
    else
        EggsLeft1 = math.floor(EggsLeft)
        EggsLeft2 = EggsLeft1
    end
    return EggsLeft2
end


function BackupEgg()
    spawn(function()
        local StartEggTP = true
        local username = game:GetService("Players").LocalPlayer.Name
        local BackupCount1 = 0
        BackupCount1 = game:GetService("Players")[username].leaderstats.Eggs.Value
        while wait(300) do
            local TotalEggsLeft = GetEggsLeft()
            if not _G.SettingsTable.BuyEgg then break end
            if _G.SettingsTable.EnableBackup then
                if TotalEggsLeft < 100 then
                    _G.SettingsTable.EggType = _G.SettingsTable.BackupEggType
                    _G.SettingsTable.EggTP = _G.SettingsTable.BackupEggTP
                    _G.SettingsTable.WorldOption = _G.SettingsTable.BackupWorldOption
                    _G.PlaceHolders.BackupActive = "Yes"
                    if StartEggTP then
                        TweenToEgg()
                        StartEggTP = false
                    end
                    if not StartEggTP then
                        local username = game:GetService("Players").LocalPlayer.Name
                        local BackupCount2 = 0
                        BackupCount2 = game:GetService("Players")[username].leaderstats.Eggs.Value
                        if BackupCount1 == BackupCount2 then
                            TweenToEgg()
                        else
                            local BackupEggDifference = BackupCount2 - BackupCount1
                            BackupCount1 = BackupCount1 + BackupEggDifference
                        end
                    end
                end
            end
        end
    end)
end

function PetInventoryBackup()
    spawn(function()
        while wait(30) do
            if not _G.SettingsTable.BuyEgg then break end
            if _G.SettingsTable.EnableBackup then
                local GetLoadModule = require(game.ReplicatedStorage.LoadModule);
                local GetPetStorage = GetLoadModule("GetPetStorage");
                local GetAddCommas = GetLoadModule("AddCommas");
                local GetLocalData = GetLoadModule("LocalData");
                local GetPetsOwned = GetLocalData:GetData("Pets")
                local PetsOwned = GetAddCommas(#GetPetsOwned)
                local PetStorage = GetPetStorage(GetLocalData:GetData())
                local PetStorage1 = PetStorage - 10
                local PetsOwned1 = tonumber(FormatNumber(PetsOwned))
                if PetsOwned1 >= PetStorage1 then
                    _G.SettingsTable.EggType = "Basic Egg"
                    _G.SettingsTable.EggTP = "Basic Egg"
                    _G.SettingsTable.WorldOption = "Surface"
                    _G.PlaceHolders.BackupActive = "Yes (Pet Inventory Backup)"
                    TweenToEgg()
                    break
                end
            end
        end
    end)
end

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

function EnableLuckyBoost()
    spawn(function()
        --game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Boosts.Lucky.Frame.Title.Text
    end)
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

function TweenToEgg()
    spawn(function()
        if _G.SettingsTable.WorldOption == "Surface" then
            local args = {
                [1] = "The Overworld"
            }

            game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
            wait(1)
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
        elseif _G.SettingsTable.WorldOption == "St Patricks" then
            local args = {
                [1] = "St Patricks"
            }

            game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
            wait(1)
            local args = {
                [1] = "St Patricks SurfaceSell"
            }

            game:GetService("ReplicatedStorage").Events.Teleport:FireServer(unpack(args))
            wait(5)
            local StPatricksCFrame = CFrame.new(-8829.93, 10.98154, 67.1992)
            local ts = game:GetService('TweenService')
            local char = game.Players.LocalPlayer.Character
            local part = char.HumanoidRootPart
            local ti = TweenInfo.new(5, Enum.EasingStyle.Linear)
            local tp = {CFrame = StPatricksCFrame}
            ts:Create(part, ti, tp):Play()
            wait(10)
            local New_CFrame = game:GetService("Workspace").Eggs[_G.SettingsTable.EggTP].Price.CFrame
            local ts = game:GetService('TweenService')
            local char = game.Players.LocalPlayer.Character
            local part = char.HumanoidRootPart
            local ti = TweenInfo.new(5, Enum.EasingStyle.Linear)
            local tp = {CFrame = New_CFrame}
            ts:Create(part, ti, tp):Play()
        else
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
        end
    end)
end

function ActivateStatsTracker()
    spawn(function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/Buddy25112/StatTrackers/main/MS2StatTracker.lua"),true))()
    end)
end

function SetFPSValue()
    spawn(function()
        setfpscap(_G.SettingsTable.FPSSettings)
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

function BuyLuckyBoost1Hour()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyLucky1Hour then break end
            local args = {
                [1] = "Lucky",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuyLuckyBoost2Hour()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyLucky2Hour then break end
            local args = {
                [1] = "Lucky",
                [2] = 2
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuySuperLuckyBoost1Hour()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuySuperLucky1Hour then break end
            local args = {
                [1] = "Super Lucky",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuySuperLuckyBoost2Hour()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuySuperLucky2Hour then break end
            local args = {
                [1] = "Super Lucky",
                [2] = 2
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuyOmegaLuckyBoost1Hour()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyOmegaLucky1Hour then break end
            local args = {
                [1] = "Omega Lucky",
                [2] = 1
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuyOmegaLuckyBoost2Hour()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyOmegaLucky2Hour then break end
            local args = {
                [1] = "Omega Lucky",
                [2] = 2
            }

            game:GetService("ReplicatedStorage").Events.BuyBoost:FireServer(unpack(args))
        end
    end)
end

function BuyChristmasBoosts1()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyEventBoosts then break end
            local args = {
                [1] = "boost0"
            }
            
            game:GetService("ReplicatedStorage").Events.BuyEventShopItem:FireServer(unpack(args))
        end
    end)
end

function BuyChristmasBoosts2()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyEventBoosts then break end
            local args = {
                [1] = "boost1"
            }

            game:GetService("ReplicatedStorage").Events.BuyEventShopItem:FireServer(unpack(args))
        end
    end)
end

function BuyChristmasBoosts3()
    spawn(function()
        while wait(5) do
            if not _G.SettingsTable.BuyEventBoosts then break end
            local args = {
                [1] = "boost2"
            }

            game:GetService("ReplicatedStorage").Events.BuyEventShopItem:FireServer(unpack(args))
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

function SkipAnimation()
    spawn(function()
        game.ReplicatedStorage.ClientModules.Other.OpenEgg.HatchGui:Destroy()
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



-- Secrets Hatched Function
LoadSettingsSecretsList()
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



-- Beginning of UI
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
	Name = "Hatchers Hub | Mining Simulator 2 | Version 1.2.3",
	LoadingTitle = "Mining Simulator 2 GUI",
	LoadingSubtitle = "By PetSimulatorXPlayer",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "Hatchers Hub MS2", -- Create a custom folder for your hub/game
		FileName = username .. "_Settings_MS2.txt"
	},
        Discord = {
        	Enabled = true,
        	Invite = "83aFw8rGM8", -- The Discord invite code, do not include discord.gg/
        	RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Sirius Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/sirius)",
		FileName = "SiriusKey",
		SaveKey = true,
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = "Hello"
	}
})



-- UI Tabs
-- Credits UI
local CreditsTab = Window:CreateTab("Credits")
local CreditsSection = CreditsTab:CreateSection("------------------------------- Hatchers Hub MS2 -------------------------------")
local CreditsSection1 = CreditsTab:CreateSection("Creator/Dev: PetSimulatorXPlayer#5011")
local CreditsSection2 = CreditsTab:CreateSection("Helper: Cor#0002")
local CreditsSection3 = CreditsTab:CreateSection("Helper: wYn#0001 (Youtube Guides)")
local CreditsSection4 = CreditsTab:CreateSection("⚠️ Saved Settings Will Auto Load When Executed ⚠️")
local CreditsSection5 = CreditsTab:CreateSection("--------------------------------------------------------------------------------------")
local CreditsSection6 = CreditsTab:CreateSection("Last Updated: 2023-03-17")
local CreditsSection7 = CreditsTab:CreateSection("Last Update: Spin To Win + Lucky Egg updates")
local CreditsSection8 = CreditsTab:CreateSection("Upcoming Update: More New Features")
local CreditsSection9 = CreditsTab:CreateSection("Discord Link: https://discord.gg/83aFw8rGM8")
local CreditsSection10 = CreditsTab:CreateSection("-------------------------------------------------------------------------------------")

-- AutofarmUI
local AutoFarmTab = Window:CreateTab("AutoFarm")

-- EggFarmingUI
local EggFarmingTab = Window:CreateTab("Egg Farming")

-- StatsTrackerUI
local StatsTrackerTab = Window:CreateTab("Stats Tracker")

-- MiscUI
local MiscTab = Window:CreateTab("Miscellaneous")

-- Other GUI's
local OtherUITab = Window:CreateTab("Other GUI's")

-- SettingsUI
local SettingsTab = Window:CreateTab("Settings")

-- HelpUI
local HelpTab = Window:CreateTab("Help")



-- Tab Toggles
-- AutoFarm
local AutoFarmSelection = AutoFarmTab:CreateSection("Auto Farm Gems (Factory)")
local CurrencyParagraph = AutoFarmTab:CreateParagraph({
    Title = "All World Currency Counts", 
    Content = "Coins: " .. FormatCurrency(CoinsCount) .. "\nCyber Tokens: " .. FormatCurrency(SpaceCoinsCount) .. "\nShells: " .. FormatCurrency(ShellsCount) .. "\nCandy: " .. FormatCurrency(CandyCount) .. "\nBricks: " .. FormatCurrency(BricksCount) .. "\nCrystals: " .. FormatCurrency(CrystalCount) .. "\nStars: " .. FormatCurrency(StarsCount)
})
local AutoFactoryCraftParagraph = AutoFarmTab:CreateParagraph({
    Title = "Current Factory Settings", 
    Content = "Craft Option: " .. _G.SettingsTable.GemType .. "\nActivated: " .. _G.PlaceHolders.AutoFactoryCraftPlaceHolder
})

local CraftOption = AutoFarmTab:CreateDropdown({
	Name = "Craft Option (Factory)",
	Options = {"Coins 1", "Coins 2", "Coins 3", "Coins 4", "CyberTokens 1", "CyberTokens 2", "CyberTokens 3", "CyberTokens 4", "Shells 1", "Shells 2", "Shells 3", "Shells 4", "Shells 5", "Candy 1", "Candy 2", "Candy 3", "Candy 4", "Candy 5", "Bricks 1", "Bricks 2", "Bricks 3", "Bricks 4", "Bricks 5", "Crystals 1", "Crystals 2", "Crystals 3", "Crystals 4", "Crystals 5", "Stars 1", "Stars 2", "Stars 3", "Stars 4", "Stars 5"},
	CurrentOption = "Coins 1",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(GemTypetxt)
        _G.SettingsTable.GemType = GemTypetxt
	end,
})
local AutoFactoryCraft = AutoFarmTab:CreateToggle({
	Name = "Auto Factory Craft",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.AutoCraft = bool
        if bool then
            AutoFactoryCraft1()
            AutoFactoryCraft2()
            AutoFactoryCraft3()
            _G.PlaceHolders.AutoFactoryCraftPlaceHolder = "Yes"
        else
            _G.PlaceHolders.AutoFactoryCraftPlaceHolder = "No"
        end
	end,
})
local AutoGroupRewardsSection = AutoFarmTab:CreateSection("Auto Collect Features")
local AutoGroupRewardsParagraph = AutoFarmTab:CreateParagraph({
    Title = "Current Auto Collect Settings", 
    Content = "Auto Collect Group Rewards: " .. _G.PlaceHolders.AutoCollectGroupRewardsPlaceHolder .. "\nAuto Collect Event Boosts: " .. _G.PlaceHolders.AutoBuyEventBoostsPlaceHolder .. "\nAuto Spin Wheel: " .. _G.PlaceHolders.AutoSpinWheelPlaceHolder .. "\nAuto Collect Spins: " .. _G.PlaceHolders.AutoCollectSpinsPlaceHolder .. "\nAuto Buy Spins: " .. _G.PlaceHolders.AutoBuySpinsPlaceHolder
})
local AutoCollectGroupRewards = AutoFarmTab:CreateToggle({
	Name = "Auto Collect Group Rewards",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.ClaimGroupBenefits = bool
        if bool then
            ClaimGroupBenefits()
            _G.PlaceHolders.AutoCollectGroupRewardsPlaceHolder = "Activated"
        else
            _G.PlaceHolders.AutoCollectGroupRewardsPlaceHolder = "Deactivated"
        end
	end,
})
local AutoCollectSpins = AutoFarmTab:CreateToggle({
	Name = "Auto Collect Spins",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.AutoCollectSpins = bool
        if bool then
            AutoCollectSpins()
            _G.PlaceHolders.AutoCollectSpinsPlaceHolder = "Activated"
        else
            _G.PlaceHolders.AutoCollectSpinsPlaceHolder = "Deactivated"
        end
	end,
})
local AutoBuySpins = AutoFarmTab:CreateToggle({
	Name = "Auto Buy Spins",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
       _G.SettingsTable.AutoBuySpins = bool
        if bool then
            AutoBuySpins()
            _G.PlaceHolders.AutoBuySpinsPlaceHolder = "Activated"
        else
            _G.PlaceHolders.AutoBuySpinsPlaceHolder = "Deactivated"
        end
	end,
})
local AutoSpinWheel = AutoFarmTab:CreateToggle({
	Name = "Auto Spin Wheel",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.AutoSpinWheel = bool
        if bool then
            AutoSpinWheel()
            _G.PlaceHolders.AutoSpinWheelPlaceHolder = "Activated"
        else
            _G.PlaceHolders.AutoSpinWheelPlaceHolder = "Deactivated"
        end
	end,
})
 local AutoBuyChristmasBoosts = AutoFarmTab:CreateToggle({
 	Name = "Auto Buy Event Boosts",
 	CurrentValue = false,
 	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
 	Callback = function(bool)
         _G.SettingsTable.BuyEventBoosts = bool
         if bool then
             BuyChristmasBoosts1()
             BuyChristmasBoosts2()
             BuyChristmasBoosts3()
	     _G.PlaceHolders.AutoBuyEventBoostsPlaceHolder = "Activated"
	else
	     _G.PlaceHolders.AutoBuyEventBoostsPlaceHolder = "Deactivated"
        end
 	end,
})



-- Auto Buy Shop Boosts
local AutoShopBoostsSection = AutoFarmTab:CreateSection("Auto Shop Boosts")
local AutoBuyBoostsParagraph = AutoFarmTab:CreateParagraph({
    Title = "Current Auto Buy Boosts Settings", 
    Content = "Auto Buy Lucky Boost (1 Hour): " .. _G.PlaceHolders.BuyLucky1HourPlaceHolder .. "\nAuto Buy Lucky Boost (2 Hours): " .. _G.PlaceHolders.BuyLucky2HourPlaceHolder .. "\nAuto Buy Super Lucky Boost (1 Hour): " .. _G.PlaceHolders.BuySuperLucky1HourPlaceHolder .. "\nAuto Buy Super Lucky Boost (2 Hours): " .. _G.PlaceHolders.BuySuperLucky2HourPlaceHolder .. "\nAuto Buy Omega Lucky Boost (1 Hour): " .. _G.PlaceHolders.BuyOmegaLucky1HourPlaceHolder .. "\nAuto Buy Omega Lucky Boost (2 Hours): " .. _G.PlaceHolders.BuyOmegaLucky2HourPlaceHolder
})
local AutoBuyLucky1Hours = AutoFarmTab:CreateToggle({
	Name = "Auto Buy Lucky (1 Hour)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BuyLucky1Hour = bool
        if bool then
            BuyLuckyBoost1Hour()
            _G.PlaceHolders.BuyLucky1HourPlaceHolder = "Activated"
        else
            _G.PlaceHolders.BuyLucky1HourPlaceHolder = "Deactivated"
        end
	end,
})
local AutoBuyLucky2Hours = AutoFarmTab:CreateToggle({
	Name = "Auto Buy Lucky (2 Hour)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BuyLucky2Hour = bool
        if bool then
            BuyLuckyBoost2Hour()
            _G.PlaceHolders.BuyLucky2HourPlaceHolder = "Activated"
        else
            _G.PlaceHolders.BuyLucky2HourPlaceHolder = "Deactivated"
        end
	end,
})
local AutoBuySuperLucky1Hours = AutoFarmTab:CreateToggle({
	Name = "Auto Buy Super Lucky (1 Hour)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BuySuperLucky1Hour = bool
        if bool then
            BuySuperLuckyBoost1Hour()
            _G.PlaceHolders.BuySuperLucky1HourPlaceHolder = "Activated"
        else
            _G.PlaceHolders.BuySuperLucky1HourPlaceHolder = "Deactivated"
        end
	end,
})
local AutoBuySuperLucky2Hours = AutoFarmTab:CreateToggle({
	Name = "Auto Buy Super Lucky (2 Hour)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BuySuperLucky2Hour = bool
        if bool then
            BuySuperLuckyBoost2Hour()
            _G.PlaceHolders.BuySuperLucky2HourPlaceHolder = "Activated"
        else
            _G.PlaceHolders.BuySuperLucky2HourPlaceHolder = "Deactivated"
        end
	end,
})
local AutoBuyOmegaLucky1Hours = AutoFarmTab:CreateToggle({
	Name = "Auto Buy Omega Lucky (1 Hour)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BuyOmegaLucky1Hour = bool
        if bool then
            BuyOmegaLuckyBoost1Hour()
            _G.PlaceHolders.BuyOmegaLucky1HourPlaceHolder = "Activated"
        else
            _G.PlaceHolders.BuyOmegaLucky1HourPlaceHolder = "Deactivated"
        end
	end,
})
local AutoBuyOmegaLucky2Hours = AutoFarmTab:CreateToggle({
	Name = "Auto Buy Omega Lucky (2 Hour)",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BuyOmegaLucky2Hour = bool
        if bool then
            BuyOmegaLuckyBoost2Hour()
            _G.PlaceHolders.BuyOmegaLucky2HourPlaceHolder = "Activated"
        else
            _G.PlaceHolders.BuyOmegaLucky2HourPlaceHolder = "Deactivated"
        end
	end,
})



-- Egg Farming
-- Egg Settings
local AutoHatchEggSection = EggFarmingTab:CreateSection("Auto Hatch Egg")
local EggFarmingParagraph = EggFarmingTab:CreateParagraph({
    Title = "Current Egg Settings", 
    Content = "Eggs Hatched: \nSecrets Hatched: \nCurrent Egg: " .. _G.SettingsTable.EggType .. "\nMulti/Quad Hatch: " .. _G.PlaceHolders.MultiHatchPlaceHolder .. "\nSkip Animation: " .. _G.PlaceHolders.SkipAnimationPlaceHolder .. "\nAuto Hatch Egg: " .. _G.PlaceHolders.AutoHatchEggPlaceHolder .. "\nEggs Left: NONE" 
})
local ChooseEggToHatchDropdown = EggFarmingTab:CreateDropdown({
	Name = "Choose Egg: (Dropdown)",
	Options = {"Basic Egg", "Spotted Egg", "Forest Egg", "Exotic Egg", "Arctic Egg", "Ice Egg", "Dark Egg", "Volcanic Egg", "Underworld Egg", "Crystal Egg", "Space Egg", "Slime Egg", "Nebula Egg", "Cyborg Egg", "Glitched Egg", "Holographic Egg", "Coral Egg", "Snorkel Egg", "Dark Coral Egg", "Atlantis Egg", "Gumdrop Egg", "Cake Egg", "Candy Egg", "Chocolate Egg", "Pastry Egg", "WindUp Egg", "Brick Egg", "Toy Egg", "Pixel Egg", "Cartoon Egg", "Mossy Egg", "Mushroom Egg", "Element Egg", "Red Egg", "Yellow Egg", "Fancy Egg", "Comet Egg", "Clover Egg", "Brilliant Egg", "Fortune Egg", "Jackpot Egg", "Lucky Egg"},
	CurrentOption = "Basic Egg",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(EggTypetxt)
        _G.SettingsTable.EggType = EggTypetxt
	end,
})
local ChooseEggToHatchText = EggFarmingTab:CreateInput({
	Name = "Choose Egg: (Text)",
	PlaceholderText = "Type The Name Of The Egg",
	RemoveTextAfterFocusLost = false,
	Callback = function(EggTypetxt)
		_G.SettingsTable.EggType = EggTypetxt
	end,
})
local QuadOrMultiEggHatch = EggFarmingTab:CreateToggle({
	Name = "Quad/Multi Egg Hatch",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.MultiHatch = bool
        if _G.SettingsTable.MultiHatch then
            _G.PlaceHolders.MultiHatchPlaceHolder = "Activated"
        else
            _G.PlaceHolders.MultiHatchPlaceHolder = "Deactivated"
        end
	end,
})
local StartHatchingEgg = EggFarmingTab:CreateToggle({
	Name = "Start Hatching Egg",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BuyEgg = bool
        if bool then
            HatchEgg()
            BackupEgg()
            PetInventoryBackup()
            _G.PlaceHolders.AutoHatchEggPlaceHolder = "Activated"
        else
            _G.PlaceHolders.AutoHatchEggPlaceHolder = "Deactivated"
            _G.PlaceHolders.BackupActive = "No"
        end
	end,
})
local SkipAnimation = EggFarmingTab:CreateButton({
	Name = "Skip Animation",
	Callback = function()
        _G.SettingsTable.SkipAnimation = true
            SkipAnimation()
        if _G.SettingsTable.SkipAnimation then
            _G.PlaceHolders.SkipAnimationPlaceHolder = "Activated"
        else
            _G.PlaceHolders.SkipAnimationPlaceHolder = "Deactivated"
        end
	end,
})
local DisableSkipAnimation = EggFarmingTab:CreateButton({
	Name = "Disable Skip Animation (Rejoin)",
	Callback = function()
        _G.SettingsTable.SkipAnimation = false
        _G.PlaceHolders.SkipAnimationPlaceHolder = "Deactivated (Rejoin Game)"
	end,
})

-- Egg Teleport Settings
local AutoTeleportSection = EggFarmingTab:CreateSection("Auto Teleport To Egg")
local AutoTeleportParagraph = EggFarmingTab:CreateParagraph({
    Title = "Current Auto Teleport Settings", 
    Content = "Current Egg: " .. _G.SettingsTable.EggTP .. "\nCurrent World: " .. _G.SettingsTable.WorldOption .. "\nActivated: " .. _G.PlaceHolders.AutoTeleportToEggPlaceHolder 
})
local ChooseEggToTPDropdown = EggFarmingTab:CreateDropdown({
	Name = "Choose Egg: (Dropdown)",
	Options = {"Basic Egg", "Spotted Egg", "Forest Egg", "Exotic Egg", "Arctic Egg", "Ice Egg", "Dark Egg", "Volcanic Egg", "Underworld Egg", "Crystal Egg", "Space Egg", "Slime Egg", "Nebula Egg", "Cyborg Egg", "Glitched Egg", "Holographic Egg", "Coral Egg", "Snorkel Egg", "Dark Coral Egg", "Atlantis Egg", "Gumdrop Egg", "Cake Egg", "Candy Egg", "Chocolate Egg", "Pastry Egg", "WindUp Egg", "Brick Egg", "Toy Egg", "Pixel Egg", "Cartoon Egg", "Mossy Egg", "Mushroom Egg", "Element Egg", "Red Egg", "Yellow Egg", "Fancy Egg", "Comet Egg", "Clover Egg", "Brilliant Egg", "Fortune Egg", "Jackpot Egg", "Lucky Egg"},
	CurrentOption = "Basic Egg",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Eggtptxt)
        _G.SettingsTable.EggTP = Eggtptxt
	end,
})
local ChooseEggToTPText = EggFarmingTab:CreateInput({
	Name = "Choose Egg: (Text)",
	PlaceholderText = "Type The Name Of The Egg",
	RemoveTextAfterFocusLost = false,
	Callback = function(Eggtptxt)
		_G.SettingsTable.EggTP = Eggtptxt
	end,
})
local WorldToTweenTo = EggFarmingTab:CreateDropdown({
	Name = "World",
	Options = {"Surface", "The Overworld", "Cyber Galaxy", "Atlantis", "Candyland", "Toyland", "Mystic Forest", "Rainbow Land", "St Patricks"},
	CurrentOption = "Surface",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(WorldTextOption)
        _G.SettingsTable.WorldOption = WorldTextOption
	end,
})
local TeleportToEgg = EggFarmingTab:CreateButton({
	Name = "Teleport To Egg",
	Callback = function()
        _G.SettingsTable.TpToEgg = true
        if _G.SettingsTable.TpToEgg then
            TweenToEgg()
            _G.PlaceHolders.AutoTeleportToEggPlaceHolder = "Yes"
        else
            _G.PlaceHolders.AutoTeleportToEggPlaceHolder = "No"
        end
	end,
})

-- Egg Backup Settings
local EggBackupSection = EggFarmingTab:CreateSection("Egg Backup")
local EggBackupParagraph = EggFarmingTab:CreateParagraph({
    Title = "Current Egg Backup Settings", 
    Content = "Info: Teleports to a backup egg if under 100 eggs left on main egg \nBackup Egg: " .. _G.SettingsTable.BackupEggType .. "\nBackup World: " .. _G.SettingsTable.BackupWorldOption .. "\nActivated: " .. _G.PlaceHolders.EnableBackupPlaceHolder .. "\nBackup Active: " .. _G.PlaceHolders.BackupActive
})
local ChooseEggToHatchDropdownBackup = EggFarmingTab:CreateDropdown({
	Name = "Choose Backup Egg: (Dropdown)",
	Options = {"Basic Egg", "Spotted Egg", "Forest Egg", "Exotic Egg", "Arctic Egg", "Ice Egg", "Dark Egg", "Volcanic Egg", "Underworld Egg", "Crystal Egg", "Space Egg", "Slime Egg", "Nebula Egg", "Cyborg Egg", "Glitched Egg", "Holographic Egg", "Coral Egg", "Snorkel Egg", "Dark Coral Egg", "Atlantis Egg", "Gumdrop Egg", "Cake Egg", "Candy Egg", "Chocolate Egg", "Pastry Egg", "WindUp Egg", "Brick Egg", "Toy Egg", "Pixel Egg", "Cartoon Egg", "Mossy Egg", "Mushroom Egg", "Element Egg", "Red Egg", "Yellow Egg", "Fancy Egg", "Comet Egg", "Clover Egg", "Brilliant Egg", "Fortune Egg", "Jackpot Egg", "Lucky Egg"},
	CurrentOption = "Basic Egg",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(EggBackupTypetxt)
        _G.SettingsTable.BackupEggType = EggBackupTypetxt
        _G.SettingsTable.BackupEggTP = EggBackupTypetxt
	end,
})
local ChooseEggToHatchTextBackup = EggFarmingTab:CreateInput({
	Name = "Choose Backup Egg: (Text)",
	PlaceholderText = "Type The Name Of The Egg",
	RemoveTextAfterFocusLost = false,
	Callback = function(EggBackupTypetxt)
		_G.SettingsTable.BackupEggType = EggBackupTypetxt
        _G.SettingsTable.BackupEggTP = EggBackupTypetxt
	end,
})
local BackupWorldToTweenTo = EggFarmingTab:CreateDropdown({
	Name = "World",
	Options = {"Surface", "The Overworld", "Cyber Galaxy", "Atlantis", "Candyland", "Toyland", "Mystic Forest", "Rainbow Land", "St Patricks"},
	CurrentOption = "Surface",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(WorldBackupTextOption)
        _G.SettingsTable.BackupWorldOption = WorldBackupTextOption
	end,
})
local EnableBackupEgg = EggFarmingTab:CreateToggle({
	Name = "Enable Backup",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.EnableBackup = bool
        if bool then
            _G.PlaceHolders.EnableBackupPlaceHolder = "Yes"
        else
            _G.PlaceHolders.EnableBackupPlaceHolder = "No"
        end
	end,
})



-- Stat Tracker
local StatsTrackerSection = StatsTrackerTab:CreateSection("Stats Tracker Settings")
local StatsTrackerParagraph = StatsTrackerTab:CreateParagraph({
    Title = "Current Stats Tracker Settings", 
    Content = "Time Between Updates: (Seconds)" .. _G.PlaceHolders.IntervalsPlaceHolder .. "\nEmbed Color (Hex Value): " .. _G.PlaceHolders.ColorPlaceHolder .. "\nEgg Count: " .. _G.PlaceHolders.EggCountTrackerPlaceHolder .. "\nRebirth Count: " .. _G.PlaceHolders.RebirthCountTrackerPlaceHolder .. "\nBlocks Count " .. _G.PlaceHolders.BlockCountTrackerPlaceHolder .. "\nActivated: " .. _G.PlaceHolders.StatsTrackerActivationPlaceHolder
})
local WebhookParagraph = StatsTrackerTab:CreateParagraph({
    Title = "Webhook Data", 
    Content = "Webhook: " .. _G.PlaceHolders.WebhookPlaceHolder .. "\nWebhook Paragraph Error (Dev Issue): " .. _G.PlaceHolders.WebhookErrorPlaceHolder
})
local WebhookText = StatsTrackerTab:CreateInput({
	Name = "Webhook: ",
	PlaceholderText = "Paste Your Webhook Here",
	RemoveTextAfterFocusLost = false,
	Callback = function(WebhookTypetxt)
		_G.SettingsTable.Webhookssss = WebhookTypetxt
        _G.PlaceHolders.WebhookPlaceHolder = WebhookTypetxt
	end,
})
local IntervalsText = StatsTrackerTab:CreateInput({
	Name = "Time Between Updates (In Seconds): ",
	PlaceholderText = "Type the time here",
	RemoveTextAfterFocusLost = false,
	Callback = function(IntervalsTypetxt)
		_G.SettingsTable.Intervals = IntervalsTypetxt
        _G.SettingsTable.WebhookPasted = "Yes"
        _G.PlaceHolders.IntervalsPlaceHolder = IntervalsTypetxt
	end,
})
local ColorDropdown = StatsTrackerTab:CreateDropdown({
	Name = "Ember Color (Simple)",
	Options = {"Red", "Orange", "Yellow", "Green", "Blue", "Purple"},
	CurrentOption = "Red",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(ColorTextOption)
        _G.SettingsTable.ColorOption = ColorTextOption
        if _G.SettingsTable.ColorOption == "Red" then
            _G.SettingsTable.Color = "ff0000"
            _G.PlaceHolders.ColorPlaceHolder = "ff0000"
        elseif _G.SettingsTable.ColorOption == "Orange" then
            _G.SettingsTable.Color = "ffae00"
            _G.PlaceHolders.ColorPlaceHolder = "ffae00"
        elseif _G.SettingsTable.ColorOption == "Yellow" then
            _G.SettingsTable.Color = "fffb00"
            _G.PlaceHolders.ColorPlaceHolder = "fffb00"
        elseif _G.SettingsTable.ColorOption == "Green" then
            _G.SettingsTable.Color = "00ff00"
            _G.PlaceHolders.ColorPlaceHolder = "00ff00"
        elseif _G.SettingsTable.ColorOption == "Blue" then
            _G.SettingsTable.Color = "0004ff"
            _G.PlaceHolders.ColorPlaceHolder = "0004ff"
        elseif _G.SettingsTable.ColorOption == "Purple" then
            _G.SettingsTable.Color = "9000ff"
            _G.PlaceHolders.ColorPlaceHolder = "9000ff"
        else
            _G.SettingsTable.Color = "None"
            _G.PlaceHolders.ColorPlaceHolder = "Default (Light Blue)"
        end
	end,
})
local ColorText = StatsTrackerTab:CreateInput({
	Name = "Embed Color (Hex Value): ",
	PlaceholderText = "Paste the colors HEX value here",
	RemoveTextAfterFocusLost = false,
	Callback = function(ColorTypetxt)
		_G.SettingsTable.Color = ColorTypetxt
        _G.PlaceHolders.ColorPlaceHolder = ColorTypetxt
	end,
})
local EggCountStatsTracker = StatsTrackerTab:CreateToggle({
	Name = "Egg Count",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.EggCount = bool
        if bool then
            _G.PlaceHolders.EggCountTrackerPlaceHolder = "Activated"
        else
            _G.PlaceHolders.EggCountTrackerPlaceHolder = "Deactivated"
        end
	end,
})
local RebirthCountStatsTracker = StatsTrackerTab:CreateToggle({
	Name = "Rebirth Count",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.RebirthCount = bool
        if bool then
            _G.PlaceHolders.RebirthCountTrackerPlaceHolder = "Activated"
        else
            _G.PlaceHolders.RebirthCountTrackerPlaceHolder = "Deactivated"
        end
	end,
})
local BlockCountStatsTracker = StatsTrackerTab:CreateToggle({
	Name = "Block Count",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        _G.SettingsTable.BlocksCount = bool
        if bool then
            _G.PlaceHolders.BlockCountTrackerPlaceHolder = "Activated"
        else
            _G.PlaceHolders.BlockCountTrackerPlaceHolder = "Deactivated"
        end
	end,
})
local StatsTrackerActivate = StatsTrackerTab:CreateButton({
    Name = "Activate Stats Tracker",
	Callback = function()
        _G.SettingsTable.StatsTrackerActivated = true
        if _G.SettingsTable.StatsTrackerActivated then
            _G.PlaceHolders.StatsTrackerActivationPlaceHolder = "Yes"
            ActivateStatsTracker()
        else
            _G.PlaceHolders.StatsTrackerActivationPlaceHolder = "No"
        end
	end,
})
local StatsTrackerDisable = StatsTrackerTab:CreateButton({
	Name = "Dectivate Stats Tracker (Rejoin)",
	Callback = function()
        _G.SettingsTable.StatsTrackerActivated = false
        _G.PlaceHolders.StatsTrackerActivationPlaceHolder = "No (Rejoin)"
	end,
})



-- Misc
-- Layers Settings
local LayersSection = MiscTab:CreateSection("Layers")
local LayerToTpTo = MiscTab:CreateDropdown({
	Name = "Layer",
	Options = {"Hidden Treasure", "Frozen Depths", "Gloomy Basin", "Molten Core", "The Underworld", "Crystal Cavern", "Cyber Sewers", "Cosmic Abyss", "Cyber Core", "Glitched Chasm", "Rocky Depths", "Sea Shell Shallows", "City of Gold", "Dark Coral Depths", "Chocolate Caves", "Gummy Depths", "Cupcake Cavern", "Donut Depths", "Blocky Basin", "Bear Depths", "Building Depths", "Pixel Park", "Glowing Depths", "Neon Rocks", "Mystic Cavern", "Magenta Forest", "Rainbow Depths", "Violet Forest", "St Patricks Surface"},
	CurrentOption = "Hidden Treasure",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(LayerTextOption)
        _G.SettingsTable.LayerOption = LayerTextOption
	end,
})
local TeleportToLayer = MiscTab:CreateButton({
	Name = "Teleport to Layer",
	Callback = function()
        TeleportToLayer()
	end,
})
local UnlockLayer = MiscTab:CreateButton({
	Name = "Unlock Layer",
	Callback = function()
        UnlockLayer()
	end,
})

-- Worlds Settings
local WorldsSection = MiscTab:CreateSection("Worlds")
local WorldToTpTo = MiscTab:CreateDropdown({
	Name = "World",
	Options = {"The Overworld", "Cyber Galaxy", "Atlantis", "Candyland", "Toyland", "GemGenie", "Mystic Forest", "Rainbow Land", "St Patricks"},
	CurrentOption = "The Overworld",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(InstantWorldTextOption)
        _G.SettingsTable.InstantWorldOption = InstantWorldTextOption
	end,
})
local TeleportToWorld = MiscTab:CreateButton({
	Name = "Teleport To World",
	Callback = function()
        InstantTeleportToLayer()
	end,
})
local FPSSection = MiscTab:CreateSection("FPS Settings (Synapse Required)")
local AutoFPSParagraph = MiscTab:CreateParagraph({
    Title = "Current FPS Settings", 
    Content = "Current FPS: " .. _G.SettingsTable.FPSSettings
})
local ChooseFPSValue = MiscTab:CreateInput({
	Name = "Choose FPS Value:",
	PlaceholderText = "Default = 60",
	RemoveTextAfterFocusLost = false,
	Callback = function(FPStxt)
		_G.SettingsTable.FPSSettings = FPStxt
	end,
})
local SetFPSValues = MiscTab:CreateButton({
	Name = "Set FPS Value",
	Callback = function()
        SetFPSValue()
	end,
})

-- Remote UIs
local RemoteUIsSection = MiscTab:CreateSection("Remote UI's (X buttons dont work)")
local PetEnchantsUI = MiscTab:CreateToggle({
	Name = "Pet Enchantments",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.PetEnchant.Visible = bool
	end,
})
local RebirthShopUI = MiscTab:CreateToggle({
	Name = "Rebirth Shop",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.RebirthShop.Visible = bool
	end,
})
local ForgeUI = MiscTab:CreateToggle({
	Name = "Forge",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.Forge.Visible = bool
	end,
})
local AutoDeleteUI = MiscTab:CreateToggle({
	Name = "Auto Delete",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.AutoDelete.Visible = bool
	end,
})
local GemEnchantsUI = MiscTab:CreateToggle({
	Name = "Gem Enchantments",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.GemEnchant.Visible = bool
	end,
})
local AchievementsUI = MiscTab:CreateToggle({
	Name = "Achievements",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.Achievements.Visible = bool
	end,
})
local FactoryUI = MiscTab:CreateToggle({
	Name = "Factory",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.Factory.Visible = bool
	end,
})
local QuestsUI = MiscTab:CreateToggle({
	Name = "Gem Genie Quests",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.Quests.Visible = bool
	end,
})
local StPatricksUI = MiscTab:CreateToggle({
	Name = "St Patricks Challenges",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(bool)
        game:GetService("Players")[username].PlayerGui.ScreenGui.StPatricksPass.Visible = bool
	end,
})

-- Other Gui's 
-- Tense UI
local NotMyGUISection = OtherUITab:CreateSection("I do NOT OWN these GUIS! Credits to the devs")
local CorsGUISection = OtherUITab:CreateSection("Tense's OP GUI")
local TensesOPGUIFeatures = OtherUITab:CreateDropdown({
	Name = "Tense's OP GUI Features:",
	Options = {"Auto farm Blocks", "Egg Hatching", "Auto Collect Ores", "Auto Sell/Teleport", "AntiAFK", "Auto Trick Or Treat (OP)", "Auto Factory", "Fake Pet Equip", "Fake Pet Hatch", "Mass Delete Pets", "Auto Shiny", "Unlock/Teleport To Any Layer", "Pet Hatcher", "Stats Tracker", "Remote UI's", "Skip Animation", "SO MUCH MORE!"},
	CurrentOption = "Most Of Tense's Op GUI's Features",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function()
	end,
})
local ActivateTenseScript = OtherUITab:CreateButton({
	Name = "Activate Script",
	Callback = function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/wingedmother69/thingz/main/ms2ui.lua"),true))()
	end,
})

-- System Exodus Settings
local SystemExodusSection = OtherUITab:CreateSection("System Exodus")
local SystemExodusFeatures = OtherUITab:CreateDropdown({
	Name = "System Exodus Features:",
	Options = {"Auto Farm Blocks (3x3)", "Auto Farm Eggs", "Pet Hatcher", "Auto Factory", "Auto Open Crates", "Auto Trick Or Treat", "Auto Claim Group Rewards", "Auto Delete Pets", "Statistics", "Skip Animation", "WAY MORE!"},
	CurrentOption = "Most Of System Exodus Features",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function()
	end,
})
local ActivateExodusScript = OtherUITab:CreateButton({
	Name = "Activate Script",
	Callback = function()
        loadstring(game:HttpGet("https://www.system-exodus.com/scripts/MiningSimulator/MiningSimulator2.lua"))()
	end,
})



-- Help Section
local DiscordlinkSection = HelpTab:CreateSection("Need help with the GUI? Join the Discord for help!")
local DiscordlinkInvite = HelpTab:CreateButton({
	Name = "Discord Invite",
	Callback = function()
        (syn and syn.request or http_request or request)({ Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST",Headers = {["Content-Type"] = "application/json",
        ["Origin"] = "https://discord.com"},
        Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",
        args = {code = "83aFw8rGM8"},
        nonce = game:GetService("HttpService"):GenerateGUID(false)})})
	end,
})
local SaveSettingsSection = HelpTab:CreateSection("Settings that are saveable")
local Settingsthataresaveable = HelpTab:CreateDropdown({
	Name = "Settings:",
	Options = {"Craft Option", "Auto Factory Craft", "Auto Collect Group Rewards", "Auto Buy Shop Boosts", "Choose Egg: (Hatching)", "Quad/Multi Hatch", "Start Hatching Egg", "Skip Animation", "Disable Skip Animation", "Choose Egg: (Teleport)", "Select World (Egg Teleport)", "Teleport To Egg"},
	CurrentOption = "Settings that will be saved",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function()
	end,
})
local NoSaveSettingsSection = HelpTab:CreateSection("Settings that are not saveable")
local Settingsthataresaveable = HelpTab:CreateDropdown({
	Name = "Settings:",
	Options = {"All Other GUI's", "Select Layer (Teleport/Unlock)","Teleport To Layer","Unlock Layer", "Select World (Instant TP)", "Teleport to world"},
	CurrentOption = "Settings that will not be saved",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function()
	end,
})
local TextBoxHelpSection = HelpTab:CreateSection("Tip: Press the ENTER key after typing in the textboxes")



-- Load Settings
function LoadSettingsTableSettings()
        local HttpService = game:GetService("HttpService")
        if (readfile and isfile and isfile(SettingsTableName)) then
            _G.SettingsTable = HttpService:JSONDecode(readfile(SettingsTableName))
            AutoBuyLucky1Hours:Set(_G.SettingsTable.BuyLucky1Hour)
            AutoBuyLucky2Hours:Set(_G.SettingsTable.BuyLucky2Hour)
            AutoBuySuperLucky1Hours:Set(_G.SettingsTable.BuySuperLucky1Hour)
            AutoBuySuperLucky2Hours:Set(_G.SettingsTable.BuySuperLucky2Hour)
            AutoBuyOmegaLucky1Hours:Set(_G.SettingsTable.BuyOmegaLucky1Hour)
            AutoBuyOmegaLucky2Hours:Set(_G.SettingsTable.BuyOmegaLucky2Hour)
            AutoBuyLucky1Hours:Set(_G.SettingsTable.BuyLucky1Hour)
            AutoFactoryCraft:Set(_G.SettingsTable.AutoCraft)
            AutoCollectGroupRewards:Set(_G.SettingsTable.ClaimGroupBenefits)
            StartHatchingEgg:Set(_G.SettingsTable.BuyEgg)
            QuadOrMultiEggHatch:Set(_G.SettingsTable.MultiHatch)
            EggCountStatsTracker:Set(_G.SettingsTable.EggCount)
            RebirthCountStatsTracker:Set(_G.SettingsTable.RebirthCount)
            BlockCountStatsTracker:Set(_G.SettingsTable.BlocksCount)
            EnableBackupEgg:Set(_G.SettingsTable.EnableBackup)
            AutoBuyChristmasBoosts:Set(_G.SettingsTable.BuyEventBoosts)
            --AutoBuySpins:Set(_G.SettingsTable.AutoBuySpins)
            --AutoCollectSpins:Set(_G.SettingsTable.AutoCollectSpins)
            --AutoSpinWheel:Set(_G.SettingsTable.AutoSpinWheel)
            print("Settings: Loaded")
            game.StarterGui:SetCore(
                "SendNotification",
            {
            Title = "SUCCESS!",
            Text = "Settings Have Been Loaded",
            Duration = 5
            }
            )
        else
            if not isfile(SettingsTableName) then
                print("Settings: None Found")
                game.StarterGui:SetCore(
                    "SendNotification",
                {
                Title = "ERROR",
                Text = "Settings Not Found",
                Duration = 5
                }
                )
            end
    end
end

LoadSettingsTableSettings()
SetFPSValue()


-- Second Skip Animation cuz the other one was being difficult
function SkipAnimation1()
    spawn(function()
        game.ReplicatedStorage.ClientModules.Other.OpenEgg.HatchGui:Destroy()
    end)
end



-- Setting Checkers/Function Checkers
if _G.SettingsTable.TpToEgg then
    TweenToEgg()
    _G.PlaceHolders.AutoTeleportToEggPlaceHolder = "Yes"
end
if _G.SettingsTable.SkipAnimation then
    SkipAnimation1()
    _G.PlaceHolders.SkipAnimationPlaceHolder = "Activated"
end
if _G.SettingsTable.StatsTrackerActivated then
    _G.PlaceHolders.StatsTrackerActivationPlaceHolder = "Yes"
    ActivateStatsTracker()
end



-- Nil Value Checkers (if you are running old settings)
if _G.SettingsTable.Intervals == nil or _G.SettingsTable.Webhookssss == nil or _G.SettingsTable.Color == nil then
    _G.PlaceHolders.WebhookErrorPlaceHolder = "Yes"
else
    _G.PlaceHolders.IntervalsPlaceHolder = _G.SettingsTable.Intervals
    _G.PlaceHolders.WebhookPlaceHolder = _G.SettingsTable.Webhookssss
    _G.PlaceHolders.ColorPlaceHolder = _G.SettingsTable.Color
end
if _G.SettingsTable.GemType == nil then
    _G.SettingsTable.GemType = "None"
end
if _G.SettingsTable.InstantWorldOption == nil then
    _G.SettingsTable.InstantWorldOption = "None"
end
if _G.SettingsTable.LayerOption == nil then
    _G.SettingsTable.LayerOption = "None"
end
if _G.SettingsTable.WorldOption == nil then
    _G.SettingsTable.WorldOption = "None"
end
if _G.SettingsTable.EggType == nil then
    _G.SettingsTable.EggType = "None"
end
if _G.SettingsTable.EggTP == nil then
    _G.SettingsTable.EggTP = "None"
end
if _G.SettingsTable.BackupEggTP == nil then
    _G.SettingsTable.BackupEggTP = "None"
end
if _G.SettingsTable.BackupEggType == nil then
    _G.SettingsTable.BackupEggType = "None"
end
if _G.SettingsTable.BackupWorldOption == nil then
    _G.SettingsTable.BackupWorldOption = "None"
end
if _G.SettingsTable.FPSSettings == nil then
    _G.SettingsTable.FPSSettings = "60"
end



-- Setting Stuff
local SettingsSection = SettingsTab:CreateSection("Setting Options (Settings Save Per Account)")
local SeeCurrentSettings = SettingsTab:CreateButton({
	Name = "See Your Current Settings (Type /console in chat)",
	Callback = function()
        print("---CURRENT SETTINGS---")
        for i,v in pairs(_G.SettingsTable) do
            print(i,v)
        end
        print("----------------------")
	end,
})
local SaveCurrentSettings = SettingsTab:CreateButton({
	Name = "Save Your Current Settings",
	Callback = function()
        SaveSettingsTableSettings()
	end,
})
local LoadSavedSettings = SettingsTab:CreateButton({
	Name = "Load Your Saved Settings",
	Callback = function()
        LoadSettingsTableSettings()
	end,
})



-- End Loop to update Textboxes
while wait() do
    local plr = game.Players.LocalPlayer
    local count = 0
    count = game:GetService("Players")[username].leaderstats.Eggs.Value
    local CoinsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Coins.Label.text
    local SpaceCoinsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.CyberTokens.Label.text
    local ShellsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Shells.Label.text
    local CandyCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Candy.Label.text
    local BricksCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Bricks.Label.text
    local CrystalCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Crystals.Label.text
    local StarsCount = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Stars.Label.text
    CurrencyParagraph:Set({Title = "All World Currency Counts", Content = "Coins: " .. FormatCurrency(CoinsCount) .. "\nCyber Tokens: " .. FormatCurrency(SpaceCoinsCount) .. "\nShells: " .. FormatCurrency(ShellsCount) .. "\nCandy: " .. FormatCurrency(CandyCount) .. "\nBricks: " .. FormatCurrency(BricksCount) .. "\nCrystals: " .. FormatCurrency(CrystalCount) .. "\nStars: " .. FormatCurrency(StarsCount)})
    AutoFactoryCraftParagraph:Set({Title = "Current Factory Settings", Content = "Craft Option: " .. _G.SettingsTable.GemType .. "\nActivated: " .. _G.PlaceHolders.AutoFactoryCraftPlaceHolder})
    AutoGroupRewardsParagraph:Set({Title = "Current Auto Collect Settings", Content = "Auto Collect Group Rewards: " .. _G.PlaceHolders.AutoCollectGroupRewardsPlaceHolder .. "\nAuto Collect Event Boosts: " .. _G.PlaceHolders.AutoBuyEventBoostsPlaceHolder .. "\nAuto Spin Wheel: " .. _G.PlaceHolders.AutoSpinWheelPlaceHolder .. "\nAuto Collect Spins: " .. _G.PlaceHolders.AutoCollectSpinsPlaceHolder .. "\nAuto Buy Spins: " .. _G.PlaceHolders.AutoBuySpinsPlaceHolder})
    AutoBuyBoostsParagraph:Set({Title = "Current Auto Buy Boosts Settings", Content = "Auto Buy Lucky Boost (1 Hour): " .. _G.PlaceHolders.BuyLucky1HourPlaceHolder .. "\nAuto Buy Lucky Boost (2 Hours): " .. _G.PlaceHolders.BuyLucky2HourPlaceHolder .. "\nAuto Buy Super Lucky Boost (1 Hour): " .. _G.PlaceHolders.BuySuperLucky1HourPlaceHolder .. "\nAuto Buy Super Lucky Boost (2 Hours): " .. _G.PlaceHolders.BuySuperLucky2HourPlaceHolder .. "\nAuto Buy Omega Lucky Boost (1 Hour): " .. _G.PlaceHolders.BuyOmegaLucky1HourPlaceHolder .. "\nAuto Buy Omega Lucky Boost (2 Hours): " .. _G.PlaceHolders.BuyOmegaLucky2HourPlaceHolder})
    EggFarmingParagraph:Set({Title = "Current Egg Settings", Content = "Eggs Hatched: " .. abb(count) .. "\nSecrets Hatched: " .. abb(_G.SecretsList.TotalSecretsHatched) .. "\nCurrent Egg: " .. _G.SettingsTable.EggType .. "\nMulti/Quad Hatch: " .. _G.PlaceHolders.MultiHatchPlaceHolder .. "\nSkip Animation: " .. _G.PlaceHolders.SkipAnimationPlaceHolder .. "\nAuto Hatch Egg: " .. _G.PlaceHolders.AutoHatchEggPlaceHolder .. "\nEggs Left: " .. abb(GetEggsLeft())})
    AutoTeleportParagraph:Set({Title = "Current Auto Teleport Settings", Content = "Current Egg: " .. _G.SettingsTable.EggTP .. "\nCurrent World: " .. _G.SettingsTable.WorldOption .. "\nActivated: " .. _G.PlaceHolders.AutoTeleportToEggPlaceHolder })
    AutoFPSParagraph:Set({Title = "Current FPS Settings", Content = "Current FPS: " .. _G.SettingsTable.FPSSettings})
    StatsTrackerParagraph:Set({Title = "Current Stats Tracker Settings", Content = "Time Between Updates (In Seconds): " .. _G.PlaceHolders.IntervalsPlaceHolder .. "\nEmbed Color (Hex Value): " .. _G.PlaceHolders.ColorPlaceHolder .. "\nEgg Count: " .. _G.PlaceHolders.EggCountTrackerPlaceHolder .. "\nRebirth Count: " .. _G.PlaceHolders.RebirthCountTrackerPlaceHolder .. "\nBlocks Count " .. _G.PlaceHolders.BlockCountTrackerPlaceHolder .. "\nActivated: " .. _G.PlaceHolders.StatsTrackerActivationPlaceHolder})
    WebhookParagraph:Set({Title = "Webhook Data", Content = "Webhook: " .. _G.PlaceHolders.WebhookPlaceHolder .. "\nWebhook Paragraph Error (Dev Issue): " .. _G.PlaceHolders.WebhookErrorPlaceHolder})
    EggBackupParagraph:Set({Title = "Current Egg Backup Settings", Content = "Info: Teleports to a backup egg if under 100 eggs left on main egg \nBackup Egg: " .. _G.SettingsTable.BackupEggType .. "\nBackup World: " .. _G.SettingsTable.BackupWorldOption .. "\nActivated: " .. _G.PlaceHolders.EnableBackupPlaceHolder .. "\nBackup Active: " .. _G.PlaceHolders.BackupActive})
end
Rayfield:LoadConfiguration()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

if not RunService:IsStudio() then
	return
end

local TEST_MONEY = 2000000000
local MONEY_NAME = "Money"
local LEADERSTATS_NAME = "leaderstats"

local function setValue(valueObject)
	if valueObject:IsA("IntValue") or valueObject:IsA("NumberValue") then
		if valueObject.Value ~= TEST_MONEY then
			valueObject.Value = TEST_MONEY
		end
	elseif valueObject:IsA("StringValue") then
		local value = tostring(TEST_MONEY)
		if valueObject.Value ~= value then
			valueObject.Value = value
		end
	end
end

local function findMoneyValue(player)
	local leaderstats = player:FindFirstChild(LEADERSTATS_NAME)
	if leaderstats then
		local moneyValue = leaderstats:FindFirstChild(MONEY_NAME)
		if moneyValue and moneyValue:IsA("ValueBase") then
			return moneyValue
		end
	end

	local existingValue = player:FindFirstChild(MONEY_NAME, true)
	if existingValue and existingValue:IsA("ValueBase") then
		return existingValue
	end

	return nil
end

local function ensureTestMoney(player)
	local moneyValue = findMoneyValue(player)
	if not moneyValue then
		local leaderstats = player:FindFirstChild(LEADERSTATS_NAME)
		if not leaderstats then
			leaderstats = Instance.new("Folder")
			leaderstats.Name = LEADERSTATS_NAME
			leaderstats.Parent = player
		end

		moneyValue = Instance.new("IntValue")
		moneyValue.Name = MONEY_NAME
		moneyValue.Parent = leaderstats
	end

	setValue(moneyValue)

	if moneyValue:GetAttribute("InfiniteTestMoneyConnection") then
		return
	end

	moneyValue:SetAttribute("InfiniteTestMoneyConnection", true)
	moneyValue.Changed:Connect(function()
		setValue(moneyValue)
	end)
end

local function watchPlayer(player)
	ensureTestMoney(player)

	player.DescendantAdded:Connect(function(instance)
		if instance.Name == MONEY_NAME and instance:IsA("ValueBase") then
			ensureTestMoney(player)
		end
	end)
end

Players.PlayerAdded:Connect(watchPlayer)

for _, player in Players:GetPlayers() do
	task.spawn(watchPlayer, player)
end

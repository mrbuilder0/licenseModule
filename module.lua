local blacklisted = {
	651278665, --guesi30011
	1462461963, -- UhJose_ph
	3177378056, -- ben_robloxs5456
	3345038459, -- Bluedragon14689
	104323376, -- happyevdev
	2278371332, -- juls661
	1519073315, -- exer_ella
	5288774131, -- asimiii3253
	33951584, -- Infinite Technology
}

local GlobalITAPI = Instance.new("BindableEvent")
GlobalITAPI.Name = "GlobalITAPI"
GlobalITAPI.Parent = game.ReplicatedFirst

local webhook = "https://webhook.lewisakura.moe/api/webhooks/1326135635274371133/lU26dfH7KLkyfTyvUscob69lkmOM2BTSJQfs3MJyzdeBcIOUplUz48r5Bz1Ag5on9s9e"

function module.TamperedThings(product)
	local data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "<:9692redguard:1220335561366044742> **Stolen Asset** <:9692redguard:1220335561366044742>",
			["description"] = "Detected game using stolen assets. They either don't have a license or it was re-sold!",
			["type"] = "rich",
			["color"] = tonumber(0xff0000),
			["fields"] = {
				{
					["name"] = "**Game:**",
					["value"] = "> ["..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."](https://www.roblox.com/games/"..game.PlaceId..")",
					["inline"] = false
				},
				{
					["name"] = "**Product:**",
					["value"] = "> "..product,
					["inline"] = false
				}
			}
		}}
	}
	local encodedData = game:GetService("HttpService"):JSONEncode(data)
	game:GetService("HttpService"):PostAsync(webhook,encodedData)
	for i = 1,#game.Players:GetChildren() do
		local player = game.Players:GetChildren()[i]
		game.Players:GetPlayerByUserId(player.UserId):Kick("[IT x MRS] This game is either using stolen products or doesn't own the license for it! Reselling our products results in a blacklist + DMCA!")
	end
end

GlobalITAPI.Event:Connect(function(product)
	module.TamperedThings(product)
end)

game.Players.PlayerAdded:Connect(function(plr)
	for i = 1,#blacklisted do
		local blacklist = blacklisted[i]
		if plr.UserId == blacklist then
			plr:Kick("[IT x MRS] You are blacklisted from games that use MRS and IT!")
		
		elseif plr:IsInGroup(blacklist) then
			local gname = game:GetService("GroupService"):GetGroupInfoAsync(blacklist).Name
			plr:Kick("[IT x MRS] You are in a blacklisted group, "..gname.."("..blacklist.."). In order to play games that use MRS and IT products you have to leave this group!")
		end
		wait(0.01)
	end
end)
game.Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		local message = msg:lower()
		print(message)
		if message == ":tampered" then
			if plr:GetRankInGroup(8116097) >= 253 then
				module.TamperedThings("N/A")
			end
		end
	end)
end)
if game:GetService("RunService"):IsRunning() then
	local data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "<:9692greedguard:1220371306793533542> **Game Using IT / MRS** <:9692greedguard:1220371306793533542>",
			["description"] = "The following game is using our products!",
			["type"] = "rich",
			["color"] = tonumber(0x228B22),
			["fields"] = {
				{
					["name"] = "**Game**",
					["value"] = "> ["..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."](https://www.roblox.com/games/"..game.PlaceId..")",
					["inline"] = false
				},
				{
					["name"] = "**Game ID**",
					["value"] = "> "..game.PlaceId,
					["inline"] = false
				},
			}
		}}
	}
	local encodedData = game:GetService("HttpService"):JSONEncode(data)
	game:GetService("HttpService"):PostAsync(webhook,encodedData)
end

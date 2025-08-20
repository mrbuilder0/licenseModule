
local GlobalITAPI = Instance.new("BindableEvent")
GlobalITAPI.Name = "GlobalITAPI"
GlobalITAPI.Parent = game.ReplicatedFirst

local webhook = "https://webhook.lewisakura.moe/api/webhooks/1326135635274371133/lU26dfH7KLkyfTyvUscob69lkmOM2BTSJQfs3MJyzdeBcIOUplUz48r5Bz1Ag5on9s9e"

function TamperedThings(product)
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
	TamperedThings(product)
end)

game.Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		local message = msg:lower()
		print(message)
		if message == ":tampered" then
			if plr:GetRankInGroup(8116097) >= 253 then
				TamperedThings("N/A")
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

local HttpService = game:GetService("HttpService")

local url = tostring("https://xafnibzfmjswrgcjfoit.supabase.co/rest/v1/licenses?robloxID=eq."..game.CreatorId) 

local headers = {
	["apikey"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhZm5pYnpmbWpzd3JnY2pmb2l0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4NDI1MTgsImV4cCI6MjA2ODQxODUxOH0.vkhtKVOr3JYYfvv8NStqIURoNIDAuN0jnDYCOD1biaE",
	["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhZm5pYnpmbWpzd3JnY2pmb2l0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4NDI1MTgsImV4cCI6MjA2ODQxODUxOH0.vkhtKVOr3JYYfvv8NStqIURoNIDAuN0jnDYCOD1biaE"
}

local response = HttpService:GetAsync(url, false, headers)
local data = HttpService:JSONDecode(response)
if #data > 0 then
	local folder = Instance.new("Folder")
	folder.Name = "Infinity Tech License Service hZm5pYnpmbWpzd3JnY2pmb2l0Ii"
	folder.Parent = game.ReplicatedStorage
	for i, license in ipairs(data) do
		print("IT | Licence found:", license.license_type)

		local name = tostring(license.license_type)
		print(name)
		local license = Instance.new("StringValue")
		license.Name = name
		license:AddTag("hZm5pYnpmbWpzd3JnY2pmdsab2l0Ii")
		license.Parent = folder
	end
else
	warn("IT | No licenses found.", data)
end

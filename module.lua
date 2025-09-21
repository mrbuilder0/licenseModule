local GlobalITAPI = Instance.new("BindableEvent")
GlobalITAPI.Name = "Global_IT_License_API"
GlobalITAPI.Parent = game.ReplicatedFirst

local webhook = "https://webhook.lewisakura.moe/api/webhooks/1326135635274371133/lU26dfH7KLkyfTyvUscob69lkmOM2BTSJQfs3MJyzdeBcIOUplUz48r5Bz1Ag5on9s9e"

function TamperedThings(product)
	local data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "<:report:1418650254533988493> **Stolen Asset(s)** <:report:1418650254533988493>",
			["description"] = "> Detected game using stolen assets. They either don't have a license or it was re-sold!",
			["type"] = "rich",
			["color"] = tonumber(0xff0000),
			["fields"] = {
				{
					["name"] = "**Game:**",
					["value"] = "["..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."](https://www.roblox.com/games/"..game.PlaceId..")",
					["inline"] = true
				},
				{
					["name"] = "**Product:**",
					["value"] = product,
					["inline"] = true
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


------------------- License Check -------------------

local HttpService = game:GetService("HttpService")

local url = tostring("https://xafnibzfmjswrgcjfoit.supabase.co/rest/v1/licenses?robloxID=eq."..game.CreatorId) 

local headers = {
	["apikey"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhZm5pYnpmbWpzd3JnY2pmb2l0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4NDI1MTgsImV4cCI6MjA2ODQxODUxOH0.vkhtKVOr3JYYfvv8NStqIURoNIDAuN0jnDYCOD1biaE",
	["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhZm5pYnpmbWpzd3JnY2pmb2l0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4NDI1MTgsImV4cCI6MjA2ODQxODUxOH0.vkhtKVOr3JYYfvv8NStqIURoNIDAuN0jnDYCOD1biaE"
}

local response = HttpService:GetAsync(url, false, headers)
local data = HttpService:JSONDecode(response)
local usedProducts = ""

if script:FindFirstChild("RankTag") then
	usedProducts = usedProducts.."RankTag, "
end

if #data > 0 then

	local folder = Instance.new("Folder")
	folder.Name = "hghZm5pYnpmbWpzd3JnY2pmb2l0Ii"
	folder.Parent = game.ReplicatedStorage

	for i, license in ipairs(data) do

		print("IT | Licence found:", license.license_type)

		usedProducts = usedProducts..license.license_type..", "

		if script:FindFirstChild(tostring(license.license_type)) then

			local LicenseFolder = script:FindFirstChild(tostring(license.license_type))


			if game.Workspace:FindFirstChild(LicenseFolder:GetAttribute("LocName")) then
				local SubFolder = game.Workspace:FindFirstChild(LicenseFolder:GetAttribute("LocName")):FindFirstChild(LicenseFolder:GetAttribute("SubFolder"))
				for _,till in pairs(SubFolder:GetChildren()) do
					local LoaderScript = LicenseFolder:FindFirstChild("Loader"):Clone()

					LoaderScript.Parent = till
					LoaderScript:AddTag("hghZm5pYnpmbWpzd3JnY2pmb2l0Iidsadwa")
					LoaderScript.Disabled = false
				end

			else
				warn("IT | No product folder found for"..license.license_type)
			end
		else 
			warn("IT | No source folder found for "..license.license_type)
		end
	end
	local data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "<:9692greedguard:1220371306793533542> **Legitimate License(s)** <:9692greedguard:1220371306793533542>",
			["description"] = "The following game uses valid licenses!",
			["type"] = "rich",
			["color"] = tonumber(0x050099),
			["fields"] = {
				{
					["name"] = "**Game**",
					["value"] = "["..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."](https://www.roblox.com/games/"..game.PlaceId..")",
					["inline"] = true
				},
				{
					["name"] = "**Game ID**",
					["value"] = game.PlaceId,
					["inline"] = true
				},
				{
					["name"] = "**Licences**",
					["value"] = usedProducts,
					["inline"] = true
				},
			}
		}}
	}
	local encodedData = game:GetService("HttpService"):JSONEncode(data)
	game:GetService("HttpService"):PostAsync(webhook,encodedData)

else
	warn("IT | No licenses found.", data)
end

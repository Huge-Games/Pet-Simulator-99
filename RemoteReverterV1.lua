
-- Shitty Name Reverted To Revert the Silly "EnCryPtIoN"
-- Hopefully this will patch skids :D


-- Dear BIGGames: Please stop trying to patch exploits, they're the only thing keeping your game alive <3
-- Instead remove "CoderJoey" from the dev team, Most useless twat there, just a deadweight tbh
-- He do got nice tits tho


local Networking = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Senv = getsenv(game:GetService("ReplicatedStorage").Library.Client.Network)

local nameCache = {[1]={},[2]={},[3]={}}
for i,v in next, getgc(true) do
	if type(v) == "function" and islclosure(v) then-- and not isexecutorclosure(v) then
		local Constants = getconstants(v)
		local Func = v
		
		for Index,Method in pairs({"Fire", "Invoke", "UnreliableFire"}) do
			local tableFind_Method = table.find(Constants, "Fire")
			if Constants and tableFind_Method then
				local remote_Name = Constants[tableFind_Method+1]
				if remote_Name and not table.find(nameCache[Index], remote_Name) then
					table.insert(nameCache[Index], remote_Name)
				end
			end
		end
	end
end

local Replaced = 0
for Index,List in pairs(nameCache) do
	for i,RemoteName in pairs(List) do
		local newName = Senv._getName(Index, RemoteName)
		if newName then
			local NetworkList = getupvalues(Senv._remote)[1][Index]
			if NetworkList[newName] then
				local PhysicalRemote = NetworkList[newName]
				if typeof(PhysicalRemote) == "Instance" then PhysicalRemote.Name = RemoteName;Replaced+=1 end
			end
		end
	end
end

warn("-----------------------------------")
local Total = #nameCache[1]+#nameCache[2]+#nameCache[3]
warn("Reverted Names ("..Replaced.."/"..Total..")")
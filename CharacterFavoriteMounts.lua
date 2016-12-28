characterFavoriteMountsList = {}
characterFavoritePetsList = {}
characterFavoritePetsIDs = {}
characterFavoritePetsAbilities = {}

function characterFavoriteMountsOnEvent(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "CharacterFavoriteMounts" then
		self:RegisterEvent("PLAYER_LOGIN")
		self:RegisterEvent("PLAYER_LOGOUT")
		self:UnregisterEvent("ADDON_LOADED")
	end
	if event == "PLAYER_LOGIN" then
		local characterFavoriteMountsCount = C_MountJournal.GetNumMounts()
		local characterFavoriteMountsTemp
		local characterFavoriteMountsID
		local characterFavoriteMountsCollected
		if table.getn(characterFavoriteMountsList) > 0 then
			for i = 1, characterFavoriteMountsCount do
				characterFavoriteMountsTemp, characterFavoriteMountsID, characterFavoriteMountsTemp, characterFavoriteMountsTemp, characterFavoriteMountsTemp, characterFavoriteMountsTemp, characterFavoriteMountsIsFavorite, characterFavoriteMountsTemp, characterFavoriteMountsTemp, characterFavoriteMountsTemp, characterFavoriteMountsCollected = C_MountJournal.GetMountInfo(i)
				if characterFavoriteMountsCollected then
					if not characterFavoriteMountsFind(characterFavoriteMountsList, characterFavoriteMountsID) then
						characterFavoriteMountsIsFavorite = C_MountJournal.GetIsFavorite(i)
						while characterFavoriteMountsIsFavorite do
							C_MountJournal.SetIsFavorite(i, false)
							characterFavoriteMountsIsFavorite = C_MountJournal.GetIsFavorite(i)
						end
					end
				end
			end
			for i = 1, characterFavoriteMountsCount do
				characterFavoriteMountsTemp, characterFavoriteMountsID = C_MountJournal.GetMountInfo(i)
				if characterFavoriteMountsFind(characterFavoriteMountsList, characterFavoriteMountsID) then
					characterFavoriteMountsIsFavorite = C_MountJournal.GetIsFavorite(i)
					while not characterFavoriteMountsIsFavorite do
						C_MountJournal.SetIsFavorite(i, true)
						characterFavoriteMountsIsFavorite = C_MountJournal.GetIsFavorite(i)
					end
				end
			end
		else
			for i = 1, characterFavoriteMountsCount do
				characterFavoriteMountsIsFavorite = C_MountJournal.GetIsFavorite(i)
				if characterFavoriteMountsIsFavorite then
					characterFavoriteMountsName, characterFavoriteMountsID = C_MountJournal.GetMountInfo(i)
					table.insert(characterFavoriteMountsList, characterFavoriteMountsID)
				end
			end
		end
		self:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
	end
	if event == "PET_JOURNAL_LIST_UPDATE" then
		local characterFavoritePetsTemp
		local characterFavoritePetsCount
		local characterFavoritePetsID
		local characterFavoritePetsIsFavorite
		self:UnregisterEvent("PET_JOURNAL_LIST_UPDATE")
		if table.getn(characterFavoritePetsIDs) > 0 then
			C_PetJournal.SetPetLoadOutInfo(1, characterFavoritePetsIDs[1])
			C_PetJournal.SetAbility(1, 1, characterFavoritePetsAbilities[1])
			C_PetJournal.SetAbility(1, 2, characterFavoritePetsAbilities[2])
			C_PetJournal.SetAbility(1, 3, characterFavoritePetsAbilities[3])
			C_PetJournal.SetPetLoadOutInfo(2, characterFavoritePetsIDs[2])
			C_PetJournal.SetAbility(2, 1, characterFavoritePetsAbilities[4])
			C_PetJournal.SetAbility(2, 2, characterFavoritePetsAbilities[5])
			C_PetJournal.SetAbility(2, 3, characterFavoritePetsAbilities[6])
			C_PetJournal.SetPetLoadOutInfo(3, characterFavoritePetsIDs[3])
			C_PetJournal.SetAbility(3, 1, characterFavoritePetsAbilities[7])
			C_PetJournal.SetAbility(3, 2, characterFavoritePetsAbilities[8])
			C_PetJournal.SetAbility(3, 3, characterFavoritePetsAbilities[9])
		else
			characterFavoritePetsIDs[1], characterFavoritePetsAbilities[1], characterFavoritePetsAbilities[2], characterFavoritePetsAbilities[3] = C_PetJournal.GetPetLoadOutInfo(1)
			characterFavoritePetsIDs[2], characterFavoritePetsAbilities[4], characterFavoritePetsAbilities[5], characterFavoritePetsAbilities[6] = C_PetJournal.GetPetLoadOutInfo(2)
			characterFavoritePetsIDs[3], characterFavoritePetsAbilities[7], characterFavoritePetsAbilities[8], characterFavoritePetsAbilities[9] = C_PetJournal.GetPetLoadOutInfo(3)
		end
		characterFavoritePetsTemp, characterFavoritePetsCount = C_PetJournal.GetNumPets()
		if table.getn(characterFavoritePetsList) > 0 then
			for i = 1, characterFavoritePetsCount do
				characterFavoritePetsID = C_PetJournal.GetPetInfoByIndex(i)
				if not characterFavoriteMountsFind(characterFavoritePetsList, characterFavoritePetsID) then
					characterFavoritePetsIsFavorite = C_PetJournal.PetIsFavorite(characterFavoritePetsID)
					while characterFavoritePetsIsFavorite do
						C_PetJournal.SetFavorite(characterFavoritePetsID, 0)
						characterFavoritePetsIsFavorite = C_PetJournal.PetIsFavorite(characterFavoritePetsID)
					end
				end
			end
			for i = 1, characterFavoritePetsCount do
				characterFavoritePetsID = C_PetJournal.GetPetInfoByIndex(i)
				if characterFavoriteMountsFind(characterFavoritePetsList, characterFavoritePetsID) then
					characterFavoritePetsIsFavorite = C_PetJournal.PetIsFavorite(characterFavoritePetsID)
					while not characterFavoritePetsIsFavorite do
						C_PetJournal.SetFavorite(characterFavoritePetsID, 1)
						characterFavoritePetsIsFavorite = C_PetJournal.PetIsFavorite(characterFavoritePetsID)
					end
				end
			end
		else
			for i = 1, characterFavoritePetsCount do
				characterFavoritePetsID = C_PetJournal.GetPetInfoByIndex(i)
				if characterFavoritePetsID ~= nil then
					characterFavoritePetsIsFavorite = C_PetJournal.PetIsFavorite(characterFavoritePetsID)
					if characterFavoritePetsIsFavorite then
						table.insert(characterFavoritePetsList, characterFavoritePetsID)
					end
				end
			end
		end
	end
end

function characterFavoriteMountsFind(list, value)
	local number = table.getn(list)
	for i = 1, number do
		if list[i] == value then
			return true
		end
	end
	return false
end

function characterFavoriteMountRemove(list, value)
	local number = table.getn(list)
	for i = 1, number do
		if list[i] == value then
			table.remove(list, i)
			break
		end
	end
end

local characterFavoriteMountsFrame = CreateFrame("FRAME", nil, UIParent)
characterFavoriteMountsFrame:RegisterEvent("ADDON_LOADED")
characterFavoriteMountsFrame:SetScript("OnEvent", characterFavoriteMountsOnEvent)

hooksecurefunc(C_MountJournal, "SetIsFavorite", function(index, value)
	local characterFavoriteMountsTemp, characterFavoriteMountsID = C_MountJournal.GetMountInfo(index)
	if value then
		if not characterFavoriteMountsFind(characterFavoriteMountsList, characterFavoriteMountsID) then
			table.insert(characterFavoriteMountsList, characterFavoriteMountsID)
		end
	else
		characterFavoriteMountRemove(characterFavoriteMountsList, characterFavoriteMountsID)
	end
end)

hooksecurefunc(C_PetJournal, "SetFavorite", function(id, value)
	if value == 1 then
		if not characterFavoriteMountsFind(characterFavoritePetsList, id) then
			table.insert(characterFavoritePetsList, id)
		end
	else
		characterFavoriteMountRemove(characterFavoritePetsList, id)
	end
end)

hooksecurefunc(C_PetJournal, "SetPetLoadOutInfo", function(slot, id)
	characterFavoritePetsIDs[slot], characterFavoritePetsAbilities[3 * (slot - 1) + 1], characterFavoritePetsAbilities[3 * (slot - 1) + 2], characterFavoritePetsAbilities[3 * (slot - 1) + 3] = C_PetJournal.GetPetLoadOutInfo(slot)
end)
hooksecurefunc(C_PetJournal, "SetAbility", function(slot, spell, id)
	characterFavoritePetsIDs[slot], characterFavoritePetsAbilities[3 * (slot - 1) + 1], characterFavoritePetsAbilities[3 * (slot - 1) + 2], characterFavoritePetsAbilities[3 * (slot - 1) + 3] = C_PetJournal.GetPetLoadOutInfo(slot)
end)
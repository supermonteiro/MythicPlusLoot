MythicPlusLoot = LibStub("AceAddon-3.0"):NewAddon("MythicPlusLoot", "AceConsole-3.0", "AceEvent-3.0" );
local L = LibStub("AceLocale-3.0"):GetLocale("MythicPlusLoot")

local lineAdded = false

local numScreen = ""

local frame = CreateFrame("Frame");
frame:RegisterEvent("ADDON_LOADED");
--[[
local lootTable = CreateFrame("Frame", nil, PVEFrame) --code for displaing the mythic loot progression table on PVEFrame
lootTable:SetPoint("TOPLEFT", PVEFrame)
lootTable:SetPoint("BOTTOMRIGHT", PVEFrame)
lootTable:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", PVEFrame, "TOPRIGHT", 0, -250)
	GameTooltip:SetText("Key    Loot  Cache  Azerite")
    GameTooltip:AddLine(" 0     340     -      - ")
	GameTooltip:AddLine(" 2     345    355    340")
	GameTooltip:AddLine(" 3     345    355    340")
	GameTooltip:AddLine(" 4     350    360    355")
    GameTooltip:AddLine(" 5     355    360    355")
    GameTooltip:AddLine(" 6     355    365    360")
    GameTooltip:AddLine(" 7     360    370    370")
    GameTooltip:AddLine(" 8     365    370    370")
    GameTooltip:AddLine(" 9     365    375    370")
	GameTooltip:AddLine("10+    370    380    385")	
	GameTooltip:Show()
end)

lootTable:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)
--]]
local rewards  = { 
	{ " Key ", " Loot ", " Cache ", " Azerite " },--1
	{ "0", "340", "-", "-" },--2
	{ "2", "345", "355", "340" },--3
	{ "3", "345", "355", "340" },--4
	{ "4", "350", "360", "355" },--5
	{ "5", "355", "360", "355" },--6
	{ "6", "355", "365", "355" },--7
	{ "7", "360", "370", "370" },--8
	{ "8", "365", "370", "370" },--9
	{ "9", "365", "375", "370" },--10
	{ "10+", "370", "380", "385" },--11
}

local mplustable = CreateFrame("Frame", "MythisPlusLootTable", PVEFrame)
mplustable:SetSize(50, 50)
mplustable:SetPoint("TOPLEFT", PVEFrame, "TOPRIGHT", 0, -260)
local last, lastline
local widths = {}
for i=1, #rewards do
	for t=1, #rewards[i] do
		local s = mplustable:CreateFontString()
		--s:SetFontObject(GameFontNormal)
		s:SetFontObject(GameFontNormalLarge)
		if i == 1 then
			s:SetTextColor(1, 1, 0) 
		elseif (1 < i and  i < 5) then
			s:SetTextColor(1, 1,1) 
		elseif (4 < i and i < 8) then
			s:SetTextColor(0.6, 1, 1) 
		elseif (7 < i and i < 11) then
			s:SetTextColor(1, 1, 0) 
		elseif i==11 then
			s:SetTextColor(0.2, 1, 0.3)
		end
		s:SetText(rewards[i][t])
		if i == 1 and t == 1 then
			s:SetPoint("TOPLEFT", mplustable)
			mplustable.first = s
		elseif t == 1 then
			s:SetPoint("TOPLEFT", lastline, "BOTTOMLEFT")
		else
			s:SetPoint("LEFT", last, "RIGHT")
		end
		if i == 1 then 
			widths[t] = s:GetWidth()
		else
			s:SetWidth(widths[t])
		end
		last = s
		if t == 1 then
			lastline = s
		end
	end
end
local width = 0
for i=1, #widths do
	width = width + widths[i]
end
mplustable:SetSize(width + 10, (last:GetHeight() * #rewards) + 10)
local backdrop = { 
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	edgeSize = 16,
	tileSize = 16,
	insets = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 4,
	},
}
mplustable:SetBackdrop(backdrop)
mplustable:SetBackdropColor(0, 0, 0)
mplustable.first:ClearAllPoints()
mplustable.first:SetPoint("TOPLEFT", 5, -5)


frame:SetScript("OnEvent",function(self,event,...)	
    if (event == "ADDON_LOADED") then		
        local addon = ...

        --if (addon == "Blizzard_ChallengesUI") then		
            
            --local iLvlFrm = CreateFrame("Frame","LootLevel",ChallengesModeWeeklyBest);
            --iLvlFrm:SetWidth(100);
            --iLvlFrm:SetHeight(50);
            --iLvlFrm:SetPoint("CENTER",-128,-37); 
			
			--sdm_SetTooltip(iLvlFrm, L["This shows the level of the item you'll find in this week's chest."]);

            --iLvlFrm.text = iLvlFrm:CreateFontString(nil, "MEDIUM", "GameFontHighlightLarge");
            --iLvlFrm.text:SetAllPoints(iLvlFrm);
			--iLvlFrm.text:SetFont("Fonts\\FRIZQT__.TTF",30);
            --iLvlFrm.text:SetPoint("CENTER",0,0);
            --iLvlFrm.text:SetTextColor(1,0,1,1);
            --iLvlFrm:SetScript("OnUpdate",function(self,elaps)		
				--self.time = (self.time or 1)-elaps
				
				--if (self.time > 0) then
					--return
				--end
				
				--while (self.time <= 0) do				
					--if (ChallengesModeWeeklyBest) then                    
						--numScreen = ChallengesModeWeeklyBest.Child.Level:GetText();				
						
						--self.time = self.time+1;
						
						--self.text:SetText(MythicWeeklyLootItemLevel(numScreen));	
						----self.text:SetText(numScreen);
						--self:SetScript("OnUpdate",nil);
					--end					
				--end
            --end)		
		--end
    end
end)

-- Tooltip functions
function sdm_OnEnterTippedButton(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	--GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
		
	GameTooltip:AddLine("|cffff00ff" .. L["Weekly Chest Reward"]  .."|r")
	GameTooltip:AddLine("|cff00ff00" .. self.tooltipText .."|r")
	GameTooltip:Show()
end

function sdm_OnLeaveTippedButton()
	GameTooltip_Hide()
end

-- if text is provided, sets up the button to show a tooltip when moused over. Otherwise, removes the tooltip.
function sdm_SetTooltip(self, text)
	if text then
		self.tooltipText = text
		self:SetScript("OnEnter", sdm_OnEnterTippedButton)
		self:SetScript("OnLeave", sdm_OnLeaveTippedButton)
	else
		self:SetScript("OnEnter", nil)
		self:SetScript("OnLeave", nil)
	end
end

local function OnTooltipSetItem(tooltip, ...)
	name, link = GameTooltip:GetItem()
	
	-- The player is using the Auction House, return!
	if (link == nil) then
		return
	end

	for itemLink in link:gmatch("|%x+|Hkeystone:.-|h.-|h|r") do
		local itemString = string.match(itemLink, "keystone[%-?%d:]+")
		-- local itemName = string.match(itemLink, "\124h.-\124h"):gsub("%[","%%[)("):gsub("%]",")(%%]")
		-- local _,itemid,_,_,_,_,_,_,_,_,_,flags,_,_,mapid,mlvl,modifier1,modifier2,modifier3 = strsplit(":", itemString)
		-- keystone:234:12:1:6:3:9
		local mlvl = select(4, strsplit(":", itemString))

		local ilvl = MythicLootItemLevel(mlvl)
		local wlvl = MythicWeeklyLootItemLevel(mlvl)
		local alvl = MythicWeeklyAzeriteItemLevel(mlvl)	-- thanks to monteiro for the idea and function
		
		-- if (itemid == "138019") then -- Mythic Keystone
			if not lineAdded then						
				tooltip:AddLine("|cffff00ff" .. L["Loot Item Level: "] .. ilvl .. "+" .. "|r") --551A8B   --ff00ff 
				tooltip:AddLine("|cffff00ff" .. L["Weekly Chest Item Level: "] .. wlvl .."|r") --551A8B   --ff00ff
				tooltip:AddLine("|cffff00ff" .. L["Weekly Azerite Armor Item Level: "] .. alvl .."|r") --551A8B   --ff00ff
				lineAdded = true
			end
		-- end
	end
end
 
local function OnTooltipCleared(tooltip, ...)
   lineAdded = false
end

-- ITEM REF Tooltip
local function SetHyperlink_Hook(self,hyperlink,text,button)		
	-- local _,itemid,_,_,_,_,_,_,_,_,_,flags,_,_,mapid,mlvl,modifier1,modifier2,modifier3 = strsplit(":", hyperlink)
	local itemString = string.match(hyperlink, "keystone[%-?%d:]+")
	if itemString == nil or itemString == "" then return end
	if strsplit(":", itemString) == "keystone" then
		local mlvl = select(4, strsplit(":", hyperlink))

		local ilvl = MythicLootItemLevel(mlvl)
		local wlvl = MythicWeeklyLootItemLevel(mlvl)
		local alvl = MythicWeeklyAzeriteItemLevel(mlvl)
		--local FULLINFO = itemString
			
									   
															
  
		-- if (itemid == "138019") then -- Mythic Keystone			
			ItemRefTooltip:AddLine("|cffff00ff" .. L["Loot Item Level: "] .. ilvl .. "+" .. "|r", 1,1,1,true) --551A8B   --ff00ff 
			ItemRefTooltip:AddLine("|cffff00ff" .. L["Weekly Chest Item Level: "] .. wlvl .."|r", 1,1,1,true) --551A8B   --ff00ff 
			ItemRefTooltip:AddLine("|cffff00ff" .. L["Weekly Azerite Item Level: "] .. alvl .."|r", 1,1,1,true) --551A8B   --ff00ff
			--ItemRefTooltip:AddLine("|cffff00ff" .. FULLINFO .."|r", 1,1,1,true)
			ItemRefTooltip:Show()
			--if not lineAdded then				
			--	ItemRefTooltip:AddLine("|cffff00ff" .. L["Loot Item Level: "] .. ilvl .. "+" .. "|r", 1,1,1,true) --551A8B   --ff00ff 
			--	ItemRefTooltip:AddLine("|cffff00ff" .. L["Weekly Chest Item Level: "] .. wlvl .."|r", 1,1,1,true) --551A8B   --ff00ff 
			--	ItemRefTooltip:Show()
			--lineAdded = true
			--end		
		-- end
	end
end
 
GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
GameTooltip:HookScript("OnTooltipCleared", OnTooltipCleared)
hooksecurefunc("ChatFrame_OnHyperlinkShow",SetHyperlink_Hook)

function MythicLootItemLevel(mlvl)
 if (mlvl == "2" or mlvl == "3") then
  return "345"
 elseif (mlvl == "4") then
  return "350"
 elseif (mlvl == "5" or mlvl == "6") then
  return "355"
 elseif (mlvl == "7") then
  return "360"
 elseif (mlvl == "8" or mlvl == "9") then
  return "365"
 elseif (mlvl >= "10") then
  return "370"
 else
  return ""
 end
end

 

function MythicWeeklyLootItemLevel(mlvl)
 if (mlvl == "2" or mlvl == "3") then
  return "355"
 elseif (mlvl == "4" or mlvl == "5") then
  return "360"
 elseif (mlvl == "6") then
  return "365"
 elseif (mlvl == "7" or mlvl == "8") then
  return "370" 
 elseif (mlvl == "9") then
  return "375"
 elseif (mlvl >= "10") then
  return "380"
 else
  return ""
 end
end


function MythicWeeklyAzeriteItemLevel(mlvl)
 if (mlvl == "2" or mlvl == "3") then
  return "340"
 elseif (mlvl == "4" or mlvl == "5" or mlvl == "6") then
  return "355" 
 elseif (mlvl == "7" or mlvl == "8" or mlvl == "9") then
  return "370"  
 elseif (mlvl >= "10") then
  return "385"
 else
  return ""
 end
end
function MythicPlusLoot:OnInitialize()
		-- Called when the addon is loaded

		-- Print a message to the chat frame
		self:Print(L["MythicPlusLoot: Loaded"])
end

function MythicPlusLoot:OnEnable()
		-- Called when the addon is enabled

		-- Print a message to the chat frame		
		self:Print(L["MythicPlusLoot: Enabled"])
end

function MythicPlusLoot:OnDisable()
		-- Called when the addon is disabled
		self:Print(L["MythicPlusLoot: Disabled"])
end
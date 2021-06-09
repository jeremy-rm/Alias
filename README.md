# Alias

> *noun*, *plural* **a·li·as·es**  
> 1. a false name used to conceal one's identity; an assumed name:  
> *The police files indicate that “Smith” is an alias for Simpson.*  
> &mdash; [dictionary.com](https://www.dictionary.com/browse/alias)  

Alias is an Elder Scrolls Online addon which allows you to create and save console commands which are aliases to other console commands.

Alias can be used to:
- Shorten commonly used commands: `/alias add rui reloadui`
- Save commonly used command parameters: `/alias add ls loot show`
- Create entirely new commands: `/alias add clear script CHAT_SYSTEM.primaryContainer.currentBuffer:Clear()`

Features:
- Aliases are saved account-wide, making them available to all characters.
- Aliases are restored each time you play.
- Aliases can be set to automatically execute on player load, allowing for persistent changes using script commands.

Alias is accessed via the chat console by typing `/alias`.

---

# Example Aliases

- Add a new command to clear the current chat tab.

```
/alias add clear script CHAT_SYSTEM.primaryContainer.currentBuffer:Clear()
```

- Add a new command to teleport to your Guild Hall.

```
/alias add gh script JumpToSpecificHouse("@MyGuildsHouse", 47)
```

- Add a new command to teleport to your group leader.

```
/alias add jtl script JumpToGroupLeader()
```

- Add a new command to generate a table of all existing player houses and their associated ID numbers.

```
/alias add houseids script for id=1,100 do house=GetCollectibleName(GetCollectibleIdForHouse(id)); if house ~= "" then CHAT_SYSTEM:AddMessage(zo_strformat("<<1>>: <<2>> (<<3>>)", id, house, GetZoneNameById(GetParentZoneId(GetHouseZoneId(id))))) end end
```

- Add two new commands to mark and unmark your companion with a floating icon.

```
/alias add markcompanion script EVENT_MANAGER:RegisterForEvent(aliasmarkcompanion, EVENT_COMPANION_ACTIVATED, function() SetFloatingMarkerInfo(MAP_PIN_TYPE_ACTIVE_COMPANION, 32, "/esoui/art/progression/stamina_points_frame.dds") end); SetFloatingMarkerInfo(MAP_PIN_TYPE_ACTIVE_COMPANION, 32, "/esoui/art/progression/stamina_points_frame.dds")
```

```
/alias add unmarkcompanion script EVENT_MANAGER:UnregisterForEvent(aliasmarkcompanion, EVENT_COMPANION_ACTIVATED); SetFloatingMarkerInfo(MAP_PIN_TYPE_ACTIVE_COMPANION, 0, "")
```

- Add two new commands to mark and unmark your group leader with a floating icon.

```
/alias add markleader script EVENT_MANAGER:RegisterForEvent(aliasmarkleader, EVENT_PLAYER_ACTIVATED, function() SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER, 32, "/esoui/art/progression/health_points_frame.dds") end); SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER, 32, "/esoui/art/progression/health_points_frame.dds")
```

```
/alias add unmarkleader script EVENT_MANAGER:UnregisterForEvent(aliasmarkleader, EVENT_PLAYER_ACTIVATED); SetFloatingMarkerInfo(MAP_PIN_TYPE_GROUP_LEADER, 0, "")
```

- Add a new command to display your current AvA rank progress.

```
/alias add myrank script CHAT_SYSTEM:AddMessage(GetUnitName("player")..zo_strformat("\n- <<t:1>> (<<2>>/50)\n- Grade: <<3>> of <<4>> points\n- Rank: <<5>> of <<6>> points", string.lower(ZO_CampaignAvARankName:GetText()), ZO_CampaignAvARankRank:GetText(), GetAvARankProgress(GetUnitAvARankPoints("player"))))
```

- Add a new command to display your current AvA reward tier progress.

```
/alias add mytier script CHAT_SYSTEM:AddMessage(zo_strformat("Current Rewards Tier: <<1>>, Next Tier Progress: <<2>> of <<3>>", GetPlayerCampaignRewardTierInfo(GetCurrentCampaignId())))
```

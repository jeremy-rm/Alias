# Alias

> *noun*, *plural* **a·li·as·es**  
> 1. a false name used to conceal one's identity; an assumed name:  
> *The police files indicate that “Smith” is an alias for Simpson.*  
> &mdash; [dictionary.com](https://www.dictionary.com/browse/alias)  

---

Alias is an Elder Scrolls Online addon which allows you to create and save console commands which are aliases to other console commands, a simple idea with meaningful implications.

Alias can be used to:
- Shorten commonly used commands: `/alias add rui reloadui`
- Save commonly used command parameters: `/alias add ls loot show`
- Create entirely new commands: `/alias add test script d("Success!")`
- Alias client commands, commands added by other addons, even non-existent commands.
- Register and unregister game events.
 

Alias cannot be used to:
- Automatically send chat messages - *this is a limitation imposed by the game client*.
 

## Features:
- Aliases are saved account-wide, making them available to all characters.
- Aliases are restored each time you play.
- Aliases can be set to automatically execute on player load.
 

## Links:
- [Alias on Github](https://github.com/jeremy-rm/Alias) - Script source and examples are provided here.
- [Latest Release](https://github.com/jeremy-rm/Alias/releases/latest) - Direct link to the latest released version.
 

## Installation:
1. Download the latest release using the link above.
2. Place the contents of the newly downloaded archive into your ESO Addons folder.
3. Delete any previous versions of Alias from your ESO Addons folder.

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

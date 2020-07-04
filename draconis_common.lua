-- Defining common parametters and functions

if (default) then
    draconis.game_core = default
    draconis.sound_core = default
    draconis.game_core_prefix = "default"
    draconis.sound_core_prefix = "default"
    draconis.saddle_id = "mobs:saddle"
    draconis.mutton_raw_id = "mobs:mutton_raw"
    draconis.meat_raw_id = "mobs:meat_raw"
elseif (mcl_core) then
    draconis.game_core = mcl_core
    draconis.game_core_prefix = "mcl_core"
    draconis.sound_core = mcl_sounds
    draconis.sound_core_prefix = "mcl_sounds"
    draconis.saddle_id = mobs_mc.items.saddle
    draconis.mutton_raw_id = mobs_mc.items.mutton_raw
    draconis.meat_raw_id = mobs_mc.items.meat_raw
else
    -- Invalid scenario, mod will crash sonner or later
    draconis.game_core = {}
end

draconis.spawn_chance = 15000

draconis.get_translator = function()
    local S
    if mobs and mobs.intllib then
        S = mobs.intllib
    elseif mcl_mobs then
        S = minetest.get_translator("mcl_mobs")
    else
        -- Fallback implementation if everything else fails
        S = function(str)
            return str
        end
    end
    return S
end    

-- Fire Breathing

function fire_breath(pos)
    draconis.trace("invoked fire_breath")
	for i = pos.x - math.random(0, 1), pos.x + math.random(0, 1), 1 do
		for j = pos.y - 1, pos.y + 2, 1 do
			for k = pos.z - math.random(0, 1), pos.z + math.random(0, 1), 1 do
				local p = {x = i, y = j, z = k}
				local n = minetest.env:get_node(p).name
				if minetest.get_item_group(n, "unbreakable") == 1 or minetest.is_protected(p, "") then
				else
					minetest.set_node({x = i, y = j, z = k}, {name = "draconis:dragon_fire"})
				end
			end
		end
	end
end

-- Frost Breathing

function ice_tomb(pos)
    draconis.trace("invoked ice_tomb")
	for i = pos.x - math.random(0, 1), pos.x + math.random(0, 1), 1 do
		for j = pos.y - 1, pos.y + 2, 1 do
			for k = pos.z - math.random(0, 1), pos.z + math.random(0, 1), 1 do
				local p = {x = i, y = j, z = k}
				local n = minetest.env:get_node(p).name
				if minetest.get_item_group(n, "unbreakable") == 1 or minetest.is_protected(p, "") then
                else
                    local ice = draconis.game_core_prefix .. ":ice"
					minetest.set_node({x = i, y = j, z = k}, {name = ice})
				end
			end
		end
	end
end

draconis.trace = function (message)
    -- uncomment the line below for debugging 
    -- minetest.log("action", "[MOD] Draconis trace: " .. message)
end

draconis.animation_fly = {
    speed_normal = 10,
    speed_sprint = 20,
    stand_start = 140,
    stand_end = 160,
    walk_start = 110,
    walk_end = 130
}

draconis.animation_land = {
    speed_normal = 10,
    speed_sprint = 20,
    stand_start = 50,
    stand_end = 100,
    walk_start = 1,
    walk_end = 40
}

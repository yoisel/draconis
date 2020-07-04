local S = draconis.get_translator()

mobs:register_arrow(
	"draconis:wyvern_frost_breath",
	{
		visual = "sprite",
		visual_size = {x = 1, y = 1},
		textures = {"default_ice.png"},
		collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
		velocity = 7,
		tail = 1,
		tail_texture = "default_ice.png",
		tail_size = 10,
		glow = 5,
		expire = 0.1,
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups({immortal = 1, fleshy = 100})
		end,
		hit_player = function(self, player, pos)
			local pos = self.object:getpos()
			ice_tomb(pos)
			player:punch(
				self.object,
				1.0,
				{
					full_punch_interval = 1.0,
					damage_groups = {fleshy = 18}
				},
				nil
			)
		end,
		hit_mob = function(self, player, pos)
			local pos = self.object:getpos()
			ice_tomb(pos)
			minetest.set_node({x = 5, y = 5, z = 5}, {name = draconis.game_core_prefix .. ":ice"})
			player:punch(
				self.object,
				1.0,
				{
					full_punch_interval = 1.0,
					damage_groups = {fleshy = 18}
				},
				nil
			)
		end,
		-- node hit
		hit_node = function(self, pos, node)
			mobs:boom(self, pos, 1)
			ice_tomb(pos)
		end
	}
)

-- Ice Wyvern by ElCeejo

mobs:register_mob(
	"draconis:ice_wyvern",
	{
		type = "monster",
		hp_min = 394,
		hp_max = 394,
		armor = 75,
		passive = false,
		walk_velocity = 7,
		run_velocity = 9,
		walk_chance = 35,
		jump = false,
		jump_height = 1.1,
		stepheight = 1.5,
		fly = true,
		fly_in = "air",
		runaway = false,
		pushable = false,
		view_range = 30,
		knock_back = 0,
		damage = 24,
		fear_height = 6,
		fall_speed = -8,
		fall_damage = 20,
		water_damage = -32,
		lava_damage = 38,
		light_damage = 0,
		suffocation = false,
		floats = 1,
		reach = 5,
		attack_chance = 100,
		attack_animals = true,
		attack_npcs = true,
		attack_players = true,
		attacks_monsters = true,
		attack_type = "dogshoot",
		shoot_interval = 1,
		dogshoot_switch = 2,
		dogshoot_count = 0,
		dogshoot_count_max = 5,
		arrow = "draconis:wyvern_frost_breath",
		shoot_offset = 1,
		group_attack = true,
		pathfinding = 1,
		makes_footstep_sound = true,
		sounds = {
			random = "draconis_wyvern_random",
			shoot_attack = "draconis_wyvern_attack"
		},
		drops = {
			{name = draconis.meat_raw_id, chance = 1, min = 7, max = 10}
		},
		visual = "mesh",
		visual_size = {x = 20, y = 20},
		collisionbox = {-1.3, -1.0, -1.3, 1.3, 1.8, 1.3},
		textures = {
			{"draconis_ice_wyvern1.png"},
			{"draconis_ice_wyvern2.png"},
			{"draconis_ice_wyvern3.png"},
			{"draconis_ice_wyvern4.png"}
		},
		child_texture = {
			{"draconis_ice_wyvern1.png"},
			{"draconis_ice_wyvern2.png"},
			{"draconis_ice_wyvern3.png"},
			{"draconis_ice_wyvern4.png"}
		},
		mesh = "draconis_wyvern.b3d",
		animation = draconis.animation_fly
	}
)

mobs:register_egg("draconis:ice_wyvern", S("Ice Wyvern"), "draconis_frost_flame.png", 1)

--  Tamed Ice Wyvern by ElCeejo

mobs:register_mob(
	"draconis:hatched_ice_wyvern",
	{
		type = "npc",
		hp_min = 394,
		hp_max = 394,
		armor = 75,
		passive = false,
		walk_velocity = 3,
		run_velocity = 4,
		walk_chance = 50,
		jump = true,
		jump_height = 3,
		stepheight = 1,
		runaway = false,
		pushable = false,
		view_range = 26,
		knock_back = 0,
		damage = 28,
		fear_height = 0,
		fall_speed = -8,
		fall_damage = 0,
		water_damage = -32,
		lava_damage = 38,
		light_damage = 0,
		suffocation = false,
		floats = 0,
		owner = "",
		follow = {draconis.mutton_raw_id},
		reach = 10,
		attack_chance = 100,
		attack_animals = true,
		attack_npcs = true,
		attack_players = true,
		owner_loyal = true,
		group_attack = true,
		pathfinding = 1,
		makes_footstep_sound = true,
		sounds = {
			random = "draconis_ice_wyvern"
		},
		drops = {
			{name = draconis.meat_raw_id, chance = 1, min = 7, max = 10}
		},
		visual = "mesh",
		visual_size = {x = 20, y = 20},
		collisionbox = {-1.3, -1.0, -1.3, 1.3, 1.8, 1.3},
		textures = {
			{"draconis_ice_wyvern1.png"},
			{"draconis_ice_wyvern2.png"},
			{"draconis_ice_wyvern3.png"},
			{"draconis_ice_wyvern4.png"}
		},
		child_texture = {
			{"draconis_ice_wyvern1.png"},
			{"draconis_ice_wyvern2.png"},
			{"draconis_ice_wyvern3.png"},
			{"draconis_ice_wyvern4.png"}
		},
		mesh = "draconis_wyvern.b3d",
		animation = draconis.animation_land,
		do_custom = function(self, dtime, player)
			if not self.v2 then
				self.v2 = 0
				self.max_speed_forward = 8
				self.max_speed_reverse = 2
				self.accel = 10
				self.terrain_type = 3
				self.driver_attach_at = {x = 0, y = 1.22, z = 0.5}
				self.driver_eye_offset = {x = 0, y = 24, z = 0}
			end

			if not self.driver then
				self.animation = draconis.animation_land

				return true
			end

			if self.driver then
				mobs.drive(self, "walk", "stand", true, dtime)
				mobs.fly(self, dtime, 8, true, "draconis:wyvern_frost_breath", "walk", "stand")
				self.animation = draconis.animation_fly
				self.driver:set_properties({visual_size = {x = 0.05, y = 0.05}})

				return false -- skip rest of mob functions
			end

			return true
		end,
		on_die = function(self, pos)
			if self.driver then
				minetest.add_item(pos, draconis.saddle_id)
				mobs.detach(self.driver, {x = 1, y = 0, z = 1})
				self.saddle = nil
			end
		end,
		on_rightclick = function(self, clicker)
			if not clicker or not clicker:is_player() then
				return
			end

			if mobs:protect(self, clicker) then
				return
			end

			-- Babies can't be ridden, but can be imprinted

			if self.child and (clicker:get_wielded_item():get_name() == draconis.saddle_id) then
				mobs.detach(clicker, {x = 0, y = 0, z = 0})

				return true
			end

			if self.tamed == false then
				self.tamed = true
				self.owner = clicker:get_player_name()

				return false
			end

			-- Wyvern can be ordered with the Dragon Staff

			if self.owner == "" then
				self.owner = clicker:get_player_name()
			else
				if (clicker:get_wielded_item():get_name() == "draconis:dragon_staff") and self.order == "roam" then
					self.jump = false
					self.order = "sit"
					self.walk_chance = 0
					self.animation = animation_tamed
					mobs:set_animation(self, self.animation.stand)
				else
					self.jump = true
					self.order = "roam"
					self.walk_chance = 15
				end
			end

			if self.tamed and self.owner == clicker:get_player_name() then
				local inv = clicker:get_inventory()

				if self.driver and clicker == self.driver then
					mobs.detach(clicker, {x = 0, y = 2, z = 0})

					-- add saddle back to inventory
					if inv:room_for_item("main", draconis.saddle_id) then
						inv:add_item("main", draconis.saddle_id)
					else
						minetest.add_item(clicker:get_pos(), draconis.saddle_id)
					end

					self.saddle = nil
				elseif (not self.driver and clicker:get_wielded_item():get_name() == draconis.saddle_id) or self.saddle then
					self.object:set_properties({stepheight = 1.1})
					mobs.attach(self, clicker)

					if not self.saddle then
						inv:remove_item("main", draconis.saddle_id)
					end

					self.saddle = true
				end
			end

			mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
		end
	}
)

mobs:register_egg("draconis:hatched_ice_wyvern", S("Tame Ice Wyvern"), "draconis_frost_flame.png", 1, true)

-- Ice Wyvern Egg by ElCeejo

minetest.register_node(
	"draconis:ice_wyvern_egg",
	{
		description = "Ice Wyvern Egg",
		tiles = {"draconis_ice_wyvern_nest.png"},
		inventory_image = "draconis_ice_egg.png",
		wield_image = "draconis_ice_egg.png",
		drawtype = "mesh",
		mesh = "draconis_large_egg.obj",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, -0.1875, 0.1875, 0.0625, 0.25}
			}
		},
		is_ground_content = false,
		paramtype2 = "facedir",
		groups = {snappy = 2},
		sounds = draconis.sound_core.node_sound_stone_defaults(),
		drop = "draconis:ice_wyvern_egg",
		on_construct = function(pos)
			local pos_under = {
				x = pos.x,
				y = pos.y - 1,
				z = pos.z
			}

			local nest = minetest.get_node_or_nil(pos_under)

			if nest.name == "draconis:cold_ice" then
				minetest.get_node_timer(pos):start(math.min(10), math.max(10))
				return
			end
		end,
		on_timer = function(pos)
			mob = minetest.add_entity(pos, "draconis:hatched_ice_wyvern")
			ent2 = mob:get_luaentity()
			minetest.remove_node(pos)

			mob:set_properties(
				{
					textures = ent2.child_texture[1],
					visual_size = {
						x = ent2.base_size.x / 5,
						y = ent2.base_size.y / 5
					},
					collisionbox = {
						ent2.base_colbox[1] / 5,
						ent2.base_colbox[2] / 5,
						ent2.base_colbox[3] / 5,
						ent2.base_colbox[4] / 5,
						ent2.base_colbox[5] / 5,
						ent2.base_colbox[6] / 5
					}
				}
			)

			ent2.child = true
			ent2.tamed = false
		end
	}
)

mobs:spawn(
	{
		name = "draconis:ice_wyvern",
		nodes = draconis.game_core_prefix .. ":ice",
		neighbours = "air",
		min_light = 14,
		interval = 100,
		chance = draconis.spawn_chance,
		min_height = 80,
		max_height = 200,
		day_toggle = true
	}
)

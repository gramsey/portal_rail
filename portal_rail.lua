
local S = minetest.get_translator("portal_rail")

local function portal_on_step(cart, dtime)
	minetest.debug("cart dir".. dump(cart.old_dir))
	minetest.debug("dtime ".. dump(dtime))

	local jump = minetest.settings:get("portal_rail_jump_distance") or 500
	local jmp_pos = table.copy(cart.old_pos)

	if cart.old_dir.y == -1  then
		jmp_pos.y = jmp_pos.y - jump
	elseif cart.old_dir.y == 1 then
		jmp_pos.y = jmp_pos.y + jump
	elseif cart.old_dir.x == -1  then
		jmp_pos.x = jmp_pos.x - jump
	elseif cart.old_dir.x == 1 then
		jmp_pos.x = jmp_pos.x + jump
	elseif cart.old_dir.z == -1  then
		jmp_pos.z = jmp_pos.z - jump
	elseif cart.old_dir.z == 1 then
		jmp_pos.z = jmp_pos.z + jump
	end

	local node = minetest.get_node(jmp_pos)
	local target_rail = minetest.get_item_group(node.name, "rail") 
	minetest.debug("target is rail ".. target_rail)
	if target_rail == 0 then return end

	minetest.sound_play("portal_rail_pop", old_pos, true)

	cart.old_pos = jmp_pos
	minetest.sound_play("portal_rail_pop", jmp_pos, true)
end

carts:register_rail("portal_rail:rail", {
	description = S("Portal Rail"),
	tiles = {
		"portal_rail_straight.png", "portal_rail_curved.png",
		"portal_rail_t_junction.png", "portal_rail_crossing.png"
	},
	groups = carts:get_rail_groups(),
}, { on_step = portal_on_step })

-- minetest.register_craft({
-- 	output = "carts:powerrail 18",
-- 	recipe = {
-- 		{"iron:ingot", "group:wood", "iron:ingot"},
-- 		{"iron:ingot", "mese:crystal", "iron:ingot"},
-- 		{"iron:ingot", "group:wood", "iron:ingot"},
-- 	}
-- })

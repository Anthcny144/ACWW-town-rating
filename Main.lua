dofile "./Scripts/Game.lua"
dofile "./Scripts/Player.lua"
dofile "./Scripts/Map.lua"
dofile "./Scripts/Acre.lua"
dofile "./Scripts/Tile.lua"
dofile "./Scripts/Debug.lua"

function main()
    if not Player:is_in_map() then return end
    Debug:run()

    local input = joypad.read()

    -- Show current acre info
    Map:draw_acre_in()

    -- Draw acres on minimap
    if Game:is_minimap_menu() and input.start then
        Map:draw_acres()
    end
end

if Game:get_idx() ~= -1 then
    gui.register(main)
else
    print("ERROR: Game / version not supported, EUR is the only version supported yet")
end

-- TODO:
-- bizhawk compatibility
-- test how flower and/or trees compensate weeds and/or dropped items
-- debug mode to put specific things in acres
-- add addr for other versions (usa 1.0, usa 1.1, jpn 1.0, jpn 1.1)
-- (bug) don't draw acres when hold start after minimap closed

-- global texts showing:
--     - how perfect town rating works
--     - how many total bad / ok / perfect acres
--     - overall town rating
--     - for single acre: what to do to make it perfect

-- show acre data when hovering minimap acre

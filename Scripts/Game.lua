Game = {
    addr = {
        game_code = 0x23FFA8C,
        game_ver = 0x23FFA9E,

        player_ptr = {0x21D3F04},
        acres = {0x21E6D4C},
        burried = {0x21E8D4C}, -- following acres
        menu = {0x20DEAE1}
    },

    data = {
        world = {
            x_start = 0x21000,
            z_start = 0x21000,
            tile_size = 0x2000,
        },
        map = {
            acres_per_row = 4
        },
        acre = {
            tiles_per_row = 16,
            sizeof = 16 * 16 * 2
        },
        tile = {
            sizeof = 2
        }
    }
}

function Game:get_idx()
    local code = memory.readdword(Game.addr.game_code)
    local ver = memory.readbyte(Game.addr.game_ver)

    if code == 0x504D4441 and ver == 0 then -- ADMP 0 -> EUR (1.0)
        return 1
    end

    return -1
end

function Game:is_minimap_menu()
    return memory.readbyte(Game.addr.menu[Game:get_idx()]) == 7
end
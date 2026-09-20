Player = {}

function Player:get()
    local idx = Game:get_idx()
    local ptr = Game.addr.player_ptr[idx]
    local player = memory.readdword(ptr)

    if player >= 0x2000000 and player < 0x3000000 then
        return player
    else
        return nil
    end
end

function Player:exists()
    return Player:get() ~= nil
end

function Player:is_in_map()
    if not Player:exists() then
        return false
    end

    local pos = Player:get_tiles()
    return pos.x >= 0 and pos.x < 64 and pos.y >= 0 and pos.y < 64
end

function Player:get_coords()
    local player = Player:get()
    local x = 0
    local y = 0
    local z = 0

    if player ~= nil then 
        x = memory.readdword(player + 0x5C)
        y = memory.readdword(player + 0x60)
        z = memory.readdword(player + 0x64)
    end

    return {
        x = x,
        y = y,
        z = z
    }
end

function Player:get_tiles()
    local coords = Player:get_coords()

    return {
        x = math.floor((coords.x - Game.data.world.x_start) / Game.data.world.tile_size + 0.5),
        y = math.floor((coords.z - Game.data.world.z_start) / Game.data.world.tile_size + 0.5)
    }
end

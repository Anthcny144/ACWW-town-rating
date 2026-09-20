Tile = {}

function Tile:is_burried(tile)
    local game_idx = Game:get_idx()
    local acres_addr = Game.addr.acres[game_idx]
    local burried_addr = Game.addr.burried[game_idx]

    local tile_idx = (tile - acres_addr) / Game.data.tile.sizeof

    local burried_addr = burried_addr + math.floor(tile_idx / 8)
    local burried_bit = tile_idx % 8

    return bit.band(bit.rshift(memory.readbyte(burried_addr), burried_bit), 1) == 1
end

function Tile:is_flower(tile)
    local is_rafflesia = tile == 0x1B or tile == 0x89
    local is_dandeltion_puffs = tile == 0x1E
    local is_normal = tile >= 0 and tile <= 0x1E
    local is_withered = tile >= 0x6E and tile <= 0x88
    local is_watered = tile >= 0x8A and tile <= 0xA4
    return (not is_rafflesia) and (not is_dandeltion_puffs) and (is_normal or is_withered or is_watered)
end

function Tile:is_weed(tile)
    -- Clovers (0x1F and 0x20) and dandelion puffs (0x1E) don't count as weeds
    return tile >= 0x21 and tile <= 0x24
end

function Tile:is_tree(tile)
    local is_tree = (tile >= 0x25 and tile <= 0x5B) or (tile >= 0x66 and tile <= 0x69)
    local is_cedar = (tile >= 0x5C and tile <= 0x65) or (tile >= 0x6A and tile <= 0x6D)
    local is_palm = tile >= 0xC8 and tile <= 0xCF
    return is_tree or is_cedar or is_palm
end

function Tile:is_item(tile)
    local is_fruit = (tile >= 0x1518 and tile <= 0x151C) or tile == 0x1548
    local is_seashell = tile >= 0x1554 and tile <= 0x155C -- Scallops don't spawn naturally, maybe they don't count as sea shells?
    local is_acorn = tile >= 0x1542 and tile <= 0x1546

    local is_empty = tile == 0xFFF1 or tile == 0xF030
    local is_nature = tile >= 0 and tile <= 0x102
    local is_building = tile >= 0x5000 and tile <= 0x501F -- Unused?: 0x501B 0x501D 0x501F (crash)
    local is_snowman = tile >= 0xB001 and tile <= 0xB003

    return (not is_empty) and (not is_fruit) and (not is_seashell) and (not is_acorn) and (not is_nature) and (not is_building) and (not is_snowman)
end
Acre = {
    rating = {
        BAD = 1,
        OK = 2,
        PERFECT = 3
    },
    names = {
        "UNACCEPTABLE",
        "ACCEPTABLE",
        "PERFECT"
    },
    colors = {
        "red",
        "#FFA600",
        "green"
    }
}

function Acre:get_rating(acre)
    -- Main source: https://www.thonky.com/acww/perfect-town-guide

    local data = Acre:get_data(acre)

    -- BAD: 3+ weeds OR 3+ items
    -- TODO THIS IS NOT TRUE, weeds / items are compensated by trees / flowers
    if data.items >= 3 or data.weeds >= 3 then
        return Acre.rating.BAD
    end

    -- PERFECT: If valid amount of trees, check for minimum of 3 flowers
    if (data.trees >= 12 and data.trees <= 15) and data.flowers >= 3 then
        return Acre.rating.PERFECT
    end

    -- PERFECT: "For each number of trees fewer than 12 or more than 15, add two more flowers to make it perfect"
    local perfect_flower_shift = math.max(0, 12 - data.trees) + math.max(0, data.trees - 15)
    local perfect_flower_requirement = 3 + perfect_flower_shift * 2
    if data.flowers >= perfect_flower_requirement then
        return Acre.rating.PERFECT
    end

    -- OK: " If you have 10, [...], or 17 trees in the acre, you do not need any flowers in it to make it acceptable"
    if data.trees >= 10 and data.trees <= 17 then
        return Acre.rating.OK
    end

    -- OK: "Nine trees in an acre, or 18 trees in an acre, will need 3 flowers to make it acceptable"
    --     "For each number of trees fewer than nine or greater than 18, add two more flowers."
    local ok_flower_shift = math.max(0, 9 - data.trees) + math.max(0, data.trees - 18)
    local ok_flower_requirement = 3 + ok_flower_shift * 2
    if data.flowers >= ok_flower_requirement then
        return Acre.rating.OK
    end

    return Acre.rating.BAD
end

function Acre:get_data(acre)
    local data = {
        trees = 0,
        flowers = 0,
        weeds = 0,
        items = 0
    }

    for y = 0, Game.data.acre.tiles_per_row - 1 do
        for x = 0, Game.data.acre.tiles_per_row - 1 do
            local offset_x = x * Game.data.tile.sizeof
            local offset_y = y * Game.data.acre.tiles_per_row * Game.data.tile.sizeof
            
            local tile = memory.readword(acre + offset_x + offset_y)

            if Tile:is_tree(tile) then
                data.trees = data.trees + 1
            elseif Tile:is_flower(tile) then
                data.flowers = data.flowers + 1
            elseif Tile:is_weed(tile) then
                data.weeds = data.weeds + 1
            elseif Tile:is_item(tile) and not Tile:is_burried(acre + offset_x + offset_y) then
                data.items = data.items + 1
            end
        end
    end

    return data
end

function Acre:draw(acre, idx)
    local x1 = 25 + (idx % Game.data.map.acres_per_row) * Game.data.acre.tiles_per_row * 2 - 1
    local x2 = x1 + Game.data.acre.tiles_per_row * 2 - 1
    local y1 = 49 + math.floor(idx / Game.data.map.acres_per_row) * Game.data.acre.tiles_per_row * 2 - 1
    local y2 = y1 + Game.data.acre.tiles_per_row * 2 - 1
    gui.rect(x1, y1, x2, y2, "#00000000", Acre:get_rating_color(acre))
end

function Acre:get_rating_color(acre)
    return Acre.colors[Acre:get_rating(acre)]
end
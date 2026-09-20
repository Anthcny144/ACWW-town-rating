Map = {
    draw_pad = {x = 5, y = -191 + 6}
}

function Map:get_acres()
    local acres = {}

    for i = 0, Game.data.acre.tiles_per_row - 1 do
        local acre = Game.addr.acres[Game:get_idx()] + i * Game.data.acre.sizeof
        table.insert(acres, acre)
    end

    return acres
end

function Map:get_acre_at(x, y)
    local acre_x = math.floor(x / Game.data.acre.tiles_per_row)
    local acre_y = math.floor(y / Game.data.acre.tiles_per_row)
    local acre_idx = acre_y * Game.data.map.acres_per_row + acre_x

    return Game.addr.acres[Game:get_idx()] + acre_idx * Game.data.acre.sizeof
end

function Map:draw_acres()
    local acres = Map:get_acres()
    for i = 0, 15 do
        local acre = acres[i + 1]
        Acre:draw(acre, i)
    end
end

function Map:draw_acre_in()
    if not Player:is_in_map() then
        return
    end

    -- Data
    local pos = Player:get_tiles()
    local acre_in = Map:get_acre_at(pos.x, pos.y)
    local data = Acre:get_data(acre_in)
    local rating = Acre:get_rating(acre_in)
    local acre_color = Acre:get_rating_color(acre_in)

    local x_idx = math.floor(pos.x / Game.data.acre.tiles_per_row) + 1
    local y_idx = math.floor(pos.y / Game.data.acre.tiles_per_row) + 1
    local letter = ({"A", "B", "C", "D"})[x_idx]
    local number = tostring(y_idx)

    -- Tile
    gui.text(Map.draw_pad.x, Map.draw_pad.y, "Tile X: ", "#009BFF")
    gui.text(Map.draw_pad.x + 56, Map.draw_pad.y, tostring(pos.x))
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 10, "Tile Y: ", "#009BFF")
    gui.text(Map.draw_pad.x + 56, Map.draw_pad.y + 10, tostring(pos.y))

    -- Acre name
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 30, "Acre: ", "#009BFF")
    gui.text(Map.draw_pad.x + 56, Map.draw_pad.y + 30, letter .. number)

    -- Acre values
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 40, "Trees:", "green")
    gui.text(Map.draw_pad.x + 56, Map.draw_pad.y + 40, data.trees)
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 50, "Flowers:", "#FF80ED")
    gui.text(Map.draw_pad.x + 56, Map.draw_pad.y + 50, data.flowers)
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 60, "Items:", "orange")
    gui.text(Map.draw_pad.x + 56, Map.draw_pad.y + 60, data.items)
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 70, "Weeds:", "#5B7F00")
    gui.text(Map.draw_pad.x + 56, Map.draw_pad.y + 70, data.weeds)

    -- Rating
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 90, "Acre rating:")
    gui.text(Map.draw_pad.x, Map.draw_pad.y + 100, Acre.names[rating], acre_color)
end
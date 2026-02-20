--[[
    This is a remake of BYTEPATH, a 2D arcade shooter built using Lua and LOVE2D
    with a massive skill tree, many classes and ships

    I'm following the tutorial made by the creator behind BYTEPATH 
    at https://github.com/a327ex/blog/issues/30

    I'm hoping to ofcourse put my own spin on the game alongside learning the
    fundamentals of creating a 2D game using LOVE and Lua.

    Libraries:
        - rxi (simple Object Oriented Programming for LOVE) 
        - Input (input handler library)
        - hump (small collection of tools for developing games with LÖVE)
        [we're importing hump specifically for its timer]
]]--

Object = require 'libraries/classic/classic'
Input = require 'libraries/Input'
Timer = require 'libraries/hump/EnhancedTimer'

--[[
    recursiveEnumerate(folder, file_list) takes a [folder] name and a lua table [file_list]
    and scans all the lua files in that directory recursively and append the
    relative path to the [file_list] table.
]]--
function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.getInfo(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

--[[
    requireFiles(files) takes a table [files] filled with relative path to lua files
    (often libraries or objects) and require them so we don't have to manually
    what is NOT guaranteed however is the dependencies for OOP objects 
    because recursiveEnumeration require files alphabetically so we can't assure that
    certain objects which inherit off of other objects will be imported correctly

    In the situation where there are OOP Inheritance objects, import them manually 
    using require.
]]--
function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        local last_forward_slash_index = file:find("/[^/]*$")
        local class_name = file:sub(last_forward_slash_index+1, #file)
        _G[class_name] = require(file)
    end
end

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    input = Input()
    timer = Timer()

    rect_1 = {x = 400, y = 300, w = 50, h = 200}
    rect_2 = {x = 400, y = 300, w = 200, h = 50}
end

function love.update(dt)
    timer:update(dt)
end

function love.draw()
    love.graphics.rectangle('fill', rect_1.x - rect_1.w/2, rect_1.y - rect_1.h/2, rect_1.w, rect_1.h)
    love.graphics.rectangle('fill', rect_2.x - rect_2.w/2, rect_2.y - rect_2.h/2, rect_2.w, rect_2.h)
end

function love.keypressed(key)

end

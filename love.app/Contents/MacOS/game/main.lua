Object = require 'libraries/classic/classic'
Input = require 'libraries/Input'

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

--[[]
    requireFiles(files) takes a table [files] filled with relative path to lua files
    (often libraries or objects)
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
    input:bind('mouse1', 'test')

    hypecircle = HyperCircle(400, 300, 50, 10, 120)
end

function love.update(dt)
    hypecircle:update(dt)
end

function love.draw()
    hypecircle:draw()
end

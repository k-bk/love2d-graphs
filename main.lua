local v2 = require "v2"
local graph = require "graph"

function rand_double(min, max)
   return love.math.random() * (max-min) + min
end
function int(num) return math.floor(num) end

function love.load()
   points = {}
   points.color = { 1,0,0 } 

   for _ = 0,5000 do
      local deg = love.math.random() * 2 * math.pi
      table.insert(points, v2(100 * math.cos(deg), 100 * math.sin(deg)))
   end
end

function love.update(dt)
end

function love.draw()
   graph.graph(points)
end

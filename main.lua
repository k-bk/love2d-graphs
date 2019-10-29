local v2 = require "v2"
local graph = require "graph"


function love.load()
   love.graphics.setBackgroundColor({ 1,1,1 })

   points = {}
   points.color = { 1,0,0 } 

   for _ = 0,5000 do
      local deg = love.math.random() * 2 * math.pi
      table.insert(points, v2(100 * math.cos(deg), 100 * math.sin(deg)))
   end
end

function love.draw()
   graph.graph(points)
end

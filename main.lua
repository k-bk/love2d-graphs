local v2 = require "v2"
local graph = require "graph"


function love.load()
   love.graphics.setBackgroundColor({ 1,1,1 })

   points = { color = { 1,0,0 }, title = "Random points on ellipse" }

   for _ = 0,5000 do
      local deg = love.math.random() * 2 * math.pi
      table.insert(points, v2(1e-3 * math.cos(deg), 355 * math.sin(deg)))
   end
end

function love.draw()
   graph.graph(points)
end

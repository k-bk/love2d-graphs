local g = {}

g.GAP = 30  -- how much space do I need between labels
g.DIVISOR = 10  -- the height of axis divisor
g.FONT = love.graphics.getFont()
g.F_HEIGHT = g.FONT:getHeight() / 2
g.PAD = { left = 60, right = 30, top = 60, bottom = 60 }
g.COLOR = {  -- for now, color setup is here
   bg = function () love.graphics.setColor(1,1,1) end,
   fg = function () love.graphics.setColor(0,0,0) end
}

function g.labels(min, max, how_many)
   -- find nice, round labels for axis, eg. for <-53.23, 114.10>
   -- it should be: [ -60 -20 0 20 40 60 80 100 120 ]
   local len = max - min
   local step = 10 ^ math.ceil(math.log10(len))
   while (len / step) < how_many do
      if 5 * (len / step) < how_many then step = step / 5 end 
      if 2 * (len / step) < how_many then step = step / 2 else break end
   end
   local unit = 10 ^ math.floor(math.log10(step))

   -- find nearest, smaller round number to start counting from
   local _min = math.floor(min / unit) * unit

   result = {}
   for x = _min, max+unit, step do
      if math.abs(x) < 1e-5 then x = 0 end
      table.insert(result, ("%g"):format(x))
   end
   return result
end

function g.xaxis(min, max, from, to, y_pos)
   local how_many = math.floor((to - from) / g.GAP)
   local labels = g.labels(min, max, how_many)
   local gap = (to - from) / (#labels - 1)

   -- calculate rotation of the text if it doesn't fit
   local w = g.FONT:getWidth(labels[1].."   ")
   if w > gap then r = math.acos(gap / w) else r = 0 end
   text_y_pos = math.floor(y_pos + g.F_HEIGHT * (1/2 + 1/math.cos(r)))

   for i = 1,#labels do
      x_pos = from + (i-1) * gap
      love.graphics.line(x_pos, y_pos, x_pos, y_pos - g.DIVISOR)
      love.graphics.printf(labels[i], x_pos, text_y_pos, 200, "center", -r, 1, 1, 100)
   end
end

function g.yaxis(min, max, from, to, x_pos)
   local how_many = math.floor((to - from) / g.GAP)
   local labels = g.labels(min, max, how_many)
   local gap = (to - from) / (#labels - 1)
   for i = 1,#labels do
      y_pos = to - (i-1) * gap
      love.graphics.line(x_pos, y_pos, x_pos + g.DIVISOR, y_pos)
      love.graphics.printf(labels[i], x_pos - 100 - g.F_HEIGHT, y_pos - g.F_HEIGHT, 100, "right")
   end
end

function g.graph(points)
   local w,h = love.graphics.getDimensions() 
   local pad = g.PAD
   local w_in = w - pad.left - pad.right
   local h_in = h - pad.top - pad.bottom 

   -- find rectangle that covers all points
   local max,min = {-math.huge,-math.huge},{math.huge,math.huge}
   for _,p in ipairs(points) do
      max[1] = math.max(p[1],max[1])
      max[2] = math.max(p[2],max[2])
      min[1] = math.min(p[1],min[1])
      min[2] = math.min(p[2],min[2])
   end
   -- leave some margin for values
   xrange = max[1] - min[1]
   yrange = max[2] - min[2]
   min[1] = min[1] - xrange * 0.1
   max[1] = max[1] + xrange * 0.1
   min[2] = min[2] - yrange * 0.1
   max[2] = max[2] + yrange * 0.1

   -- scale points to screen size
   local _points = {}
   for _,p in ipairs(points) do
      _p = {}
      _p[1] = pad.left + (p[1] - min[1]) / (max[1] - min[1]) * w_in
      _p[2] = h - pad.bottom - (p[2] - min[2]) / (max[2] - min[2]) * h_in
      table.insert(_points, _p[1])
      table.insert(_points, _p[2])
   end

   -- draw the graph
   g.COLOR.bg()
   love.graphics.rectangle("fill",0,0,w,h)
   g.COLOR.fg()
   love.graphics.rectangle("line",pad.left,pad.top,w_in,h_in)
   g.xaxis(min[1], max[1], pad.left, w - pad.right, h - pad.bottom)
   g.yaxis(min[2], max[2], pad.top, h - pad.bottom, pad.left)
   love.graphics.setColor(points.color or {0,0,0})
   love.graphics.points(_points)
end

return g

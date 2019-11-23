local v2 = {}

do 
   local v = {}
   v.__index = function (vec, key)
      if key == "x" then return vec[1] end
      if key == "y" then return vec[2] end
      return v[key]
   end
   v.__newindex = function (vec, key, value)
      if key == "x" then vec[1] = value end
      if key == "y" then vec[2] = value end
   end

   
   function v.__add(v,u) return v2(v[1]+u[1], v[2]+u[2]) end
   function v.__sub(v,u) return v2(v[1]-u[1], v[2]-u[2]) end
   function v.__mul(a,v) return v2(a * v[1], a * v[2]) end
   function v.__eq(v,u) return v[1]==u[1] and v[2]==u[2] end
   function v.__tostring(v) return ("<%g, %g>"):format(v[1], v[2]) end
   function v.__concat(s,v) return tostring(s)..tostring(v) end
   function v.len(v) return math.sqrt(v[1]*v[1] + v[2]*v[2]) end
   function v.dot(v,u) return v[1]*u[1] + v[2]*u[2] end

   setmetatable(v2, { 
      __call = function (_,i,j) 
         return setmetatable({ i,j }, v)
      end })
end

function v2.test()
   local tests = {
      v2(1,3)[1] == 1,
      v2(1,3)[2] == 3,
      v2(1,-1) + v2(1,2) == v2(2,1),
      3 * v2(2,-5) == v2(6,-15)
   }
   for num,t in ipairs(tests) do
      res = t and "passed" or "failed"
      print("Test "..num.." "..res)
   end
end

return v2

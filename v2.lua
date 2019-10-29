local v2 = {}

do 
   local v = {}
   v.__index = v
   
   function v.__add(v,u) return v2(v[1]+u[1], v[2]+u[2]) end
   function v.__sub(v,u) return v2(v[1]-u[1], v[2]-u[2]) end
   function v.__eq(v,u) return v[1]==u[1] and v[2]==u[2] end
   function v.__tostring(v) return ("<%g, %g>"):format(v[1], v[2]) end

   setmetatable(v2, { 
      __call = function (_,i,j) 
         return setmetatable({ i,j }, v)
      end })
end

function v2.test()
   local tests = {
      v2(1,3)[1] == 1,
      v2(1,3)[2] == 3,
      v2(1,-1) + v2(1,2) == v2(2,1)
   }
   for num,t in ipairs(tests) do
      res = t and "passed" or "failed"
      print("Test "..num.." "..res)
   end
end

return v2

-- ColorChanger v1.3 by Smurfier (smurfier20@gmail.com)
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

-- PROPERTIES={Colors='';MeasureName='';MinimumValue=0;MaximumValue=1;}

function Update()
   MinValue,MaxValue,Colors,ColorsString,Measure=SELF:GetNumberOption("MinimumValue", 0),SELF:GetNumberOption("MaximumValue", 1),{},SKIN:ReplaceVariables(SELF:GetOption("Colors")),SKIN:GetMeasure(SELF:GetOption("MeasureName"))
   print(ColorsString)
   for a=1,4 do Colors[a]={} end
   if string.len(ColorsString)==0 or not string.match(ColorsString,'%d+%s-,%s-%d+%s-,%s-%d+') then
      print('ColorChanger: Invalid color string')
   elseif not Measure then
      print('ColorChanger: Cannot retrieve Measure '..Measure)
   else
      for a in string.gmatch(ColorsString,'[^%|]+') do
         local b={}
         for c in string.gmatch(a,'[^,]+') do table.insert(b,tonumber(c)) end
         for d=1,4 do table.insert(Colors[d],b[d] and b[d] or 255) end
      end
      Divider=math.ceil((MaxValue-MinValue)/(#Colors[1]-1))
   end
end

function Update()
   if #Colors[1]<2 or not Measure then
      return #Colors[1]==1 and string.gsub(ColorsString,'|','') or '255,255,255,255'
   else
      local rValue,uColor=Measure:GetValue()-MinValue,{}
      Num=math.floor(rValue/Divider)
      for i=1,4 do table.insert(uColor,Average(Colors[i][Num+1],Colors[i][Num+2],rValue%Divider,Divider)) end
      return table.concat(uColor,',')
   end
end

function Average(a,b,c,d) return (a*(d-c)+(b and b or 0)*c)/d end
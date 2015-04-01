-- ColorChanger v1.3 by Smurfier (smurfier20@gmail.com); Modified
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

function Initialize() Colors,MinValue,MaxValue,Measure={},SKIN:ParseFormula(SELF:GetOption("MinimumValue", 0)),SKIN:ParseFormula(SELF:GetOption("MaximumValue", 1)),SKIN:GetMeasure(SELF:GetOption("MeasureName")) end

function Update()
	local ColorsStr=SKIN:ReplaceVariables(SELF:GetOption("Colors"))
	for a=1,4 do Colors[a]={} end
	for a in string.gmatch(ColorsStr,'[^%|]+') do
		local b={}
		for c in string.gmatch(a,'[^,]+') do table.insert(b,tonumber(c)) end
		for d=1,4 do table.insert(Colors[d],b[d] and b[d] or 255) end
	end
	
	local rValue,Divider,uColor=Measure:GetValue()-MinValue,math.ceil((MaxValue-MinValue)/(#Colors[1]-1)),{}
	local Num=math.floor(rValue/Divider)
	for i=1,4 do table.insert(uColor,Average(Colors[i][Num+1],Colors[i][Num+2],rValue%Divider,Divider)) end
	return table.concat(uColor,',')
end

function Average(a,b,c,d) return (a*(d-c)+(b and b or 0)*c)/d end
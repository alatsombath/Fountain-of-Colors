-- ColorChanger v1.3 by Smurfier (smurfier20@gmail.com); Modified
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

function Initialize()
	local SKIN,SELF=SKIN,SELF
	MinValue=SKIN:ParseFormula(SELF:GetOption("MinimumValue",0))
	MaxMin,ColorsTable,Var,Output=(SKIN:ParseFormula(SELF:GetOption("MaximumValue",1))-MinValue),{},{},SELF:GetOption("Output")
	Measure,Meter,Option=SELF:GetOption("MeasureName"),SELF:GetOption("MeterName"),SELF:GetOption("MeterOption")
	Sub,Index,Limit=SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit"))
	find,gmatch,gsub,ceil,floor,concat=string.find,string.gmatch,string.gsub,math.ceil,math.floor,table.concat
	
	if Output ~= "" then local Output,ColorsTable,Var=Output,ColorsTable,Var for i=1,Output do ColorsTable[i],Var[i]="Colors"..i,"VarName"..i end end
end

function Update()
	local MinValue,MaxMin,ColorsTable,Var,Output,Measure,Meter,Option,Sub,Index,Limit=MinValue,MaxMin,ColorsTable,Var,Output,Measure,Meter,Option,Sub,Index,Limit
	local SKIN,SELF,find,gmatch,gsub,ceil,floor,concat=SKIN,SELF,find,gmatch,gsub,ceil,floor,concat
	
	local function Check(ColorsStr)
		local MinValue,MaxMin,Var,Measure,Meter,Option,Sub=MinValue,MaxMin,Var,Measure,Meter,Option,Sub
		local SKIN,SELF,find,gmatch,gsub,ceil,floor,concat=SKIN,SELF,find,gmatch,gsub,ceil,floor,concat
		
		local function Main(ColorsStr, i, j)
			local MinValue,MaxMin,ceil,floor,concat=MinValue,MaxMin,ceil,floor,concat
			
			local function Calculate(MeasureValue, Colors)
				local function Average(a,b,c,d) return (a*(d-c)+(b and b or 0)*c)/d end

				local uColor,rValue,Divider={},MeasureValue-MinValue,ceil(MaxMin/(#Colors[1]-1))
				local Num=floor(rValue/Divider)
				for i=1,4 do uColor[i]=Average(Colors[i][Num+1],Colors[i][Num+2],rValue%Divider,Divider) end
				return concat(uColor,',')
			end
			
			local gmatch,Colors,f=gmatch,{},0
			for a=1,4 do Colors[a]={} end
			for a in gmatch(ColorsStr,"[^%|]+") do
				local b,e={},0 f=f+1
				for c in gmatch(a,"[^,]+") do e=e+1 b[e]=c end
				for d=1,4 do Colors[d][f]=b[d] and b[d] or 255 end
			end
			
			if i ~= -1 then
				local gsub=gsub
				if Meter ~= "" then SKIN:Bang("!SetOption", (gsub(Meter,Sub, i)), Option, Calculate(SKIN:GetMeasure((gsub(Measure,Sub,i))):GetValue(), Colors))
				else SKIN:Bang("!SetVariable", (gsub(SELF:GetOption(Var[j]),Sub,i)), Calculate(i, Colors)) end
			else SKIN:Bang("!SetVariable", SELF:GetOption(Var[j]), Calculate(SKIN:GetMeasure(Measure):GetValue(), Colors)) end
		end
	
		if Sub ~= "" then
			if find(ColorsStr,Sub) ~= nil then local Index,Limit=Index,Limit for i=Index,Limit do Main(SKIN:ReplaceVariables((gsub(ColorsStr,Sub,i))), i, j) end
			else local Index,Limit=Index,Limit for i=Index,Limit do Main(ColorsStr, i, j) end end
		else Main(ColorsStr, -1, j) end
	end

	if Output ~= "" then for j=1,Output do Check(SKIN:ReplaceVariables(SELF:GetOption(ColorsTable[j]))) end else Check(SKIN:ReplaceVariables(SELF:GetOption("Colors"))) end
end
-- ColorChanger v1.3 by Smurfier (smurfier20@gmail.com); Modified
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

function Initialize()
	MinValue,MaxValue=SKIN:ParseFormula(SELF:GetOption("MinimumValue",0)),SKIN:ParseFormula(SELF:GetOption("MaximumValue",1))
	ColorsTable,Var,Output,Measure,Meter,Option={},{},SELF:GetOption("Output"),SELF:GetOption("MeasureName"),SELF:GetOption("MeterName"),SELF:GetOption("MeterOption")
	Sub,Index,Limit=SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit"))
	
	if Output ~= "" then for i=1,Output do ColorsTable[i],Var[i]="Colors"..i,"VarName"..i end
	else ColorsTable[1],Var[1]="Colors","VarName" end
end

function Update() if Output ~= "" then for j=1,Output do Check(j) end else Check(1) end end

function Check(j)
	local ColorsStr=SKIN:ReplaceVariables(SELF:GetOption(ColorsTable[j]))
	if Sub ~= "" then
		if ColorsStr:find(Sub) ~= nil then for i=Index,Limit do Main(SKIN:ReplaceVariables((ColorsStr:gsub(Sub, i))), 0, i, j) end
		else for i=Index,Limit do Main(ColorsStr, 0, i, j) end end	
	else Main(ColorsStr, SKIN:GetMeasure(Measure):GetValue(), -1, j) end
end

function Main(ColorsStr, m, i, j)
	local Colors={}
	for a=1,4 do Colors[a]={} end
	for a in string.gmatch(ColorsStr,'[^%|]+') do
		local b={}
		for c in string.gmatch(a,'[^,]+') do table.insert(b,tonumber(c)) end
		for d=1,4 do table.insert(Colors[d],b[d] and b[d] or 255) end
	end
	
	if i ~= -1 then
		if Meter ~= "" then SKIN:Bang("!SetOption", (Meter:gsub(Sub, i)), Option, Calculate(SKIN:GetMeasure((Measure:gsub(Sub, i))):GetValue(), Colors))
		else SKIN:Bang("!SetVariable", (SELF:GetOption(Var[j]):gsub(Sub, i)), Calculate(i, Colors)) end
	else SKIN:Bang("!SetVariable", SELF:GetOption(Var[j]), Calculate(m, Colors)) end
end

function Calculate(MeasureValue, Colors)
	local uColor,rValue,Divider={},MeasureValue-MinValue,math.ceil((MaxValue-MinValue)/(#Colors[1]-1))
	local Num=math.floor(rValue/Divider)
	for i=1,4 do table.insert(uColor,Average(Colors[i][Num+1],Colors[i][Num+2],rValue%Divider,Divider)) end
	return table.concat(uColor,',')
end

function Average(a,b,c,d) return (a*(d-c)+(b and b or 0)*c)/d end
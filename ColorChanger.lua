-- ColorChanger v1.3 by Smurfier (smurfier20@gmail.com); Modified
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

function Initialize()
	ColorsTable,Var,MinValue,MaxMin,Measure,Meter,Option={},{},{},{},{},{},{}
	
	local SKIN,SELF=SKIN,SELF
	Sub,Index,Limit=SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit"))
	
	Output=SELF:GetOption("Output")
	for i=1,Output do
		ColorsTable[i],Var[i]="Colors"..i,SELF:GetOption("VarName"..i)
		MinValue[i]=SKIN:ParseFormula(SELF:GetOption("MinimumValue"..i,0))
		MaxMin[i]=(SKIN:ParseFormula(SELF:GetOption("MaximumValue"..i,1))-MinValue[i])
		Measure[i],Meter[i],Option[i]=SELF:GetOption("MeasureName"..i),SELF:GetOption("MeterName"..i),SELF:GetOption("MeterOption"..i)
	end
end

function Update()
	local VarTable,Output,ColorsTable,Var,MinValue,MaxMin,Measure,Meter,Option,Sub,Index,Limit={},Output,ColorsTable,Var,MinValue,MaxMin,Measure,Meter,Option,Sub,Index,Limit
	local SKIN,SELF,find,gmatch,gsub,ceil,floor,concat=SKIN,SELF,string.find,string.gmatch,string.gsub,math.ceil,math.floor,table.concat
	
	local function Check(j)
		local Output,Var,MinValue,MaxMin,Measure,Meter,Option,Sub=Output,Var,MinValue,MaxMin,Measure,Meter,Option,Sub
		local SKIN,SELF,find,gmatch,gsub,ceil,floor,concat=SKIN,SELF,find,gmatch,gsub,ceil,floor,concat
		
		local function Main(ColorsStr,i,j)
			local MinValue,MaxMin,ceil,floor,concat=MinValue,MaxMin,ceil,floor,concat
			
			local function Calculate(MeasureValue,Colors,j)
				local function Average(a,b,c,d) return (a*(d-c)+(b and b or 0)*c)/d end

				local uColor,rValue,Divider={},MeasureValue-MinValue[j],ceil(MaxMin[j]/(#Colors[1]-1))
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
				if Meter[j] ~= "" then SKIN:Bang("!SetOption",(gsub(Meter[j],Sub,i)),Option[j],Calculate(SKIN:GetMeasure((gsub(Measure[j],Sub,i))):GetValue(),Colors,j))
				else VarTable[(gsub(Var[j],Sub,i))]=Calculate(i,Colors,j) end
			else VarTable[Var[j]]=Calculate(SKIN:GetMeasure(Measure[j]):GetValue(),Colors,j) end
		end
	
		local ColorsStr=SKIN:ReplaceVariables(SELF:GetOption(ColorsTable[j]))
		
		if find(ColorsStr,Sub) ~= nil then
			for i=Index,Limit do
				for k=1,Output do
					if find(ColorsStr,Var[k]) ~= nil then
						if find(Var[k],Sub) ~= nil then ColorsStr=(gsub(ColorsStr,Var[k],VarTable[(gsub(Var[k],Sub,i))]))
						else ColorsStr=(gsub(ColorsStr,Var[k],VarTable[Var[k]])) end end end
				Main(ColorsStr,i,j)
			end
		else 
			for k=1,Output do if find(ColorsStr,Var[k])~= nil then ColorsStr=(gsub(ColorsStr,Var[k],VarTable[Var[k]])) end end
			if find(Var[j],Sub) ~= nil then for i=Index,Limit do Main(ColorsStr,i,j) end
			else Main(ColorsStr,-1,j) end
		end
	end

	for j=1,Output do Check(j) end
end
-- ColorChanger v1.3 by Smurfier (smurfier20@gmail.com); Modified
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

local ColorsTable,ColorsOptTable,ColorsCheckTable,ColorsVarTable,VarTable,VarNameTable,VarSubTable={},{},{},{},{},{},{}
local MeasureTable,MeasureSubTable,MeterTable,MinValue,MaxValue,MaxMin,Amp,Option={},{},{},{},{},{},{},{}
local gmatch,gsub,concat,random=string.gmatch,string.gsub,table.concat,math.random

local function Go(ColorsStr,Init,i,j)
	local a,b,c={},Init,1
	
	local function Replace(d)
		local a,b={},0 for c in gmatch(d,"[^,]+") do b=b+1
			if c=="Random" then a[b]=random(0,255) else a[b]=c end end
		return concat(a,",")
	end
	
	if b==-1 then local e=0 for d in gmatch(ColorsOptTable[j],"[^%|]+") do if e==0 then e=e+1 else a[2]=Replace(d) end end end
	for d in gmatch(ColorsStr,"[^%|]+") do if b==1 then a[c]=Replace(d) c=c+1 elseif b==-1 then b=b+1 else a[1]=d end end
	
	if i~=-1 then ColorsTable[j][i]=concat(a,"|") else ColorsTable[j]=concat(a,"|") end
end

function Initialize()
	local SKIN,SELF=SKIN,SELF
	Index,Limit,Output=SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit")),SELF:GetOption("Output")

	local Sub,Index,Limit,Output,find=SELF:GetOption("Sub"),Index,Limit,Output,string.find
	for j=1,Output do
		ColorsOptTable[j],VarNameTable[j]=SELF:GetOption("Colors"..j),SELF:GetOption("VarName"..j)
		MinValue[j],MaxValue[j]=SKIN:ParseFormula(SELF:GetOption("MinimumValue"..j,0)),SKIN:ParseFormula(SELF:GetOption("MaximumValue"..j,1))
		MaxMin[j],Amp[j],Option[j]=math.ceil(MaxValue[j]-MinValue[j]),SKIN:ReplaceVariables(SELF:GetOption("MeasureAmp"..j,1)),SELF:GetOption("MeterOption"..j)
		
		local Measure,Meter=SELF:GetOption("MeasureName"..j),SELF:GetOption("MeterName"..j)
		if find(Measure,Sub) then MeasureTable[j]={} MeasureSubTable[j]=1 for i=Index,Limit do MeasureTable[j][i]=SKIN:GetMeasure((gsub(Measure,Sub,i))) end
		else MeasureTable[j]=SKIN:GetMeasure(SELF:GetOption("MeasureName"..j)) end
		if find(Meter,Sub) then MeterTable[j]={} for i=Index,Limit do MeterTable[j][i]=(gsub(Meter,Sub,i)) end
		else MeterTable[j]=SELF:GetOption("MeterName"..j) end
		
		local ColorsStr=ColorsOptTable[j]
		if find(ColorsStr,Sub) then ColorsCheckTable[j]=1 end
		if find(VarNameTable[j],Sub) then VarTable[j]={} VarSubTable[j]=1 ColorsTable[j]={} local Go=Go
			for i=Index,Limit do Go(ColorsStr,1,i,j) end
		elseif find(ColorsStr,"Random") then ColorsCheckTable[j]=2 Go(ColorsStr,1,-1,j) end
	end
	for j=1,Output do ColorsVarTable[j]={} local ColorsStr=ColorsOptTable[j] for k=1,Output do if find(ColorsStr,VarNameTable[k]) then ColorsVarTable[j][k]=1 end end end
end

function Transition(j)
	if VarSubTable[j] then local Go,Index,Limit=Go,Index,Limit
		for i=Index,Limit do Go(ColorsTable[j][i],-1,i,j) end
	else Go(ColorsTable[j],-1,-1,j) end
end

function Update()
	local function Check(j)
		local ColorsVarTable,MeterTable=ColorsVarTable[j],MeterTable[j]
		local MinValue,MaxValue,MaxMin,Amp,Option=MinValue[j],MaxValue[j],MaxMin[j],Amp[j],Option[j]
		
		local function CheckAgain(ColorsStr,Output,i)
			local function Main(ColorsStr,MeasureTable,i)
				local function Calculate(MeasureValue,Colors)
					local function Average(a,b,c,d) local Value=((a*(d-c)+(b and b or 0)*c)/d)+0.5 return Value-Value%1 end
					local function FastAverage(a,b,c) local Value=(a*(1-c)+(b and b or 0)*c)+0.5 return Value-Value%1 end
					
					if MaxMin==1 then
						local uColor,rValue={},MeasureValue-MinValue
						for i=1,4 do uColor[i]=FastAverage(Colors[i][1],Colors[i][2],rValue) end
						return concat(uColor,",")
					else
						local uColor,rValue={},MeasureValue-MinValue
						local NumCalc=rValue/MaxMin local Num=NumCalc-NumCalc%1
						for i=1,4 do uColor[i]=Average(Colors[i][Num+1],Colors[i][Num+2],rValue%MaxMin,MaxMin) end
						return concat(uColor,",")
					end
				end
				
				local function AmpCheck(MeasureValue)
					local AmpValue=Amp*MeasureValue if AmpValue>MaxValue then return MaxValue else return AmpValue end
				end

				local gmatch,Colors,f=gmatch,{},0
				for a=1,4 do Colors[a]={} end
				for a in gmatch(ColorsStr,"[^%|]+") do
					local b,e={},0 f=f+1
					for c in gmatch(a,"[^,]+") do e=e+1 b[e]=c end
					for d=1,4 do Colors[d][f]=b[d] and b[d] or 255 end end
					
				if i~=-1 then
					if MeterTable ~= "" then SKIN:Bang("!SetOption",MeterTable[i],Option,Calculate(AmpCheck(MeasureTable[i]:GetValue()),Colors))
					else VarTable[j][i]=Calculate(i,Colors) end
				else VarTable[j]=Calculate(AmpCheck(MeasureTable:GetValue()),Colors) end
			end
		
			if i~=-1 then local MeasureTable=MeasureTable for k=1,Output do
				if ColorsVarTable[k] then ColorsStr=(gsub(ColorsStr,VarNameTable[k],VarTable[k])) elseif MeasureSubTable[k] then MeasureTable=MeasureTable[k] end end
				if MeasureTable[i]:GetValue()~=0 then Main(ColorsStr,MeasureTable[j],i) end
			elseif ColorsCheckTable[j]==1 then
				local a,b,MeasureTable,ColorsStrLocal,Index,Limit={},0,MeasureTable[j],ColorsStrLocal,Index,Limit
				for k=1,Output do if ColorsVarTable[k] then if VarSubTable[k] then a[b]=k b=b+1
					else ColorsStr=(gsub(ColorsStr,VarNameTable[k],VarTable[k])) end end end
				for m=Index,Limit do
					if MeasureTable[m]:GetValue()~=0 then for c=0,b-1 do ColorsStrLocal=(gsub(ColorsStr,VarNameTable[a[c]],VarTable[a[c]][m])) end
						Main(ColorsStrLocal,MeasureTable,m) end end
			else 
				for k=1,Output do if ColorsVarTable[k] then ColorsStr=(gsub(ColorsStr,VarNameTable[k],VarTable[k])) end end
				if MeasureSubTable[j] then local MeasureTable,Index,Limit=MeasureTable[j],Index,Limit for i=Index,Limit do
					if MeasureTable[i]:GetValue()~=0 then Main(ColorsStr,MeasureTable,i) end end
				else Main(ColorsStr,MeasureTable[j],-1) end
			end
		end
		
		if VarSubTable[j] then local ColorsTable,Index,Limit=ColorsTable[j],Index,Limit for i=Index,Limit do CheckAgain(ColorsTable[i],Output,i) end
		elseif ColorsCheckTable[j]==2 then CheckAgain(ColorsTable[j],Output,-1)
		else CheckAgain(ColorsOptTable[j],Output,-1) end
	end
	
	for j=1,Output do Check(j) end
end
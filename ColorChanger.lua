-- ColorChanger v1.3 by Smurfier (smurfier20@gmail.com); Modified
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

function Initialize()
	ColorsTable,ColorsOptTable,ColorsSubTable,ColorsRandTable,ColorsVarTable,VarTable,VarNameTable,VarSubTable={},{},{},{},{},{},{},{}
	MeasureTable,MeasureSubTable,MeterTable,MinValue,MaxValue,Amp,Option={},{},{},{},{},{},{}
	
	gmatch,gsub,concat,ceil,random=string.gmatch,string.gsub,table.concat,math.ceil,math.random
	
	SKIN,SELF=SKIN,SELF
	local SKIN,SELF=SKIN,SELF
	Sub,Index,Limit,Output=SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit")),SELF:GetOption("Output")
	
	local Sub,Index,Limit,Output,find=Sub,Index,Limit,Output,string.find
	for j=1,Output do
		ColorsOptTable[j],VarNameTable[j]=SELF:GetOption("Colors"..j),SELF:GetOption("VarName"..j)
		MinValue[j],MaxValue[j]=SKIN:ParseFormula(SELF:GetOption("MinimumValue"..j,0)),SKIN:ParseFormula(SELF:GetOption("MaximumValue"..j,1))
		Measure[j],Amp[j],Option[j]=SELF:GetOption("MeasureName"..j),SKIN:ReplaceVariables(SELF:GetOption("MeasureAmp"..j,1)),SELF:GetOption("MeterOption"..j)
		
		local Measure,Meter=SELF:GetOption("MeasureName"..j),SELF:GetOption("MeterName"..j)
		if find(Measure,Sub) then MeasureTable[j]={} MeasureSubTable[j]=1 for i=Index,Limit do MeasureTable[j][i]=SKIN:GetMeasure((gsub(Measure,Sub,i))) end
		else MeasureTable[j]=SKIN:GetMeasure(SELF:GetOption("MeasureName"..j)) end
		if find(Meter,Sub) then MeterTable[j]={} for i=Index,Limit do MeterTable[j][i]=(gsub(Meter,Sub,i)) end
		else MeterTable[j]=SELF:GetOption("MeterName"..j) end
		
		local ColorsStr=ColorsOptTable[j]
		if find(ColorsStr,Sub) then ColorsSubTable[j]=1 end
		if find(VarNameTable[j],Sub) then VarTable[j]={} VarSubTable[j]=1 ColorsTable[j]={} local Go=Go
			for i=Index,Limit do Go(ColorsStr,1,i,j) end
		elseif find(ColorsStr,"Random") then ColorsRandTable[j]=1 Go(ColorsStr,1,-1,j) end
	end
	for j=1,Output do ColorsVarTable[j]={} local ColorsStr=ColorsOptTable[j] for k=1,Output do if find(ColorsStr,VarNameTable[k]) then ColorsVarTable[j][k]=1 end end end
end

function Go(ColorsStr,Init,i,j)
	local a,b,c,gmatch,random={},Init,1,gmatch,random
	
	local function Replace(d)
		local a,b={},0 for c in gmatch(d,"[^,]+") do b=b+1
			if c=="Random" then a[b]=random(0,255) else a[b]=c end end
		return concat(a,",")
	end
	
	if b==-1 then local e=0 for d in gmatch(ColorsOptTable[j],"[^%|]+") do if e==0 then e=e+1 else a[2]=Replace(d) end end end
	for d in gmatch(ColorsStr,"[^%|]+") do if b==1 then a[c]=Replace(d) c=c+1 elseif b==-1 then b=b+1 else a[1]=d end end
	
	if i~=-1 then ColorsTable[j][i]=concat(a,"|")
	else ColorsTable[j]=concat(a,"|") end
end

function Transition(j)
	if VarSubTable[j] then local Go,Index,Limit=Go,Index,Limit
		for i=Index,Limit do Go(ColorsTable[j][i],-1,i,j) end
	else Go(ColorsTable[j],-1,-1,j) end
end

function Update()
	local ColorsTable,ColorsOptTable,ColorsSubTable,ColorsVarTable=ColorsTable,ColorsOptTable,ColorsSubTable,ColorsVarTable
	local VarTable,VarNameTable,VarSubTable,MeasureTable,MeasureSubTable,MeterTable=VarTable,VarNameTable,VarSubTable,MeasureTable,MeasureSubTable,MeterTable
	local MinValue,MaxValue,Amp,Option=MinValue,MaxValue,Amp,Option
	local Sub,Index,Limit,Output=Sub,Index,Limit,Output
	local SKIN,SELF,gmatch,gsub,ceil,concat=SKIN,SELF,gmatch,gsub,ceil,concat
	
	local function Check(j)
		local ColorsSubTable,ColorsVarTable,VarTable,VarNameTable,VarSubTable=ColorsSubTable[j],ColorsVarTable[j],VarTable,VarNameTable,VarSubTable
		local MeasureTable,MeasureSubTable,MeterTable,Sub,Output=MeasureTable[j],MeasureSubTable[j],MeterTable[j],Sub,Output
		local MinValue,MaxValue,Amp,Option=MinValue[j],MaxValue[j],Amp[j],Option[j]
		local SKIN,SELF,gmatch,gsub,ceil,concat=SKIN,SELF,gmatch,gsub,ceil,concat
		
		local function Main(ColorsStr,i)
			if MeterTable ~= "" then if MeasureTable[i]:GetValue()==0 then return end end
			
			local MinValue,MaxValue,Amp,ceil,concat=MinValue,MaxValue,Amp,ceil,concat
			
			local function Calculate(MeasureValue,Colors)
				local function Average(a,b,c,d) local Value=((a*(d-c)+(b and b or 0)*c)/d)+0.5 return Value-Value%1 end

				local uColor,rValue,Divider={},MeasureValue-MinValue,ceil((MaxValue-MinValue)/(#Colors[1]-1))
				local NumCalc=rValue/Divider local Num=NumCalc-NumCalc%1
				for i=1,4 do uColor[i]=Average(Colors[i][Num+1],Colors[i][Num+2],rValue%Divider,Divider) end
				return concat(uColor,",")
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
		
		local function CheckAgain(ColorsStr,i)
			local Output=Output
			if ColorsSubTable then local a,b,Index,Limit={},0,Index,Limit
				for k=1,Output do if ColorsVarTable[k] then if VarSubTable[k] then a[b]=k b=b+1
					else ColorsStr=(gsub(ColorsStr,VarNameTable[k],VarTable[k])) end end end
				for m=Index,Limit do local ColorsStrLocal for c=0,b-1 do ColorsStrLocal=(gsub(ColorsStr,VarNameTable[a[c]],VarTable[a[c]][m])) end Main(ColorsStrLocal,m) end
			else 
				for k=1,Output do local VarName=VarNameTable[k]
					if ColorsVarTable[k] then ColorsStr=(gsub(ColorsStr,VarName,VarTable[k])) end end
					
				if i~=-1 then Main(ColorsStr,i)
				elseif MeasureSubTable then for i=Index,Limit do Main(ColorsStr,i) end
				else Main(ColorsStr,-1) end
			end
		end
		
		local ColorsStr=ColorsOptTable[j]
		if VarSubTable[j] then local Index,Limit=Index,Limit for i=Index,Limit do CheckAgain(ColorsTable[j][i],i) end
		elseif ColorsRandTable[j] then CheckAgain(ColorsTable[j],-1)
		else CheckAgain(ColorsStr,-1) end
	end

	for j=1,Output do Check(j) end
end
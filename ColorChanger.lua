-- ColorChanger v2.0, A modification of ColorChanger v1.3 by Smurfier (smurfier20@gmail.com)
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

local Colors,ColorsIdx,VarColors,VarNames,Check,CheckVar,Measure,Meter,MinValue,MaxValue,MaxMin,Amp,Option,random,concat=
	{},{},{},{},{},{},{},{},{},{},{},{},{},math.random,table.concat

function Initialize()
	local SKIN,SELF,SplitColors=SKIN,SELF,{} Index,Limit,Output=SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit")),SELF:GetOption("Output")
	local Sub,Index,Limit,Output,find,gsub,gmatch,ceil=SELF:GetOption("Sub"),Index,Limit,Output,string.find,string.gsub,string.gmatch,math.ceil
	for j=1,Output do
		SplitColors[j],Colors[j],ColorsIdx[j],VarColors[j],CheckVar[j],VarNames[j]={},{},{},{},{},SELF:GetOption("VarName"..j)
		MinValue[j],MaxValue[j]=SKIN:ParseFormula(SELF:GetOption("MinimumValue"..j,0)),SKIN:ParseFormula(SELF:GetOption("MaximumValue"..j,1))
		MaxMin[j],Amp[j],Option[j]=ceil(MaxValue[j]-MinValue[j]),SKIN:ReplaceVariables(SELF:GetOption("MeasureAmp"..j,1)),SELF:GetOption("MeterOption"..j)
		
		local MeasureName,MeterName=SELF:GetOption("MeasureName"..j),SELF:GetOption("MeterName"..j)
		if find(MeasureName,Sub) then Measure[j]={} Check[j]=1 for i=Index,Limit do Measure[j][i]=SKIN:GetMeasure((gsub(MeasureName,Sub,i))) end
			else Measure[j]=SKIN:GetMeasure(MeasureName) end
		if find(MeterName,Sub) then Meter[j]={} for i=Index,Limit do Meter[j][i]=(gsub(MeterName,Sub,i)) end else Meter[j]=SELF:GetOption(MeterName) end
		if find(VarNames[j],Sub) then Check[j]=2 for i=Index,Limit do VarColors[j][i]={} end end
		
		local ColorsStr,a=SELF:GetOption("Colors"..j),1 for b in gmatch(ColorsStr,"[^%|]+") do SplitColors[j][a]=b a=a+1 end
		for a=1,2 do Colors[j][a]={} ColorsIdx[j][a]={} local b=1 for c in gmatch(SplitColors[j][a],"[^,]+") do ColorsIdx[j][a][b]=c b=b+1 end
			for d=1,4 do if ColorsIdx[j][a][d]=="Random" then Colors[j][a][d]=random(0,255) else Colors[j][a][d]=ColorsIdx[j][a][d] end end
			for k=1,Output do if SplitColors[j][a]==VarNames[k] then if Check[k]==2 then CheckVar[j][a]=1 end
				Colors[j][a]=VarNames[k] ColorsIdx[j][a]=VarNames[k] break end end end end end

function Transition(j) for a=1,4 do Colors[j][1][a]=Colors[j][2][a] if ColorsIdx[j][2][a]=="Random" then Colors[j][2][a]=random(0,255) else Colors[j][2][a]=ColorsIdx[j][2][a] end end end

function Update()
	for j=1,Output do local Colors,CheckVar,Meter,MinValue,MaxValue,MaxMin,Amp,Option,Index,Limit,concat=
		Colors[j],CheckVar[j],Meter[j],MinValue[j],MaxValue[j],MaxMin[j],Amp[j],Option[j],Index,Limit,concat
		local function Main(Colors1,Colors2,Measure,i)
			if i~=-1 then if Meter~="" then local AmpValue=Amp*Measure[i]:GetValue() if AmpValue>MaxValue then AmpValue=MaxValue-.0001 end
					local ColorsTable,c={},(AmpValue-MinValue)%MaxMin local b=MaxMin-c
					for k=1,4 do local Value=((Colors1[k]*b+(Colors2[k] and Colors2[k] or 0)*c)/MaxMin)+0.5 ColorsTable[k]=Value-Value%1 end
					SKIN:Bang("!SetOption",Meter[i],Option,concat(ColorsTable,","))
				else local c=(i-MinValue)%MaxMin local b=MaxMin-c
				for k=1,4 do local Value=((Colors1[k]*b+(Colors2[k] and Colors2[k] or 0)*c)/MaxMin)+0.5 VarColors[j][i][k]=Value-Value%1 end end
			else local c=(Measure:GetValue()-MinValue)%MaxMin local b=MaxMin-c
			for k=1,4 do local Value=((Colors1[k]*b+(Colors2[k] and Colors2[k] or 0)*c)/MaxMin)+0.5 VarColors[j][k]=Value-Value%1 end end end
			
		local ColorsTable={} for a=1,2 do for k=1,Output do if Colors[a]==VarNames[k] then ColorsTable[a]=VarColors[k] break end end
			if ColorsTable[a]==nil then ColorsTable[a]={} for b=1,4 do ColorsTable[a][b]=Colors[a][b] end end end
		if Check[j] or CheckVar[1] or CheckVar[2] then local Measure,Output=Measure,Output for k=Output,1,-1 do if Check[k]==1 then Measure=Measure[k] break end end
			if CheckVar[1] and CheckVar[2] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1][i],ColorsTable[2][i],Measure,i) end end
			elseif CheckVar[1] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1][i],ColorsTable[2],Measure,i) end end
			elseif CheckVar[2] then for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1],ColorsTable[2][i],Measure,i) end end
			else for i=Index,Limit do if Measure[i]:GetValue()~=0 then Main(ColorsTable[1],ColorsTable[2],Measure,i) end end end
		else Main(ColorsTable[1],ColorsTable[2],Measure[j],-1) end end end
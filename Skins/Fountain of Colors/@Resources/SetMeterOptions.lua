function Update()
	
	-- Parse these values only once to be easily read on every update cycle
	local BarHeight=SKIN:ParseFormula(SKIN:ReplaceVariables("#BarHeight#"))
	local BarWidth=SKIN:ParseFormula(SKIN:ReplaceVariables("#BarWidth#"))
	local BarGap=SKIN:ParseFormula(SKIN:ReplaceVariables("#BarGap#"))
	local Offset=BarWidth+BarGap
	
	local NearestAxis=SKIN:GetMeasure("NearestAxis"):GetValue()
	local CheckRotation=SKIN:GetMeasure("CheckRotation"):GetValue()
	
	local Limit=SKIN:ParseFormula(SKIN:ReplaceVariables("#Bands#")-1)
	
	local Meter={}
	local gsub,Sub,MeterName=string.gsub,SELF:GetOption("Sub"),SELF:GetOption("MeterName")
	for i=1,Limit do
		Meter[i]=(gsub(MeterName,Sub,i))
		SKIN:Bang("!SetOption",Meter[i],"Group","Bars")
		SKIN:Bang("!UpdateMeter",Meter[i])
	end
	
	-- If the rotation is closer to the X-axis
	if NearestAxis==0 then
		
		SKIN:Bang("!SetOptionGroup","Bars","W",BarWidth)
		SKIN:Bang("!SetOptionGroup","Bars","H",BarHeight)
		
		-- First bar is offset by the gap value
		SKIN:Bang("!SetOption","MeterBar1","X",BarGap)
		for i=2,Limit do
			SKIN:Bang("!SetOption",Meter[i],"X",BarGap+Offset*(i-1))
		end	
		
	-- If the rotation is closer to the Y-axis
	else
		
		SKIN:Bang("!SetOptionGroup","Bars","W",BarHeight)
		SKIN:Bang("!SetOptionGroup","Bars","H",BarWidth)
		
		-- First bar is offset by the gap value
		SKIN:Bang("!SetOption","MeterBar1","Y",BarGap)
		for i=2,Limit do
			SKIN:Bang("!SetOption",Meter[i],"Y",BarGap+Offset*(i-1))
		end
		
	end
			
	-- If the spectrum has not rotated
	if CheckRotation==0 then
	
		SKIN:Bang("!HideMeter","BoundingBox")
	
	-- If the spectrum has rotated
	else
		
		if NearestAxis==1 then
			SKIN:Bang("!SetOptionGroup","Bars","BarOrientation","Horizontal")
		end
		
		SKIN:Bang("!SetOptionGroup","Bars","AntiAlias",1)
		SKIN:Bang("!SetOptionGroup","Bars","TransformationMatrix",SKIN:GetMeasure("Matrix"):GetStringValue())
		SKIN:Bang("!UpdateMeterGroup","Bars")
		
		-- Unset the matrix after the meters have been transformed
		SKIN:Bang("!SetOptionGroup","Bars","TransformationMatrix","")
		
	end
	
	-- If the ColorChanger script is disabled
	if SKIN:ReplaceVariables("#ColorUpdatesPerSecond#")=="-62.5" then
		SKIN:Bang("!SetOptionGroup","Bars","BarColor",SKIN:ReplaceVariables("#BarColor#"))
	end
	
	SKIN:Bang("!SetOptionGroup","Bars","MouseOverAction","[!SetOptionGroup Bars TooltipText \"Right-click to change settings\"]")
	SKIN:Bang("!SetOptionGroup","Bars","MouseLeaveAction","[!SetOptionGroup Bars TooltipText \"\"]")
	
	SKIN:Bang("!SetOptionGroup","Bars","RightMouseDownAction","[!SkinCustomMenu]")
	SKIN:Bang("!SetOptionGroup","Bars","UpdateDivider",1)
	SKIN:Bang("!UpdateMeterGroup","Bars")
	
end
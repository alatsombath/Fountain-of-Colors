-- ColorChanger v2.3.1, A modification of ColorChanger v1.3 by Smurfier
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

local Colors,ColorsIdx,VarColors,Check,Out,Mode,OldMeasureValue,Measure,Meter={},{},{},{},{},{},{},{},{}
local random,abs,concat=math.random,math.abs,table.concat

function Initialize()

	-- See local "Main" function within global "Update" function
	Amp,Threshold=SKIN:ParseFormula(SKIN:ReplaceVariables("#ColorIntensity#")),SKIN:ParseFormula(SELF:GetNumberOption("Threshold"))
	
	-- Color option that is dynamically updated
	Option=SELF:GetOption("OptionName","BarColor")
	
	-- Iteration control variables
	Sub,Index,Limit=SELF:GetOption("Sub"),SELF:GetOption("Index"),SKIN:ParseFormula(SELF:GetNumberOption("Limit"))
	
	local MeasureName,MeterName,gsub=SELF:GetOption("MeasureName"),SELF:GetOption("MeterName"),string.gsub
	
	-- Check for leading zeros
	if Index:match("0%d") then
	
		-- Retrieve measures and meter names, store in tables
		for i=0,9 do
			Measure[i],Meter[i]=SKIN:GetMeasure((gsub(MeasureName,Sub,"0"..i))),(gsub(MeterName,Sub,"0"..i))
			OldMeasureValue[i]=0
		end
		
		for i=10,Limit do
			Measure[i],Meter[i]=SKIN:GetMeasure((gsub(MeasureName,Sub,i))),(gsub(MeterName,Sub,i))
			OldMeasureValue[i]=0
		end
	
	else
	
		for i=Index,Limit do
			Measure[i],Meter[i]=SKIN:GetMeasure((gsub(MeasureName,Sub,i))),(gsub(MeterName,Sub,i))
			OldMeasureValue[i]=0
		end
		
	end
	
	-- Initialize colors based on the default playlist
	Playlist(SKIN:ReplaceVariables("#ColorPlaylist#"))
	
end

function Playlist(Name)

	local PlaylistMeasure=SKIN:GetMeasure(Name)
	
	-- Determine total number of color items in the playlist
	local j=1
	while PlaylistMeasure:GetOption(j)~="" do
		j=j+1
	end
	Total=j-1
	
	-- Initialize color item iteration index
	Shuffle=PlaylistMeasure:GetNumberOption("Shuffle")
	if Shuffle==1 then
		Idx,Next=random(1,Total),random(1,Total)
	else
		Idx,Next=1,2
	end
	
	-- Initialize counter
	Counter=0
	TransitionTime=math.floor((PlaylistMeasure:GetNumberOption("TransitionTime",3.5)*1000)/16)
	
	local SplitColors,Sub,Index,Limit,find,gmatch={},Sub,Index,Limit,string.find,string.gmatch
	
	
	-- For each color item in the playlist
	for j=1,Total do
	
		-- Initialize the tables for colors and color item options
		Colors[j],ColorsIdx[j],VarColors[j],SplitColors[j],Out[j],Mode[j]={},{},{},{},PlaylistMeasure:GetOption("Out"..j),PlaylistMeasure:GetOption("Mode"..j)
		
		-- Retrieve the color item
		local ColorsStr=SKIN:ReplaceVariables(PlaylistMeasure:GetOption(j))
		
		-- Check output variables
		if Out[j]=="Meter" then
			Check[j]=3
		
		elseif Out[j]~="" then
			Check[j]=1
			
			-- Check if interpolation is designated in the output variable
			if find(Out[j],Sub) then
				Check[j]=2
				for i=Index,Limit do
					VarColors[j][i]={}
				end
			end
			
		else
			Check[j]=0
		end
		
		-- Check if interpolation is designated in the colors string
		if find(ColorsStr,Sub) then
			Check[j]={}
		end
		
		-- Split colors string at the "|" separator into left-hand and right-hand substrings
		local a=1
		for b in gmatch(ColorsStr,"[^%|]+") do
			SplitColors[j][a]=b
			a=a+1
		end
		
		
		-- For each left-hand and right-hand substring
		for a=1,2 do
		
			Colors[j][a],ColorsIdx[j][a]={},{}
			
			-- Split left-hand and right-hand substrings at the "," commas into individual R,G,B,(A) channels
			local b=1
			for c in gmatch(SplitColors[j][a],"[^,]+") do
			
				-- Initialize index table
				ColorsIdx[j][a][b]=c
				b=b+1
				
			end
			
			-- Check for transparency
			if ColorsIdx[j][a][4]==nil then
				ColorsIdx[j][a][4]=255
			end
			
			-- Initialize manipulated table
			for d=1,4 do
				if ColorsIdx[j][a][d]=="Random" then
					Colors[j][a][d]=random(0,255)
				else
					Colors[j][a][d]=ColorsIdx[j][a][d]
				end
			end
			 
			for k=1,Total do
			
				-- Check if left-hand or right-hand substring matches an output variable
				if SplitColors[j][a]==Out[k] then
				
					-- Set the manipulated left-hand or right-hand color table as a reference to the designated output color table
					Colors[j][a]=VarColors[k]
					
					-- Check if interpolation is designated in the substring
					if Check[k]==2 then
						Check[j][a]=1
					end
					
					break
					
				end
				
			end
			
		end
		
		
	end
	
	
end

local function Transition(j)

	if Mode[j]=="RightToLeft" then
	
		for a=1,4 do
		
			-- Set left-hand color as right-hand color
			Colors[j][1][a]=Colors[j][2][a]
			
			-- Set right-hand color retrieved from index
			if ColorsIdx[j][2][a]=="Random" then
				Colors[j][2][a]=random(0,255)
			else
				Colors[j][2][a]=ColorsIdx[j][2][a]
			end
			
		end
	
	-- Color item without output variables
	elseif j==Idx and Out[j]=="" then
		
		-- Set left-hand and right-hand colors retrieved from index
		for a=1,2 do
			for b=1,4 do
				if ColorsIdx[j][a][b]=="Random" then
					Colors[j][a][b]=random(0,255)
				else
					Colors[j][a][b]=ColorsIdx[j][a][b]
				end
			end
		end
		
	end
	
end

function Update()

	Counter=Counter+1
	
	-- Update color item iteration index when counter reaches limit
	if Counter==TransitionTime then
		
		for j=1,Total do
			Transition(j)
		end 
		
		if Shuffle==1 then
			Idx=Next
			Next=random(1,Total)
			
		else
			Idx,Next=Idx+1,Next+1
			
			if Idx>Total then
				Idx,Next=1,2
			elseif Next>Total then
				Next=1
			end
		end
		
		Counter=0
		
	end
	
	local Idx,Next,Amp,Index,Limit=Idx,Next,Amp,Index,Limit
	
	-- For each color item in the playlist
	for j=1,Total do
	
		-- Color calculation and updating meter color
		local function Main(Colors1,Colors2,i)
		
			if i~=-1 then
			
				if Check[j]==2 then
					local c=(i-Index)%Limit
					local b=Limit-c
					
					-- Calculate and store average color in the designated output color table
					for k=1,4 do
						VarColors[j][i][k]=(Colors1[k]*b+Colors2[k]*c)/Limit
					end
					
					return VarColors[j][i]
				
				else
					local Value=Measure[i]:GetValue()
					
					-- Minimum measure value difference to update meter color, based on visible changes to the meter
					if abs(Value-OldMeasureValue[i])>=Threshold then
						
						-- Shift measure floor upward to increase average color vibrancy
						local AmpValue=Amp*Value
						if AmpValue>1 then
							AmpValue=1
						end
						
						local ColorsTable,b={},1-AmpValue
						
						-- Calculate average color
						for k=1,4 do
							ColorsTable[k]=Colors1[k]*b+Colors2[k]*AmpValue
						end
						
						-- Update meter color
						SKIN:Bang("!SetOption",Meter[i],Option,concat(ColorsTable,","))
						
						OldMeasureValue[i]=Value
						
					end
					
				end
			
			
			elseif Mode[j]=="RightToLeft" then
				local b=TransitionTime-Counter
				
				-- Calculate average color based on transition time and store in the designated output color table
				for k=1,4 do
					VarColors[j][k]=(Colors1[k]*b+Colors2[k]*Counter)/TransitionTime
				end
			
			
			elseif j==Idx then 
				local ColorsTable,b={},TransitionTime-Counter
				
				-- Calculate average color based on transition time
				for k=1,4 do
					ColorsTable[k]=(Colors1[k]*b+Colors2[k]*Counter)/TransitionTime
				end
				
				return ColorsTable
			end
			
		end
		
		
		-- Color item matches iteration index, without output variables
		if j==Idx and Out[j]=="" then
		
			local ColorsTable,DoubleCheck={},{}
			local k=Next
			
			for a=1,2 do
			
				-- Output variable is null
				if Check[j]==0 and Check[k]==0 then
					ColorsTable[a]=Main(Colors[j][a],Colors[k][a],-1)
				
				-- Left-hand or right-hand substrings exist in both color items that designate interpolation
				elseif Check[j][a] and Check[k][a] then
					ColorsTable[a],DoubleCheck[a]={},1
					for i=Index,Limit do
						ColorsTable[a][i]=Main(Colors[j][a][i],Colors[k][a][i],i)
					end
				
				-- Left-hand or right-hand substrings exist in the current color item that designate interpolation
				elseif Check[j][a] then
					ColorsTable[a],DoubleCheck[a]={},1
					for i=Index,Limit do
						ColorsTable[a][i]=Main(Colors[j][a][i],Colors[k][a],i)
					end
				
				-- Left-hand or right-hand substrings exist in the next color item that designate interpolation
				elseif Check[k][a] then
					ColorsTable[a],DoubleCheck[a]={},1
					for i=Index,Limit do
						ColorsTable[a][i]=Main(Colors[j][a],Colors[k][a][i],i)
					end
					
				end
				
			end
			
			-- Output variable is null
			if Check[j]==0 and Check[k]==0 then
				for i=Index,Limit do
					Main(ColorsTable[1],ColorsTable[2],i)
				end
			
			-- Both left-hand and right-hand substrings exist in a color item that designate interpolation
			elseif DoubleCheck[1] and DoubleCheck[2] then
				for i=Index,Limit do
					Main(ColorsTable[1][i],ColorsTable[2][i],i)
				end
			
			-- Left-hand substring exists in a color item that designate interpolation
			elseif DoubleCheck[1] then
				for i=Index,Limit do
					Main(ColorsTable[1][i],ColorsTable[2],i)
				end
			
			-- Right-hand substring exists in a color item that designate interpolation
			elseif DoubleCheck[2] then
				for i=Index,Limit do
					Main(ColorsTable[1],ColorsTable[2][i],i)
				end
			end
		
		-- Output variable is either null or is neither "Meter" nor designates interpolation
		elseif Check[j]==0 or Check[j]==1 then
			Main(Colors[j][1],Colors[j][2],-1)
		
		-- Output variable is "Meter" or designates interpolation
		elseif Check[j]==2 or Check[j]==3 then
			for i=Index,Limit do
				Main(Colors[j][1],Colors[j][2],i)
			end
		
		-- Both left-hand and right-hand substrings designate interpolation
		elseif Check[j][1] and Check[j][2] then
			for i=Index,Limit do
				Main(Colors[j][1][i],Colors[j][2][i],i)
			end
		
		-- Left-hand substring designates interpolation
		elseif Check[j][1] then
			for i=Index,Limit do
				Main(Colors[j][1][i],Colors[j][2],i)
			end
			
		-- Right-hand substring designates interpolation
		elseif Check[j][2] then
			for i=Index,Limit do
				Main(Colors[j][1],Colors[j][2][i],i)
			end
			
		end
		
	end
	
end
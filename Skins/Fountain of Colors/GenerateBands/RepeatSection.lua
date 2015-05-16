-- RepeatSection v1.1
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

function Initialize()

	local w,j,ini,gsub={},1,io.input(SKIN:ReplaceVariables(SELF:GetOption("ReadFile"))):read("*all"),string.gsub
	
	local Sub,Index,Limit=SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetNumberOption("Index")),SKIN:ParseFormula(SELF:GetNumberOption("Limit"))
	
	for i=Index,Limit do
		w[j]=gsub(ini,Sub,i)
		j=j+1
	end
	
	local f=io.open(SKIN:ReplaceVariables(SELF:GetOption("WriteFile")),"w")
	f:write(table.concat(w,"\n\n"))
	f:close()
	
end
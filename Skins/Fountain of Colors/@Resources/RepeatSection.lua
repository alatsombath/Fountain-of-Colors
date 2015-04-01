-- RepeatSection v1.0
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0
function Initialize()
	local w,ini,gsub,Sub,Index,Limit={},io.input(SKIN:ReplaceVariables(SELF:GetOption("ReadFile"))):read("*all"),string.gsub,SELF:GetOption("Sub"),SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit"))
	for i=Index,Limit do w[i]=gsub(ini,Sub,i) end
	io.open(SKIN:ReplaceVariables(SELF:GetOption("WriteFile")),"w"):write(table.concat(w,"\n\n"))
end
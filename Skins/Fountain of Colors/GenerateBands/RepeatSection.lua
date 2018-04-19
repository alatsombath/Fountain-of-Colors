function Update()
  local index, section, gsub, readFile = 1, {}, string.gsub, io.input(SKIN:ReplaceVariables(SELF:GetOption("ReadFile"))):read("*all")
  local substitution, lowerLimit, upperLimit = SELF:GetOption("Substitution"), SELF:GetNumberOption("LowerLimit") + 1, SELF:GetNumberOption("UpperLimit") + 1
  
  for i = lowerLimit, upperLimit do
	section[index] = gsub(readFile, substitution, i-1)
	section[index] = gsub(section[index], i-1 .. "D1", i-2)
	section[index] = gsub(section[index], i-1 .. "I1", i)
	index = index + 1
  end
  
  local file = io.open(SKIN:ReplaceVariables(SELF:GetOption("WriteFile")), "w")
  file:write(table.concat(section))
  file:close()
end
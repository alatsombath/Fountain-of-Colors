-- RepeatSection v1.2
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

function Initialize()
  local index, section, gsub, readFile = 1, {}, string.gsub, io.input(SKIN:ReplaceVariables(SELF:GetOption("ReadFile"))):read("*all")
  local substitution, lowerLimit, upperLimit = SELF:GetOption("Substitution"), SELF:GetNumberOption("LowerLimit") + 1, SELF:GetNumberOption("UpperLimit") + 1
  
  for i = lowerLimit, upperLimit do
    section[index], index = gsub(readFile, substitution, i-1), index + 1
  end
  
  local file = io.open(SKIN:ReplaceVariables(SELF:GetOption("WriteFile")), "w")
  file:write(table.concat(section, "\n\n"))
  file:close()
end
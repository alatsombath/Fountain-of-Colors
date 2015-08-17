function Update()
  local barHeight = SKIN:ParseFormula(SKIN:GetVariable("BarHeight"))
  local barWidth, barGap = SKIN:ParseFormula(SKIN:GetVariable("BarWidth")), SKIN:ParseFormula(SKIN:GetVariable("BarGap"))
  local offset = barWidth + barGap
  local nearestAxis, checkRotation = SKIN:GetMeasure("NearestAxis"):GetValue(), SKIN:GetMeasure("CheckRotation"):GetValue()
  local meterName, lowerLimit, upperLimit = {}, SKIN:ParseFormula(SKIN:GetVariable("FirstBandIndex")) + 1, (SKIN:ParseFormula(SKIN:GetVariable("Bands")) - 1) + 1
  
  for i = lowerLimit, upperLimit do
    meterName[i] = "MeterBar" .. i-1
    SKIN:Bang("!SetOption", meterName[i], "Group", "Bars")
    SKIN:Bang("!UpdateMeter", meterName[i])
  end
  
  if nearestAxis == 0 then
    local iterator = 0
    SKIN:Bang("!SetOptionGroup", "Bars", "W", barWidth)
    SKIN:Bang("!SetOptionGroup", "Bars", "H", barHeight)
    for i = lowerLimit, upperLimit do
      SKIN:Bang("!SetOption", meterName[i], "X", offset * iterator)
	  iterator = iterator + 1
    end  
  else
    local iterator = 0
    SKIN:Bang("!SetOptionGroup", "Bars", "W", barHeight)
    SKIN:Bang("!SetOptionGroup", "Bars", "H", barWidth)
    for i = lowerLimit, upperLimit do
      SKIN:Bang("!SetOption", meterName[i], "Y", offset * iterator)
	  iterator = iterator + 1
    end
  end
      
  if checkRotation == 0 then
    SKIN:Bang("!HideMeter", "BoundingBox")
  else
    if nearestAxis == 1 then
      SKIN:Bang("!SetOptionGroup", "Bars", "BarOrientation", "Horizontal")
    end
    SKIN:Bang("!SetOptionGroup", "Bars", "AntiAlias", 1)
    SKIN:Bang("!SetOptionGroup", "Bars", "TransformationMatrix", SKIN:GetMeasure("Matrix"):GetStringValue())
    SKIN:Bang("!UpdateMeterGroup", "Bars")
    SKIN:Bang("!SetOptionGroup", "Bars", "TransformationMatrix", "")
  end
  
  SKIN:Bang("!SetOptionGroup","Bars","LeftMouseUpAction","[]")
  SKIN:Bang("!SetOptionGroup", "Bars", "UpdateDivider", 1)
  SKIN:Bang("!UpdateMeterGroup", "Bars")
end
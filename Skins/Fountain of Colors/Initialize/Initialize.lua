function Initialize()
  config = SKIN:GetVariable("Config")

  -- Measure/meter options should be absolute (non-referenced/calculated)
  local max, fftSize, samplingRate = math.max, SKIN:ParseFormula(SKIN:GetVariable("FFTSize")), SKIN:GetMeasure("SamplingRate"):GetStringValue()
    
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "Port", SKIN:GetVariable("Port"), "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "ID", SKIN:GetVariable("ID"), "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "FFTSize", fftSize * max(48000, samplingRate) / 48000, "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "FFTOverlap",
    ((fftSize - (fftSize - SKIN:ParseFormula(SKIN:GetVariable("FFTOverlap"))) * 0.5 * SKIN:GetMeasure("NumChannels"):GetStringValue() * max(48000, samplingRate) / 48000) * max(48000, samplingRate) / 48000)
    , "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "FFTAttack", SKIN:ParseFormula(SKIN:GetVariable("FFTAttack")), "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "FFTDecay", SKIN:ParseFormula(SKIN:GetVariable("FFTDecay")), "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "Bands", SKIN:ParseFormula(SKIN:GetVariable("Bands")), "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "FreqMin", SKIN:ParseFormula(SKIN:GetVariable("FreqMin")), "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "FreqMax", SKIN:ParseFormula(SKIN:GetVariable("FreqMax")), "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "MeasureAudio", "Sensitivity", SKIN:ParseFormula(SKIN:GetVariable("Sensitivity")), "#@##SkinGroup#.inc")
  
  if SKIN:ParseFormula(SKIN:GetVariable("Invert")) ~= 0 then
    SKIN:Bang("!WriteKeyValue", "MeasureAudioRepeat", "BandIdx", "'(Abs(#FirstBandIndex# + #Bands# - 1 - Repeat))'", "#ROOTCONFIGPATH#\\GenerateBands\\Template.inc")
  else
    SKIN:Bang("!WriteKeyValue", "MeasureAudioRepeat", "BandIdx", "Repeat", "#ROOTCONFIGPATH#\\GenerateBands\\Template.inc")
  end
  
  SKIN:Bang("!WriteKeyValue", "Include", "@Include", "#@#Bands.inc", "#@##SkinGroup#.inc")
  
  -- "Conditional" including measures/meters
  if SKIN:ParseFormula(SKIN:GetVariable("Angle")) ~= 0 then
    SKIN:Bang("!WriteKeyValue", "Include", "@Include2", "#@#SkinRotation.inc", "#@##SkinGroup#.inc")
  else
    SKIN:Bang("!WriteKeyValue", "Include", "@Include2", "", "#@##SkinGroup#.inc")
  end
  
  if SKIN:GetVariable("Colors") ~= "Individual" then
    SKIN:Bang("!WriteKeyValue", "Include", "@Include3", "", "#@##SkinGroup#.inc")
  else
    SKIN:Bang("!WriteKeyValue", "Include", "@Include3", "#@#IndividualBarColors.inc", "#@##SkinGroup#.inc")
  end
  
  if SKIN:GetVariable("Colors") ~= "Single" and true or (SKIN:ParseFormula(SKIN:GetVariable("DecayEffect")) ~= 0 and true or false) then
    SKIN:Bang("!WriteKeyValue", "Include", "@Include4", "#@#ColorChanger.inc", "#@##SkinGroup#.inc")
    -- Also let ColorChanger know which skins are active
    SKIN:Bang("!WriteKeyValue", "Variables", "SetCloneColorState", '[!CommandMeasure ScriptColorChanger """AddChild("[CurrentConfig]", #Invert#)""" "#ROOTCONFIG#"]', "#@#Variables.inc")
	
	if SKIN:GetVariable("Config") == SKIN:GetVariable("ROOTCONFIG") then
	  mainColorState = '[!CommandMeasure ScriptColorChanger SetParent() "#ROOTCONFIG#"]'
	else mainColorState = "" end
  else
    mainColorState = ""
    SKIN:Bang("!WriteKeyValue", "Include", "@Include4", "", "#@##SkinGroup#.inc")
	SKIN:Bang("!WriteKeyValue", "Variables", "SetCloneColorState", "", "#@#Variables.inc")
  end
  
  if SKIN:ParseFormula(SKIN:GetVariable("ClipOffset")) ~= 0 and true or (SKIN:ParseFormula(SKIN:GetVariable("MinBarHeight")) ~= 0 and true or false) then
    SKIN:Bang("!WriteKeyValue", "Include", "@Include5", "#@#CalcMeasures.inc", "#@##SkinGroup#.inc")
	SKIN:Bang("!WriteKeyValue", "MeterBarRepeat", "MeasureName", "MeasureAudioCalcRepeat", "#ROOTCONFIGPATH#\\GenerateBands\\Template.inc")
	
	local maxValue = math.min(10^(-SKIN:ParseFormula(SKIN:GetVariable("ClipOffset")) / 20), 1)
    local minValue = math.max(0, 0.5  * (1 - maxValue))
	SKIN:Bang("!WriteKeyValue", "MeasureAudioCalcRepeat", "Formula",
	  "'(Max(" .. 0.00001 + minValue + ((maxValue - minValue) * (SKIN:ParseFormula(SKIN:GetVariable("MinBarHeight")) / SKIN:ParseFormula(SKIN:GetVariable("BarHeight"))))
	  .. ", MeasureAudioRepeat))'", "#ROOTCONFIGPATH#\\GenerateBands\\TemplateCalcMeasures.inc")
  else
    if SKIN:ParseFormula(SKIN:GetVariable("ModeKeyboard")) ~= 0 then
	  SKIN:Bang("!WriteKeyValue", "MeterBarRepeat", "MeasureName", "MeasureFull", "#ROOTCONFIGPATH#\\GenerateBands\\Template.inc")
	else
	  SKIN:Bang("!WriteKeyValue", "MeterBarRepeat", "MeasureName", "MeasureAudioRepeat", "#ROOTCONFIGPATH#\\GenerateBands\\Template.inc")
	end
    SKIN:Bang("!WriteKeyValue", "Include", "@Include5", "", "#@##SkinGroup#.inc")
  end
  
  nearestAxis, matrix = 0, ""
  SKIN:Bang("!WriteKeyValue", "NearestAxis", "OnUpdateAction", '[!CommandMeasure ScriptInitialize "nearestAxis = [NearestAxis]" "#ROOTCONFIG#\\Initialize"]', "#@#SkinRotation.inc")
  SKIN:Bang("!WriteKeyValue", "Matrix", "OnUpdateAction", '[!CommandMeasure ScriptInitialize """matrix = "[Matrix]"""" "#ROOTCONFIG#\\Initialize"]', "#@#SkinRotation.inc")
  
  SKIN:Bang("!WriteKeyValue", "Rainmeter", "@Include", "#@#Variables.inc", "#ROOTCONFIGPATH#\\Fountain of Colors.ini")
  SKIN:Bang("!WriteKeyValue", "Variables", "@Include", "#@##SkinGroup#.inc", "#ROOTCONFIGPATH#\\Fountain of Colors.ini")
  
  SKIN:Bang("!WriteKeyValue", "Rainmeter", "Group", "#SkinGroup#", "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "Rainmeter", "ContextAction", '[!ActivateConfig "#ROOTCONFIG#\\SettingsWindow"]', "#@##SkinGroup#.inc")
  SKIN:Bang("!WriteKeyValue", "Rainmeter", "ContextAction2", '["#@#Variables.inc"]', "#@##SkinGroup#.inc")
  
  SKIN:Bang("!WriteKeyValue", "Rainmeter", "OnRefreshAction", "", "#@##SkinGroup#.inc")
  
  SKIN:Bang("!ActivateConfig", "#ROOTCONFIG#\\GenerateBands")
  
  SKIN:Bang("!DeactivateConfig", config)
  SKIN:Bang("!ActivateConfig", config)
  
  
  
  SKIN:Bang(mainColorState)

  -- Set options for each config
  local barHeight = SKIN:ParseFormula(SKIN:GetVariable("BarHeight"))
  local barWidth, barGap = SKIN:ParseFormula(SKIN:GetVariable("BarWidth")), SKIN:ParseFormula(SKIN:GetVariable("BarGap"))
  local offset = barWidth + barGap
  local angle = SKIN:ParseFormula(SKIN:GetVariable("Angle"))
  local meterName, lowerLimit, upperLimit = {}, SKIN:ParseFormula(SKIN:GetVariable("FirstBandIndex")) + 1, (SKIN:ParseFormula(SKIN:GetVariable("Bands")) - 1) + 1
  
  for i = lowerLimit, upperLimit do
    meterName[i] = "MeterBar" .. i-1
    SKIN:Bang("!SetOption", meterName[i], "Group", "Bars", config)
    SKIN:Bang("!UpdateMeter", meterName[i], config)
  end
  
  if nearestAxis ~= 0 then
	SKIN:Bang("!SetOptionGroup", "Bars", "W", barHeight, config)
    SKIN:Bang("!SetOptionGroup", "Bars", "H", barWidth, config)
    for i = lowerLimit, upperLimit do
      SKIN:Bang("!SetOption", meterName[i], "Y", offset * (i - lowerLimit), config)
    end
  else
    SKIN:Bang("!SetOptionGroup", "Bars", "W", barWidth, config)
    SKIN:Bang("!SetOptionGroup", "Bars", "H", barHeight, config)
    for i = lowerLimit, upperLimit do
      SKIN:Bang("!SetOption", meterName[i], "X", offset * (i - lowerLimit), config)
    end
  end
  
  if angle ~= 0 then
    if nearestAxis ~= 0 then
      SKIN:Bang("!SetOptionGroup", "Bars", "BarOrientation", "Horizontal", config)
    end
	SKIN:Bang("!SetOptionGroup", "Bars", "AntiAlias", 1, config)
    SKIN:Bang("!SetOptionGroup", "Bars", "TransformationMatrix", matrix, config)
    SKIN:Bang("!UpdateMeterGroup", "Bars", config)
    SKIN:Bang("!SetOptionGroup", "Bars", "TransformationMatrix", "", config)
  end
  
  if SKIN:GetVariable("Colors") == "Single" then
    SKIN:Bang("!SetOptionGroup", "Bars", "BarColor", SKIN:GetVariable("PaletteColor1"), config)
  end
  
  if SKIN:ParseFormula(SKIN:GetVariable("ClipOffset")) ~= 0 then
    local maxValue = math.min(10^(-SKIN:ParseFormula(SKIN:GetVariable("ClipOffset")) / 20), 1)
    local minValue = math.max(0, 0.5  * (1 - maxValue))
    SKIN:Bang("!SetOptionGroup", "AudioCalc", "MaxValue", maxValue, config)
	SKIN:Bang("!SetOptionGroup", "AudioCalc", "MinValue", minValue, config)
  end
  
  SKIN:Bang("!SetOptionGroup", "Bars", "LeftMouseUpAction", '[!ActivateConfig "#ROOTCONFIG#\\SettingsWindow"]', config)
  
  SKIN:Bang("!SetOptionGroup", "Bars", "UpdateDivider", 1, config)
  SKIN:Bang("!UpdateMeterGroup", "Bars", config)
  
  if SKIN:GetVariable("Channel") ~= "Avg" then
    SKIN:Bang("!SetOptionGroup", "Audio", "Channel", SKIN:GetVariable("Channel"), config)
  end
  
  SKIN:Bang("!SetOptionGroup", "Audio", "AverageSize", SKIN:ParseFormula(SKIN:GetVariable("AverageSize")), config)
  
  SKIN:Bang("!SetOptionGroup", "Audio", "UpdateDivider", 1, config)
  SKIN:Bang("!UpdateMeasureGroup", "Audio", config)
  
  SKIN:Bang("!WriteKeyValue", "NearestAxis", "OnUpdateAction", "", "#@#SkinRotation.inc")
  SKIN:Bang("!WriteKeyValue", "Matrix", "OnUpdateAction", "", "#@#SkinRotation.inc")
  
  -- Each skin INI file has some specific settings to be copied to the global Variables.inc file
  local envAngle = '[!WriteKeyValue Variables Angle #*Angle*# "#*@*#Variables.inc"]'
  local envInvert = '[!WriteKeyValue Variables Invert #*Invert*# "#*@*#Variables.inc"]'
  local envChannel = '[!WriteKeyValue Variables Channel #*Channel*# "#*@*#Variables.inc"]'
  local envPort = '[!WriteKeyValue Variables Port #*Port*# "#*@*#Variables.inc"]'
  local envID = '[!WriteKeyValue Variables ID "#*ID*#" "#*@*#Variables.inc"]'
  local envConfig = '[!WriteKeyValue Variables Config "#*CURRENTCONFIG*#" "#*@*#Variables.inc"]'
  local envConfigPath = '[!WriteKeyValue Variables ConfigPath "#*CURRENTPATH*##*CURRENTFILE*#" "#*@*#Variables.inc"]'
  local envVariables = envAngle .. envInvert .. envChannel .. envPort .. envID .. envConfig .. envConfigPath
  local envInitialize = envVariables .. '[!ActivateConfig "#*ROOTCONFIG*#\\Initialize"]'
  
  -- For the next skin initialization
  SKIN:Bang("!WriteKeyValue", "Rainmeter", "OnRefreshAction", envInitialize, "#@##SkinGroup#.inc")
  
  SKIN:Bang("!DeactivateConfig")
end
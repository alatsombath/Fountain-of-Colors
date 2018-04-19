function Initialize()
  if SKIN:ParseFormula(SKIN:GetVariable("Invert")) ~= 0 then
    SKIN:Bang("!WriteKeyValue", "AudioRepeat", "BandIdx", "'(Abs(-#FirstBandIndex# + Max(2,#Bands#-1) - Repeat))'", "#ROOTCONFIGPATH#GenerateBands\\Template.inc")
  else
    SKIN:Bang("!WriteKeyValue", "AudioRepeat", "BandIdx", "Repeat", "#ROOTCONFIGPATH#GenerateBands\\Template.inc")
  end

  if SKIN:ParseFormula(SKIN:GetVariable("MinBarHeight")) ~= 0 and true or (SKIN:ParseFormula(SKIN:GetVariable("ModeKeyboard")) ~= 0 and true or false) then

    SKIN:Bang("!WriteKeyValue", "Repeat", "MeasureName", "AudioCalcRepeat", "#ROOTCONFIGPATH#GenerateBands\\Template.inc")
    SKIN:Bang("!WriteKeyValue", "Include", "@Include5", "#*@*#CalcMeasures.inc", "#@##SkinGroup#.inc")
  
    if SKIN:ParseFormula(SKIN:GetVariable("ModeKeyboard")) ~= 0 then
      SKIN:Bang("!WriteKeyValue", "AudioCalcRepeat", "Formula", "'(Max(AudioRepeat, 1))'", "#ROOTCONFIGPATH#GenerateBands\\TemplateCalcMeasures.inc")
    else
      SKIN:Bang("!WriteKeyValue", "AudioCalcRepeat", "Formula",
        "'(Max(" .. 0.00001 + (SKIN:ParseFormula(SKIN:GetVariable("MinBarHeight")) / SKIN:ParseFormula(SKIN:GetVariable("BarHeight")))
        .. ", AudioRepeat))'", "#ROOTCONFIGPATH#GenerateBands\\TemplateCalcMeasures.inc")
    end

  else
    SKIN:Bang("!DisableMeasure", "GenerateCalcMeasures")
    SKIN:Bang("!WriteKeyValue", "Repeat", "MeasureName", "AudioRepeat", "#ROOTCONFIGPATH#GenerateBands\\Template.inc")
    SKIN:Bang("!WriteKeyValue", "Include", "@Include5", "", "#@##SkinGroup#.inc")
  end
end
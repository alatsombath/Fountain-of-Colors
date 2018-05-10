-- ColorChanger v3.1.5, A modification of ColorChanger v1.3 by Smurfier
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

function Initialize()
  InitRandom()
  random, min, max, floor, concat = math.random, math.min, math.max, math.floor, table.concat
  parent, childTotal, child, childhInvert = 0, 0, {}, {}
  color, colorIdx, hColorIdx, hPosNorm, cacheColor, hidden = {}, {}, {}, {}, {}, {}
  for b = 1, 8 do hColorIdx[b] = {} end
  measure, meterName, option = {}, {}, SELF:GetOption("MeterOption")
  oldMeasureValues, timeSinceDecay, decayEffect = {}, {}, SELF:GetNumberOption("DecayEffect")
  decayThreshold = 0.001 * SELF:GetNumberOption("DecayThreshold")
  decaySustain, decayDuration = 0.001 * 62.5 * SELF:GetNumberOption("DecaySustain"), 0.001 * 62.5 * SELF:GetNumberOption("DecayDuration")
  decayOpacityMin, decayOpacityMax = SELF:GetNumberOption("DecayOpacityMin"), SELF:GetNumberOption("DecayOpacityMax")
  hInvert = SELF:GetNumberOption("hInvert")
  hBlendingMultiplier, vBlendingMultiplier = SELF:GetNumberOption("hBlendingMultiplier"), SELF:GetNumberOption("vBlendingMultiplier")
  opacityMultiplier, opacityLower, opacityUpper = SELF:GetNumberOption("OpacityMultiplier"), SELF:GetNumberOption("OpacityLower"), SELF:GetNumberOption("OpacityUpper")
  hLowerLimit, hUpperLimit = SELF:GetNumberOption("hLowerLimit") + 1, SELF:GetNumberOption("hUpperLimit") + 1
  
  for i = hLowerLimit, hUpperLimit do
    hidden[i], oldMeasureValues[i], timeSinceDecay[i] = 0, 0, 0
	cacheColor[i], colorIdx[i], hPosNorm[i] = "", {}, hInvert == 0 and (i / hUpperLimit) * hBlendingMultiplier or (1 - (i / hUpperLimit)) * hBlendingMultiplier
	measure[i], meterName[i] = SKIN:GetMeasure(SELF:GetOption("MeasureBaseName") .. i-1), SELF:GetOption("MeterBaseName") .. i-1
	for c = 1, 4 do colorIdx[i][c] = {} end
  end
  
  hsvTemp, colorsExclude, colorsExcludeStr = {}, {}, SELF:GetOption("ColorsExclude")
  local a = 1
  for b in string.gmatch(colorsExcludeStr, "[^|]+") do
    colorsExclude[a] = {}
	local c = 1
    for d in string.gmatch(b, "[^,]+") do
	  colorsExclude[a][c] = {}
	  local e = 1
	  for f in string.gmatch(d, "[^-]+") do
	    colorsExclude[a][c][e], e = tonumber(f), e + 1
      end
	  c = c + 1
	end
	a = a + 1
  end
  
  updateWhenZero = SELF:GetNumberOption("UpdateWhenZero")
  transitionTime = math.ceil(SELF:GetOption("TransitionTime") * 1000 / 16)
  enableTransition, enableHorizontalTransition = 0, 0
  counterNorm, counter = {}, transitionTime
  for i = 1, transitionTime do counterNorm[i] = i / transitionTime end
  SKIN:Bang("!UpdateMeasure", "EnableColorTransition")
  SKIN:Bang("!UpdateMeasure", "SetColors")
end

function InitRandom()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
end

function SetParent() parent = 1 end
function AddChild(name, hInvert) child[childTotal + 1], childhInvert[childTotal + 1], childTotal, counter = name, hInvert, childTotal + 1, transitionTime end

-- https://www.cs.rit.edu/~ncs/color/t_convert.html
function RGBtoHSV(color)
  local r, g, b = color[1] / 255, color[2] / 255, color[3] / 255
  local lMax = max(r, g, b)
  local delta = lMax - min(r, g, b)
  hsvTemp[3] = lMax * 100

  if max ~= 0 then
    hsvTemp[2] = delta / lMax * 100
  else
  	hsvTemp[2], hsvTemp[1] = 0, -1
	return
  end
  
  if r == lMax then
    hsvTemp[1] = (g - b) / delta
  elseif g == lMax then
    hsvTemp[1] = 2 + (b - r) / delta
  else
    hsvTemp[1] = 4 + (r - g) / delta
  end
  
  hsvTemp[1] = hsvTemp[1] * 60
  hsvTemp[1] = hsvTemp[1] < 0 and hsvTemp[1] + 360 or hsvTemp[1]
end

function Validate(color)
  RGBtoHSV(color)
  for a = 1, #colorsExclude do
    if not
	  (hsvTemp[1] < colorsExclude[a][1][1] or hsvTemp[1] > colorsExclude[a][1][2] or
	   hsvTemp[2] < colorsExclude[a][2][1] or hsvTemp[2] > colorsExclude[a][2][2] or
	   hsvTemp[3] < colorsExclude[a][3][1] or hsvTemp[3] > colorsExclude[a][3][2])
	then
	  return -1
	end
  end
  return 0
end

function HorizontalInterpolation()
  for i = hLowerLimit, hUpperLimit do
    local c, hPosNorm = 1, hPosNorm[i]
	for b = 1, 8, 2 do
      for a = 1, 3 do
	    colorIdx[i][c][a] = (hColorIdx[b][a] * (1 - hPosNorm) + hColorIdx[b+1][a] * hPosNorm)
	  end
	  c = c + 1
	end
  end
end

function Transition()
  if enableHorizontalTransition ~= 0 then
    for b = 1, 4 do
      for a = 1, 3 do
	    hColorIdx[b][a] = hColorIdx[b+4][a]
	    for k = 1, childTotal do
	      SKIN:Bang("!CommandMeasure", "ScriptColorChanger", "hColorIdx[" .. b .. "][" .. a .. "] = " .. hColorIdx[b][a], child[k])
        end
	  end
    end
    SKIN:Bang("!UpdateMeasure", "SetColors")
    HorizontalInterpolation()
    counter = 1
    for k = 1, childTotal do
      for b = 1, 4 do
        for a = 1, 3 do
          SKIN:Bang("!CommandMeasure", "ScriptColorChanger", "hColorIdx[" .. b+4 .. "][" .. a .. "] = " .. hColorIdx[b+4][a], child[k])
        end
      end
      SKIN:Bang("!CommandMeasure", "ScriptColorChanger", "HorizontalInterpolation(); counter = 1", child[k])
    end
  else
	for i = hLowerLimit, hUpperLimit do
	  for a = 1, 3 do 
		colorIdx[i][1][a], colorIdx[i][2][a] = colorIdx[i][3][a], colorIdx[i][4][a]
      end
	end
	for k = 1, childTotal do
	  for i = hLowerLimit, hUpperLimit do
	    local idx, childIdx = hInvert == 0 and i or (hLowerLimit + hUpperLimit - i), childhInvert[k] == 0 and i or (hLowerLimit + hUpperLimit - i)
	    for a = 1, 3 do 
	      SKIN:Bang("!CommandMeasure", "ScriptColorChanger", "colorIdx[" .. childIdx .. "][1][" .. a .. "], colorIdx[" .. childIdx  .. "][2][" .. a .. "] = " .. colorIdx[idx][1][a] .. "," .. colorIdx[idx][2][a], child[k])
        end
	  end
	end
    SKIN:Bang("!UpdateMeasure", "SetColors")
	counter = 1
	for k = 1, childTotal do
      for i = hLowerLimit, hUpperLimit do
	    local idx, childIdx = hInvert == 0 and i or (hLowerLimit + hUpperLimit - i), childhInvert[k] == 0 and i or (hLowerLimit + hUpperLimit - i)
        for a = 1, 3 do
		  SKIN:Bang("!CommandMeasure", "ScriptColorChanger", "colorIdx[" .. childIdx .. "][3][" .. a .. "], colorIdx[" .. childIdx .. "][4][" .. a .. "] = " .. colorIdx[idx][3][a] .. "," .. colorIdx[idx][4][a], child[k])
		end
      end
	  SKIN:Bang("!CommandMeasure", "ScriptColorChanger", "counter = 1", child[k])
	end
  end
end

function Update()
  if enableTransition ~= 0 then
    if counter ~= transitionTime then counter = counter + 1
    elseif parent ~= 0 then Transition()
	else return 0 end
  end

  for i = hLowerLimit, hUpperLimit do
    if measure[i]:GetValue() ~= 0 or updateWhenZero ~= 0 then
	  local measureValue = measure[i]:GetValue()
	  local color, colorIdx, counterNorm = color, colorIdx[i], counterNorm[counter]
	  local blendingValue = vBlendingMultiplier * measureValue
	  if blendingValue > 1 then blendingValue = 1 end
	  local blendingValueRe, counterNormRe = 1 - blendingValue, 1 - counterNorm
	  
	  if enableTransition ~= 0 then
        for a = 1, 3 do
          color[a] = floor((colorIdx[1][a] * counterNormRe + colorIdx[3][a] * counterNorm) * blendingValueRe + (colorIdx[2][a] * counterNormRe + colorIdx[4][a] * counterNorm) * blendingValue + 0.5)
        end
	  else
	    for a = 1, 3 do 
	      color[a] = floor(colorIdx[1][a] * blendingValueRe + colorIdx[2][a] * blendingValue + 0.5)
	    end
      end
	  
	  local opacityValue = opacityMultiplier * measureValue
	  if opacityValue > 1 then opacityValue = 1 end
	  color[4] = floor(opacityLower * (1 - opacityValue) + opacityUpper *  opacityValue + 0.5)
	  
	  if decayEffect ~= 0 then
	    diff, oldMeasureValues[i] = measureValue - oldMeasureValues[i], measureValue
		if diff > decayThreshold then
		  timeSinceDecay[i], color[4] = -1, decayOpacityMax
        else
          timeSinceDecay[i] = timeSinceDecay[i] + 1
	      if timeSinceDecay[i] > decaySustain then
	        if (timeSinceDecay[i] - decaySustain) > decayDuration then
		      timeSinceDecay[i], color[4] = decayDuration + decaySustain, decayOpacityMin
		    else
		      local decay = timeSinceDecay[i] - decaySustain
		      if decay < 0 then decay = 0 end
		      color[4] = floor(decayOpacityMax * (1 - (decay / decayDuration)) + 0.5)
			  if color[4] < decayOpacityMin then color[4] = decayOpacityMin end
		    end
	      else
		    color[4] = decayOpacityMax
	      end
	    end
	  end
	  
	  if color[4] ~= 0 then
	    hidden[i] = 0
      elseif hidden[i] == 0 then
	    hidden[i] = 1
	  elseif hidden[i] ~= 2 then
	    hidden[i] = 2
	  end
      
	  if hidden[i] ~= 2 then
	    color = concat(color, ",")
	    if color ~= cacheColor[i] then
	      cacheColor[i] = color
	      SKIN:Bang("!SetOption", meterName[i], option, color)
	    end
	  end
	  
	else
	  oldMeasureValues[i] = 0
	end
  end
end
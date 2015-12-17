-- ColorChanger v3.1.1, A modification of ColorChanger v1.3 by Smurfier
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

function Initialize()
  random, floor, concat = math.random, math.floor, table.concat
  parent, childTotal, child, childhInvert = 0, 0, {}, {}
  color, colorIdx, hColorIdx, hPosNorm, cacheColor = {}, {}, {}, {}, {}
  for b = 1, 8 do hColorIdx[b] = {} end
  measure, meterName, option = {}, {}, SELF:GetOption("MeterOption")
  oldMeasureValues, timeSinceDecay, decayEffect = {}, {}, SELF:GetNumberOption("DecayEffect")
  decayThreshold = 0.001 * SELF:GetNumberOption("DecayThreshold")
  decaySustain, decayDuration = 0.001 * 62.5 * SELF:GetNumberOption("DecaySustain"), 0.001 * 62.5 * SELF:GetNumberOption("DecayDuration")
  hInvert = SELF:GetNumberOption("hInvert")
  hBlendingMultiplier, vBlendingMultiplier = SELF:GetNumberOption("hBlendingMultiplier"), SELF:GetNumberOption("vBlendingMultiplier")
  opacityMultiplier, opacityLower, opacityUpper = SELF:GetNumberOption("OpacityMultiplier"), SELF:GetNumberOption("OpacityLower"), SELF:GetNumberOption("OpacityUpper")
  hLowerLimit, hUpperLimit = SELF:GetNumberOption("hLowerLimit") + 1, SELF:GetNumberOption("hUpperLimit") + 1
  
  for i = hLowerLimit, hUpperLimit do
    oldMeasureValues[i], timeSinceDecay[i] = 0, 0
	cacheColor[i], colorIdx[i], hPosNorm[i] = "", {}, hInvert == 0 and (i / hUpperLimit) * hBlendingMultiplier or (1 - (i / hUpperLimit)) * hBlendingMultiplier
	measure[i], meterName[i] = SKIN:GetMeasure(SELF:GetOption("MeasureBaseName") .. i-1), SELF:GetOption("MeterBaseName") .. i-1
	for c = 1, 4 do colorIdx[i][c] = {} end
  end
  
  updateWhenZero = SELF:GetNumberOption("UpdateWhenZero")
  transitionTime = math.ceil(SELF:GetOption("TransitionTime") * 1000 / 16)
  enableTransition, enableHorizontalTransition = 0, 0
  counterNorm, counter = {}, transitionTime
  for i = 1, transitionTime do counterNorm[i] = i / transitionTime end
  SKIN:Bang("!UpdateMeasure", "EnableColorTransition")
  SKIN:Bang("!UpdateMeasure", "SetColors")
end

function SetParent() parent = 1 end
function AddChild(name, hInvert) child[childTotal + 1], childhInvert[childTotal + 1], childTotal, counter = name, hInvert, childTotal + 1, transitionTime end

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
	  
	  if decayEffect ~= 0 then
	    diff, oldMeasureValues[i] = measureValue - oldMeasureValues[i], measureValue
		if diff > decayThreshold then
		  timeSinceDecay[i], color[4] = -1, 255
        else
          timeSinceDecay[i] = timeSinceDecay[i] + 1
	      if timeSinceDecay[i] > decaySustain then
	        if (timeSinceDecay[i] - decaySustain) > decayDuration then
		      timeSinceDecay[i], color[4] = decayDuration + decaySustain, 0
		    else
		      local decay = timeSinceDecay[i] - decaySustain
		      if decay < 0 then decay = 0 end
		      color[4] = floor(255 * (1 - (decay / decayDuration)) + 0.5)
		    end
	      else
		    color[4] = 255
	      end
	    end
	  end

	  color = concat(color, ",")
	  if color ~= cacheColor[i] then
	    cacheColor[i] = color
	    SKIN:Bang("!SetOption", meterName[i], option, color)
	  end
	  
	else
	  oldMeasureValues[i] = 0
	end
  end
end
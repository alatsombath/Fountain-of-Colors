[ScriptColorChanger]
Measure=Script
ScriptFile=#@#ColorChanger.lua
MeasureBaseName=MeasureAudio
MeterBaseName=MeterBar
MeterOption=BarColor
hLowerLimit=#FirstBandIndex#
hUpperLimit=(#Bands#-1)
hInvert=#Invert#
hBlendingMultiplier=#hBlendingMultiplier#
vBlendingMultiplier=#vBlendingMultiplier#
OpacityLower=#OpacityLower#
OpacityUpper=#OpacityUpper#
OpacityMultiplier=#OpacityMultiplier#
TransitionTime=#TransitionTime#
DecayEffect=#DecayEffect#
DecayThreshold=#DecayThreshold#
DecaySustain=#DecaySustain#
DecayDuration=#DecayDuration#
DecayOpacityMin=#DecayOpacityMin#
DecayOpacityMax=#DecayOpacityMax#
ColorsExclude=#ColorsExclude#
UpdateWhenZero=(#ModeKeyboard# = 1 || #MinBarHeight# <> 0 ? 1 : 0)
UpdateDivider=1

[EnableColorTransition]
Measure=String
String=#Colors#
IfMatch="Random|Wallpaper|Taskbar"
IfMatchAction=[!CommandMeasure ScriptColorChanger "enableTransition, enableHorizontalTransition = 1, 1"]
IfMatch2="IndivRand"
IfMatchAction2=[!CommandMeasure ScriptColorChanger "enableTransition = 1"]

[EnablePluginColors]
Measure=String
String=#Colors#
IfMatch="Wallpaper"
IfMatchAction=[!SetOptionGroup Chameleon UpdateDivider 62.5][!SetOptionGroup Chameleon Format Dec]
IfMatch2="Taskbar"
IfMatchAction2=[!SetOption mWindowColor UpdateDivider 62.5]

@Include=#@##ColorsPlugin#.inc

[SetColors]
Measure=String
String=#Colors#
IfMatchMode=1
IfMatch="Single"
IfMatchAction=[!CommandMeasure ScriptColorChanger """local a = 1; for c in string.gmatch("#PaletteColor1#", "[^,]+") do for i = hLowerLimit, hUpperLimit do colorIdx[i][1][a], colorIdx[i][2][a] = c, c end; a = a + 1 end"""]
IfMatch2="Random"
IfMatchAction2=[!CommandMeasure ScriptColorChanger """for b = 1, 4 do repeat for a = 1, 3 do hColorIdx[b+4][a] = random(0, 255) end; until colorsExcludeStr == '' or Validate(hColorIdx[b+4]) ~= -1 end"""]
IfMatch3="Custom"
IfMatchAction3=[!CommandMeasure ScriptColorChanger """for b = 1, 4 do local a = 1; for c in SKIN:GetVariable("PaletteColor" .. b):gmatch("[^,]+") do hColorIdx[b][a], hColorIdx[b+4][a], a = c, c, a + 1 end; end; HorizontalInterpolation()"""]
IfMatch4="Individual"
IfMatchAction4=[!CommandMeasure ScriptColorChanger """local a = 1; for c in string.gmatch("#PaletteColor1#", "[^,]+") do for i = hLowerLimit, hUpperLimit do colorIdx[i][1][a], colorIdx[i][2][a] = c, c end; a = a + 1 end; for i = hLowerLimit, hUpperLimit do local bar = SKIN:GetVariable(i-1); if bar ~= nil then local c = 1; for d in bar:gmatch("[^%|]+") do local a = 1; for e in d:gmatch("[^,]+") do colorIdx[#Invert# == 0 and i or (hLowerLimit + hUpperLimit - i)][c][a], a = e, a + 1 end; c = c + 1 end; end; end"""]
IfMatch5="IndivRand"
IfMatchAction5=[!CommandMeasure ScriptColorChanger """for i = hLowerLimit, hUpperLimit do repeat for a = 1, 3 do colorIdx[i][3][a] = random(0, 255) end until colorsExcludeStr == '' or Validate(colorIdx[i][3]) ~= -1; repeat for a = 1, 3 do colorIdx[i][4][a] = random(0, 255) end until colorsExcludeStr == '' or Validate(colorIdx[i][4]) ~= -1; end]
IfMatch6="Wallpaper"
IfMatchAction6=[!CommandMeasure ScriptColorChanger """local wallpaperColors = {"[Desktop#WallpaperColorSource#]", "[DesktopBG2]", "[DesktopFG2]", "[DesktopBG1]"}; if "#WallpaperColorSource#" == "Cycle" then for a = 1, 4 do wallpaperColors[a] = wallpaperColors[random(2, 4)] end end for b = 1, 4 do local a = 1; for c in wallpaperColors[b]:gmatch("[^,]+") do hColorIdx[b+4][a], a = c, a + 1 end; end"""]
IfMatch7="Taskbar"
IfMatchAction7=[!CommandMeasure ScriptColorChanger """local taskbarColor = "[mWindowColor]"; local a = 1; for c in taskbarColor:gmatch("[^,]+") do for b = 1, 4 do hColorIdx[b+4][a] = c end; a = a + 1 end]

[MeasureFull]
Measure=Calc
Formula=1
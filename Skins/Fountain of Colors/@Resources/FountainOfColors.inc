[Rainmeter]
Update=16
DefaultUpdateDivider=-1
Group=#SkinGroup#
OnCloseAction=[!RefreshGroup #SkinGroup#]

; Since each skin file has some specific settings, their config name and settings should be written to the global Variables file for access
ContextTitle="Open settings window"
ContextAction=[!WriteKeyValue Variables Angle #Angle# "#@#Variables.inc"][!WriteKeyValue Variables Invert #Invert# "#@#Variables.inc"][!WriteKeyValue Variables Channel #Channel# "#@#Variables.inc"][!WriteKeyValue Variables Port #Port# "#@#Variables.inc"][!WriteKeyValue Variables ID "#ID#" "#@#Variables.inc"][!WriteKeyValue Variables Config "#CURRENTCONFIG#" "#@#Variables.inc"][!WriteKeyValue Variables ConfigPath "#CURRENTPATH##CURRENTFILE#" "#@#Variables.inc"][!ActivateConfig "#ROOTCONFIG#\SettingsWindow"]
ContextTitle2="Edit variables"
ContextAction2=["#@#Variables.inc"]

[MeasureAudio]
Measure=Plugin
Plugin=AudioLevel
Port=#Port#
ID=#ID#
FFTSize=#FFTSize#
FFTOverlap=#FFTOverlap#
FFTAttack=#FFTAttack#
FFTDecay=#FFTDecay#
Bands=#Bands#
FreqMin=#FreqMin#
FreqMax=#FreqMax#
Sensitivity=#Sensitivity#
UpdateDivider=1

; Hide meters and disable measures when idle
IfCondition=(MeasureAudio < 0.000000000000000001)
IfTrueAction=[!DisableMeasure MeasureAudio][!DisableMeasure ScriptColorChanger][!HideMeterGroup Bars][!HideMeter BoundingBox]

[Standby]
Measure=Plugin
Plugin=AudioLevel
Port=#Port#
ID=#ID#
UpdateDivider=1
IfConditionMode=1

; Show meters and enable measures when sound begins playing
IfCondition=(Standby > 0.000000000000000001)
IfTrueAction=[!EnableMeasure MeasureAudio][!EnableMeasure ScriptColorChanger][!ShowMeterGroup Bars][!ShowMeter BoundingBox]

@Include=#@#Bands.inc
@Include2=#@#SkinRotation.inc
@Include3=#@#IndividualBarColors.inc

[SetMeasureOptions]
Measure=Calc
OnUpdateAction=[!SetOptionGroup Audio Channel #Channel#][!SetOptionGroup Audio AverageSize #AverageSize#][!SetOptionGroup Audio UpdateDivider 1][!UpdateMeasureGroup Audio]

[SetMeterOptions]
Measure=Script
ScriptFile=#@#SetMeterOptions.lua

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
TransitionTime=#TransitionTime#
OpacityLower=#OpacityLower#
OpacityUpper=#OpacityUpper#
OpacityMultiplier=#OpacityMultiplier#
UpdateDivider=1

[EnableUpdateWhenZero]
Measure=String
String=#ModeKeyboard#
IfMatch="1"
IfMatchAction=[!CommandMeasure ScriptColorChanger "updateWhenZero = 1"]

[EnableColorTransition]
Measure=String
String=#Colors#
IfMatch="Random"
IfMatchAction=[!CommandMeasure ScriptColorChanger "enableTransition = 1"]

[SetColors]
Measure=String
String=#Colors#
IfMatchMode=1
IfMatch="Single"
IfMatchAction=[!SetOption ScriptColorChanger UpdateDivider -1][!SetOptionGroup Bars BarColor #PaletteColor1#]
IfMatch2="Random"
IfMatchAction2=[!CommandMeasure ScriptColorChanger """for b = 1, 4 do for a = 1, 3 do hColorIdx[b+4][a] = random(0, 255) end; end"""]
IfMatch3="Custom"
IfMatchAction3=[!CommandMeasure ScriptColorChanger """for b = 1, 4 do local a = 1; for c in SKIN:GetVariable("PaletteColor" .. b):gmatch("[^,]+") do hColorIdx[b][a], hColorIdx[b+4][a], a = c, c, a + 1 end; end; HorizontalInterpolation()"""]
IfMatch4="Individual"
IfMatchAction4=[!CommandMeasure ScriptColorChanger """for i = hLowerLimit, hUpperLimit do local bar = SKIN:GetVariable(i-1); if bar ~= nil then local c = 1; for d in bar:gmatch("[^%|]+") do local a = 1; for e in d:gmatch("[^,]+") do colorIdx[i][c][a], a = e, a + 1 end; c = c + 1 end; else local a = 1; for c in string.gmatch("#PaletteColor1#", "[^,]+") do colorIdx[i][1][a], colorIdx[i][2][a], a = c, c, a + 1 end; end; end"""]

[CurrentConfig]
Measure=String
String=#CURRENTCONFIG#
Substitute="\":"\\"

[MeasureFull]
Measure=Calc
Formula=1
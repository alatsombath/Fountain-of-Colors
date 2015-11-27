[Rainmeter]
Update=16
DefaultUpdateDivider=-1
Group=#SkinGroup#
OnCloseAction=[!RefreshGroup #SkinGroup#]

ContextTitle="Open settings window"
ContextAction=#OpenSettingsWindow#
ContextTitle2="Edit variables"
ContextAction2=["#@#Variables.inc"]

[Variables]

; Since each skin file has some specific settings, they should be written to the global Variables file for access
EnvAngle=[!WriteKeyValue Variables Angle #Angle# "#@#Variables.inc"]
EnvInvert=[!WriteKeyValue Variables Invert #Invert# "#@#Variables.inc"]
EnvChannel=[!WriteKeyValue Variables Channel #Channel# "#@#Variables.inc"]
EnvPort=[!WriteKeyValue Variables Port #Port# "#@#Variables.inc"]
EnvID=[!WriteKeyValue Variables ID "#ID#" "#@#Variables.inc"]
EnvConfig=[!WriteKeyValue Variables Config "#CURRENTCONFIG#" "#@#Variables.inc"]
EnvConfigPath=[!WriteKeyValue Variables ConfigPath "#CURRENTPATH##CURRENTFILE#" "#@#Variables.inc"]
EnvSettingsWindow=#EnvAngle##EnvInvert#EnvChannel##EnvPort##EnvID##EnvConfig##EnvConfigPath#
OpenSettingsWindow=#EnvSettingsWindow#[!ActivateConfig "#ROOTCONFIG#\SettingsWindow"][!Refresh "#ROOTCONFIG#\SettingsWindow"]

[MeasureAudio]
Measure=Plugin
Plugin=AudioLevel
Port=#Port#
ID=#ID#
RMSAttack=0
RMSDecay=0
RMSGain=1
PeakAttack=0
PeakDecay=0
PeakGain=1
FFTSize=#FFTSize#
FFTOverlap=#FFTOverlap#
FFTAttack=#FFTAttack#
FFTDecay=#FFTDecay#
Bands=#Bands#
FreqMin=#FreqMin#
FreqMax=#FreqMax#
Sensitivity=#Sensitivity#
UpdateDivider=1

[DisableProcessCheck]
Measure=String
String=#MusicPlayer#
IfMatch="None"
IfMatchAction=[!SetOption DisableProcessCheck String 1][!UpdateMeasure DisableProcessCheck]
IfNotMatchAction=[!SetOption MeasureProcess UpdateDivider 62.5]

[MeasureProcess]
Measure=Plugin
Plugin=Process
ProcessName=#MusicPlayer#.exe

[Standby]
Measure=Plugin
Plugin=AudioLevel
Port=#Port#
ID=#ID#
RMSAttack=0
RMSDecay=0
RMSGain=1
PeakAttack=0
PeakDecay=0
PeakGain=1
UpdateDivider=1

; Toggle measures/meters based on idle audio and music player running status
IfCondition=((Standby > 0.00001) && ((DisableProcessCheck = 1) || (MeasureProcess = 1)))
IfTrueAction=[!EnableMeasure MeasureAudio][!EnableMeasure ScriptColorChanger][!EnableMeasure DynamicSensitivity][!EnableMeasure DynamicFFTDecay][!ShowFade]
IfFalseAction=[!DisableMeasure MeasureAudio][!DisableMeasure ScriptColorChanger][!DisableMeasure DynamicSensitivity][!DisableMeasure DynamicFFTDecay][!HideFade]

[DynamicSensitivity]
Measure=Calc
Formula=(#Sensitivity# - (MeasureAudio * 100 - #Sensitivity#))
IfCondition=((DynamicSensitivity > #Sensitivity#) && (#LoudnessEqualization# = 1))
IfTrueAction=[!SetOption MeasureAudio Sensitivity [DynamicSensitivity]]
IfConditionMode=1
UpdateDivider=1
; Average over the past 0.9 seconds to prevent stuttering
AverageSize=56

[DynamicFFTDecay]
Measure=Calc
Formula=(#FFTDecay# + (MeasureAudio * 100 - #Sensitivity#) * 10)
IfCondition=((DynamicSensitivity > #Sensitivity#) && (#LoudnessEqualization# = 1))
IfTrueAction=[!SetOption MeasureAudio FFTDecay [DynamicFFTDecay]]
IfConditionMode=1
UpdateDivider=1
AverageSize=56

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
DecayEffect=#DecayEffect#
DecayThreshold=#DecayThreshold#
DecaySustain=#DecaySustain#
DecayDuration=#DecayDuration#
UpdateWhenZero=(#ModeKeyboard# = 1 ? 1 : 0)
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
IfMatchAction=[!SetOption ScriptColorChanger UpdateDivider -1][!SetOptionGroup Bars BarColor #PaletteColor1#]
IfMatch2="Random"
IfMatchAction2=[!CommandMeasure ScriptColorChanger """for b = 1, 4 do for a = 1, 3 do hColorIdx[b+4][a] = random(0, 255) end; end"""]
IfMatch3="Custom"
IfMatchAction3=[!CommandMeasure ScriptColorChanger """for b = 1, 4 do local a = 1; for c in SKIN:GetVariable("PaletteColor" .. b):gmatch("[^,]+") do hColorIdx[b][a], hColorIdx[b+4][a], a = c, c, a + 1 end; end; HorizontalInterpolation()"""]
IfMatch4="Individual"
IfMatchAction4=[!CommandMeasure ScriptColorChanger """local a = 1; for c in string.gmatch("#PaletteColor1#", "[^,]+") do for i = hLowerLimit, hUpperLimit do colorIdx[i][1][a], colorIdx[i][2][a] = c, c end; a = a + 1 end; for i = hLowerLimit, hUpperLimit do local bar = SKIN:GetVariable(i-1); if bar ~= nil then local c = 1; for d in bar:gmatch("[^%|]+") do local a = 1; for e in d:gmatch("[^,]+") do colorIdx[#Invert# == 0 and i or (hLowerLimit + hUpperLimit - i)][c][a], a = e, a + 1 end; c = c + 1 end; end; end"""]
IfMatch5="IndivRand"
IfMatchAction5=[!CommandMeasure ScriptColorChanger """for i = hLowerLimit, hUpperLimit do for a = 1, 3 do colorIdx[i][3][a], colorIdx[i][4][a] = random(0, 255), random(0, 255) end; end]
IfMatch6="Wallpaper"
IfMatchAction6=[!CommandMeasure ScriptColorChanger """local wallpaperColors = {"[DesktopAvg]", "[DesktopFG2]", "[DesktopFG1]", "[DesktopBG2]"}; for b = 1, 4 do local a = 1; for c in wallpaperColors[b]:gmatch("[^,]+") do hColorIdx[b+4][a], a = c, a + 1 end; end"""]
IfMatch7="Taskbar"
IfMatchAction7=[!CommandMeasure ScriptColorChanger """local taskbarColor = "[mWindowColor]"; local a = 1; for c in taskbarColor:gmatch("[^,]+") do for b = 1, 4 do hColorIdx[b+4][a] = c end; a = a + 1 end]

[CurrentConfig]
Measure=String
String=#CURRENTCONFIG#
Substitute="\":"\\"

[MeasureFull]
Measure=Calc
Formula=1
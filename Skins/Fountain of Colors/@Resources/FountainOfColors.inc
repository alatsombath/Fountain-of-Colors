[Rainmeter]
Update=16
DefaultUpdateDivider=-1
Group=FountainOfColors

; Reassociate child ColorChanger script instances
OnCloseAction=[!RefreshGroup FountainOfColors]

ContextTitle="Color settings..."
ContextAction=[!WriteKeyValue Variables Config "#CURRENTCONFIG#" "#@#Variables.inc"][!ActivateConfig "Fountain of Colors\ContextMenus" "Color.ini"]
ContextTitle2="Display settings..."
; Each skin file uses a specific rotation angle
ContextAction2=[!WriteKeyValue Variables Angle #Angle# "#@#Variables.inc"][!WriteKeyValue Variables Config "#CURRENTCONFIG#" "#@#Variables.inc"][!WriteKeyValue Variables ConfigPath "#CURRENTPATH##CURRENTFILE#" "#@#Variables.inc"][!ActivateConfig "Fountain of Colors\ContextMenus" "Display.ini"]
ContextTitle3="Audio settings..."
ContextAction3=[!WriteKeyValue Variables Config "#CURRENTCONFIG#" "#@#Variables.inc"][!WriteKeyValue Variables ConfigPath "#CURRENTPATH##CURRENTFILE#" "#@#Variables.inc"][!ActivateConfig "Fountain of Colors\ContextMenus" "Audio.ini"]
ContextTitle4="Performance settings..."
ContextAction4=[!WriteKeyValue Variables Config "#CURRENTCONFIG#" "#@#Variables.inc"][!ActivateConfig "Fountain of Colors\ContextMenus" "Performance.ini"]
ContextTitle5=---
ContextTitle6="Edit local settings..."
ContextAction6=["Notepad" "#CURRENTPATH##CURRENTFILE#"]
ContextTitle7="Edit global settings..."
ContextAction7=["Notepad" "#@#Variables.inc"]

[MeasureAudio]
Measure=Plugin
Group=Audio
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
IfTrueAction=[!DisableMeasureGroup Audio][!DisableMeasure ScriptColorChanger][!HideMeterGroup Bars][!HideMeter BoundingBox]

[Standby]
Measure=Plugin
Plugin=AudioLevel
Port=#Port#
ID=#ID#
UpdateDivider=1

; Show meters and enable measures when sound begins playing
IfCondition=(Standby > 0.000000000000000001)
IfTrueAction=[!EnableMeasureGroup Audio][!EnableMeasure ScriptColorChanger][!ShowMeterGroup Bars][!ShowMeter BoundingBox]

[MeasureNowPlaying]
Measure=Plugin
Plugin=NowPlaying
PlayerName=#PlayerName#
PlayerType=POSITION
UpdateDivider=62.5

; Include audio bands and colors
@Include=#@#Bands.inc
@Include2=#@#SongSettings.inc
@Include3=#@#ColorPlaylists.inc
@Include4=#@#ColorHexPalette.inc

[ScriptColorChanger]
Measure=Script
ScriptFile=#@#ColorChanger.lua
Sub=Repeat
Index=1
Limit=(#Bands#-1)
MeasureName=MeasureAudioRepeat
MeterName=MeterBarRepeat
OptionName=BarColor
UpdateDivider=(1000/(16*#ColorUpdatesPerSecond#))

; Validate the string for use in the script
[CurrentConfig]
Measure=String
String=#CURRENTCONFIG#
Substitute="\":"\\"

; Include rotation measures
@Include=#@#SkinRotation.inc

[SetMeasureOptions]
Measure=Calc
OnUpdateAction=[!SetOptionGroup Audio Channel #Channel#][!SetOptionGroup Audio AverageSize #AverageSize#][!SetOptionGroup Audio UpdateDivider 1][!UpdateMeasureGroup Audio]

[SetMeterOptions]
Measure=Script
ScriptFile=#@#SetMeterOptions.lua
Sub=Repeat
MeterName=MeterBarRepeat
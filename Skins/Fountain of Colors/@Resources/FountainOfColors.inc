[Rainmeter]
Update=0
DefaultUpdateDivider=-1
Group=FountainOfColors
LeftMouseUpAction=[!ActivateConfig "Fountain of Colors\SettingsWindow"]

OnRefreshAction=[!WriteKeyValue Variables Angle #Angle# "#@#Variables.inc"][!WriteKeyValue Variables Invert #Invert# "#@#Variables.inc"][!WriteKeyValue Variables Channel #Channel# "#@#Variables.inc"][!WriteKeyValue Variables Port #Port# "#@#Variables.inc"][!WriteKeyValue Variables ID "#ID#" "#@#Variables.inc"][!WriteKeyValue Variables Config "#CURRENTCONFIG#" "#@#Variables.inc"][!WriteKeyValue Variables ConfigPath "#CURRENTPATH##CURRENTFILE#" "#@#Variables.inc"][!ActivateConfig "Fountain of Colors\Initialize"]

[MeasureAudio]
Measure=Plugin
Plugin=AudioLevel
Port=Output
ID=
RMSAttack=0
RMSDecay=0
RMSGain=1
PeakAttack=0
PeakDecay=0
PeakGain=1
FFTSize=4096
FFTOverlap=3584
FFTAttack=2
FFTDecay=43
Bands=54
FreqMin=33
FreqMax=14000
Sensitivity=48.16473
UpdateDivider=1

[Include]
@Include=

@Include2=
@Include3=
@Include4=
@Include5=

[MeasureAudioRepeat]
Measure=Plugin
Group=Audio
Plugin=AudioLevel
Parent=MeasureAudio
Type=Band
BandIdx=(Abs((#Invert# = 1 ? (#FirstBandIndex# + #Bands# - 1) : 0) - Repeat))
[MeasureAudioMinRepeat]
Measure=Calc
Formula=(Max(#MinBarHeight# / #BarHeight#, MeasureAudioRepeat))
UpdateDivider=1
[MeterBarRepeat]
Meter=Bar
MeasureName=MeasureAudioMinRepeat

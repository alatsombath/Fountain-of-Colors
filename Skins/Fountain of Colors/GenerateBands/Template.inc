[MeasureAudioRepeat]
Measure=Plugin
Group=Audio
Plugin=AudioLevel
Parent=MeasureAudio
Type=Band
BandIdx=(Abs((#Invert# = 1 ? #Bands# : 0)-Repeat))

[MeterBarRepeat]
Meter=Bar
MeasureName=MeasureAudioRepeat
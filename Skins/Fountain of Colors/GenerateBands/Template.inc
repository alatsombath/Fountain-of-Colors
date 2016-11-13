[MeasureAudioRepeat]
Measure=Plugin
Group=Audio
Plugin=AudioLevel
Parent=MeasureAudio
Type=Band
BandIdx=(Abs((#Invert# = 1 ? (#FirstBandIndex# + #Bands# - 1) : 0) - Repeat))
[MeasureAudioCalcRepeat]
Measure=Calc
Group=AudioCalc
; Formula=(Max(0.00001 + SetMinValue + ((SetMaxValue - SetMinValue) * (#MinBarHeight# / #BarHeight#)), (MeasureAudioRepeatD1 + MeasureAudioRepeat + MeasureAudioRepeatI1) / 3))
Formula=(Max(0.00001 + SetMinValue + ((SetMaxValue - SetMinValue) * (#MinBarHeight# / #BarHeight#)), MeasureAudioRepeat))
UpdateDivider=1
[MeterBarRepeat]
Meter=Bar
MeasureName=MeasureAudioCalcRepeat

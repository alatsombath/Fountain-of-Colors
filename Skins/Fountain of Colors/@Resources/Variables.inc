[Variables]

Bands=49
; Number of bars - Activate Fountain of Colors\GenerateBands.ini skin after changing this value

BarGap=6
BarWidth=15
BarHeight=320

AverageSize=0
; "Smoothness" - Number of past measure values used to increase continuity

LoudnessEqualization=1

FFTSize=10240
FFTOverlap="(#FFTSize#-512)"
FFTAttack=0
FFTDecay=340
FreqMin=20
FreqMax=20000
Sensitivity=26
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

Colors=Random
; Single, Random, Custom, Individual

PaletteColor1=255,0,0
PaletteColor2=0,255,0
PaletteColor3=0,0,255
PaletteColor4=0,0,0

TransitionTime=8
hBlendingMultiplier=0.2
vBlendingMultiplier=0.1
OpacityLower=179
OpacityUpper=255
OpacityMultiplier=1

ModeKeyboard=0
FirstBandIndex=1

; Environment variables for settings window
SkinGroup=FountainOfColors
Config=Fountain of Colors
ConfigPath=#ROOTCONFIGPATH##Config#.ini
WriteVariable=PaletteColor1
Angle=0
Invert=0
Channel=Avg
Port=Output
ID=

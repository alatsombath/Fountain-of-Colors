[Variables]

Bands=44
; Number of bars - Activate the GenerateBands.ini file after changing this value

BarGap=7
BarWidth=16
BarHeight=350

AverageSize=4
; "Smoothness" - Number of past measure values used to increase continuity

FFTSize=6144
FFTOverlap=(#FFTSize#*0.5)
FFTAttack=0
FFTDecay=320
FreqMin=20
FreqMax=20000
Sensitivity=30
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

Colors=Random

PaletteColor1=255,0,0
PaletteColor2=0,255,0
PaletteColor3=0,0,255
PaletteColor4=0,0,0

TransitionTime=6
hBlendingMultiplier=0.3
vBlendingMultiplier=0.2
OpacityLower=153
OpacityUpper=255
OpacityMultiplier=1

ModeKeyboard=0
FirstBandIndex=1

; Environment variables for settings window
SkinGroup=FountainOfColors
Config=Fountain of Colors
ConfigPath=#ROOTCONFIGPATH#\Fountain of Colors.ini
WriteVariable=PaletteColor1
Angle=0
Invert=0
Channel=Avg
Port=Output
ID=

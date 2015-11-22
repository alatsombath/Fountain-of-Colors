[Variables]

Bands=45
; Number of bars - Activate Fountain of Colors\GenerateBands.ini skin after changing this value

BarGap=6
BarWidth=14
BarHeight=250

AverageSize=0
; Average sound levels over time to provide continuity

LoudnessEqualization=1
; Increases visibility for quiet audio sources when applicable

FFTSize=10240
FFTOverlap="(#FFTSize#-512)"
FFTAttack=0
FFTDecay=275
FreqMin=20
FreqMax=20000
Sensitivity=21
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

MusicPlayer=None
; Music player process name

Colors=Random
; Single, Random, Custom, Individual, IndivRand, Wallpaper, Taskbar

ColorsPlugin=None
; None, Chameleon (Wallpaper), SysColor (Taskbar)

PaletteColor1=255,0,0
PaletteColor2=0,255,0
PaletteColor3=0,0,255
PaletteColor4=0,0,0

TransitionTime=6
hBlendingMultiplier=0.2
vBlendingMultiplier=0.1
OpacityLower=204
OpacityUpper=255
OpacityMultiplier=1

ModeKeyboard=0
FirstBandIndex=1

; Environment variables for settings window
SkinGroup=FountainOfColors
Config=Fountain of Colors
ConfigPath=#ROOTCONFIGPATH##Config#.ini
WriteVariable=PaletteColor1
Refresh=0
Angle=0
Invert=0
Channel=Avg
Port=Output
ID=

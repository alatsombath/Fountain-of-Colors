[Variables]

Bands=35
; Number of bars - Activate Fountain of Colors\GenerateBands.ini skin after changing this value

BarGap=6
BarWidth=14
BarHeight=200

AverageSize=3
; Average sound levels over time to provide continuity

LoudnessEqualization=1
; Increases visibility for quiet audio sources when applicable

FFTSize=10240
FFTOverlap="(#FFTSize#-256)"
FFTAttack=75
FFTDecay=425
FreqMin=32
FreqMax=17500
Sensitivity=17
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

MusicPlayer=None
; Music player process name

Colors=Random
; Single, Random, Custom, Individual, IndivRand, Wallpaper, Taskbar

ColorsPlugin=None
; None, Chameleon (Wallpaper), SysColor (Taskbar)

WallpaperColorSource=Avg
; Avg, FG1, BG1, FG2, BG2

PaletteColor1=255,0,0
PaletteColor2=0,255,0
PaletteColor3=0,0,255
PaletteColor4=0,0,0

TransitionTime=6
hBlendingMultiplier=0.3
vBlendingMultiplier=0.1

DecayEffect=1
DecayThreshold=40
DecaySustain=250
DecayDuration=450

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

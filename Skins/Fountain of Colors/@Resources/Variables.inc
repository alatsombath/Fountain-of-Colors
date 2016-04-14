[Variables]

Bands=42
; Number of bars - Activate Fountain of Colors\GenerateBands.ini skin after changing this value

BarGap=4
BarWidth=13
BarHeight=240

MinBarHeight=0

AverageSize=0
; Average sound levels over time to provide continuity

LoudnessEqualization=1
; Increases visibility for quiet audio sources when applicable

FFTSize=6144
FFTOverlap="(#FFTSize#-128)"
FFTAttack=0
FFTDecay=240
FreqMin=30
FreqMax=10000
Sensitivity=24
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

MusicPlayer=None
; Music player process name, such as "VLC" (not "VLC.exe")

Colors=Random
; Single, Random, Custom, Individual, IndivRand, Wallpaper, Taskbar

ColorsPlugin=None
; None, Chameleon (Wallpaper), SysColor (Taskbar)

WallpaperColorSource=Avg
; Avg, FG1, BG1, FG2, BG2

PaletteColor1=255,128,255
PaletteColor2=96,160,224
PaletteColor3=255,160,160
PaletteColor4=240,240,240

TransitionTime=6
hBlendingMultiplier=0
vBlendingMultiplier=0

DecayEffect=0
DecayThreshold=55
DecaySustain=365
DecayDuration=635

ModeKeyboard=0
; Requires DecayEffect=1

FirstBandIndex=1
; "0" band should be skipped for aesthetic purpose

IdleAudioTimeout=1
; How long before hiding the visualizer when no sound is playing

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

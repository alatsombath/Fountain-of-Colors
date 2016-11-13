[Variables]

Bands=45
; Number of bars - Activate Fountain of Colors\GenerateBands.ini skin after changing this value

BarGap=3
BarWidth=13
BarHeight=285

MinBarHeight=0

AverageSize=1
; Average sound levels over time to provide continuity

ClipOffset=0.844
; Increase precision by narrowing (in dB) the range of displayed values

FFTSize=4096
FFTOverlap="(#FFTSize#-(#FFTSize#/32))"
FFTAttack=42
FFTDecay=151
FreqMin=31
FreqMax=10000
Sensitivity=37
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

MusicPlayer=None
; Music player process name, such as "VLC" (not "VLC.exe")

Colors=Random
; Single, Random, Custom, Individual, IndivRand, Wallpaper, Taskbar

ColorsPlugin=None
; None, Chameleon (Wallpaper), SysColor (Taskbar)

WallpaperColorSource=Cycle
; Avg, FG1, BG1, FG2, BG2, Cycle

PaletteColor1=255,128,255
PaletteColor2=96,160,224
PaletteColor3=255,160,160
PaletteColor4=240,240,240

TransitionTime=12
hBlendingMultiplier=0
vBlendingMultiplier=0
OpacityLower=255
OpacityUpper=255
OpacityMultiplier=1

DecayEffect=0
DecayThreshold=55
DecaySustain=365
DecayDuration=635
DecayOpacityMin=0
DecayOpacityMax=255

ColorsExclude=
; Exclude ranges of random generated colors (in HSV)
; Format: "Min H - Max H, Min S - Max S, Min V - Max V|H,S,V|..."
; Example "52-74,15-100,15-100|74-84,15-80,15-95|0-52,15-80,15-95|330-360,0-0,15-95" roughly excludes yellow and brown

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

; Don't change these here, edit the skin file instead
Angle=0
Invert=0
Channel=Avg
Port=Output
ID=

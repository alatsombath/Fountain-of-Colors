[Variables]

Bands=64
BarGap=3
BarWidth=6
BarHeight=171
MinBarHeight=0
PaletteColor1=0,250,154

FFTSize=4096
FFTOverlap="(#FFTSize#-(#FFTSize#/8))"
FFTAttack=4
FFTDecay=16
FreqMin=33
FreqMax=20000
Sensitivity=51.6
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

AverageSize=0
; Average sound levels over time to provide continuity

ClipOffset=0
; Increase precision by narrowing (in dB) the range of displayed values

Colors=Single
; Single, Random, Custom, Individual, IndivRand, Wallpaper, Taskbar

ColorsPlugin=None
; None, Chameleon (Wallpaper), SysColor (Taskbar)

WallpaperColorSource=Cycle
; Avg, FG1, BG1, FG2, BG2, Cycle

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

; Environment variables for settings window/skin
SkinGroup=FountainOfColors
Config=Fountain of Colors
ConfigPath=#ROOTCONFIGPATH##Config#.ini
WriteVariable=PaletteColor1
SetCloneColorState=

; Don't change these here, edit the skin file instead
Angle=0
Invert=0
Channel=Avg
Port=Output
ID=

[Variables]

Bands=80
BarGap=5
BarWidth=11
BarHeight=267
MinBarHeight=0
PaletteColor1=0,250,154

FFTSize=5120
FFTOverlap="(Ceil((2/3)*#FFTSize#))"
FFTAttack=0
FFTDecay=0
FreqMin=16.352
FreqMax=16744.036
Sensitivity=42
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel

AverageSize=3
; Average sound levels over time to provide continuity

Colors=Single
; Single, Random, Custom, Individual, IndivRand, Wallpaper, Window
GetColors=
; "", Wallpaper, Window

PaletteColor2=96,160,224
PaletteColor3=255,160,160
PaletteColor4=240,240,240

TransitionTime=12.0
hBlendingMultiplier=0.0
vBlendingMultiplier=0.0
OpacityLower=255
OpacityUpper=255
OpacityMultiplier=1.0

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

; !!! Do not change (environment variables)
SkinGroup=FountainOfColors
Config=Fountain of Colors
SetCloneColorState=
Angle=0
Invert=0
Channel=Avg
Port=Output

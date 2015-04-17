[Variables]
; Dynamically set via !WriteKeyValue in FetchColorHexPalette.ini
PaletteColor1=
PaletteColor2=
PaletteColor3=
PaletteColor4=
PaletteColor5=

[Counter]
Measure=Calc
Formula=(Counter+1)%(Ceil((#ColorTransitionTime#*1000)/16))
IfCondition=(Counter = 0)
IfTrueAction=[!UpdateMeasure CheckPalettePlaylist]

[CheckPalettePlaylist]
Measure=String
String=#ColorPlaylist#
UpdateDivider=-1
IfMatchMode=1
IfMatch=ColorHexPalette

; If the ColorPlaylist variable is the ColorHexPalette, update the random color indices
IfMatchAction=[!UpdateMeasure RandomLeftTopColorIndex]

; Otherwise disable the counter
IfNotMatchAction=[!SetOption Counter UpdateDivider -1]

[RandomLeftTopColorIndex]
Measure=Calc
Group=Index
Formula=Random
LowBound=1
HighBound=5
UpdateRandom=1
UpdateDivider=-1

OnUpdateAction=[!UpdateMeasure RandomRightTopColorIndex]

[RandomRightTopColorIndex]
Measure=Calc
Group=Index
Formula=Random
LowBound=1
HighBound=5
UpdateRandom=1
UpdateDivider=-1
IfConditionMode=1

; Prevent random indices from being the same
IfCondition=(RandomRightTopColorIndex = RandomLeftTopColorIndex)
IfTrueAction=[!UpdateMeasure RandomRightTopColorIndex]
IfFalseAction=[!UpdateMeasure RandomLeftBottomColorIndex]

[RandomLeftBottomColorIndex]
Measure=Calc
Group=Index
Formula=Random
LowBound=1
HighBound=5
UpdateRandom=1
UpdateDivider=-1
IfConditionMode=1

IfCondition=(RandomLeftBottomColorIndex = RandomLeftTopColorIndex) || (RandomLeftBottomColorIndex = RandomRightTopColorIndex)
IfTrueAction=[!UpdateMeasure RandomLeftBottomColorIndex]
IfFalseAction=[!UpdateMeasure RandomRightBottomColorIndex]

[RandomRightBottomColorIndex]
Measure=Calc
Group=Index
Formula=Random
LowBound=1
HighBound=5
UpdateRandom=1
UpdateDivider=-1
IfConditionMode=1

IfCondition=(RandomRightBottomColorIndex = RandomLeftTopColorIndex) || (RandomRightBottomColorIndex = RandomRightTopColorIndex) || (RandomRightBottomColorIndex = RandomLeftBottomColorIndex)
IfTrueAction=[!UpdateMeasure RandomRightTopColorIndex]

; Parse the variable strings containing the random color indices
IfFalseAction=[!SetOption ParseLeftTopColor String #PaletteColor[RandomLeftTopColorIndex]#][!SetOption ParseRightTopColor String #PaletteColor[RandomRightTopColorIndex]#][!SetOption ParseLeftBottomColor String #PaletteColor[RandomLeftBottomColorIndex]#][!SetOption ParseRightBottomColor String #PaletteColor[RandomRightBottomColorIndex]#][!UpdateMeasureGroup Parse]

[ParseLeftTopColor]
Measure=String
Group=Parse
DynamicVariables=1
UpdateDivider=-1

[ParseRightTopColor]
Measure=String
Group=Parse
DynamicVariables=1
UpdateDivider=-1

[ParseLeftBottomColor]
Measure=String
Group=Parse
DynamicVariables=1
UpdateDivider=-1

[ParseRightBottomColor]
Measure=String
Group=Parse
DynamicVariables=1
UpdateDivider=-1

; Transition the color items from right-to-left, replace the right-hand side with a random palette color, and call ColorChanger.lua to reinitialize the color items in the playlist
OnUpdateAction=[!SetVariable LeftTop1 #LeftTop2#][!SetVariable RightTop1 #RightTop2#][!SetVariable LeftBottom1 #LeftBottom2#][!SetVariable RightBottom1 #RightBottom2#][!SetVariable LeftTop2 [ParseLeftTopColor]][!SetVariable RightTop2 [ParseRightTopColor]][!SetVariable LeftBottom2 [ParseLeftBottomColor]][!SetVariable RightBottom2 [ParseRightBottomColor]][!UpdateMeasure ColorHexPalette][!CommandMeasure ScriptColorChanger """Playlist("#ColorPlaylist#")"""]

[ColorHexPalette]
Measure=String
DynamicVariables=1
UpdateDivider=-1

TransitionTime=#ColorTransitionTime#

1=#LeftTop1#|#LeftTop2#
; Transition this color string from right to left
Mode1=RightToLeft
; Output to a temporary variable, for use in the next sequence
Out1=LeftTop

2=#RightTop1#|#RightTop2#
Mode2=RightToLeft
Out2=RightTop

3=#LeftBottom1#|#LeftBottom2#
Mode3=RightToLeft
Out3=LeftBottom

4=#RightBottom1#|#RightBottom2#
Mode4=RightToLeft
Out4=RightBottom

5=LeftTop|RightTop
; "Repeat" designates a table of interpolated colors, one specific color for each bar/band
Out5=TopRepeat

6=LeftBottom|RightBottom
Out6=BottomRepeat

7=BottomRepeat|TopRepeat
; Output to display
Out7=Meter

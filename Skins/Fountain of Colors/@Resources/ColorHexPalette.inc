[Variables]
; Dynamically set via !WriteKeyValue in FetchColorHexPalette.ini
PaletteColor1=nil
PaletteColor2=nil
PaletteColor3=nil
PaletteColor4=nil
PaletteColor5=nil

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
IfMatchAction=[!UpdateMeasure RandomLeftColorIndex]

; Otherwise disable the counter
IfNotMatchAction=[!SetOption Counter UpdateDivider -1]

[RandomLeftColorIndex]
Measure=Calc
Group=Index
Formula=Random
LowBound=1
HighBound=5
UpdateRandom=1
UpdateDivider=-1

OnUpdateAction=[!UpdateMeasure RandomRightColorIndex]

[RandomRightColorIndex]
Measure=Calc
Group=Index
Formula=Random
LowBound=1
HighBound=5
UpdateRandom=1
UpdateDivider=-1
IfConditionMode=1

; Prevent random indices from being the same
IfCondition=(RandomRightColorIndex = RandomLeftColorIndex)
IfTrueAction=[!UpdateMeasure RandomRightColorIndex]
IfFalseAction=[!UpdateMeasure RandomBottomColorIndex]

[RandomBottomColorIndex]
Measure=Calc
Group=Index
Formula=Random
LowBound=1
HighBound=5
UpdateRandom=1
UpdateDivider=-1
IfConditionMode=1

IfCondition=(RandomBottomColorIndex = RandomLeftColorIndex) || (RandomBottomColorIndex = RandomRightColorIndex)
IfTrueAction=[!UpdateMeasure RandomBottomColorIndex]

; Parse the variable strings containing the random color indices
IfFalseAction=[!SetOption ParseLeftColor String #PaletteColor[RandomLeftColorIndex]#][!SetOption ParseRightColor String #PaletteColor[RandomRightColorIndex]#][!SetOption ParseBottomColor String #PaletteColor[RandomBottomColorIndex]#][!UpdateMeasureGroup Parse]

[ParseLeftColor]
Measure=String
Group=Parse
DynamicVariables=1
UpdateDivider=-1

[ParseRightColor]
Measure=String
Group=Parse
DynamicVariables=1
UpdateDivider=-1

[ParseBottomColor]
Measure=String
Group=Parse
DynamicVariables=1
UpdateDivider=-1

; Transition the color items from right-to-left, replace the right-hand side with a random palette color, and call ColorChanger.lua to reinitialize the color items in the playlist
OnUpdateAction=[!SetVariable Left1 #Left2#][!SetVariable Right1 #Right2#][!SetVariable Bottom1 #Bottom2#][!SetVariable Left2 [ParseLeftColor]][!SetVariable Right2 [ParseRightColor]][!SetVariable Bottom2 [ParseBottomColor]][!UpdateMeasure ColorHexPalette][!CommandMeasure ScriptColorChanger """Playlist("#ColorPlaylist#")"""]

[ColorHexPalette]
Measure=String
DynamicVariables=1
UpdateDivider=-1

1=#Left1#|#Left2#
; Transition this color string from right to left
Mode1=RightToLeft
; Output to a temporary variable, for use in the next sequence
Out1=Left

2=#Right1#|#Right2#
Mode2=RightToLeft
Out2=Right

3=#Bottom1#|#Bottom2#
Out3=Bottom
Mode3=RightToLeft

4=Left|Right
; "Repeat" designates a table of interpolated colors, one specific color for each bar/band
Out4=TopRepeat

5=Bottom|TopRepeat
; Output to display
Out5=Meter

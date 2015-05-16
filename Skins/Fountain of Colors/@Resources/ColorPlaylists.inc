[ExampleColorPlaylist]
Measure=String

Shuffle=0
; 0 = Play the colors in order
; 1 = Play the colors in a random order

; R,G,B,(A) color format
; http://docs.rainmeter.net/manual-beta/skins/option-types#Color
; Color for quiet sounds | Color for loud sounds
1=255,0,0,255|255,0,255,255
2=255,165,0,255|0,0,255,128
3=255,255,0,128|0,255,0,0
4=0,255,0,0|255,0,0,128
5=0,0,255,128|255,165,0,255
6=255,0,255,255|255,255,0,255

[RandomColorPlaylist]
Measure=String

1=Random,Random,Random|Random,Random,Random
; Transition this color string from right to left
Mode1=RightToLeft
; Output to a temporary variable, for use in the next sequence
Out1=Left

2=Random,Random,Random|Random,Random,Random
Mode2=RightToLeft
Out2=Right

3=Random,Random,Random|Random,Random,Random
Out3=Bottom
Mode3=RightToLeft

4=Left|Right
; "Repeat" designates a table of interpolated colors, one specific color for each bar/band
Out4=TopRepeat

5=Bottom|TopRepeat
; Output to display
Out5=Meter

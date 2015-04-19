[Variables]

; Refresh the skin after updating these settings!


; DISPLAY
; =======

Bands=96
; Number of bars

BarGap=4
; Spacing between the bars

BarWidth=12
BarHeight=300

Flip=0
; Flip the bars upside down

AverageSize=2
; Transition smoothness
; (Number of past measure values to average from)


; AUDIO
; =====

Sensitivity=50
; Increase this if the spectrum is not visible enough

FFTAttack=175
FFTDecay=175
; Decrease for faster response, increase for slower response
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel#FFTAttack

FFTSize=3072
; Increase this if the bars "stick" together too much

FFTOverlap=(#FFTSize#/2)
FreqMin=40
FreqMax=16000
Port=Output
; Additional audio settings
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel#FFTOptions


; MECHANICS
; =========

ColorTransitionTime=3
; Number of seconds between changing to the next set of colors
; (Default transition time for the RandomColorPlaylist and ColorHexPalette)

ColorIntensity=1.5
; Play around with this to change color vibrancy, based on the loudness of sound

ColorPlaylist=RandomColorPlaylist
; ColorPlaylist=ExampleColorPlaylist
; Scroll down for more examples below

PlayerName=CAD
; The interface name for the media player
; http://docs.rainmeter.net/manual-beta/plugins/nowplaying#playerlist

Refresh=0
; Check if the skin has refreshed twice to include updated meters in WriteBands.inc


; === DO NOT ADD VARIABLES BELOW THIS LINE ===


[ExampleColorPlaylist]
Measure=String
; Do not remove this line. This section acts as a "measure"

Shuffle=0
; 0 = Play the colors in order
; 1 = Play the colors in a random order

TransitionTime=1
; Number of seconds to move to the next "Number=" item

; R,G,B,(A) color format
; http://docs.rainmeter.net/manual-beta/skins/option-types#Color
; Color for quiet sounds | Color for loud sounds
1=255,0,0,255|255,0,255,255
2=255,165,0,255|0,0,255,128
3=255,255,0,128|0,255,0,0
4=0,255,0,0|255,0,0,128
5=0,0,255,128|255,165,0,255
6=255,0,255,255|255,255,0,255


[ArtistColorSettings]
Measure=String
String=[MeasureArtist]
DynamicVariables=1
UpdateDivider=31.25

; IfMatchN=ARTIST_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorChanger """Playlist("PLAYLIST_NAME")"""]

IfMatch=The Beatles$
; DO NOT REMOVE "$" symbol, DO NOT ADD "" quotes
IfMatchAction=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]
; DO NOT REMOVE """ quotes

IfMatch2=Led Zeppelin$
IfMatchAction2=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Coldplay$
IfMatchAction3=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]


[AlbumColorSettings]
Measure=String
String=[MeasureAlbum]
DynamicVariables=1
UpdateDivider=31.25

; IfMatchN=ALBUM_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorChanger """Playlist("PLAYLIST_NAME")"""]

IfMatch=Hotel California$
IfMatchAction=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch2=The Dark Side of the Moon$
IfMatchAction2=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Moonmadness$
IfMatchAction3=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]


[TrackColorSettings]
Measure=String
String=[MeasureTrack]
DynamicVariables=1
UpdateDivider=31.25

; IfMatchN=TRACK_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorChanger """Playlist("PLAYLIST_NAME")"""]

IfMatch=Mr. Blue Sky$
IfMatchAction=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch2=Here Comes the Sun$
IfMatchAction2=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Make It with You$
IfMatchAction3=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]


[RandomColorPlaylist]
; For advanced users
Measure=String

TransitionTime=#ColorTransitionTime#

1=Random,Random,Random|Random,Random,Random
; Transition this color string from right to left
Mode1=RightToLeft
; Output to a temporary variable, for use in the next sequence
Out1=LeftTop

2=Random,Random,Random|Random,Random,Random
Mode2=RightToLeft
Out2=RightTop

3=Random,Random,Random|Random,Random,Random
Mode3=RightToLeft
Out3=LeftBottom

4=Random,Random,Random|Random,Random,Random
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

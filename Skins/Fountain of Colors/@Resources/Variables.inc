[Variables]

; Refresh the skin after updating these settings!


; DISPLAY
; =======

Bands=96
; Number of bars

BarWidth=14
BarHeight=(#WORKAREAHEIGHT#/2)
; "#WORKAREAHEIGHT#" is generally your monitor's height
; http://docs.rainmeter.net/manual-beta/variables/built-in-variables#WORKAREAXYWH

BarGapX=3.5R
BarGapY=0
; "R" means relative to the bottom/right edge of the previous meter
; http://docs.rainmeter.net/manual-beta/meters/general-options#XY

BarOrientation=Vertical


; MECHANICS
; =========

ColorPlaylist=RandomColorPlaylist
; ColorPlaylist=ExampleColorPlaylist
; Scroll down for more examples below

ColorTransitionTime=3.5
; The default transition time for the RandomColorPlaylist

ColorIntensity=1.75
; Play around with this to change color vibrancy, based on the loudness of sound

PlayerName=CAD
; The interface name for the media player
; http://docs.rainmeter.net/manual-beta/plugins/nowplaying#playerlist


; AUDIO
; =====

Sensitivity=42
; Increase this if the spectrum is not visible enough

FFTAttack=350
FFTDecay=350
; Decrease for faster response, increase for slower response
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel#FFTAttack

FFTSize=2048
FFTOverlap=(#FFTSize#/2)
FreqMin=40
FreqMax=16000
Port=Output
; Additional audio settings
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel#FFTOptions


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

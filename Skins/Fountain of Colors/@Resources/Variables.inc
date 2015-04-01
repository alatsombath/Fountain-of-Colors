[Variables]
BarWidth=10
BarHeight=(#WORKAREAHEIGHT#/3)
BarGapX=0R
BarGapY=0
BarOrientation=Vertical

FFTAttack=350
FFTDecay=350
FFTSize=2048
FreqMin=40
FreqMax=16000
; Audio settings
; http://docs.rainmeter.net/manual-beta/plugins/audiolevel#FFTOptions

MeasureName=MeasureAudioRepeat
MeterName=MeterBarRepeat

PlayerName=CAD
; The interface name for the media player
; http://docs.rainmeter.net/manual-beta/plugins/nowplaying#playerlist

Bands=160
Sensitivity=42
ColorIntensity=1.75
ColorTransitionTime=3.5

ColorPlaylist=RandomColorPlaylist
; ColorPlaylist=ExampleColorPlaylist

; === DO NOT ADD VARIABLES BELOW THIS LINE ===

[ExampleColorPlaylist]
Measure=String

Shuffle=0

; R,G,B color format
; Color for quiet sounds | Color for loud sounds
1=255,0,0|255,255,255
2=255,165,0|255,255,255
3=255,255,0|255,255,255
4=0,255,0|255,255,255
5=0,0,255|255,255,255
6=255,0,255|255,255,255

[ExampleColorPlaylist2]
Measure=String

Shuffle=1

1=Random,Random,Random|Random,Random,Random
2=Random,Random,Random|Random,Random,Random
3=Random,Random,Random|Random,Random,Random

[ArtistColorSettings]
Measure=String
String=[MeasureNowPlayingArtist]
DynamicVariables=1
IfMatch=^$
IfMatchAction[!CommandMeasure ScriptColorChanger Playlist(#ColorPlaylist#)]

; IfMatchN=ARTIST_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorChanger """Playlist("PLAYLIST_NAME")"""]

IfMatch2=The Beatles$
; DO NOT REMOVE "$" symbol, DO NOT ADD "" quotes
IfMatchAction2=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]
; DO NOT REMOVE """ quotes

IfMatch3=Led Zeppelin$
IfMatchAction3=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch4=Coldplay$
IfMatchAction4=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

[AlbumColorSettings]
Measure=String
String=[MeasureNowPlayingAlbum]
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
String=[MeasureNowPlayingTrack]
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
; Output to a table of interpolated colors, one specific color for each bar/band
Out4=TopRepeat

5=Bottom|TopRepeat
; Output to display
Out5=Meter

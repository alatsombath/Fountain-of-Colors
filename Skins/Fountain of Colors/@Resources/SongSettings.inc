[ArtistColorSettings]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[MeasureNowPlaying]
PlayerType=ARTIST
UpdateDivider=62.5

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
Measure=Plugin
Plugin=NowPlaying
PlayerName=[MeasureNowPlaying]
PlayerType=ALBUM
UpdateDivider=62.5

; IfMatchN=ALBUM_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorChanger """Playlist("PLAYLIST_NAME")"""]

IfMatch=Hotel California$
IfMatchAction=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch2=The Dark Side of the Moon$
IfMatchAction2=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Moonmadness$
IfMatchAction3=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]


[TrackColorSettings]
Measure=Plugin
Plugin=NowPlaying
PlayerName=[MeasureNowPlaying]
PlayerType=TITLE
UpdateDivider=62.5

; IfMatchN=TRACK_NAME$
; IfMatchActionN[!CommandMeasure ScriptColorChanger """Playlist("PLAYLIST_NAME")"""]

IfMatch=Mr. Blue Sky$
IfMatchAction=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch2=Here Comes the Sun$
IfMatchAction2=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]

IfMatch3=Make It with You$
IfMatchAction3=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]
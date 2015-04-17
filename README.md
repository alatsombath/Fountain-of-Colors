Good news! You can now easily choose and display [color palettes from the Color-Hex.com website](http://www.color-hex.com/color-palettes/)

Just go to the "Enter Color-Hex.com Palette ID#" context menu option (Right-click the visualizer or tray icon) and enter the palette ID# in the textbox

Example: If the URL is [color-hex.com/color-palette/4482](http://www.color-hex.com/color-palette/4482), enter "4482" in the textbox

By default, the colors are randomly generated

For customizable colors, select the "Edit variables" context menu option. An example color playlist:
```
1=255,0,0|255,165,0
2=0,255,0|0,0,255
```

Each "Number=" option includes two colors: One for the bottom of the visualizer, and the other for the top of the visualizer

With quieter sounds, "255,0,0" (Red) will be displayed. With louder sounds, "255,165,0" (Orange) will be displayed

You move to the next "Number=" option like a song playlist. "255,0,0" transitions to "0,255,0" (Red to Green), and "255,165,0" transitions to "0,0,255" (Orange to Blue)

You can add as many colors to the playlist as you want!

Use the Shuffle option if you want to play the colors randomly

Change the TransitionTime to the number of seconds it takes to move to the next "Number=" item

You can also create a horizontal color gradient across the spectrum. If you don't know how to get started, feel free to ask for help!

An example matching option for a custom song:
```
IfMatch=Hotel California$
IfMatchAction=[!CommandMeasure ScriptColorChanger """Playlist("ExampleColorPlaylist")"""]
```

Do not remove the "$" symbol, and do not the remove the """ quotes. They are used for literal string matching and sending proper arguments to the script

GIF was recorded in [ScreenToGif](https://screentogif.codeplex.com/)

![Preview](http://orig03.deviantart.net/3f7a/f/2015/093/2/a/fountain_of_colors__music_visualizer___rainmeter__by_alatsombath-d8kxplv.gif)

# Using ColorChanger.lua with other visualizers

[Grab a copy of the ColorChanger.lua script](https://raw.githubusercontent.com/alatsombath/Fountain-of-Colors/master/Skins/Fountain%20of%20Colors/%40Resources/ColorChanger.lua) and place it in the @Resources folder of the skin folder (Under My Documents by default)

Attach these core settings ***at the end* of the [Variables] section** in the skin's .ini file (Customize accordingly):

	ColorPlaylist=RandomColorPlaylist
	ColorTransitionTime=3.5
	ColorIntensity=1.75

	; === DO NOT ADD VARIABLES BELOW THIS LINE ===

	[RandomColorPlaylist]
	Measure=String
	TransitionTime=#ColorTransitionTime#
	1=Random,Random,Random|Random,Random,Random
	Mode1=RightToLeft
	Out1=Left
	2=Random,Random,Random|Random,Random,Random
	Mode2=RightToLeft
	Out2=Right
	3=Random,Random,Random|Random,Random,Random
	Out3=Bottom
	Mode3=RightToLeft
	4=Left|Right
	Out4=TopRepeat
	5=Bottom|TopRepeat
	Out5=Meter

If there is no [Variables] section, but an @Include instead, add a section header below the line:
	
	@Include=(Whatever external variables file)
	
	[Variables]
	ColorPlaylist=RandomColorPlaylist
	
	... (Other core settings) ...

(We're not done yet, we still need to include a measure for the Script)

Favorite song colors require additional measures to be included in the skin's .ini file:

	[MeasureNowPlaying]
	Measure=Plugin
	Plugin=NowPlaying
	PlayerName=#PlayerName#
	PlayerType=POSITION
	
	[MeasureArtist]
	Measure=Plugin
	Plugin=NowPlaying
	PlayerName=[MeasureNowPlaying]
	PlayerType=ARTIST
	
	[MeasureAlbum]
	Measure=Plugin
	Plugin=NowPlaying
	PlayerName=[MeasureNowPlaying]
	PlayerType=ALBUM
	
	[MeasureTrack]
	Measure=Plugin
	Plugin=NowPlaying
	PlayerName=[MeasureNowPlaying]
	PlayerType=TITLE
	
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

## [ScriptColorChanger] section options
	
- **Sub:** "Repeat" (It's our pattern substitution string)

- **Index:** "1" or "0" (Depending on the starting pattern for the measure name)

- **Limit:** Number of bands

- **Threshold:** "0" (Only for now, but if you've derived a formula that determines the minimum measure value difference that visibly updates the meter, just drop a message)

- **MeasureName:** The pattern name of the audio measures

- **MeterName:** The pattern name of the meters

- **OptionName:** The color option that is dynamically updated

## List of default visualizer settings

After including the core settings, place the [ScriptColorChanger] section(s) in the skin's .ini file

I would appreciate it a lot if someone could help compile a complete list of the options for all the released visualizers

### [MarcoPixel's Monstercat Visualizer 1.1](http://marcopixel.deviantart.com/art/UPDATE-Monstercat-Visualizer-for-Rainmeter-1-1-486330771)
visualizer.ini
```
[ScriptColorChanger]
Measure=Script
ScriptFile=#@#ColorChanger.lua
Sub=Repeat
Index=01
Limit=63
Threshold=0
MeasureName=measureAudioOut_Repeat
MeterName=Meter_barRepeat
OptionName=BarColor
```

### [madhoe's VisBubble 1.6](http://madhoe.deviantart.com/art/VisBubble-for-Rainmeter-488601501)
BarExtrude.ini / LineExtrude.ini
```
[ScriptColorChanger]
Measure=Script
ScriptFile=#@#ColorChanger.lua
Sub=Repeat
Index=0
Limit=(#NumOfItems#-1)
Threshold=0
MeasureName=mBandRepeat
MeterName=LineRepeat
OptionName=LineColor
```

ShapeBubble.ini / ShapeExtrude.ini
```
[ScriptColorChanger]
Measure=Script
ScriptFile=#@#ColorChanger.lua
Sub=Repeat
Index=0
Limit=(#NumOfItems#-1)
Threshold=0
MeasureName=mBandRepeat
MeterName=ShapeRepeat
OptionName=ImageTint
```
		
MultiLineExtrude.ini
```
[ScriptColorChangerL]
Measure=Script
ScriptFile=#@#ColorChanger.lua
Sub=Repeat
Index=0
Limit=(#NumOfItems#-1)
Threshold=0
MeasureName=mBandLRepeat
MeterName=LineLRepeat
OptionName=LineColor
			
[ScriptColorChangerR]
Measure=Script
ScriptFile=#@#ColorChanger.lua
Sub=Repeat
Index=0
Limit=(#NumOfItems#-1)
Threshold=0
MeasureName=mBandRRepeat
MeterName=LineRRepeat
OptionName=LineColor
```	

### [alatsombath's Ocean 1.4.1](http://alatsombath.deviantart.com/art/Ocean-Music-Visualizer-for-Rainmeter-522306245)
Ocean.ini / OceanBars.ini / Wave.ini - You also need to [use this modified version of ColorChanger.lua](https://gist.github.com/alatsombath/2ecfb7869e320e4ac1de)

```
[ScriptColorChanger]
Measure=Script
ScriptFile=#@#ColorChanger.lua
Sub=Repeat
Index=1
Limit=(#Bands#-1)
Threshold=0
MeasureName=MeasureAudioRepeat
```

Don't worry if something breaks! Feel free to drop a message and we'll work together to try and fix the problem

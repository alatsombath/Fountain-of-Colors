--[[ Effect: Ghost ]]

local floor = math.floor

function Initialize()
	
	nBANDS = SKIN:GetVariable( "Bands" ) * 1
	nATTACK = SKIN:GetVariable( "nFXGhostAttack" ) * 1
	nDECAY = SKIN:GetVariable( "nFXGhostDecay" ) * 1
	szRGB = SKIN:GetVariable( "PaletteColor1" )
	flSTEP_ATTACK = nATTACK / 10
	flSTEP_DECAY = 255.0 / ( nDECAY / 10 )
	
	t_flAlpha = {}
	t_flAttack = {}
	t_flFFTOut_Max = {}
	t_msFFTOut = {}
	
	for iBand = 1, nBANDS - 1 do
		t_flAlpha[ iBand ] = 255.0
		t_flAttack[ iBand ] = nATTACK
		t_flFFTOut_Max[ iBand ] = 0.0
		t_msFFTOut[ iBand ] = SKIN:GetMeasure( "Audio" .. iBand )
	end
	
end

function Update()
	
	for iBand = 1, nBANDS - 1 do
		
		if t_flAlpha[ iBand ] > 0.0 then
			if t_flAttack[ iBand ] < 0.0 then
				if t_flFFTOut_Max[ iBand ] < t_msFFTOut[ iBand ]:GetValue() then
					t_flAlpha[ iBand ] = 255.0
					t_flAttack[ iBand ] = nATTACK
					t_flFFTOut_Max[ iBand ] = t_msFFTOut[ iBand ]:GetValue()
				end
			else
				t_flAttack[ iBand ] = t_flAttack[ iBand ] - flSTEP_ATTACK
			end
			t_flAlpha[ iBand ] = t_flAlpha[ iBand ] - flSTEP_DECAY
			
			if t_flFFTOut_Max[ iBand ] > t_msFFTOut[ iBand ]:GetValue() then
				SKIN:Bang( "!SetOption", "mt_barGhost" .. iBand, "BarColor",
					szRGB .. "," .. floor( 0.5 + t_flAlpha[ iBand ] ) )
			end
		else
			t_flAlpha[ iBand ] = 255.0
			t_flFFTOut_Max[ iBand ] = t_msFFTOut[ iBand ]:GetValue()
		end
		
	end
end

function GetValue( iBand )
	return t_flFFTOut_Max[ iBand ]
end
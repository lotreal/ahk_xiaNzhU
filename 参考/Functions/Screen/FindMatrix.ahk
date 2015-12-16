FindMatrix(ScanStartX,ScanEndX,ScanStartY,ScanEndY,Dimension,Matrix)
{
	StringSplit, Pix, Matrix, |
	Length := ScanEndY - ScanStartY
	
	;loop for per line of screenY
	Loop, %Length%
	{
		StartX = %ScanStartX%
		EndX = %ScanEndX%

		StartY := ScanStartY + A_Index - 1
		EndY := ScanStartY + A_Index - 1
	
		;loop for searching inside a line
		Loop
		{
			count = 0
			MatchFound = 1
			
			;change variance and 'Fast' if not suited
			PixelSearch, pX, pY, %StartX%, %StartY%, %EndX%, %EndY%, %Pix1%, 0, Fast
			IfNotEqual, ERRORLEVEL, 0, Break
			sX = %pX%
			sY = %pY%
			
			;loop for matching
			Loop, %Dimension%
			{
				Loop, %Dimension%
				{
					Count ++
					PixelGetColor, CurrPix, %pX%, %pY%
					
					IfNotEqual, Pix%Count%, %CurrPix%
						MatchFound = 0
					
					IfEqual, MatchFound, 0, Break
					pX ++
				}
				IfEqual, MatchFound, 0, Break
				pY ++
				pX -= %Dimension%
			}
			
			;match found!
			IfEqual, MatchFound, 1
			{
				Result = %sX% %sY%
				Return Result
			}
			
			StartX ++
			
			DiffX := EndX - StartX
			IfLess, DiffX, %Dimension%, Break
		}
		StartY ++
		EndY ++
	}
	Return 0
}

GetMatrix(StartX,StartY,Dimension)
{
	Loop, %Dimension%
	{
		Loop, %Dimension%
		{
			PixelGetColor, Pix, %StartX%, %StartY%
			Matrix = %Matrix%|%Pix%
			StartX ++
		}
		
		StartY ++
		StartX -= %Dimension%
	}
	StringTrimLeft, Matrix, Matrix, 1
	Return %Matrix%
}

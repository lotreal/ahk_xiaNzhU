;IniSectionGet Fuction
;Get All sections names from Said file and store in said array
IniSectionGet(File,Array)
{
	Global
	i = 0 ;Index used for array element number
	Loop, Read, %File%
	{
		StringLeft, L, A_LoopReadLine, 1
		;Possible Section name, so check right side
		If L = [
		{
			StringRight, R, A_LoopReadLine, 1
			;If its a right bracket Section found
			If R = ]
			{
				i++
				;Econt = Element Contents
				ECont = %A_LoopReadLine%
				StringTrimLeft, ECont, ECont, 1
				StringTrimRight, ECont, ECont, 1
				%Array%%i% = %ECont%
			}
		}
	}
	%Array%0 = %i%
}
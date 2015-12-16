;IniKeyGet Function
;Gets all key names from said section of said file and store in said array
;Array0 stores how many elements are in said array.
IniKeyGet(File,Sect,Array)
{
	Local i
	i = 0
	LineNum = 0
	Loop, Read, %File%
	{
		Section = [%Sect%]
		If A_LoopReadLine = %Section% 
		StringLeft, L, A_LoopReadLine, 1
		;Possible Section name, so check right side
		If L = [
		{
			StringRight, R, A_LoopReadLine, 1
			;If it not a right bracket, not a section, continue
			If R <> ]
				Continue
			;Else, section name 
			Else
			{
				;Econt = Element Contents
				ECont = %A_LoopReadLine%
				StringTrimLeft, ECont, ECont, 1
				StringTrimRight, ECont, ECont, 1
				LineNum = %A_Index%
				;if true, section found
				If ECont = %Sect%
				{
					LineNum++
					Loop
					{
						FileReadLine, LineCont, %File%, %LineNum%
						;Check is line may be a section, not a key name
						StringLeft, LL, LineCont, 1
						If LL = [
						{
							;Check right side, if right bracket, line is section(next section must have been reached), so return
							StringRight, RL, LineCont, 1
							{
								If RL = ]
								{
									;Declare Array0 Value
									%Array%0 = %i%
									Return
								}
							}	
						}
						;Line not a key
						If LineCont Not Contains =
						{	
							LineNum++
							Continue
						}
						i++
						StringSplit, KeyName, LineCont, =
						%Array%%i% = %KeyName1%
						LineNum++
					}
				}
			}
		}
		Else ;Not a section name
			Continue	
	}
}
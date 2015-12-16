TestArray = AnArray
TestSection = Section2
TestFile = %A_ScriptDir%\TestIni.ini
IniKeyGet(TestFile,TestSection,TestArray)
ListVars
F9::Reload

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
		LineNum = %A_Index%
		;Section Found
		If A_LoopReadLine = %Section%
		{ 
			LineNum++
			Loop
			{
				FileReadLine, LineCont, %File%, %LineNum%
				;Check if line may be a section, not a key name
				StringLeft, LL, LineCont, 1
				If LL = [
				{
					StringRight, RR, LineCont, 1
					If RR = ]
					{
						;Declare Array0 Value
						%Array%0 = %i%
						Return
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
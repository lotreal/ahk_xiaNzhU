;___RC4_____________________________________
;Data to cypher, password
RC4(Data,Pw)
{
	ATrim = %A_AutoTrim%
	AutoTrim, Off
	BLines = %A_BatchLines%
	SetBatchlines, -1

	StringLen, PWLen, PW
	
	IfNotEqual, PW, %OldPW%
	{
		Loop, 256
		{
			a := A_Index - 1
			
			Transform, ModVal, Mod, %a%, %PWLen%
			ModVal ++
			
			StringMid, C, PW, %ModVal%, 1
			Transform, AscVar, Asc, %C%
	
			Key%a% = %AscVar%
			sBox%a% = %a%
		}
		
		b = 0
		Loop, 256
		{
			a := A_Index - 1
	
			TempVar := b + sBox%a% + Key%a%
			Transform, b, Mod, %TempVar%, 256
			
			T := sBox%a%
			sBox%a% := sBox%b%
			sBox%b% = %T%
		}
	
		OldPW = %PW%
	}

	StringLen, DataLen, Data
	
	Result =
	i = 0
	j = 0

	Loop, %DataLen%
	{
		TmpVar := i + 1
		Transform, i, Mod, %TmpVar%, 256

		TmpVar := sBox%i% + j
		Transform, j, Mod, %TmpVar%, 256

		TmpVar := sBox%i% + sBox%j%
		Transform, TmpVar2, Mod, %TmpVar%, 256
		
		k := sBox%TmpVar2%
		
		StringMid, TmpVar, Data, %A_Index%, 1
		Transform, AscVar, Asc, %TmpVar%

		Transform, C, BitXOR, %AscVar%, %k%

		IfEqual, C, 0
			C = %k%
		
		Transform, ChrVar, Chr, %C%

		Result = %Result%%ChrVar%
	}

	AutoTrim, %ATrim%
	SetBatchlines, %BLines%
	Return Result
}
;___RC4_____________________________________


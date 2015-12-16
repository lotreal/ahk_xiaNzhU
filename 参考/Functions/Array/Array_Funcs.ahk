; Array Functions
String = 1,2,8,4,5,6
StringSplit, AnArray, String, `,
;ArrayCreate("MyArray","20")
;ArrayAdd("MyArray")
;ArraySet("MyArray","2","HelloWorld")
;ArraySet("MyArray","1","Test")
;ArraySwapPos("MyArray","1","2")
;ArraySwap("AnArray","1","MyArray","2")
MaxValue := ArrayMin("AnArray","1","8")
Msgbox %MaxValue%

Return
F9::Reload
F10::ListVars

;Returns the maximum value contained in elements from pos1 to pos2
ArrayMin(Array,Pos1 =1,Pos2 ="")
{
	EI := %Array%0 ;Element Index, how many elements
	;Check Syntax
	If Pos2 <= %Pos1% ;not possible
	{
		ErrorLevel = 1
		Return ""	
	}
	If EI = ;Array does not exist
	{
		ErrorLevel = 2
		Return ""
	}
	
	If (Pos2 =) Or (Pos2 > EI)
		Pos2 = %EI%
	Loop, %EI%
	{
		ElemPos := A_Index + (Pos1 - 1) 
		IfGreater, ElemPos, %Pos2%, Break ;pos > than max to be anylized, break
		ElemValue := %Array%%ElemPos%
		If A_Index = 1
			Lv = %ElemValue%
		IfLess, ElemValue, %Lv%, SetEnv, Lv, %ElemValue%
	}
	Return %Lv%	
}

;Returns the maximum value contained in elements from pos1 to pos2
ArrayMax(Array,Pos1 =1,Pos2 ="")
{
	EI := %Array%0 ;Element Index, how many elements
	;Check Syntax
	If Pos2 <= %Pos1% ;not possible
	{
		ErrorLevel = 1
		Return ""	
	}
	If EI = ;Array does not exist
	{
		ErrorLevel = 2
		Return ""
	}
	
	If (Pos2 =) Or (Pos2 > EI)
		Pos2 = %EI%
	Loop, %EI%
	{
		ElemPos := A_Index + (Pos1 - 1) 
		IfGreater, ElemPos, %Pos2%, Break ;pos > than max to be anylized, break
		ElemValue := %Array%%ElemPos%
		If A_Index = 1
			Gv = %ElemValue%
		IfGreater, ElemValue, %Gv%, SetEnv, Gv, %ElemValue%
	}
	Return %Gv%	
}


; Swaps elem1 from array1 with elem2 from array2
ArraySwap(Array1,Pos1,Array2,Pos2)
{
	Global
	Local Temp1 Temp2
	Temp1 := %Array1%%Pos1%
	Temp2 := %Array2%%Pos2%
	%Array1%%Pos1% := Temp2
	%Array2%%Pos2% := Temp1
	Return	
}

; Swaps elem1 and elem2 of said array
ArraySwapPos(ArrayName,Pos1,Pos2)
{
	Global
	Local Temp1 Temp2
	Temp1 := %ArrayName%%Pos1%
	Temp2 := %ArrayName%%Pos2%
	%ArrayName%%Pos1% := Temp2
	%ArrayName%%Pos2% := Temp1
	Return	
}

; Creates an array with empty elements
ArrayCreate(ArrayName,Pos)
{
	Global
	Loop, %Pos%
		%ArrayName%%A_Index% =
	%ArrayName%0 = %Pos%
	Return
}

; Adds an empty element to array
ArrayAdd(ArrayName)
{
	Global
	%ArrayName%0++
	I := %ArrayName%0
	%ArrayName%%I% =	
	Return
}

; sets said array elem of said array to contents
ArraySet(ArrayName,Pos,Cont)
{
	Global
	%ArrayName%%Pos% = %Cont%
	Return
}





; moves elem1 up one in array, moving elem above into original place of elem1
ArrayUp(Array,Pos)
{
	Return	
}

; moves elem1 down one in array, moving elem below into original place of elem1
ArrayDown()
{
	Return
}


ArrayToString(Array,Delim = "",Start = 1,End ="")
{
	; Author: Invalid User
	;ArrayToString Function
	;Returns a string of elements from pos start to pos end.
	
	EI := %Array%0 ;Element Index, how many elements
	;Check Syntax
	If End <= %Start% ;not possible
	{
		ErrorLevel = 1
		Return ""	
	}
	If EI = ;Array does not exist
	{
		ErrorLevel = 2
		Return ""
	}
	If Delim = ;if delim value omitted use Comma as default.
		Delim = ,
	If End = ;If End omitted use max element amt.
		End = %EI%
	
	StringLen, DelimLen, Delim
	I := End - Start + 1
	B_Index = %Start%
	Loop, %I%
	{
		ArrayElement := %Array%%B_Index%
		AECont := ArrayElement
		Result = %Result%%Delim%%AECont%
		B_Index++
	}
	StringTrimLeft, Result, Result, %DelimLen% ;Trim leading Delimiter
	Return Result
}
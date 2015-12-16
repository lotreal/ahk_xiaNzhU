;**** StringReplaceChar(ByRef In_String,In_Posi,New_Char) 
;**** Replaces an character at position In_Posi within 
;**** In_String with New_Char. If New_Char is a String 
;**** ONLY the first character in New_Char is used 
;**** If New_Char is empty the character at In_Posi 
;**** is deleted from In_String 
StringReplaceChar(ByRef In_String,In_Posi,New_Char) 
{ 
  local Length, Before, After, Rep_Char 
  StringLen, Length, In_String 
  if (In_Posi>Length)or(length=0)or(In_Posi<0) 
     return ;//nothing is done 
  StringLeft, Rep_Char, New_Char, 1 
  StringLeft, Before, In_String, In_Posi-1 
  StringRight, After, In_String, Length-In_Posi 
  In_String=%Before%%Rep_Char%%After%    
}
;**** StringInsert(In_String,In_Posi,In_Insert) 
;**** Is inserting In_Insert at position In_Posi 
StringInsert(In_String,In_Posi,In_Insert) 
{ 
  local Length, Before, After, Ret_Val 
  StringLen, Length, In_String 
  if (In_Posi>Length)or(length=0)or(In_Posi<0)or(In_Insert=) 
     return, %In_String% 
  StringLeft, Before, In_String, In_Posi 
  StringRight, After, In_String, Length-In_Posi 
  Ret_Val=%Before%%In_Insert%%After%    
  return, %Ret_Val% 
}
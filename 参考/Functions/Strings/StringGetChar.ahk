;**** Function StringGetChar(In_String,In_Posi,Param3) 
;**** Returns the Character at Position In_Posi from 
;**** In_String. If Param3=R In_Posi is from right side 
;**** of string. If In_Posi is bigger than length of 
;**** In_String an empty Result is returned 
StringGetChar(In_String,In_Posi,Param3) 
{ 
  local Length, Ret_Val 
  Ret_Val = 
  StringLen, Length, In_String 
  if (In_Posi>Length)or(length=0)or(In_Posi<1) 
     return Ret_Val 
  If (Param3=R) 
     StringMid,Ret_Val,In_String,Length+1-In_Posi,1 
  else        
     StringMid,Ret_Val,In_String,In_Posi,1 
  return, %Ret_Val%    
}
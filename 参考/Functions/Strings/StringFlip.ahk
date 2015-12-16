;**** Function StringFlip(In_String). Returns a flipped 
;**** In_String. ABCDEFG results in returning GFEDCBA 
StringFlip(In_String) 
{ 
   local Ret_Val, Length, Ch 
   Ret_Val = 
   StringLen, Length, In_String 
   loop, %Length% 
   { 
      Ch:=StringGetChar(In_String,A_Index,L) 
      Ret_Val=%Ret_Val%%Ch% 
   } 
   return, %Ret_Val% 
}
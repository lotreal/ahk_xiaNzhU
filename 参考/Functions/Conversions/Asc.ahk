;**** Function Asc(In_Val) 
;**** Returns Ascii-Code of FIRST Char in In_Val 
Asc(In_Val) 
{ 
   local Ret_Val 
   Transform, Ret_Val, Asc, %In_Val% 
   return Ret_Val  
} 
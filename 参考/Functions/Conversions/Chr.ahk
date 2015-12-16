;**** Function Chr(In_Val) 
;**** Returns Char of In_Var(Ascii-Code 0..255) 
Chr(In_Val) 
{ 
   local Ret_Val 
   Transform, Ret_Val, Chr, %In_Val% 
   return Ret_Val  
}
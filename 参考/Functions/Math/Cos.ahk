;**** Function cos(In_Val) 
;**** Returns the cosinus of In_Val 
Cos(In_Val) 
{ 
   local Ret_Val 
   Transform, Ret_Val, Cos, %In_Val% 
   return Ret_Val  
}
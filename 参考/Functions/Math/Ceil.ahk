;**** Function Ceil(In_Val) 
;**** Rounds In_Val "UP" to nearest Integer 3.14 => 4 
Ceil(In_Val) 
{ 
   local Ret_Val 
   Transform, Ret_Val, Ceil, %In_Val% 
   return Ret_Val  
}
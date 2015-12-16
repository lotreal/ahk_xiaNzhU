;**** Function Floor(In_Val) 
;**** Rounds In_Val "DOWN" to nearest Integer 7.89 => 7 
Floor(In_Val) 
{ 
   local Ret_Val 
   Transform, Ret_Val, Floor, %In_Val% 
   return Ret_Val  
}
;**** Function Round(In_Val) 
;**** Returns In_Val rounded to In_Digits digits 
;**** (look in AHK's Helpfile "Transform") 
Round(In_Val,In_Digits) 
{ 
   Transform, Ret_Val, Round, %In_Val%, %In_Digits% 
   return Ret_Val  
}
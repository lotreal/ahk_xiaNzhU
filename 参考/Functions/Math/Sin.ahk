;**** Function Sin(In_Val) 
;**** Returns the sinus of In_Val 
Sin(In_Val) 
{ 
   Transform, Ret_Val, Sin, %In_Val% 
   return Ret_Val  
}
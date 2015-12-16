;**** Function Pow(In_Val1,In_Val2) 
;**** eg. 2^4 = 16 (look in AHK's Helpfile "Transform") 
Pow(In_Val1,In_Val2) 
{ 
   Transform, Ret_Val, Pow, %In_Val1%, %In_Val2% 
   return Ret_Val  
}
;**** Function Mod(In_Dividend,In_Divisor) 
;**** Modulo-Division: eg. 200 mod 45, 45 goes 4 times 
;**** in 200 because 45*4=180. The Modulo-Rest is 20 
;**** (look in AHK's Helpfile "Transform") 
Mod(In_Dividend,In_Divisor) 
{ 
   Transform, Ret_Val, Mod, %In_Dividend%, %In_Divisor% 
   return Ret_Val  
}
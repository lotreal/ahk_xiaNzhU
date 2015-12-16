;**** Function Div(In_Dividend,In_Divisor) 
;**** Integer-Division: e.g. 200 div 45, 45 goes 4 times 
;**** So the returned result is 4 (an Integer) 
;**** (look in AHK's Helpfile "Transform") 
Div(In_Dividend,In_Divisor) 
{ 
   local Ret_Val 
   Transform, Ret_Val, Floor, In_Dividend/In_Divisor 
   return, Ret_Val 
}
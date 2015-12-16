;**** Function Abs(In_Val) 
;**** negative In_Values are returned positive -5 => 5 
Abs(In_Val) 
{ 
   local Ret_Val
   If In_Val Not Float
	ErrorLevel = 1
   Transform, Ret_Val, Abs, %In_Val% 
   ErrorLevel = 0
   return Ret_Val  
} 
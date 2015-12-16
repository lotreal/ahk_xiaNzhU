;**** Function Swap(Byref val1, ByRef Val2) 
;**** Val1 becomes Val1 and Val2 becomes Val1 
Swap_Values(Byref val1, ByRef Val2) 
{ 
   local dummy 
   dummy:=val1 
   val1:=val2 
   val2:=dummy 
}
;**** Function Max(In_Val1,In_Val2) 
;**** Returns the the bigger one of In_Val1 and In_Val2 
;**** Thanks to Laszlo who this before me 
Max(In_Val1,In_Val2) 
{ 
   IfLess In_Val1,%In_Val2%, Return In_Val2 
   Return In_Val1 
}
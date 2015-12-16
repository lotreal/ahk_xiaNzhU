;**** Function StringDelete(In_String,In_Start,In_Count) 
;**** Deletes In_Count character within In_String starting 
;**** at Position In_Start (inclusive) 
StringDelete(In_String,In_Start,In_Count) 
{ 
  If (In_Start<0)or(In_Count=0) 
    return %In_String% 
  loop, %In_Count% 
     StringReplaceChar(In_String,In_Start,"") 
  return, %In_String% 
}
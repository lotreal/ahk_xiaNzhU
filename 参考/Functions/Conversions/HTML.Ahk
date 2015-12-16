;**** Function HTML(In_Val) 
;**** Ä => &Auml; Translates Chars>127 to Html-Code 
;**** (look in AHK's Helpfile "Transform") 
HTML(In_Val) 
{ 
   Transform, Ret_Val, HTML, %In_Val% 
   return Ret_Val  
}
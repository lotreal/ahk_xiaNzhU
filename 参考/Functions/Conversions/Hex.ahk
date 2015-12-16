; Converts full string from ASC to Hex
Hex(Inp,UC = 0) 
{ 
   OldFmt = %A_FormatInteger% 
   SetFormat, Integer, hex 

   Loop, Parse, Inp 
   { 
      TransForm, Asc, Asc, %A_LoopField% 
      Asc += 0 
      StringTrimLeft, Hex, Asc, 2 
      IfEqual, UC, 0 
         Result = %Result%%Hex% 
      Else 
         Result = %Result%%Hex%00 
   } 
   SetFormat, Integer, %OldFmt% 
   StringUpper, Result, Result 

   Return Result 
}
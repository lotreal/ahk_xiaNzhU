; Converts string from Hex to ASC
Asc(Inp,UC = 0) 
{ 
   StringLen, Len, Inp 
   Len /= 2 

   OldFmt = %A_FormatInteger% 
   SetFormat, Integer, D 

   Loop, %Len% 
   { 
      StringLeft, Hex, Inp, 2 
      IfEqual, UC, 0 
         StringTrimLeft, Inp, Inp, 2 
      Else 
         StringTrimLeft, Inp, Inp, 4 
       
      Hex = 0x%Hex% 
      Hex += 0 
       
      TransForm, Chr, Chr, %Hex% 
      Result = %Result%%Chr% 
   } 
   SetFormat, Integer, %OldFmt% 

   Return Result 
}